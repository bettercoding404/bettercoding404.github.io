---
title: "Python SSH with AWS Assumed User 技术指南"
description: "在云计算环境中，常常需要通过 SSH 连接到远程服务器进行管理和操作。当涉及到 AWS 环境时，使用假定用户（Assumed User）进行 SSH 连接可以增强安全性和管理的灵活性。本文将深入探讨如何使用 Python 实现与 AWS 假定用户的 SSH 连接，包括基础概念、详细的使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在云计算环境中，常常需要通过 SSH 连接到远程服务器进行管理和操作。当涉及到 AWS 环境时，使用假定用户（Assumed User）进行 SSH 连接可以增强安全性和管理的灵活性。本文将深入探讨如何使用 Python 实现与 AWS 假定用户的 SSH 连接，包括基础概念、详细的使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. **基础概念**
    - **AWS 假定用户**
    - **SSH 协议**
    - **Python 与 SSH 和 AWS 的结合**
2. **使用方法**
    - **安装必要的库**
    - **配置 AWS 凭证**
    - **编写 Python 代码实现 SSH 连接**
3. **常见实践**
    - **在 AWS EC2 实例上执行命令**
    - **传输文件**
4. **最佳实践**
    - **安全配置**
    - **错误处理与日志记录**
5. **小结**
6. **参考资料**

## 基础概念
### AWS 假定用户
AWS 假定用户是指通过 AWS 身份与访问管理（IAM）的角色（Role）来临时获取访问权限的用户。通过假定角色，用户可以在特定的时间段内获得该角色所具备的权限，而无需使用长期的访问密钥。这大大增强了安全性，因为可以根据需要随时调整角色权限，并且临时凭证有过期时间。

### SSH 协议
SSH（Secure Shell）是一种网络协议，用于在不安全的网络环境中安全地连接到远程服务器。它通过加密技术保护数据传输的机密性和完整性，广泛用于远程系统管理、文件传输等操作。

### Python 与 SSH 和 AWS 的结合
Python 作为一种功能强大且易于使用的编程语言，提供了丰富的库来处理 SSH 和 AWS 相关的操作。借助这些库，我们可以编写简洁高效的代码来实现与 AWS 假定用户的 SSH 连接，从而自动化各种管理任务。

## 使用方法
### 安装必要的库
首先，需要安装几个关键的库：
- `paramiko`：用于实现 SSH 连接的 Python 库。
- `boto3`：AWS SDK for Python，用于与 AWS 服务进行交互。

可以使用 `pip` 进行安装：
```bash
pip install paramiko boto3
```

### 配置 AWS 凭证
在使用 AWS 服务之前，需要配置 AWS 凭证。可以通过以下几种方式：
1. **环境变量**：设置 `AWS_ACCESS_KEY_ID`、`AWS_SECRET_ACCESS_KEY` 和 `AWS_SESSION_TOKEN` 环境变量。
2. **AWS 配置文件**：在本地的 `~/.aws/config` 和 `~/.aws/credentials` 文件中配置凭证信息。

### 编写 Python 代码实现 SSH 连接
下面是一个简单的示例代码，展示如何使用假定用户的凭证进行 SSH 连接：

```python
import boto3
import paramiko


def get_assumed_role_credentials():
    sts_client = boto3.client('sts')
    assumed_role_object = sts_client.assume_role(
        RoleArn="arn:aws:iam::123456789012:role/your-role-name",
        RoleSessionName="your-session-name"
    )
    return assumed_role_object['Credentials']


def ssh_with_assumed_user():
    credentials = get_assumed_role_credentials()
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    # 替换为实际的服务器信息
    host = "your-ec2-instance-public-ip"
    port = 22
    username = "your-username"

    ssh.connect(
        hostname=host,
        port=port,
        username=username,
        key_filename="path/to/your/private/key.pem",
        aws_access_key_id=credentials['AccessKeyId'],
        aws_secret_access_key=credentials['SecretAccessKey'],
        aws_session_token=credentials['SessionToken']
    )

    stdin, stdout, stderr = ssh.exec_command('ls -l')
    output = stdout.read().decode('utf-8')
    print(output)

    ssh.close()


if __name__ == "__main__":
    ssh_with_assumed_user()

```

在上述代码中：
1. `get_assumed_role_credentials` 函数使用 `boto3` 库向 AWS STS（安全令牌服务）请求假定角色的凭证。
2. `ssh_with_assumed_user` 函数使用获取到的假定用户凭证建立 SSH 连接，并在远程服务器上执行 `ls -l` 命令，最后关闭连接。

## 常见实践
### 在 AWS EC2 实例上执行命令
可以通过 SSH 连接在 AWS EC2 实例上执行各种系统命令，例如安装软件包、配置服务等。以下是一个示例：

```python
def execute_command_on_ec2():
    credentials = get_assumed_role_credentials()
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    host = "your-ec2-instance-public-ip"
    port = 22
    username = "your-username"

    ssh.connect(
        hostname=host,
        port=port,
        username=username,
        key_filename="path/to/your/private/key.pem",
        aws_access_key_id=credentials['AccessKeyId'],
        aws_secret_access_key=credentials['SecretAccessKey'],
        aws_session_token=credentials['SessionToken']
    )

    command = "sudo apt-get update && sudo apt-get install -y nginx"
    stdin, stdout, stderr = ssh.exec_command(command)
    output = stdout.read().decode('utf-8')
    error = stderr.read().decode('utf-8')

    if error:
        print(f"Error: {error}")
    else:
        print(f"Output: {output}")

    ssh.close()

```

### 传输文件
使用 `paramiko` 库的 `sftp` 功能可以在本地和远程服务器之间传输文件。以下是一个上传文件的示例：

```python
def upload_file_to_ec2():
    credentials = get_assumed_role_credentials()
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    host = "your-ec2-instance-public-ip"
    port = 22
    username = "your-username"

    ssh.connect(
        hostname=host,
        port=port,
        username=username,
        key_filename="path/to/your/private/key.pem",
        aws_access_key_id=credentials['AccessKeyId'],
        aws_secret_access_key=credentials['SecretAccessKey'],
        aws_session_token=credentials['SessionToken']
    )

    sftp = ssh.open_sftp()
    local_file_path = "path/to/your/local/file"
    remote_file_path = "/path/to/remote/directory/your-file"
    sftp.put(local_file_path, remote_file_path)
    sftp.close()
    ssh.close()

```

## 最佳实践
### 安全配置
- **最小权限原则**：为假定角色分配最小的权限集，仅授予其执行所需任务的必要权限。
- **定期轮换凭证**：由于假定用户的凭证是临时的，应定期请求新的凭证，以减少凭证泄露的风险。
- **使用 SSH 密钥对**：使用 SSH 密钥对进行身份验证，而不是密码，以增强安全性。

### 错误处理与日志记录
- **全面的错误处理**：在代码中添加详细的错误处理逻辑，以便在出现问题时能够及时捕获并处理异常。
- **日志记录**：使用 Python 的日志模块记录关键操作和错误信息，以便于排查问题和审计。

```python
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


def ssh_with_assumed_user():
    try:
        credentials = get_assumed_role_credentials()
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

        host = "your-ec2-instance-public-ip"
        port = 22
        username = "your-username"

        ssh.connect(
            hostname=host,
            port=port,
            username=username,
            key_filename="path/to/your/private/key.pem",
            aws_access_key_id=credentials['AccessKeyId'],
            aws_secret_access_key=credentials['SecretAccessKey'],
            aws_session_token=credentials['SessionToken']
        )

        stdin, stdout, stderr = ssh.exec_command('ls -l')
        output = stdout.read().decode('utf-8')
        logging.info(output)

        ssh.close()
    except Exception as e:
        logging.error(f"An error occurred: {e}")

```

## 小结
通过本文，我们深入了解了如何使用 Python 实现与 AWS 假定用户的 SSH 连接。我们学习了基础概念，掌握了安装库、配置凭证和编写代码的使用方法，探讨了在 AWS EC2 实例上执行命令和传输文件的常见实践，以及安全配置和错误处理的最佳实践。希望这些知识能帮助读者更高效、安全地管理 AWS 环境中的远程服务器。

## 参考资料
- [Paramiko 官方文档](https://paramiko.readthedocs.io/en/stable/){: rel="nofollow"}
- [Boto3 官方文档](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html){: rel="nofollow"}
- [AWS 身份与访问管理文档](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html){: rel="nofollow"}
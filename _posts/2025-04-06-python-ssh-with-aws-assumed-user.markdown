---
title: "Python SSH with AWS Assumed User 技术详解"
description: "在云计算环境中，常常需要通过 SSH 连接到远程服务器进行管理和操作。当涉及到 AWS 时，使用假设用户（assumed user）进行 SSH 连接可以增强安全性和权限管理的灵活性。Python 作为一种功能强大且广泛使用的编程语言，提供了丰富的库来实现与 AWS 的集成以及 SSH 连接。本文将深入探讨如何使用 Python 结合 AWS 假设用户进行 SSH 连接，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在云计算环境中，常常需要通过 SSH 连接到远程服务器进行管理和操作。当涉及到 AWS 时，使用假设用户（assumed user）进行 SSH 连接可以增强安全性和权限管理的灵活性。Python 作为一种功能强大且广泛使用的编程语言，提供了丰富的库来实现与 AWS 的集成以及 SSH 连接。本文将深入探讨如何使用 Python 结合 AWS 假设用户进行 SSH 连接，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - **AWS 假设用户**
    - **SSH 与 AWS 的关联**
2. **使用方法**
    - **安装必要的库**
    - **配置 AWS 凭证**
    - **编写 Python 代码实现 SSH 连接**
3. **常见实践**
    - **自动化服务器部署**
    - **远程命令执行**
4. **最佳实践**
    - **安全增强**
    - **错误处理与日志记录**
5. **小结**
6. **参考资料**

## 基础概念
### AWS 假设用户
AWS 假设用户是指通过 AWS 身份与访问管理（IAM）角色获取临时访问凭证的用户。通过假设角色，不同的用户或应用程序可以根据其权限需求获取特定的访问权限，而无需使用长期的静态凭证。这大大增强了安全性，因为临时凭证有过期时间，降低了凭证泄露带来的风险。

### SSH 与 AWS 的关联
SSH（Secure Shell）是一种网络协议，用于在不安全的网络环境中安全地远程访问和管理服务器。在 AWS 中，许多服务（如 EC2 实例）支持通过 SSH 进行连接和操作。通过结合 AWS 假设用户和 SSH，我们可以在安全的前提下灵活地管理 AWS 资源。

## 使用方法
### 安装必要的库
首先，我们需要安装一些 Python 库来实现 SSH 连接和 AWS 集成。主要的库包括 `paramiko`（用于 SSH 连接）和 `boto3`（用于与 AWS 交互）。可以使用 `pip` 进行安装：
```bash
pip install paramiko boto3
```

### 配置 AWS 凭证
在使用 AWS 服务之前，需要配置 AWS 凭证。可以通过以下几种方式：
1. **环境变量**：设置 `AWS_ACCESS_KEY_ID` 和 `AWS_SECRET_ACCESS_KEY` 环境变量。
2. **AWS 配置文件**：在本地创建一个配置文件（通常位于 `~/.aws/config` 和 `~/.aws/credentials`），配置凭证信息。

### 编写 Python 代码实现 SSH 连接
以下是一个简单的 Python 示例，展示如何使用假设用户获取临时凭证并进行 SSH 连接：

```python
import boto3
import paramiko


def assume_role(role_arn, session_name):
    sts_client = boto3.client('sts')
    response = sts_client.assume_role(
        RoleArn=role_arn,
        RoleSessionName=session_name
    )
    return response['Credentials']


def ssh_connect(host, username, key_file, port=22):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(host, port=port, username=username, key_filename=key_file)
    return ssh


if __name__ == "__main__":
    role_arn = "arn:aws:iam::123456789012:role/your_role_name"
    session_name = "your_session_name"
    credentials = assume_role(role_arn, session_name)

    host = "your_ec2_instance_ip"
    username = "ec2-user"
    key_file = "path/to/your/private/key.pem"

    ssh = ssh_connect(host, username, key_file)
    stdin, stdout, stderr = ssh.exec_command('ls -l')
    output = stdout.read().decode('utf-8')
    print(output)
    ssh.close()

```

在上述代码中：
1. `assume_role` 函数使用 `boto3` 客户端向 AWS STS（安全令牌服务）请求假设角色，并返回临时凭证。
2. `ssh_connect` 函数使用 `paramiko` 库建立 SSH 连接到指定的主机。
3. 最后，通过 SSH 连接执行命令并打印输出。

## 常见实践
### 自动化服务器部署
可以编写 Python 脚本，使用 AWS 假设用户获取凭证后，通过 SSH 连接到多个 EC2 实例并自动化部署应用程序。例如，可以在 SSH 连接后执行一系列的安装和配置命令：

```python
if __name__ == "__main__":
    # 获取假设用户凭证
    role_arn = "arn:aws:iam::123456789012:role/your_role_name"
    session_name = "your_session_name"
    credentials = assume_role(role_arn, session_name)

    hosts = ["ec2_instance_1_ip", "ec2_instance_2_ip"]
    username = "ec2-user"
    key_file = "path/to/your/private/key.pem"

    for host in hosts:
        ssh = ssh_connect(host, username, key_file)
        commands = [
            'yum update -y',
            'yum install -y httpd',
           'systemctl start httpd',
           'systemctl enable httpd'
        ]
        for command in commands:
            stdin, stdout, stderr = ssh.exec_command(command)
            output = stdout.read().decode('utf-8')
            error = stderr.read().decode('utf-8')
            print(f"Command: {command} Output: {output} Error: {error}")
        ssh.close()

```

### 远程命令执行
通过 SSH 连接，可以在远程服务器上执行各种命令，实现系统管理和监控。例如，获取服务器的 CPU 使用率：

```python
if __name__ == "__main__":
    role_arn = "arn:aws:iam::123456789012:role/your_role_name"
    session_name = "your_session_name"
    credentials = assume_role(role_arn, session_name)

    host = "your_ec2_instance_ip"
    username = "ec2-user"
    key_file = "path/to/your/private/key.pem"

    ssh = ssh_connect(host, username, key_file)
    command = "top -bn1 | grep load | awk '{printf \"CPU Load: %.2f\", $(NF-2)}'"
    stdin, stdout, stderr = ssh.exec_command(command)
    output = stdout.read().decode('utf-8')
    print(output)
    ssh.close()

```

## 最佳实践
### 安全增强
1. **最小权限原则**：确保假设用户的 IAM 角色仅具有必要的权限，避免过度授权。
2. **定期轮换凭证**：由于临时凭证有过期时间，应定期获取新的凭证，以降低凭证泄露的风险。
3. **使用 SSH 密钥管理**：妥善管理 SSH 密钥，确保私钥的安全性，避免密钥泄露。

### 错误处理与日志记录
1. **详细的错误处理**：在代码中添加详细的错误处理逻辑，以便在出现问题时能够快速定位和解决。例如：

```python
def ssh_connect(host, username, key_file, port=22):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        ssh.connect(host, port=port, username=username, key_filename=key_file)
        return ssh
    except paramiko.AuthenticationException as e:
        print(f"Authentication failed: {e}")
    except paramiko.SSHException as e:
        print(f"SSH error: {e}")
    return None

```

2. **日志记录**：使用 Python 的日志模块记录重要的操作和事件，以便进行审计和故障排查。例如：

```python
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


def assume_role(role_arn, session_name):
    try:
        sts_client = boto3.client('sts')
        response = sts_client.assume_role(
            RoleArn=role_arn,
            RoleSessionName=session_name
        )
        logging.info("Successfully assumed role")
        return response['Credentials']
    except Exception as e:
        logging.error(f"Error assuming role: {e}")
        return None

```

## 小结
通过本文，我们深入了解了如何使用 Python 结合 AWS 假设用户进行 SSH 连接。首先介绍了相关的基础概念，包括 AWS 假设用户和 SSH 与 AWS 的关联。接着详细阐述了使用方法，涵盖安装必要的库、配置 AWS 凭证以及编写 Python 代码实现 SSH 连接。在常见实践部分，展示了自动化服务器部署和远程命令执行的示例。最后，提出了一些最佳实践，如安全增强和错误处理与日志记录。希望这些内容能帮助读者在实际工作中更高效、安全地使用 Python SSH with AWS assumed user。

## 参考资料
- [AWS 官方文档 - STS 服务](https://docs.aws.amazon.com/zh_cn/sts/latest/APIReference/Welcome.html){: rel="nofollow"}
- [Paramiko 官方文档](https://www.paramiko.org/){: rel="nofollow"}
- [Boto3 官方文档](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html){: rel="nofollow"}
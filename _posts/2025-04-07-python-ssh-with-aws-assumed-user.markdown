---
title: "Python SSH with AWS Assumed User"
description: "在云计算环境中，经常需要使用 AWS 资源并通过 SSH 进行远程管理或操作。使用 AWS 假定用户（Assumed User）结合 Python 进行 SSH 连接，能提供一种安全且灵活的方式来访问 AWS 上的资源。本文将深入探讨这一技术组合的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握在实际项目中运用这一技术。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在云计算环境中，经常需要使用 AWS 资源并通过 SSH 进行远程管理或操作。使用 AWS 假定用户（Assumed User）结合 Python 进行 SSH 连接，能提供一种安全且灵活的方式来访问 AWS 上的资源。本文将深入探讨这一技术组合的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握在实际项目中运用这一技术。

<!-- more -->
## 目录
1. 基础概念
    - AWS 假定用户
    - SSH 协议
    - Python 与 SSH 交互
2. 使用方法
    - 配置 AWS 凭证
    - 安装必要的 Python 库
    - 编写 Python SSH 连接代码
3. 常见实践
    - 远程执行命令
    - 传输文件
4. 最佳实践
    - 安全考量
    - 错误处理与日志记录
5. 小结
6. 参考资料

## 基础概念
### AWS 假定用户
AWS 假定用户是基于 AWS 身份与访问管理（IAM）角色的一种临时身份。通过假定角色，用户可以获得临时的访问凭证，这些凭证具有特定的权限集。这一机制允许不同的用户或进程在需要时以特定的权限访问 AWS 资源，增强了安全性和灵活性。

### SSH 协议
SSH（Secure Shell）是一种网络协议，用于在不安全的网络环境中安全地传输数据。它提供了加密的通道，确保远程连接的安全性。通过 SSH，用户可以在本地和远程服务器之间执行命令、传输文件等操作。

### Python 与 SSH 交互
Python 有多个库可以用于与 SSH 进行交互，如 `paramiko` 和 `fabric`。这些库提供了简单易用的 API，使得在 Python 代码中实现 SSH 连接、执行命令和传输文件等功能变得相对容易。

## 使用方法
### 配置 AWS 凭证
首先，需要配置 AWS 凭证，以便能够假定角色获取临时访问凭证。可以通过 AWS CLI 进行配置：
```bash
aws configure
```
这将提示输入 AWS 访问密钥、秘密访问密钥、默认区域等信息。

### 安装必要的 Python 库
安装 `paramiko` 库用于 SSH 连接：
```bash
pip install paramiko
```
如果还需要假定 AWS 角色获取临时凭证，可以安装 `boto3` 库：
```bash
pip install boto3
```

### 编写 Python SSH 连接代码
以下是一个简单的示例，展示如何使用 `boto3` 假定 AWS 角色获取临时凭证，并使用 `paramiko` 进行 SSH 连接：

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


def ssh_connect(host, username, key_path, commands):
    key = paramiko.RSAKey.from_private_key_file(key_path)
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname=host, username=username, pkey=key)

    for command in commands:
        stdin, stdout, stderr = ssh.exec_command(command)
        print(f"Command: {command}")
        print(f"Output: {stdout.read().decode()}")
        print(f"Error: {stderr.read().decode()}")

    ssh.close()


if __name__ == "__main__":
    role_arn = "arn:aws:iam::123456789012:role/your-role-name"
    session_name = "your-session-name"
    credentials = assume_role(role_arn, session_name)

    host = "your-ec2-instance-public-ip"
    username = "ec2-user"
    key_path = "path/to/your/private/key.pem"
    commands = [
        "ls -l",
        "df -h"
    ]

    ssh_connect(host, username, key_path, commands)
```

## 常见实践
### 远程执行命令
在上述代码示例中，`ssh_connect` 函数展示了如何通过 SSH 连接在远程服务器上执行命令。可以将需要执行的命令添加到 `commands` 列表中，代码会依次执行这些命令并输出结果。

### 传输文件
使用 `paramiko` 库的 `SFTPClient` 可以实现文件传输。以下是一个简单的示例：
```python
import paramiko


def transfer_files(host, username, key_path, local_path, remote_path):
    key = paramiko.RSAKey.from_private_key_file(key_path)
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname=host, username=username, pkey=key)

    sftp = ssh.open_sftp()
    sftp.put(local_path, remote_path)
    sftp.close()
    ssh.close()


if __name__ == "__main__":
    host = "your-ec2-instance-public-ip"
    username = "ec2-user"
    key_path = "path/to/your/private/key.pem"
    local_path = "path/to/local/file.txt"
    remote_path = "/home/ec2-user/remote_file.txt"

    transfer_files(host, username, key_path, local_path, remote_path)
```

## 最佳实践
### 安全考量
- **最小权限原则**：为假定角色分配最小的必要权限，避免过度授权。
- **密钥管理**：妥善保管 SSH 密钥，设置严格的文件权限（例如，`chmod 400 key.pem`），防止密钥泄露。
- **加密传输**：确保 SSH 连接使用强加密算法，并且服务器端配置为使用安全的加密套件。

### 错误处理与日志记录
在代码中添加适当的错误处理和日志记录功能，以便在出现问题时能够快速定位和解决。例如：
```python
import logging


def ssh_connect(host, username, key_path, commands):
    logging.basicConfig(level=logging.INFO)
    try:
        key = paramiko.RSAKey.from_private_key_file(key_path)
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(hostname=host, username=username, pkey=key)

        for command in commands:
            stdin, stdout, stderr = ssh.exec_command(command)
            logging.info(f"Command: {command}")
            logging.info(f"Output: {stdout.read().decode()}")
            logging.error(f"Error: {stderr.read().decode()}")

        ssh.close()
    except paramiko.AuthenticationException as e:
        logging.error(f"Authentication failed: {e}")
    except paramiko.SSHException as e:
        logging.error(f"SSH error: {e}")
    except FileNotFoundError as e:
        logging.error(f"Key file not found: {e}")
```

## 小结
通过结合 AWS 假定用户和 Python 的 SSH 库（如 `paramiko`），可以实现安全、灵活的远程资源访问和管理。本文介绍了相关的基础概念、使用方法、常见实践以及最佳实践，希望读者能够利用这些知识在实际项目中更高效地运用这一技术。

## 参考资料
- [AWS 文档 - 身份与访问管理](https://docs.aws.amazon.com/iam/latest/UserGuide/introduction.html){: rel="nofollow"}
- [Paramiko 官方文档](https://paramiko.readthedocs.io/en/stable/){: rel="nofollow"}
- [Boto3 官方文档](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html){: rel="nofollow"}
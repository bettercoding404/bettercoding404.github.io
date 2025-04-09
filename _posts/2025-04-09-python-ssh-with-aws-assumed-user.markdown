---
title: "Python SSH with AWS Assumed User"
description: "在云计算环境中，AWS（Amazon Web Services）提供了强大的资源管理和计算能力。有时，我们需要使用 Python 通过 SSH 连接到 AWS 资源，并且是以假定用户（assumed user）的身份进行连接。假定用户是指通过 AWS 的身份和访问管理（IAM）机制，临时获取特定权限的用户角色。这种方式能够增强安全性并灵活管理对 AWS 资源的访问。本文将深入探讨 Python SSH with AWS assumed user 的相关知识，帮助读者掌握其使用方法与最佳实践。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在云计算环境中，AWS（Amazon Web Services）提供了强大的资源管理和计算能力。有时，我们需要使用 Python 通过 SSH 连接到 AWS 资源，并且是以假定用户（assumed user）的身份进行连接。假定用户是指通过 AWS 的身份和访问管理（IAM）机制，临时获取特定权限的用户角色。这种方式能够增强安全性并灵活管理对 AWS 资源的访问。本文将深入探讨 Python SSH with AWS assumed user 的相关知识，帮助读者掌握其使用方法与最佳实践。

<!-- more -->
## 目录
1. 基础概念
    - AWS 假定用户
    - SSH 连接
2. 使用方法
    - 配置 AWS 凭证
    - 安装必要的 Python 库
    - 编写 Python SSH 连接代码
3. 常见实践
    - 连接到 AWS EC2 实例
    - 执行远程命令
4. 最佳实践
    - 安全考量
    - 错误处理与日志记录
5. 小结
6. 参考资料

## 基础概念
### AWS 假定用户
AWS 假定用户是基于 AWS IAM 角色的一种临时身份。通过使用 STS（Security Token Service），用户可以获取一组临时的访问凭证，这些凭证具有特定的权限集合。这允许我们在需要时以特定角色的权限来访问 AWS 资源，而不是使用长期的根用户或 IAM 用户凭证，从而增强安全性。例如，一个开发团队可能有一个 IAM 角色，该角色仅具有对特定开发环境 EC2 实例的 SSH 访问权限，开发人员可以通过假定该角色来获取临时凭证进行操作。

### SSH 连接
SSH（Secure Shell）是一种网络协议，用于在不安全的网络环境中提供安全的远程连接。通过 SSH，我们可以加密通信内容，防止数据在传输过程中被窃取或篡改。在 Python 中，我们可以使用各种库（如 Paramiko）来建立 SSH 连接到远程服务器，包括 AWS 上的实例。

## 使用方法
### 配置 AWS 凭证
首先，需要配置 AWS 凭证以便 Python 脚本能够访问 AWS 资源。可以通过以下几种方式进行配置：
1. **环境变量**：设置 `AWS_ACCESS_KEY_ID`、`AWS_SECRET_ACCESS_KEY` 和 `AWS_SESSION_TOKEN` 环境变量。例如，在 Linux 系统中：
```bash
export AWS_ACCESS_KEY_ID='your_access_key'
export AWS_SECRET_ACCESS_KEY='your_secret_key'
export AWS_SESSION_TOKEN='your_session_token'
```
2. **AWS 配置文件**：在 `~/.aws/config` 和 `~/.aws/credentials` 文件中配置凭证信息。

### 安装必要的 Python 库
我们需要安装 `boto3` 和 `paramiko` 库。`boto3` 是 AWS 的官方 Python SDK，用于与 AWS 服务进行交互，`paramiko` 则用于建立 SSH 连接。可以使用 `pip` 进行安装：
```bash
pip install boto3 paramiko
```

### 编写 Python SSH 连接代码
以下是一个简单的示例，展示如何使用假定用户的凭证通过 SSH 连接到 AWS EC2 实例：
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


def ssh_connect(private_key_path, username, public_ip, credentials):
    key = paramiko.RSAKey.from_private_key_file(private_key_path)
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(
        hostname=public_ip,
        username=username,
        pkey=key,
        aws_access_key_id=credentials['AccessKeyId'],
        aws_secret_access_key=credentials['SecretAccessKey'],
        aws_session_token=credentials['SessionToken']
    )
    return client


# 替换为实际值
role_arn = 'arn:aws:iam::123456789012:role/your_role'
session_name = 'your_session_name'
private_key_path = 'path/to/your/private_key.pem'
username = 'ec2-user'
public_ip = '1.2.3.4'

credentials = assume_role(role_arn, session_name)
ssh_client = ssh_connect(private_key_path, username, public_ip, credentials)

# 执行命令
stdin, stdout, stderr = ssh_client.exec_command('ls -l')
print(stdout.read().decode())

ssh_client.close()
```

## 常见实践
### 连接到 AWS EC2 实例
上述代码示例展示了基本的连接过程。在实际应用中，我们可能需要从 AWS 资源列表中获取 EC2 实例的信息，例如实例的公网 IP 和用户名。可以使用 `boto3` 获取这些信息：
```python
ec2_client = boto3.client('ec2')
response = ec2_client.describe_instances()
for reservation in response['Reservations']:
    for instance in reservation['Instances']:
        if instance['State']['Name'] == 'running':
            public_ip = instance['PublicIpAddress']
            # 根据 AMI 类型确定用户名
            if 'ami-ubuntu' in instance['ImageId']:
                username = 'ubuntu'
            else:
                username = 'ec2-user'
            # 后续进行 SSH 连接操作
```

### 执行远程命令
连接到 EC2 实例后，我们可以执行各种远程命令。例如，安装软件包、部署应用程序等：
```python
ssh_client = ssh_connect(private_key_path, username, public_ip, credentials)
# 安装更新
stdin, stdout, stderr = ssh_client.exec_command('sudo yum update -y')
print(stdout.read().decode())
ssh_client.close()
```

## 最佳实践
### 安全考量
1. **最小权限原则**：确保假定用户角色仅具有执行所需任务的最小权限。例如，如果只是需要 SSH 连接并查看日志，那么角色权限不应包含对其他敏感资源的访问。
2. **临时凭证有效期**：AWS 临时凭证有一定的有效期，在脚本中要注意处理凭证过期的情况，及时重新获取凭证。
3. **加密私钥**：用于 SSH 连接的私钥文件应进行加密存储，防止泄露。

### 错误处理与日志记录
在代码中添加适当的错误处理和日志记录功能。例如：
```python
import logging

logging.basicConfig(level=logging.INFO)


def assume_role(role_arn, session_name):
    try:
        sts_client = boto3.client('sts')
        response = sts_client.assume_role(
            RoleArn=role_arn,
            RoleSessionName=session_name
        )
        return response['Credentials']
    except Exception as e:
        logging.error(f"Error assuming role: {e}")
        return None


def ssh_connect(private_key_path, username, public_ip, credentials):
    try:
        key = paramiko.RSAKey.from_private_key_file(private_key_path)
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(
            hostname=public_ip,
            username=username,
            pkey=key,
            aws_access_key_id=credentials['AccessKeyId'],
            aws_secret_access_key=credentials['SecretAccessKey'],
            aws_session_token=credentials['SessionToken']
        )
        return client
    except Exception as e:
        logging.error(f"Error connecting via SSH: {e}")
        return None


```

## 小结
通过本文，我们了解了 Python SSH with AWS assumed user 的基础概念，掌握了配置 AWS 凭证、安装必要库以及编写 Python 代码进行 SSH 连接的方法。同时，探讨了常见实践场景和最佳实践，包括安全考量、错误处理与日志记录。希望这些内容能帮助读者在 AWS 环境中更安全、高效地使用 Python 进行 SSH 操作。

## 参考资料
- [AWS 官方文档 - STS](https://docs.aws.amazon.com/STS/latest/APIReference/Welcome.html){: rel="nofollow"}
- [Paramiko 官方文档](https://paramiko.readthedocs.io/en/stable/){: rel="nofollow"}
- [Boto3 官方文档](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html){: rel="nofollow"}
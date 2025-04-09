---
title: "Python SSH with AWS Assumed User：深入探索与实践"
description: "在云计算环境中，经常需要通过 SSH 连接到远程服务器进行管理和操作。当涉及到 AWS 环境时，使用假定用户（assumed user）来进行 SSH 连接能增强安全性和管理的灵活性。本文将详细介绍 Python 如何通过 AWS 假定用户进行 SSH 连接，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技术并在实际项目中高效运用。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在云计算环境中，经常需要通过 SSH 连接到远程服务器进行管理和操作。当涉及到 AWS 环境时，使用假定用户（assumed user）来进行 SSH 连接能增强安全性和管理的灵活性。本文将详细介绍 Python 如何通过 AWS 假定用户进行 SSH 连接，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技术并在实际项目中高效运用。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
### AWS 假定用户
AWS 假定用户是基于 AWS 身份与访问管理（IAM）角色的一种临时访问机制。通过假定一个 IAM 角色，你可以获得该角色所赋予的权限，在特定的时间内访问 AWS 资源。这种方式避免了长期使用固定的访问密钥，提高了安全性。例如，一个开发团队可能在需要时假定特定的运维角色来执行服务器管理任务，完成后访问权限自动收回。

### SSH
SSH（Secure Shell）是一种网络协议，用于在不安全的网络环境中建立安全的加密通道。通过 SSH，用户可以安全地登录到远程服务器，执行命令和传输文件。在 AWS 中，SSH 常用于连接到 EC2 实例进行系统管理、部署应用等操作。

### Python 与 SSH 及 AWS 的结合
Python 是一种功能强大且广泛使用的编程语言，有许多库可以用于实现 SSH 连接和与 AWS 交互。借助这些库，我们可以编写 Python 脚本来实现通过 AWS 假定用户进行 SSH 连接，自动化服务器管理任务，提高工作效率。

## 使用方法
### 准备工作
1. **安装必要的库**：
    - `paramiko`：用于 SSH 连接的 Python 库。可以使用 `pip install paramiko` 进行安装。
    - `boto3`：AWS SDK for Python，用于与 AWS 服务进行交互。使用 `pip install boto3` 安装。
2. **配置 AWS 凭证**：确保你的 AWS 凭证已经正确配置。可以通过 `aws configure` 命令在本地配置文件中设置访问密钥和秘密访问密钥，或者使用 AWS 提供的其他凭证提供机制，如 IAM 角色的实例配置文件。

### 代码示例
以下是一个简单的 Python 代码示例，展示如何通过 AWS 假定用户获取临时凭证并使用这些凭证进行 SSH 连接到 EC2 实例：

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


def ssh_connect_with_assumed_role(role_arn, session_name, ec2_host, username):
    credentials = assume_role(role_arn, session_name)

    key = paramiko.RSAKey.from_private_key_file('path/to/your/private/key.pem')
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    ssh.connect(
        hostname=ec2_host,
        username=username,
        pkey=key,
        aws_access_key_id=credentials['AccessKeyId'],
        aws_secret_access_key=credentials['SecretAccessKey'],
        aws_session_token=credentials['SessionToken']
    )

    stdin, stdout, stderr = ssh.exec_command('ls -l')
    output = stdout.read().decode('utf-8')
    print(output)

    ssh.close()


if __name__ == "__main__":
    role_arn = 'arn:aws:iam::123456789012:role/your-role-name'
    session_name = 'your-session-name'
    ec2_host = 'ec2-instance-public-ip'
    username = 'ec2-user'
    ssh_connect_with_assumed_role(role_arn, session_name, ec2_host, username)

```

### 代码说明
1. **`assume_role` 函数**：使用 `boto3` 的 `sts` 客户端来假定指定的 IAM 角色，获取临时凭证。
2. **`ssh_connect_with_assumed_role` 函数**：
    - 调用 `assume_role` 函数获取临时凭证。
    - 使用 `paramiko` 库创建 SSH 连接，通过提供的私钥文件、临时凭证等信息连接到 EC2 实例。
    - 执行 `ls -l` 命令并打印输出结果，最后关闭 SSH 连接。

## 常见实践
### 自动化部署
在软件部署过程中，需要将应用程序部署到多个 AWS EC2 实例上。通过编写 Python 脚本使用 AWS 假定用户进行 SSH 连接，可以自动化执行部署命令，如安装依赖、复制代码文件等操作。例如，可以遍历一个 EC2 实例列表，对每个实例执行相同的部署脚本：

```python
import boto3


def get_ec2_instances():
    ec2 = boto3.resource('ec2')
    instances = ec2.instances.filter(Filters=[{
        'Name': 'instance-state-name',
        'Values': ['running']
    }])
    return instances


def deploy_app(role_arn, session_name):
    instances = get_ec2_instances()
    for instance in instances:
        ec2_host = instance.public_ip_address
        ssh_connect_with_assumed_role(role_arn, session_name, ec2_host, 'ec2-user')


if __name__ == "__main__":
    role_arn = 'arn:aws:iam::123456789012:role/your-role-name'
    session_name = 'your-session-name'
    deploy_app(role_arn, session_name)

```

### 系统监控与维护
通过 SSH 连接到 EC2 实例，可以定期收集系统指标，如 CPU 使用率、内存使用情况等。使用 AWS 假定用户进行连接，确保监控脚本具有适当的权限，同时提高安全性。可以使用 `psutil` 等库在 SSH 连接的实例上收集系统信息：

```python
import paramiko
import psutil


def monitor_system(role_arn, session_name, ec2_host, username):
    credentials = assume_role(role_arn, session_name)

    key = paramiko.RSAKey.from_private_key_file('path/to/your/private/key.pem')
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(
        hostname=ec2_host,
        username=username,
        pkey=key,
        aws_access_key_id=credentials['AccessKeyId'],
        aws_secret_access_key=credentials['SecretAccessKey'],
        aws_session_token=credentials['SessionToken']
    )

    stdin, stdout, stderr = ssh.exec_command('python -c "import psutil; print(psutil.cpu_percent())"')
    cpu_percent = stdout.read().decode('utf-8')
    print(f"CPU 使用率: {cpu_percent}%")

    ssh.close()

```

## 最佳实践
### 最小权限原则
为假定用户的 IAM 角色分配最小的必要权限。仅授予执行 SSH 相关操作和目标服务器管理所需的权限，避免过度授权带来的安全风险。

### 凭证管理
临时凭证有一定的有效期，确保在有效期内完成操作，并在操作完成后及时释放资源。避免凭证泄露，对私钥文件等敏感信息进行严格的权限控制。

### 错误处理与日志记录
在 Python 脚本中添加完善的错误处理机制，当 SSH 连接失败或 AWS 假定用户操作出错时，能够及时捕获并记录错误信息。同时，记录所有重要的操作日志，方便后续排查问题。

```python
import logging


def ssh_connect_with_assumed_role(role_arn, session_name, ec2_host, username):
    logging.basicConfig(level=logging.INFO)
    try:
        credentials = assume_role(role_arn, session_name)
        key = paramiko.RSAKey.from_private_key_file('path/to/your/private/key.pem')
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(
            hostname=ec2_host,
            username=username,
            pkey=key,
            aws_access_key_id=credentials['AccessKeyId'],
            aws_secret_access_key=credentials['SecretAccessKey'],
            aws_session_token=credentials['SessionToken']
        )
        stdin, stdout, stderr = ssh.exec_command('ls -l')
        output = stdout.read().decode('utf-8')
        logging.info(output)
        ssh.close()
    except Exception as e:
        logging.error(f"操作失败: {e}")

```

## 小结
通过 Python 使用 AWS 假定用户进行 SSH 连接为我们在 AWS 环境中管理和操作远程服务器提供了一种安全、灵活且高效的方式。本文介绍了相关的基础概念、详细的使用方法、常见实践以及最佳实践。通过合理运用这些知识，读者可以更好地编写自动化脚本，提高工作效率，同时确保系统的安全性和稳定性。

## 参考资料
- [AWS 官方文档 - IAM 角色](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html){: rel="nofollow"}
- [Paramiko 官方文档](https://paramiko.readthedocs.io/en/stable/){: rel="nofollow"}
- [Boto3 官方文档](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html){: rel="nofollow"}
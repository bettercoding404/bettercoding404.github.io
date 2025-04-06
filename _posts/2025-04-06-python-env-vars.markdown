---
title: "Python 环境变量：从基础到最佳实践"
description: "在 Python 开发中，环境变量是一种强大且灵活的工具。它们允许你在不修改代码本身的情况下，动态地配置应用程序的行为。这在不同的开发、测试和生产环境之间切换时尤为有用。本文将深入探讨 Python 环境变量的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地利用这一特性来优化你的 Python 项目。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 开发中，环境变量是一种强大且灵活的工具。它们允许你在不修改代码本身的情况下，动态地配置应用程序的行为。这在不同的开发、测试和生产环境之间切换时尤为有用。本文将深入探讨 Python 环境变量的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地利用这一特性来优化你的 Python 项目。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 在 Python 脚本中读取环境变量
    - 在命令行中设置环境变量
    - 在操作系统中设置持久化环境变量
3. **常见实践**
    - 配置数据库连接
    - 管理 API 密钥
    - 切换不同环境的配置
4. **最佳实践**
    - 安全地处理敏感信息
    - 保持环境变量的一致性
    - 自动化环境变量的设置
5. **小结**
6. **参考资料**

## 基础概念
环境变量是操作系统中存储的键值对，它们可以被运行在该系统上的进程访问。在 Python 中，我们可以通过特定的方式读取这些环境变量，从而根据不同的环境配置来调整程序的行为。例如，你可能有一个开发环境和一个生产环境，在开发环境中你使用本地数据库，而在生产环境中使用远程数据库。通过环境变量，你可以轻松地切换数据库连接字符串，而无需修改代码中的硬编码值。

## 使用方法

### 在 Python 脚本中读取环境变量
在 Python 中，我们可以使用 `os` 模块或 `dotenv` 库来读取环境变量。

#### 使用 `os` 模块
`os` 模块是 Python 标准库的一部分，提供了与操作系统交互的功能。以下是读取环境变量的示例：

```python
import os

# 获取名为 "MY_VARIABLE" 的环境变量
my_variable = os.getenv("MY_VARIABLE")
if my_variable:
    print(f"环境变量 MY_VARIABLE 的值为: {my_variable}")
else:
    print("环境变量 MY_VARIABLE 未设置")

# 获取名为 "MISSING_VARIABLE" 的环境变量，并提供默认值
missing_variable = os.getenv("MISSING_VARIABLE", "默认值")
print(f"环境变量 MISSING_VARIABLE 的值为: {missing_variable}")
```

#### 使用 `dotenv` 库
`dotenv` 库允许你从 `.env` 文件中加载环境变量，这在开发过程中非常方便。首先，你需要安装 `dotenv` 库：
```bash
pip install python-dotenv
```

然后，在你的 Python 脚本中使用它：

```python
from dotenv import load_dotenv
import os

# 加载.env 文件中的环境变量
load_dotenv()

# 获取名为 "MY_VARIABLE" 的环境变量
my_variable = os.getenv("MY_VARIABLE")
if my_variable:
    print(f"环境变量 MY_VARIABLE 的值为: {my_variable}")
else:
    print("环境变量 MY_VARIABLE 未设置")
```

### 在命令行中设置环境变量
在不同的操作系统中，设置环境变量的方法略有不同。

#### 在 Linux 和 macOS 中
在终端中，你可以使用 `export` 命令来设置环境变量：
```bash
export MY_VARIABLE="示例值"
```

这个环境变量只在当前终端会话中有效。如果你想在脚本中使用这个环境变量，可以这样做：
```bash
#!/bin/bash
export MY_VARIABLE="示例值"
python your_script.py
```

#### 在 Windows 中
在命令提示符中，你可以使用 `set` 命令来设置环境变量：
```batch
set MY_VARIABLE=示例值
```

这个环境变量也只在当前命令提示符会话中有效。如果你想在脚本中使用它，可以在脚本中添加设置环境变量的命令：
```batch
@echo off
set MY_VARIABLE=示例值
python your_script.py
```

### 在操作系统中设置持久化环境变量
如果你希望环境变量在每次系统启动时都可用，可以将其设置为持久化环境变量。

#### 在 Linux 和 macOS 中
你可以编辑 `~/.bashrc` 或 `~/.zshrc` 文件（根据你使用的 shell），并添加以下行：
```bash
export MY_VARIABLE="示例值"
```

保存文件后，运行 `source ~/.bashrc` 或 `source ~/.zshrc` 使更改生效。

#### 在 Windows 中
1. 右键点击“此电脑”，选择“属性”。
2. 点击“高级系统设置”。
3. 在“系统属性”窗口中，点击“环境变量”按钮。
4. 在“用户变量”或“系统变量”部分（根据你的需求），点击“新建”按钮。
5. 在“变量名”字段中输入环境变量名，在“变量值”字段中输入环境变量值。
6. 点击“确定”保存更改。

## 常见实践

### 配置数据库连接
在开发 Web 应用程序时，你可能需要根据不同的环境连接到不同的数据库。例如，在开发环境中使用 SQLite，而在生产环境中使用 PostgreSQL。你可以通过环境变量来配置数据库连接字符串：

```python
import os
import sqlite3
import psycopg2

# 获取数据库类型的环境变量
DB_TYPE = os.getenv("DB_TYPE", "sqlite")

if DB_TYPE == "sqlite":
    # 连接到 SQLite 数据库
    conn = sqlite3.connect("test.db")
elif DB_TYPE == "postgresql":
    # 获取 PostgreSQL 数据库的环境变量
    DB_HOST = os.getenv("DB_HOST", "localhost")
    DB_PORT = os.getenv("DB_PORT", "5432")
    DB_NAME = os.getenv("DB_NAME", "test_db")
    DB_USER = os.getenv("DB_USER", "test_user")
    DB_PASSWORD = os.getenv("DB_PASSWORD", "test_password")

    # 连接到 PostgreSQL 数据库
    conn = psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )
else:
    print("不支持的数据库类型")
```

### 管理 API 密钥
当你使用第三方 API 时，通常需要提供 API 密钥。将 API 密钥存储在环境变量中可以避免将其硬编码在代码中，从而提高安全性。例如，使用 OpenAI API：

```python
import os
import openai

# 获取 OpenAI API 密钥的环境变量
openai.api_key = os.getenv("OPENAI_API_KEY")

# 使用 OpenAI API 进行请求
response = openai.Completion.create(
    engine="text-davinci-003",
    prompt="写一个简短的故事",
    max_tokens=100
)
print(response.choices[0].text)
```

### 切换不同环境的配置
在开发过程中，你可能有开发、测试和生产等不同的环境。通过环境变量，你可以轻松地切换不同环境的配置。例如，你可以设置一个 `ENVIRONMENT` 环境变量，根据其值加载不同的配置文件：

```python
import os
import configparser

# 获取环境变量
ENVIRONMENT = os.getenv("ENVIRONMENT", "development")

config = configparser.ConfigParser()

if ENVIRONMENT == "development":
    config.read("development.ini")
elif ENVIRONMENT == "testing":
    config.read("testing.ini")
elif ENVIRONMENT == "production":
    config.read("production.ini")
else:
    print("不支持的环境")

# 获取配置值
database_url = config.get("database", "url")
print(f"当前环境的数据库 URL: {database_url}")
```

## 最佳实践

### 安全地处理敏感信息
环境变量中可能包含敏感信息，如 API 密钥、数据库密码等。为了确保这些信息的安全，你应该：
- 避免在公开的代码仓库中暴露环境变量。
- 在生产环境中，使用安全的方式设置环境变量，例如通过服务器的配置管理工具。
- 对敏感信息进行加密存储，特别是在使用持久化环境变量时。

### 保持环境变量的一致性
为了使项目易于维护和部署，保持环境变量的命名和使用方式的一致性非常重要。建议：
- 使用大写字母命名环境变量，以区分普通变量。
- 为环境变量添加注释，说明其用途和预期值。
- 在整个项目中遵循一致的环境变量使用规范。

### 自动化环境变量的设置
在开发和部署过程中，手动设置环境变量可能会很繁琐且容易出错。你可以使用工具如 `docker-compose`、`Ansible` 或 `Terraform` 来自动化环境变量的设置。例如，在 `docker-compose.yml` 文件中：

```yaml
version: '3'
services:
  your_service:
    image: your_image
    environment:
      - MY_VARIABLE=示例值
      - ANOTHER_VARIABLE=另一个示例值
```

## 小结
Python 环境变量是一种强大的工具，它允许你在不修改代码的情况下动态地配置应用程序的行为。通过本文，你学习了环境变量的基础概念、在 Python 脚本中读取环境变量的方法、在不同操作系统中设置环境变量的方式，以及一些常见实践和最佳实践。希望这些知识能帮助你更高效地开发和管理 Python 项目。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [dotenv 库官方文档](https://pypi.org/project/python-dotenv/){: rel="nofollow"}
- [环境变量 - Wikipedia](https://en.wikipedia.org/wiki/Environment_variable){: rel="nofollow"}
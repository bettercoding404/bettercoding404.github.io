---
title: "深入理解在 Python 异步编程中在头部发送承载令牌（Bearer Token）"
description: "在现代的网络应用开发中，身份验证和授权是保障系统安全的关键环节。Bearer Token 作为一种常用的身份验证机制，被广泛应用于各种 API 交互中。在 Python 的异步编程场景下，如何有效地在请求头部发送 Bearer Token 是一个常见的需求。本文将详细探讨这一主题，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技术。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在现代的网络应用开发中，身份验证和授权是保障系统安全的关键环节。Bearer Token 作为一种常用的身份验证机制，被广泛应用于各种 API 交互中。在 Python 的异步编程场景下，如何有效地在请求头部发送 Bearer Token 是一个常见的需求。本文将详细探讨这一主题，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技术。

<!-- more -->
## 目录
1. **基础概念**
    - **Bearer Token 是什么**
    - **异步编程在 Python 中的概念**
2. **使用方法**
    - **使用 `aiohttp` 库发送带有 Bearer Token 的请求**
    - **使用 `requests` 库（在异步中结合 `asyncio`）发送请求**
3. **常见实践**
    - **从环境变量中读取 Token**
    - **处理 Token 过期**
4. **最佳实践**
    - **错误处理与重试机制**
    - **安全存储 Token**
5. **小结**
6. **参考资料**

## 基础概念
### Bearer Token 是什么
Bearer Token 是一种身份验证机制，它是一个字符串，通常由服务器颁发给客户端。客户端在后续的请求中，将这个 Token 包含在请求头部，服务器通过验证这个 Token 来确定请求者的身份和权限。例如，一个典型的包含 Bearer Token 的请求头部如下：
```
Authorization: Bearer <your_token_here>
```

### 异步编程在 Python 中的概念
Python 中的异步编程允许程序在等待 I/O 操作（如网络请求、文件读取等）时，不阻塞其他代码的执行。这通过 `asyncio` 库实现，使用 `async` 和 `await` 关键字来定义异步函数和等待异步操作完成。异步编程大大提高了程序的性能和响应性，特别是在处理大量 I/O 密集型任务时。

## 使用方法
### 使用 `aiohttp` 库发送带有 Bearer Token 的请求
`aiohttp` 是一个用于异步 HTTP 客户端/服务器编程的库，非常适合在 Python 异步环境中使用。

```python
import aiohttp
import asyncio


async def fetch_data():
    token = "your_bearer_token"
    headers = {
        "Authorization": f"Bearer {token}"
    }
    async with aiohttp.ClientSession() as session:
        async with session.get('https://example.com/api/data', headers=headers) as response:
            data = await response.json()
            return data


loop = asyncio.get_event_loop()
result = loop.run_until_complete(fetch_data())
print(result)
```

### 使用 `requests` 库（在异步中结合 `asyncio`）发送请求
虽然 `requests` 库本身不是异步的，但可以通过 `asyncio` 的 `run_in_executor` 方法在异步环境中使用它。

```python
import requests
import asyncio


async def fetch_data():
    def send_request():
        token = "your_bearer_token"
        headers = {
            "Authorization": f"Bearer {token}"
        }
        response = requests.get('https://example.com/api/data', headers=headers)
        return response.json()

    loop = asyncio.get_running_loop()
    result = await loop.run_in_executor(None, send_request)
    return result


loop = asyncio.get_event_loop()
result = loop.run_until_complete(fetch_data())
print(result)
```

## 常见实践
### 从环境变量中读取 Token
为了提高安全性和配置的灵活性，通常将 Bearer Token 存储在环境变量中。

```python
import os
import aiohttp
import asyncio


async def fetch_data():
    token = os.getenv('BEARER_TOKEN')
    if not token:
        raise ValueError("BEARER_TOKEN environment variable not set")
    headers = {
        "Authorization": f"Bearer {token}"
    }
    async with aiohttp.ClientSession() as session:
        async with session.get('https://example.com/api/data', headers=headers) as response:
            data = await response.json()
            return data


loop = asyncio.get_event_loop()
result = loop.run_until_complete(fetch_data())
print(result)
```

### 处理 Token 过期
许多 API 颁发的 Bearer Token 都有有效期，需要在 Token 过期时进行处理。

```python
import os
import aiohttp
import asyncio


async def refresh_token():
    # 这里是刷新 Token 的逻辑，例如向认证服务器发送请求
    new_token = "new_refreshed_token"
    return new_token


async def fetch_data():
    token = os.getenv('BEARER_TOKEN')
    headers = {
        "Authorization": f"Bearer {token}"
    }
    async with aiohttp.ClientSession() as session:
        async with session.get('https://example.com/api/data', headers=headers) as response:
            if response.status == 401:  # Token 过期的常见状态码
                new_token = await refresh_token()
                headers["Authorization"] = f"Bearer {new_token}"
                async with session.get('https://example.com/api/data', headers=headers) as new_response:
                    data = await new_response.json()
                    return data
            else:
                data = await response.json()
                return data


loop = asyncio.get_event_loop()
result = loop.run_until_complete(fetch_data())
print(result)
```

## 最佳实践
### 错误处理与重试机制
在发送带有 Bearer Token 的请求时，可能会遇到各种网络错误或服务器端错误。添加错误处理和重试机制可以提高程序的稳定性。

```python
import os
import aiohttp
import asyncio


async def refresh_token():
    new_token = "new_refreshed_token"
    return new_token


async def fetch_data():
    token = os.getenv('BEARER_TOKEN')
    headers = {
        "Authorization": f"Bearer {token}"
    }
    max_retries = 3
    for attempt in range(max_retries):
        try:
            async with aiohttp.ClientSession() as session:
                async with session.get('https://example.com/api/data', headers=headers) as response:
                    if response.status == 401:
                        new_token = await refresh_token()
                        headers["Authorization"] = f"Bearer {new_token}"
                        continue
                    elif response.status >= 500:  # 服务器端错误
                        if attempt < max_retries - 1:
                            continue
                    data = await response.json()
                    return data
        except aiohttp.ClientError as e:
            if attempt < max_retries - 1:
                continue
            raise e


loop = asyncio.get_event_loop()
result = loop.run_until_complete(fetch_data())
print(result)
```

### 安全存储 Token
Bearer Token 是敏感信息，应该安全存储。可以使用 `cryptography` 库对 Token 进行加密存储。

```python
from cryptography.fernet import Fernet
import os
import aiohttp
import asyncio


# 生成加密密钥
key = Fernet.generate_key()
cipher_suite = Fernet(key)

# 加密 Token
token = "your_bearer_token"
encrypted_token = cipher_suite.encrypt(token.encode())


async def fetch_data():
    decrypted_token = cipher_suite.decrypt(encrypted_token).decode()
    headers = {
        "Authorization": f"Bearer {decrypted_token}"
    }
    async with aiohttp.ClientSession() as session:
        async with session.get('https://example.com/api/data', headers=headers) as response:
            data = await response.json()
            return data


loop = asyncio.get_event_loop()
result = loop.run_until_complete(fetch_data())
print(result)
```

## 小结
在 Python 异步编程中发送 Bearer Token 涉及到多个方面的知识和技巧。理解 Bearer Token 的概念和异步编程的基础是关键，掌握不同库的使用方法、常见实践以及最佳实践可以帮助开发者构建更安全、高效和稳定的应用程序。通过合理处理 Token 的存储、过期以及请求中的错误，可以提升整个系统的性能和用户体验。

## 参考资料
- [aiohttp 官方文档](https://docs.aiohttp.org/en/stable/){: rel="nofollow"}
- [asyncio 官方文档](https://docs.python.org/3/library/asyncio.html){: rel="nofollow"}
- [requests 官方文档](https://requests.readthedocs.io/en/latest/){: rel="nofollow"}
- [cryptography 官方文档](https://cryptography.io/en/latest/){: rel="nofollow"}
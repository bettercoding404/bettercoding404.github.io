---
title: "在 Python 异步编程中在请求头中发送承载令牌（Bearer Token）"
description: "在现代的 Web 开发和 API 交互中，身份验证和授权是确保系统安全和数据隐私的关键环节。承载令牌（Bearer Token）作为一种广泛应用的身份验证机制，允许客户端在请求中携带一个令牌来证明其身份和权限。在 Python 的异步编程环境中，正确地在请求头中发送承载令牌对于构建高效、安全的异步应用至关重要。本文将深入探讨在 Python 异步编程中在请求头里发送承载令牌的相关知识，包括基础概念、使用方法、常见实践和最佳实践。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在现代的 Web 开发和 API 交互中，身份验证和授权是确保系统安全和数据隐私的关键环节。承载令牌（Bearer Token）作为一种广泛应用的身份验证机制，允许客户端在请求中携带一个令牌来证明其身份和权限。在 Python 的异步编程环境中，正确地在请求头中发送承载令牌对于构建高效、安全的异步应用至关重要。本文将深入探讨在 Python 异步编程中在请求头里发送承载令牌的相关知识，包括基础概念、使用方法、常见实践和最佳实践。

<!-- more -->
## 目录
1. 基础概念
    - 什么是承载令牌（Bearer Token）
    - Python 异步编程简介
2. 使用方法
    - 使用 `aiohttp` 库发送承载令牌
    - 使用 `requests` 库的异步变体（`asyncio` 结合 `requests`）发送承载令牌
3. 常见实践
    - 从环境变量中读取令牌
    - 令牌刷新机制
4. 最佳实践
    - 错误处理与重试
    - 安全存储令牌
5. 小结
6. 参考资料

## 基础概念
### 什么是承载令牌（Bearer Token）
承载令牌是一种身份验证令牌，通常用于 OAuth 2.0 等授权框架中。它是一个字符串，代表着客户端的身份和权限。服务器通过验证这个令牌来决定是否授权客户端访问受保护的资源。一旦客户端获得了承载令牌，它就可以在后续的请求中，将令牌包含在请求头里发送给服务器。例如：
```
Authorization: Bearer <token>
```
其中 `<token>` 是实际的承载令牌。

### Python 异步编程简介
Python 的异步编程允许程序在等待 I/O 操作（如网络请求、文件读取等）时，不阻塞其他代码的执行，从而提高程序的整体性能和响应性。主要通过 `asyncio` 库来实现异步操作。`asyncio` 提供了事件循环（Event Loop）、协程（Coroutine）等概念，使得开发者能够编写高效的异步代码。例如：
```python
import asyncio

async def main():
    print("开始执行")
    await asyncio.sleep(1)  # 模拟一个耗时的 I/O 操作
    print("执行完毕")

if __name__ == "__main__":
    asyncio.run(main())
```
在上述代码中，`await asyncio.sleep(1)` 语句会暂停 `main` 协程的执行，直到睡眠 1 秒后继续执行后续代码，期间事件循环可以处理其他任务。

## 使用方法
### 使用 `aiohttp` 库发送承载令牌
`aiohttp` 是一个用于 Python 的异步 HTTP 客户端/服务器库，非常适合在异步环境中进行 HTTP 请求。以下是使用 `aiohttp` 在请求头中发送承载令牌的示例：
```python
import asyncio
import aiohttp

async def fetch_data():
    token = "your_bearer_token"
    headers = {
        "Authorization": f"Bearer {token}"
    }
    async with aiohttp.ClientSession() as session:
        async with session.get('https://example.com/api/data', headers=headers) as response:
            data = await response.json()
            return data

if __name__ == "__main__":
    result = asyncio.run(fetch_data())
    print(result)
```
在上述代码中：
1. 定义了一个 `fetch_data` 协程函数。
2. 设置了承载令牌，并将其添加到请求头的 `Authorization` 字段中。
3. 使用 `aiohttp.ClientSession` 创建一个会话，并在会话中发送带有令牌的 GET 请求。
4. 最后，使用 `asyncio.run` 运行协程并获取响应数据。

### 使用 `requests` 库的异步变体（`asyncio` 结合 `requests`）发送承载令牌
虽然 `requests` 库本身不是异步的，但可以结合 `asyncio` 使用线程池或进程池来实现异步操作。以下是一个简单示例：
```python
import asyncio
import requests
from concurrent.futures import ThreadPoolExecutor

def fetch_data_sync(token):
    headers = {
        "Authorization": f"Bearer {token}"
    }
    response = requests.get('https://example.com/api/data', headers=headers)
    return response.json()

async def fetch_data_async():
    token = "your_bearer_token"
    loop = asyncio.get_running_loop()
    with ThreadPoolExecutor() as executor:
        result = await loop.run_in_executor(executor, fetch_data_sync, token)
        return result

if __name__ == "__main__":
    result = asyncio.run(fetch_data_async())
    print(result)
```
在这个示例中：
1. 定义了一个同步函数 `fetch_data_sync`，在其中设置请求头并发送 GET 请求。
2. 在 `fetch_data_async` 异步函数中，使用 `asyncio.get_running_loop` 获取事件循环，并通过 `ThreadPoolExecutor` 在线程池中运行同步函数 `fetch_data_sync`，实现异步效果。

## 常见实践
### 从环境变量中读取令牌
为了提高安全性和配置灵活性，通常将承载令牌存储在环境变量中，而不是硬编码在代码里。在 Python 中，可以使用 `os.environ` 来读取环境变量。示例如下：
```python
import asyncio
import aiohttp
import os

async def fetch_data():
    token = os.environ.get('BEARER_TOKEN')
    if not token:
        raise ValueError("BEARER_TOKEN 环境变量未设置")
    headers = {
        "Authorization": f"Bearer {token}"
    }
    async with aiohttp.ClientSession() as session:
        async with session.get('https://example.com/api/data', headers=headers) as response:
            data = await response.json()
            return data

if __name__ == "__main__":
    try:
        result = asyncio.run(fetch_data())
        print(result)
    except ValueError as e:
        print(e)
```
在上述代码中，首先尝试从环境变量 `BEARER_TOKEN` 中获取令牌。如果未设置该环境变量，则抛出 `ValueError` 异常。这样可以确保令牌不会在代码中暴露，并且可以方便地在不同环境中进行配置。

### 令牌刷新机制
许多情况下，承载令牌有一定的有效期。当令牌过期时，需要一种机制来刷新令牌并重新发送请求。以下是一个简单的令牌刷新示例：
```python
import asyncio
import aiohttp
import os

async def refresh_token():
    # 实际的刷新令牌逻辑，例如向认证服务器发送请求
    new_token = "new_refreshed_token"
    return new_token

async def fetch_data():
    token = os.environ.get('BEARER_TOKEN')
    headers = {
        "Authorization": f"Bearer {token}"
    }
    async with aiohttp.ClientSession() as session:
        for attempt in range(3):  # 最多尝试 3 次
            async with session.get('https://example.com/api/data', headers=headers) as response:
                if response.status == 401:  # 未授权，可能令牌过期
                    token = await refresh_token()
                    headers["Authorization"] = f"Bearer {token}"
                else:
                    data = await response.json()
                    return data
    raise Exception("无法获取数据，经过多次尝试仍失败")

if __name__ == "__main__":
    try:
        result = asyncio.run(fetch_data())
        print(result)
    except Exception as e:
        print(e)
```
在上述代码中：
1. 定义了 `refresh_token` 协程函数，用于模拟刷新令牌的操作。
2. 在 `fetch_data` 函数中，发送请求时如果遇到 `401` 状态码（表示未授权，可能令牌过期），则调用 `refresh_token` 函数获取新令牌，并重新发送请求，最多尝试 3 次。

## 最佳实践
### 错误处理与重试
在发送带有承载令牌的请求时，可能会遇到各种网络错误或服务器返回的错误状态码。为了确保程序的健壮性，需要进行适当的错误处理和重试机制。可以使用装饰器来实现通用的错误处理和重试逻辑。例如：
```python
import asyncio
import aiohttp
import os
import functools

def retry_on_error(max_retries=3):
    def decorator(func):
        @functools.wraps(func)
        async def wrapper(*args, **kwargs):
            for attempt in range(max_retries):
                try:
                    return await func(*args, **kwargs)
                except (aiohttp.ClientError, Exception) as e:
                    if attempt < max_retries - 1:
                        await asyncio.sleep(1)  # 等待 1 秒后重试
                    else:
                        raise e
        return wrapper
    return decorator

async def refresh_token():
    # 实际的刷新令牌逻辑，例如向认证服务器发送请求
    new_token = "new_refreshed_token"
    return new_token

@retry_on_error(max_retries=3)
async def fetch_data():
    token = os.environ.get('BEARER_TOKEN')
    headers = {
        "Authorization": f"Bearer {token}"
    }
    async with aiohttp.ClientSession() as session:
        async with session.get('https://example.com/api/data', headers=headers) as response:
            if response.status == 401:  # 未授权，可能令牌过期
                token = await refresh_token()
                headers["Authorization"] = f"Bearer {token}"
                async with session.get('https://example.com/api/data', headers=headers) as new_response:
                    data = await new_response.json()
                    return data
            else:
                data = await response.json()
                return data

if __name__ == "__main__":
    try:
        result = asyncio.run(fetch_data())
        print(result)
    except Exception as e:
        print(e)
```
在上述代码中：
1. 定义了一个 `retry_on_error` 装饰器，用于处理函数执行过程中的错误，并在失败时进行重试。
2. `fetch_data` 函数使用了该装饰器，在遇到网络错误或 `401` 状态码时进行重试操作。

### 安全存储令牌
承载令牌是敏感信息，需要安全地存储。除了从环境变量读取令牌外，还可以考虑使用加密存储库（如 `cryptography`）对令牌进行加密存储，并在使用时解密。另外，在内存中尽量减少令牌的暴露时间，例如在获取和使用令牌后尽快释放相关内存。

## 小结
在 Python 异步编程中，在请求头里发送承载令牌是实现安全 API 交互的重要环节。通过理解承载令牌的概念和 Python 异步编程的基础知识，掌握如 `aiohttp` 等库的使用方法，以及遵循常见实践和最佳实践（如从环境变量读取令牌、实现令牌刷新和错误处理重试机制、安全存储令牌等），开发者可以构建出高效、安全的异步应用程序。希望本文能够帮助读者更好地理解和应用这一技术。

## 参考资料
- [aiohttp 官方文档](https://docs.aiohttp.org/en/stable/){: rel="nofollow"}
- [Python asyncio 官方文档](https://docs.python.org/3/library/asyncio.html){: rel="nofollow"}
- [OAuth 2.0 官方文档](https://oauth.net/2/){: rel="nofollow"}
- [cryptography 官方文档](https://cryptography.io/en/latest/){: rel="nofollow"}
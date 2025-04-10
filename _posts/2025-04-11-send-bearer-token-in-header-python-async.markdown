---
title: "在 Python 异步编程中在头部发送承载令牌（Bearer Token）"
description: "在现代的 Web 开发和 API 交互中，身份验证和授权是确保系统安全的关键部分。承载令牌（Bearer Token）是一种广泛使用的身份验证机制，它允许客户端在请求中携带一个令牌来证明其身份和权限。在 Python 的异步编程环境中，如何有效地在请求头部发送承载令牌是一个常见的需求。本文将深入探讨这一主题，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者在实际项目中高效运用这一技术。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在现代的 Web 开发和 API 交互中，身份验证和授权是确保系统安全的关键部分。承载令牌（Bearer Token）是一种广泛使用的身份验证机制，它允许客户端在请求中携带一个令牌来证明其身份和权限。在 Python 的异步编程环境中，如何有效地在请求头部发送承载令牌是一个常见的需求。本文将深入探讨这一主题，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者在实际项目中高效运用这一技术。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是承载令牌（Bearer Token）
    - 为什么要在头部发送令牌
    - Python 异步编程简介
2. **使用方法**
    - 使用 `aiohttp` 库在异步请求中发送令牌
    - 使用 `requests` 库（同步库在异步环境中的有限使用）
3. **常见实践**
    - 从环境变量中获取令牌
    - 令牌的缓存和更新
    - 处理不同类型的 API 响应
4. **最佳实践**
    - 错误处理和重试机制
    - 安全性考量
    - 代码结构和模块化
5. **小结**
6. **参考资料**

## 基础概念

### 什么是承载令牌（Bearer Token）
承载令牌是一种不记名的令牌，它代表了拥有者的身份和权限。当客户端从认证服务器获取到承载令牌后，在后续的请求中只需将该令牌包含在请求中，服务器就能通过验证令牌来识别客户端并授权访问受保护的资源。例如，在 OAuth 2.0 框架中，承载令牌是客户端获取访问受保护 API 的一种方式。

### 为什么要在头部发送令牌
在 HTTP 请求头部发送承载令牌是一种常见且安全的做法。请求头部是 HTTP 协议中专门用于传递元数据的部分，将令牌放在这里可以与请求的主体内容清晰分开，并且大多数 Web 服务器和 API 都支持并期望在头部中接收身份验证信息。此外，这种方式易于实现和标准化，符合 RESTful API 的设计原则。

### Python 异步编程简介
Python 的异步编程允许程序在等待 I/O 操作（如网络请求、文件读取等）时不阻塞主线程，从而提高程序的整体性能和响应性。通过 `async` 和 `await` 关键字，开发者可以定义异步函数，并在这些函数中暂停执行以等待异步操作完成。常见的异步库有 `aiohttp`（用于异步 HTTP 请求）、`asyncio`（Python 的异步 I/O 库）等。

## 使用方法

### 使用 `aiohttp` 库在异步请求中发送令牌
`aiohttp` 是一个用于异步 HTTP 客户端和服务器的库，在异步环境中使用它来发送包含承载令牌的请求非常方便。

```python
import aiohttp
import asyncio


async def fetch_data():
    token = "your_bearer_token_here"
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

在上述代码中：
1. 我们首先定义了一个 `fetch_data` 异步函数。
2. 在函数内部，我们设置了承载令牌，并将其添加到请求头部的 `Authorization` 字段中，格式为 `Bearer {token}`。
3. 使用 `aiohttp.ClientSession` 创建一个会话，并在会话中发送 `GET` 请求，携带包含令牌的头部。
4. 最后，使用 `asyncio` 的事件循环来运行异步函数并获取响应数据。

### 使用 `requests` 库（同步库在异步环境中的有限使用）
虽然 `requests` 是一个同步的 HTTP 库，但在某些情况下，我们可能仍然需要在异步代码中使用它。不过要注意，这会阻塞异步事件循环，影响整体性能。

```python
import requests
import asyncio


async def fetch_data_sync():
    token = "your_bearer_token_here"
    headers = {
        "Authorization": f"Bearer {token}"
    }
    loop = asyncio.get_running_loop()
    response = await loop.run_in_executor(None, lambda: requests.get('https://example.com/api/data', headers=headers))
    data = response.json()
    return data


loop = asyncio.get_event_loop()
result = loop.run_until_complete(fetch_data_sync())
print(result)
```

在这个例子中：
1. 定义了 `fetch_data_sync` 异步函数。
2. 使用 `asyncio.get_running_loop` 获取当前的事件循环。
3. 通过 `loop.run_in_executor` 在单独的线程中运行 `requests.get` 操作，以避免阻塞事件循环。

## 常见实践

### 从环境变量中获取令牌
为了提高代码的可配置性和安全性，通常将承载令牌存储在环境变量中。

```python
import os
import aiohttp
import asyncio


async def fetch_data():
    token = os.getenv("BEARER_TOKEN")
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
try:
    result = loop.run_until_complete(fetch_data())
    print(result)
except ValueError as e:
    print(e)
```

在上述代码中，使用 `os.getenv` 从环境变量中获取 `BEARER_TOKEN`，如果环境变量未设置，则抛出 `ValueError` 异常。

### 令牌的缓存和更新
如果令牌有一定的有效期，我们需要在有效期内缓存令牌，并在过期时进行更新。

```python
import os
import aiohttp
import asyncio

token_cache = None


async def get_token():
    global token_cache
    if token_cache:
        return token_cache
    # 实际获取令牌的逻辑，例如通过认证服务器
    new_token = "new_bearer_token_obtained_from_auth_server"
    token_cache = new_token
    return new_token


async def fetch_data():
    token = await get_token()
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

在这个示例中，`get_token` 函数负责缓存和获取令牌。如果缓存中存在有效的令牌，则直接返回；否则，获取新的令牌并更新缓存。

### 处理不同类型的 API 响应
不同的 API 可能返回不同格式和状态码的响应。我们需要根据实际情况进行处理。

```python
import os
import aiohttp
import asyncio


async def fetch_data():
    token = os.getenv("BEARER_TOKEN")
    headers = {
        "Authorization": f"Bearer {token}"
    }
    async with aiohttp.ClientSession() as session:
        async with session.get('https://example.com/api/data', headers=headers) as response:
            if response.status == 200:
                data = await response.json()
                return data
            elif response.status == 401:
                raise ValueError("Unauthorized. Token may be invalid or expired.")
            else:
                raise ValueError(f"Unexpected status code: {response.status}")


loop = asyncio.get_event_loop()
try:
    result = loop.run_until_complete(fetch_data())
    print(result)
except ValueError as e:
    print(e)
```

在这段代码中，根据响应的状态码进行不同的处理。如果状态码为 200，则正常解析 JSON 数据；如果为 401，则表示未授权，可能需要重新获取令牌；其他状态码则抛出异常。

## 最佳实践

### 错误处理和重试机制
在网络请求中，可能会遇到各种错误，如网络超时、服务器故障等。添加错误处理和重试机制可以提高程序的健壮性。

```python
import os
import aiohttp
import asyncio


async def fetch_data_with_retries(max_retries=3):
    token = os.getenv("BEARER_TOKEN")
    headers = {
        "Authorization": f"Bearer {token}"
    }
    retries = 0
    while retries < max_retries:
        try:
            async with aiohttp.ClientSession() as session:
                async with session.get('https://example.com/api/data', headers=headers) as response:
                    if response.status == 200:
                        data = await response.json()
                        return data
                    elif response.status == 401:
                        raise ValueError("Unauthorized. Token may be invalid or expired.")
                    else:
                        raise ValueError(f"Unexpected status code: {response.status}")
        except (aiohttp.ClientError, ValueError) as e:
            retries += 1
            if retries == max_retries:
                raise
            await asyncio.sleep(1)


loop = asyncio.get_event_loop()
try:
    result = loop.run_until_complete(fetch_data_with_retries())
    print(result)
except (aiohttp.ClientError, ValueError) as e:
    print(e)
```

在这个示例中，`fetch_data_with_retries` 函数在遇到错误时会进行重试，最多重试 `max_retries` 次。每次重试之间会等待 1 秒。

### 安全性考量
1. **令牌存储安全**：将令牌存储在环境变量中，并确保运行环境的安全性，避免令牌泄露。
2. **传输安全**：始终使用 HTTPS 进行请求，以加密传输令牌和其他敏感数据。
3. **令牌有效期管理**：严格管理令牌的有效期，及时更新令牌，防止因令牌过期导致的服务中断。

### 代码结构和模块化
将与令牌处理和请求发送相关的逻辑封装到独立的函数或类中，提高代码的可读性和可维护性。

```python
import os
import aiohttp
import asyncio


class TokenManager:
    def __init__(self):
        self.token_cache = None

    async def get_token(self):
        if self.token_cache:
            return self.token_cache
        # 实际获取令牌的逻辑，例如通过认证服务器
        new_token = "new_bearer_token_obtained_from_auth_server"
        self.token_cache = new_token
        return new_token


class APIClient:
    def __init__(self):
        self.token_manager = TokenManager()

    async def fetch_data(self):
        token = await self.token_manager.get_token()
        headers = {
            "Authorization": f"Bearer {token}"
        }
        async with aiohttp.ClientSession() as session:
            async with session.get('https://example.com/api/data', headers=headers) as response:
                if response.status == 200:
                    data = await response.json()
                    return data
                elif response.status == 401:
                    raise ValueError("Unauthorized. Token may be invalid or expired.")
                else:
                    raise ValueError(f"Unexpected status code: {response.status}")


async def main():
    client = APIClient()
    try:
        result = await client.fetch_data()
        print(result)
    except ValueError as e:
        print(e)


loop = asyncio.get_event_loop()
loop.run_until_complete(main())
```

在这个代码结构中，`TokenManager` 类负责管理令牌的获取和缓存，`APIClient` 类负责发送请求并处理响应。通过这种模块化的方式，代码更加清晰和易于扩展。

## 小结
在 Python 异步编程中，在头部发送承载令牌是实现身份验证和授权的重要步骤。通过理解基础概念、掌握不同库的使用方法、遵循常见实践和最佳实践，开发者可以构建出高效、安全且健壮的应用程序。希望本文提供的信息能帮助读者在实际项目中更好地运用这一技术。

## 参考资料
- [aiohttp 官方文档](https://docs.aiohttp.org/en/stable/){: rel="nofollow"}
- [Python 官方异步编程文档](https://docs.python.org/3/library/asyncio.html){: rel="nofollow"}
- [OAuth 2.0 官方文档](https://oauth.net/2/){: rel="nofollow"}
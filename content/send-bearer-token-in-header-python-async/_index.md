---
title: "在 Python 异步编程中在头部发送承载令牌（Bearer Token）"
description: "在现代的 Web 开发和 API 交互中，身份验证是至关重要的一环。承载令牌（Bearer Token）是一种广泛使用的身份验证机制，它允许客户端在请求中携带一个令牌来证明其身份。在 Python 的异步编程环境中，有效地在请求头部发送承载令牌对于构建高效、安全的应用程序至关重要。本文将深入探讨在 Python 异步编程中如何在请求头部发送承载令牌，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在现代的 Web 开发和 API 交互中，身份验证是至关重要的一环。承载令牌（Bearer Token）是一种广泛使用的身份验证机制，它允许客户端在请求中携带一个令牌来证明其身份。在 Python 的异步编程环境中，有效地在请求头部发送承载令牌对于构建高效、安全的应用程序至关重要。本文将深入探讨在 Python 异步编程中如何在请求头部发送承载令牌，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
    - 什么是承载令牌（Bearer Token）
    - 为什么在异步编程中需要在头部发送令牌
2. 使用方法
    - 使用 `aiohttp` 库发送带有承载令牌的请求
    - 使用 `requests` 库（在异步上下文中的适配）发送带有承载令牌的请求
3. 常见实践
    - 从环境变量中获取令牌
    - 处理令牌过期
    - 与异步框架（如 FastAPI）集成
4. 最佳实践
    - 安全存储令牌
    - 错误处理与重试机制
    - 性能优化
5. 小结
6. 参考资料

## 基础概念

### 什么是承载令牌（Bearer Token）
承载令牌是一种身份验证机制，它是一个字符串，代表了用户或应用的身份。服务器在用户成功登录或进行身份验证后，会生成一个承载令牌并返回给客户端。客户端在后续的请求中，将这个令牌包含在请求头部（通常是 `Authorization` 头部），服务器通过验证这个令牌来确定请求的合法性。例如：
```
Authorization: Bearer <token_value>
```

### 为什么在异步编程中需要在头部发送令牌
在异步编程中，我们通常会处理多个并发请求，比如在一个异步的 Web 应用中，多个用户的请求可能同时到达。在这种情况下，每个请求都需要正确的身份验证信息。通过在请求头部发送承载令牌，我们可以确保每个请求都能被服务器正确识别和授权，从而保证系统的安全性和数据的保密性。

## 使用方法

### 使用 `aiohttp` 库发送带有承载令牌的请求
`aiohttp` 是一个流行的用于 Python 异步编程的 HTTP 客户端/服务器库。以下是一个简单的示例：

```python
import asyncio
import aiohttp


async def fetch(session, url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    async with session.get(url, headers=headers) as response:
        return await response.json()


async def main():
    token = "your_bearer_token"
    async with aiohttp.ClientSession() as session:
        result = await fetch(session, "https://example.com/api/data", token)
        print(result)


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
```

### 使用 `requests` 库（在异步上下文中的适配）发送带有承载令牌的请求
虽然 `requests` 库不是原生异步的，但可以通过 `asyncio` 和 `concurrent.futures` 来在异步上下文中使用它。

```python
import asyncio
import requests
from concurrent.futures import ThreadPoolExecutor


def fetch_sync(url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = requests.get(url, headers=headers)
    return response.json()


async def fetch_async(url, token):
    loop = asyncio.get_running_loop()
    with ThreadPoolExecutor() as executor:
        result = await loop.run_in_executor(executor, fetch_sync, url, token)
        return result


async def main():
    token = "your_bearer_token"
    result = await fetch_async("https://example.com/api/data", token)
    print(result)


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
```

## 常见实践

### 从环境变量中获取令牌
为了安全和方便管理，通常将承载令牌存储在环境变量中。在 Python 中，可以使用 `os.environ` 来获取环境变量。

```python
import os


token = os.environ.get('BEARER_TOKEN')
```

### 处理令牌过期
当令牌过期时，需要重新获取令牌并重新发送请求。可以通过捕获服务器返回的特定错误码（如 401 Unauthorized）来触发令牌刷新逻辑。

```python
async def fetch(session, url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    async with session.get(url, headers=headers) as response:
        if response.status == 401:
            # 刷新令牌逻辑
            new_token = await refresh_token()
            headers['Authorization'] = f'Bearer {new_token}'
            async with session.get(url, headers=headers) as new_response:
                return await new_response.json()
        else:
            return await response.json()


async def refresh_token():
    # 实现刷新令牌的逻辑
    pass


```

### 与异步框架（如 FastAPI）集成
在 FastAPI 应用中，可以通过依赖注入来处理带有承载令牌的请求。

```python
from fastapi import Depends, FastAPI
from fastapi.security import OAuth2PasswordBearer

app = FastAPI()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


@app.get("/protected")
async def protected_route(token: str = Depends(oauth2_scheme)):
    return {"message": f"Token is valid: {token}"}


```

## 最佳实践

### 安全存储令牌
不要将令牌硬编码在代码中，而是使用安全的存储方式，如环境变量、密钥管理服务（如 HashiCorp Vault）或操作系统的密钥环。

### 错误处理与重试机制
在请求失败时，特别是由于网络问题或令牌相关问题导致的失败，应实现适当的错误处理和重试机制，以提高应用的稳定性。

```python
import asyncio
import aiohttp


async def fetch_with_retries(session, url, token, max_retries=3):
    retries = 0
    while retries < max_retries:
        try:
            headers = {
                'Authorization': f'Bearer {token}'
            }
            async with session.get(url, headers=headers) as response:
                return await response.json()
        except Exception as e:
            retries += 1
            await asyncio.sleep(1)  # 等待一段时间后重试
    raise Exception("Max retries exceeded")


async def main():
    token = "your_bearer_token"
    async with aiohttp.ClientSession() as session:
        result = await fetch_with_retries(session, "https://example.com/api/data", token)
        print(result)


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())


```

### 性能优化
在处理大量带有令牌的异步请求时，要注意资源的合理使用，如连接池的管理。`aiohttp` 库会自动管理连接池，但在复杂场景下可能需要进一步优化。

## 小结
在 Python 异步编程中在头部发送承载令牌是实现安全、高效 API 交互的关键步骤。通过理解基础概念、掌握使用方法、遵循常见实践和最佳实践，开发者可以构建出健壮、安全的应用程序。无论是使用 `aiohttp` 这样的原生异步库，还是在异步上下文中适配 `requests` 库，都需要注意令牌的管理、错误处理和性能优化。

## 参考资料
- [aiohttp 官方文档](https://docs.aiohttp.org/en/stable/)
- [FastAPI 官方文档](https://fastapi.tiangolo.com/)
- [Python asyncio 官方文档](https://docs.python.org/3/library/asyncio.html)
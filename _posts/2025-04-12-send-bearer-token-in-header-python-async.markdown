---
title: "在 Python 异步编程中在头部发送承载令牌"
description: "在现代的 Web 开发和 API 交互中，身份验证是至关重要的一部分。承载令牌（Bearer Token）是一种广泛用于身份验证的机制。在 Python 的异步编程环境中，正确地在请求头部发送承载令牌对于确保安全、高效的 API 通信至关重要。本文将深入探讨在 Python 异步代码中如何在请求头部发送承载令牌，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在现代的 Web 开发和 API 交互中，身份验证是至关重要的一部分。承载令牌（Bearer Token）是一种广泛用于身份验证的机制。在 Python 的异步编程环境中，正确地在请求头部发送承载令牌对于确保安全、高效的 API 通信至关重要。本文将深入探讨在 Python 异步代码中如何在请求头部发送承载令牌，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是承载令牌
    - 为什么要在头部发送承载令牌
    - Python 异步编程简介
2. **使用方法**
    - 使用 `aiohttp` 库发送带有承载令牌的请求
    - 使用 `requests` 库的异步版本 `requests - async` 发送请求（如果适用）
3. **常见实践**
    - 从环境变量中获取承载令牌
    - 处理令牌过期和自动刷新
4. **最佳实践**
    - 错误处理和重试机制
    - 安全存储和管理承载令牌
5. **小结**
6. **参考资料**

## 基础概念

### 什么是承载令牌
承载令牌是一种身份验证令牌，它允许访问受保护的资源。简单来说，拥有这个令牌的一方被视为经过授权可以访问特定的资源。通常，它是一个字符串，在请求中传递给服务器，服务器通过验证令牌的有效性来决定是否授予对请求资源的访问权限。

### 为什么要在头部发送承载令牌
将承载令牌放在请求头部是一种标准的做法，主要有以下几个原因：
1. **与 HTTP 协议兼容**：HTTP 头部是用于传递各种元数据的标准位置，将令牌放在这里符合 HTTP 的设计原则。
2. **安全**：相比于放在请求参数中，令牌在头部更不容易暴露在日志或 URL 中，减少了令牌泄露的风险。
3. **易于服务器处理**：服务器端框架通常更容易从头部提取和验证令牌。

### Python 异步编程简介
Python 的异步编程允许程序在等待 I/O 操作（如网络请求、文件读取等）时执行其他任务，从而提高程序的整体效率。主要通过 `async` 和 `await` 关键字来实现。`async` 用于定义一个异步函数，`await` 用于暂停异步函数的执行，直到等待的操作完成。

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
    token = "your_bearer_token_here"
    url = "https://example.com/api/data"
    async with aiohttp.ClientSession() as session:
        result = await fetch(session, url, token)
        print(result)


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
```

在这个示例中：
1. 我们定义了一个 `fetch` 函数，它接受一个 `session` 对象、目标 `url` 和 `token`。
2. 在 `headers` 字典中，我们添加了 `Authorization` 头部，其值为 `Bearer` 加上实际的令牌。
3. 使用 `session.get` 方法发送带有头部的 GET 请求，并等待响应。
4. `main` 函数设置了令牌和目标 URL，创建了一个 `ClientSession`，并调用 `fetch` 函数获取数据。

### 使用 `requests - async` 库发送请求（如果适用）
`requests - async` 是 `requests` 库的异步版本。安装后可以这样使用：

```python
import asyncio
import requests_async as requests


async def fetch(url, token):
    headers = {
        'Authorization': f'Bearer {token}'
    }
    response = await requests.get(url, headers=headers)
    return response.json()


async def main():
    token = "your_bearer_token_here"
    url = "https://example.com/api/data"
    result = await fetch(url, token)
    print(result)


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
```

这个示例与 `aiohttp` 的示例类似，只是使用了 `requests_async` 库来发送请求。

## 常见实践

### 从环境变量中获取承载令牌
为了提高安全性和配置的灵活性，通常建议将承载令牌存储在环境变量中。在 Python 中，可以使用 `os` 模块来获取环境变量：

```python
import asyncio
import aiohttp
import os


async def fetch(session, url):
    token = os.getenv('BEARER_TOKEN')
    headers = {
        'Authorization': f'Bearer {token}'
    }
    async with session.get(url, headers=headers) as response:
        return await response.json()


async def main():
    url = "https://example.com/api/data"
    async with aiohttp.ClientSession() as session:
        result = await fetch(session, url)
        print(result)


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
```

在运行脚本之前，需要在环境中设置 `BEARER_TOKEN` 变量，例如在 Linux 或 macOS 上可以使用 `export BEARER_TOKEN="your_token"`，在 Windows 上可以使用 `set BEARER_TOKEN="your_token"`。

### 处理令牌过期和自动刷新
许多 API 提供的承载令牌都有有效期，过期后需要重新获取。以下是一个简单的处理令牌过期和自动刷新的示例：

```python
import asyncio
import aiohttp
import os


async def refresh_token():
    # 这里是实际刷新令牌的逻辑，例如向认证服务器发送请求
    new_token = "new_refreshed_token"
    return new_token


async def fetch(session, url):
    token = os.getenv('BEARER_TOKEN')
    headers = {
        'Authorization': f'Bearer {token}'
    }
    async with session.get(url, headers=headers) as response:
        if response.status == 401:  # 令牌过期的常见状态码
            new_token = await refresh_token()
            os.environ['BEARER_TOKEN'] = new_token
            headers['Authorization'] = f'Bearer {new_token}'
            async with session.get(url, headers=headers) as new_response:
                return await new_response.json()
        else:
            return await response.json()


async def main():
    url = "https://example.com/api/data"
    async with aiohttp.ClientSession() as session:
        result = await fetch(session, url)
        print(result)


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
```

在这个示例中，当请求返回 401 状态码（通常表示未经授权，可能是令牌过期）时，我们调用 `refresh_token` 函数获取新的令牌，并重新发送请求。

## 最佳实践

### 错误处理和重试机制
在发送带有承载令牌的请求时，可能会遇到各种网络错误或服务器端错误。添加错误处理和重试机制可以提高程序的健壮性。

```python
import asyncio
import aiohttp
import os


async def refresh_token():
    new_token = "new_refreshed_token"
    return new_token


async def fetch(session, url, max_retries=3):
    token = os.getenv('BEARER_TOKEN')
    headers = {
        'Authorization': f'Bearer {token}'
    }
    retries = 0
    while retries < max_retries:
        try:
            async with session.get(url, headers=headers) as response:
                if response.status == 401:
                    new_token = await refresh_token()
                    os.environ['BEARER_TOKEN'] = new_token
                    headers['Authorization'] = f'Bearer {new_token}'
                    async with session.get(url, headers=headers) as new_response:
                        return await new_response.json()
                else:
                    return await response.json()
        except aiohttp.ClientError as e:
            print(f"Error: {e}")
            retries += 1
            await asyncio.sleep(1)  # 等待一段时间后重试
    raise Exception("Max retries reached")


async def main():
    url = "https://example.com/api/data"
    async with aiohttp.ClientSession() as session:
        result = await fetch(session, url)
        print(result)


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
```

在这个示例中，我们添加了一个重试机制，当遇到 `aiohttp.ClientError` 时，会等待 1 秒后重试，最多重试 3 次。

### 安全存储和管理承载令牌
承载令牌是访问受保护资源的关键，因此安全存储和管理至关重要。
1. **避免硬编码**：如前面所述，从环境变量中获取令牌，而不是在代码中直接硬编码。
2. **使用安全的存储机制**：对于长期存储，可以考虑使用密钥管理服务（如 HashiCorp Vault、AWS Secrets Manager 等），或者使用操作系统提供的安全存储功能（如 macOS 的 Keychain、Windows 的 Credential Manager）。
3. **限制令牌的有效期**：尽量使用有效期较短的令牌，并及时刷新，以减少令牌泄露带来的风险。

## 小结
在 Python 异步编程中，在请求头部发送承载令牌是实现安全 API 通信的重要环节。通过理解承载令牌的概念、掌握在异步库中发送令牌的方法、遵循常见实践和最佳实践，我们可以构建出高效、安全的应用程序。希望本文的内容能帮助你在实际项目中更好地处理承载令牌相关的操作。

## 参考资料
- [aiohttp 官方文档](https://docs.aiohttp.org/en/stable/){: rel="nofollow"}
- [requests - async 官方文档](https://github.com/ross/requests-async){: rel="nofollow"}
- [Python 官方异步编程文档](https://docs.python.org/3/library/asyncio.html){: rel="nofollow"}
---
title: "深入理解 Python 中 log httpx request"
description: "在 Python 的网络请求处理中，`httpx` 是一个强大且易用的库。而记录 `httpx` 请求（log httpx request）在调试、监控以及安全审计等方面都有着重要意义。通过记录请求的详细信息，我们能够更好地理解程序与外部服务之间的交互过程，快速定位问题并优化性能。本文将深入探讨如何在 Python 中记录 `httpx` 请求，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 的网络请求处理中，`httpx` 是一个强大且易用的库。而记录 `httpx` 请求（log httpx request）在调试、监控以及安全审计等方面都有着重要意义。通过记录请求的详细信息，我们能够更好地理解程序与外部服务之间的交互过程，快速定位问题并优化性能。本文将深入探讨如何在 Python 中记录 `httpx` 请求，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 配置日志记录
    - 记录 `httpx` 请求
3. 常见实践
    - 记录请求头
    - 记录请求体
    - 记录响应信息
4. 最佳实践
    - 日志级别控制
    - 日志格式优化
    - 日志文件管理
5. 小结
6. 参考资料

## 基础概念
### `httpx` 库
`httpx` 是一个基于 Python 的现代 HTTP 客户端库，它同时支持同步和异步请求，提供了简洁易用的 API。`httpx` 不仅能处理标准的 HTTP 协议，还支持 HTTP/2 协议，在性能和功能上都表现出色。

### 日志记录（Logging）
日志记录是一种在程序运行过程中记录重要信息的机制。通过日志，我们可以了解程序的执行流程、记录错误信息以及跟踪请求和响应。Python 内置了 `logging` 模块，用于实现日志记录功能。我们可以通过配置 `logging` 模块来定义日志的级别、格式以及输出位置等。

## 使用方法
### 配置日志记录
首先，我们需要配置 Python 的 `logging` 模块。以下是一个基本的日志配置示例：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个控制台处理器并设置级别为 DEBUG
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# 创建一个日志格式
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将日志格式添加到控制台处理器
ch.setFormatter(formatter)

# 将控制台处理器添加到日志记录器
logger.addHandler(ch)
```

在上述代码中，我们创建了一个日志记录器 `logger`，设置其日志级别为 `DEBUG`。然后创建了一个控制台处理器 `ch`，并将其日志级别也设置为 `DEBUG`。接着定义了一个日志格式 `formatter`，最后将格式添加到处理器并将处理器添加到日志记录器。这样，所有发送到这个日志记录器的日志信息都会按照指定的格式输出到控制台。

### 记录 `httpx` 请求
要记录 `httpx` 请求，我们需要使用 `httpx` 的事件钩子（event hooks）功能。`httpx` 提供了 `request`、`response` 等事件钩子，我们可以在这些钩子函数中记录请求和响应的相关信息。

```python
import httpx


async def log_request(request):
    logger.debug(f"Request method: {request.method}")
    logger.debug(f"Request url: {request.url}")


async def log_response(response):
    logger.debug(f"Response status code: {response.status_code}")


async def main():
    async with httpx.AsyncClient(event_hooks={"request": [log_request], "response": [log_response]}) as client:
        response = await client.get('https://example.com')


if __name__ == "__main__":
    import asyncio

    asyncio.run(main())

```

在上述代码中，我们定义了两个异步函数 `log_request` 和 `log_response`，分别用于记录请求和响应的信息。在 `main` 函数中，我们创建了一个 `httpx` 的异步客户端，并通过 `event_hooks` 参数注册了这两个函数。这样，每次发送请求和收到响应时，相应的日志信息就会被记录下来。

## 常见实践
### 记录请求头
请求头中包含了很多重要信息，如认证信息、用户代理等。我们可以在 `log_request` 函数中添加记录请求头的代码：

```python
async def log_request(request):
    logger.debug(f"Request method: {request.method}")
    logger.debug(f"Request url: {request.url}")
    logger.debug("Request headers:")
    for key, value in request.headers.items():
        logger.debug(f"{key}: {value}")
```

### 记录请求体
对于 POST、PUT 等请求，请求体中可能包含了发送给服务器的数据。我们可以通过以下方式记录请求体：

```python
async def log_request(request):
    logger.debug(f"Request method: {request.method}")
    logger.debug(f"Request url: {request.url}")
    logger.debug("Request headers:")
    for key, value in request.headers.items():
        logger.debug(f"{key}: {value}")

    if request.content_length:
        body = await request.aread()
        logger.debug(f"Request body: {body.decode('utf-8')}")
```

### 记录响应信息
除了记录响应状态码，我们还可以记录响应头和响应体：

```python
async def log_response(response):
    logger.debug(f"Response status code: {response.status_code}")
    logger.debug("Response headers:")
    for key, value in response.headers.items():
        logger.debug(f"{key}: {value}")

    if response.content_length:
        body = await response.aread()
        logger.debug(f"Response body: {body.decode('utf-8')}")
```

## 最佳实践
### 日志级别控制
根据不同的环境和需求，合理设置日志级别。在开发环境中，可以将日志级别设置为 `DEBUG`，以便获取详细的信息；在生产环境中，建议将日志级别设置为 `INFO` 或 `WARN`，避免过多的日志信息影响系统性能。

```python
# 在开发环境中
logger.setLevel(logging.DEBUG)

# 在生产环境中
logger.setLevel(logging.INFO)
```

### 日志格式优化
优化日志格式，使其包含更有用的信息。例如，可以添加线程信息、进程信息等。

```python
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(threadName)s - %(message)s')
```

### 日志文件管理
将日志输出到文件中，便于后续的分析和审计。可以使用 `logging.FileHandler` 来实现，并设置日志文件的大小限制和备份策略。

```python
# 创建一个文件处理器
fh = logging.FileHandler('app.log')
fh.setLevel(logging.DEBUG)

# 设置日志文件大小限制和备份策略
from logging.handlers import RotatingFileHandler
fh = RotatingFileHandler('app.log', maxBytes=1024*1024, backupCount=5)

formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
fh.setFormatter(formatter)

logger.addHandler(fh)
```

## 小结
通过本文，我们深入了解了在 Python 中如何记录 `httpx` 请求。从基础概念的介绍，到详细的使用方法、常见实践以及最佳实践，希望读者能够掌握如何有效地记录和管理 `httpx` 请求相关的日志信息。这不仅有助于调试和优化网络请求代码，还能提高系统的可维护性和安全性。

## 参考资料
- [httpx 官方文档](https://www.python-httpx.org/)
- [Python logging 模块官方文档](https://docs.python.org/3/library/logging.html)
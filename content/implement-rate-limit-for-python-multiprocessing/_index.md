---
title: "为 Python 多进程实现速率限制"
description: "在 Python 的多进程编程中，速率限制（Rate Limit）是一个重要的概念。多进程允许我们充分利用多核处理器的优势，并行处理任务以提高程序的执行效率。然而，在某些情况下，我们可能需要对进程的执行频率或资源使用进行限制，这就是速率限制发挥作用的地方。通过实施速率限制，我们可以避免系统资源过度消耗，确保程序稳定运行，同时也可以满足一些外部服务的请求频率限制等需求。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 的多进程编程中，速率限制（Rate Limit）是一个重要的概念。多进程允许我们充分利用多核处理器的优势，并行处理任务以提高程序的执行效率。然而，在某些情况下，我们可能需要对进程的执行频率或资源使用进行限制，这就是速率限制发挥作用的地方。通过实施速率限制，我们可以避免系统资源过度消耗，确保程序稳定运行，同时也可以满足一些外部服务的请求频率限制等需求。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
### 速率限制是什么
速率限制是一种控制机制，它限制了在给定时间内某个操作或事件的发生频率。在 Python 多进程环境中，这意味着我们可以限制进程启动的频率、进程对资源（如网络带宽、文件 I/O 等）的访问频率等。

### 为什么需要速率限制
 - **资源保护**：防止过多进程同时运行导致系统资源（如内存、CPU）耗尽，使系统崩溃或性能严重下降。
 - **避免外部服务过载**：当多进程与外部 API 交互时，许多 API 都有请求频率限制，实施速率限制可以确保我们的程序不会因为发送过多请求而被封禁。

## 使用方法
### 使用 `time.sleep` 实现简单速率限制
```python
import multiprocessing
import time


def worker_function():
    print(f"{multiprocessing.current_process().name} is working")


if __name__ == '__main__':
    rate_limit = 2  # 每秒允许启动的进程数
    interval = 1 / rate_limit

    for _ in range(10):
        p = multiprocessing.Process(target=worker_function)
        p.start()
        time.sleep(interval)
```
在这个例子中，我们通过 `time.sleep` 函数来控制进程启动的频率。`rate_limit` 变量定义了每秒允许启动的进程数，`interval` 是每个进程启动之间需要等待的时间。

### 使用 `multiprocessing.Semaphore` 实现更复杂的速率限制
```python
import multiprocessing
import time


def worker_function(semaphore):
    with semaphore:
        print(f"{multiprocessing.current_process().name} is working")


if __name__ == '__main__':
    rate_limit = 3  # 每秒允许启动的进程数
    semaphore = multiprocessing.Semaphore(rate_limit)

    process_list = []
    for _ in range(10):
        p = multiprocessing.Process(target=worker_function, args=(semaphore,))
        p.start()
        process_list.append(p)

    for p in process_list:
        p.join()
```
这里我们使用 `multiprocessing.Semaphore` 信号量来控制并发进程的数量。信号量的初始值为 `rate_limit`，每个进程在开始执行任务前需要获取信号量，执行完后释放信号量，从而确保在同一时间内最多有 `rate_limit` 个进程在运行。

## 常见实践
### 网络请求速率限制
在多进程中进行网络请求时，我们需要限制请求的频率，以避免被服务器封禁或造成网络拥塞。
```python
import multiprocessing
import requests
import time


def fetch_url(semaphore, url):
    with semaphore:
        response = requests.get(url)
        print(f"{multiprocessing.current_process().name} fetched {url} with status code {response.status_code}")


if __name__ == '__main__':
    urls = ["http://example.com" for _ in range(10)]
    rate_limit = 5  # 每秒允许的请求数
    semaphore = multiprocessing.Semaphore(rate_limit)

    process_list = []
    for url in urls:
        p = multiprocessing.Process(target=fetch_url, args=(semaphore, url))
        p.start()
        process_list.append(p)

    for p in process_list:
        p.join()
```
### 文件 I/O 速率限制
在多进程同时进行文件读写操作时，限制 I/O 速率可以防止文件系统过载。
```python
import multiprocessing
import time


def write_to_file(semaphore, file_path, content):
    with semaphore:
        with open(file_path, 'a') as f:
            f.write(content)
            print(f"{multiprocessing.current_process().name} wrote to {file_path}")


if __name__ == '__main__':
    file_path = "output.txt"
    rate_limit = 4  # 每秒允许的文件写入操作数
    semaphore = multiprocessing.Semaphore(rate_limit)

    data_list = ["Line " + str(i) for i in range(10)]
    process_list = []
    for data in data_list:
        p = multiprocessing.Process(target=write_to_file, args=(semaphore, file_path, data))
        p.start()
        process_list.append(p)

    for p in process_list:
        p.join()
```

## 最佳实践
### 动态调整速率限制
根据系统资源的使用情况或外部服务的反馈，动态调整速率限制。例如，可以使用 `psutil` 库来监控系统资源，然后根据资源的空闲情况调整 `Semaphore` 的值。
```python
import multiprocessing
import psutil
import time


def worker_function(semaphore):
    with semaphore:
        print(f"{multiprocessing.current_process().name} is working")


if __name__ == '__main__':
    initial_rate_limit = 3
    semaphore = multiprocessing.Semaphore(initial_rate_limit)

    process_list = []
    for _ in range(10):
        while psutil.cpu_percent() > 80:  # 如果 CPU 使用率超过 80%
            time.sleep(1)  # 等待资源空闲
        new_rate_limit = max(1, int(psutil.cpu_count() * 0.5))  # 根据 CPU 核心数动态调整速率限制
        semaphore = multiprocessing.Semaphore(new_rate_limit)
        p = multiprocessing.Process(target=worker_function, args=(semaphore,))
        p.start()
        process_list.append(p)

    for p in process_list:
        p.join()
```

### 日志记录与监控
记录速率限制的相关信息，如实际的请求频率、进程启动时间等，以便进行监控和调试。可以使用 Python 的 `logging` 模块来实现。
```python
import multiprocessing
import logging
import time


def worker_function(semaphore):
    logger = logging.getLogger(__name__)
    with semaphore:
        logger.info(f"{multiprocessing.current_process().name} is working")


if __name__ == '__main__':
    rate_limit = 2
    semaphore = multiprocessing.Semaphore(rate_limit)

    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

    process_list = []
    for _ in range(10):
        p = multiprocessing.Process(target=worker_function, args=(semaphore,))
        p.start()
        process_list.append(p)
        time.sleep(1 / rate_limit)

    for p in process_list:
        p.join()
```

## 小结
在 Python 多进程编程中实现速率限制是确保程序稳定运行、合理利用资源以及满足外部服务要求的重要手段。通过简单的 `time.sleep` 或更复杂的 `multiprocessing.Semaphore` 等工具，我们可以轻松地控制进程的启动频率和并发数量。同时，结合动态调整速率限制和日志记录监控等最佳实践，可以使我们的多进程程序更加健壮和灵活。

## 参考资料
 - 《Python 并发编程实战》
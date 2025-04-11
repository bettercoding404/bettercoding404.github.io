---
title: "为 Python 多进程实现速率限制"
description: "在处理 Python 多进程任务时，速率限制是一项重要的技术。它可以帮助我们控制进程执行的频率，避免对系统资源造成过度压力，或者在网络请求等场景下，避免超过外部服务的请求限制。本文将深入探讨如何为 Python 多进程实现速率限制，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在处理 Python 多进程任务时，速率限制是一项重要的技术。它可以帮助我们控制进程执行的频率，避免对系统资源造成过度压力，或者在网络请求等场景下，避免超过外部服务的请求限制。本文将深入探讨如何为 Python 多进程实现速率限制，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `time.sleep` 实现简单速率限制
    - 使用 `queue.Queue` 实现速率限制
    - 使用第三方库 `ratelimit`
3. 常见实践
    - 网络请求速率限制
    - 文件读写速率限制
4. 最佳实践
    - 结合日志记录
    - 动态调整速率限制
5. 小结
6. 参考资料

## 基础概念
速率限制是指在一定时间范围内，限制某个操作的执行次数。在 Python 多进程环境中，这意味着我们需要控制每个进程或者整个进程池在单位时间内的任务执行频率。这可以通过多种方式实现，主要思路是通过某种机制来监控和控制任务的执行时间间隔。

## 使用方法

### 使用 `time.sleep` 实现简单速率限制
这是一种最基本的方法，通过在进程执行任务后使用 `time.sleep` 来暂停一段时间，从而控制执行频率。

```python
import multiprocessing
import time


def task_with_rate_limit():
    for _ in range(5):
        print("Task is running")
        time.sleep(1)  # 每 1 秒执行一次任务


if __name__ == "__main__":
    p = multiprocessing.Process(target=task_with_rate_limit)
    p.start()
    p.join()
```

### 使用 `queue.Queue` 实现速率限制
`queue.Queue` 可以用来控制进程执行的节奏。我们可以在队列中放入一定数量的元素，每个进程在执行任务前从队列中获取一个元素，如果队列为空则等待。

```python
import multiprocessing
import time


def task(queue):
    while True:
        if not queue.empty():
            queue.get()
            print("Task is running")
            time.sleep(1)


if __name__ == "__main__":
    q = multiprocessing.Queue()
    for _ in range(5):
        q.put(1)  # 初始化队列

    p = multiprocessing.Process(target=task, args=(q,))
    p.start()
    p.join()
```

### 使用第三方库 `ratelimit`
`ratelimit` 库提供了更方便的方式来实现速率限制。首先需要安装该库：`pip install ratelimit`。

```python
import multiprocessing
from ratelimit import limits, sleep_and_retry


CALLS = 5
PERIOD = 10  # 每 10 秒最多允许 5 次调用


@sleep_and_retry
@limits(calls=CALLS, period=PERIOD)
def limited_task():
    print("Limited task is running")


def process_task():
    for _ in range(10):
        limited_task()


if __name__ == "__main__":
    p = multiprocessing.Process(target=process_task)
    p.start()
    p.join()
```

## 常见实践

### 网络请求速率限制
在进行网络请求时，很多 API 都有请求频率限制。例如，使用 `requests` 库进行 HTTP 请求时：

```python
import multiprocessing
import requests
from ratelimit import limits, sleep_and_retry


CALLS = 10
PERIOD = 60  # 每分钟最多 10 次请求


@sleep_and_retry
@limits(calls=CALLS, period=PERIOD)
def fetch_data(url):
    response = requests.get(url)
    return response.json()


def worker(url):
    data = fetch_data(url)
    print(f"Fetched data: {data}")


if __name__ == "__main__":
    urls = ["https://example.com/api/data1", "https://example.com/api/data2"]
    processes = []
    for url in urls:
        p = multiprocessing.Process(target=worker, args=(url,))
        p.start()
        processes.append(p)

    for p in processes:
        p.join()
```

### 文件读写速率限制
在进行大量文件读写时，为了避免对磁盘造成过大压力，可以限制读写频率。

```python
import multiprocessing
import time


def read_file_with_rate_limit(file_path):
    with open(file_path, 'r') as f:
        while True:
            line = f.readline()
            if not line:
                break
            print(line.strip())
            time.sleep(0.1)  # 每 0.1 秒读取一行


if __name__ == "__main__":
    file_path = "example.txt"
    p = multiprocessing.Process(target=read_file_with_rate_limit, args=(file_path,))
    p.start()
    p.join()
```

## 最佳实践

### 结合日志记录
在实现速率限制时，结合日志记录可以方便我们监控和调试。

```python
import multiprocessing
import logging
import time
from ratelimit import limits, sleep_and_retry


CALLS = 5
PERIOD = 10

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')


@sleep_and_retry
@limits(calls=CALLS, period=PERIOD)
def logged_task():
    logging.info("Logged task is running")


def worker_process():
    for _ in range(10):
        logged_task()


if __name__ == "__main__":
    p = multiprocessing.Process(target=worker_process)
    p.start()
    p.join()
```

### 动态调整速率限制
根据系统状态或外部条件动态调整速率限制。

```python
import multiprocessing
import time
from ratelimit import limits, sleep_and_retry


def get_calls_per_period():
    # 这里可以根据系统状态或外部条件返回不同的值
    return 5


def get_period():
    return 10


@sleep_and_retry
@limits(calls=get_calls_per_period, period=get_period)
def dynamic_task():
    print("Dynamic task is running")


def worker():
    for _ in range(10):
        dynamic_task()


if __name__ == "__main__":
    p = multiprocessing.Process(target=worker)
    p.start()
    p.join()
```

## 小结
为 Python 多进程实现速率限制是一个重要的技术点，可以帮助我们更好地管理系统资源和避免违反外部限制。通过本文介绍的基础概念、多种使用方法、常见实践以及最佳实践，读者可以根据自己的需求选择合适的方式来实现速率限制，从而优化多进程程序的性能和稳定性。

## 参考资料
- [Python 官方文档 - multiprocessing](https://docs.python.org/3/library/multiprocessing.html){: rel="nofollow"}
- [ratelimit 库文档](https://pypi.org/project/ratelimit/){: rel="nofollow"}
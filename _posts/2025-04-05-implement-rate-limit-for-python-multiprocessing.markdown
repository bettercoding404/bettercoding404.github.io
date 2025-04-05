---
title: "为 Python 多进程实现速率限制"
description: "在 Python 的多进程编程中，有时我们需要控制进程执行的速率，以避免对系统资源造成过大压力，或者满足特定的业务需求，比如避免频繁调用 API 导致超出限制。实现速率限制（Rate Limit）可以帮助我们有效地管理多进程任务的执行频率。本文将详细介绍为 Python 多进程实现速率限制的相关概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---

# 为 Python 多进程实现速率限制

## 简介
在 Python 的多进程编程中，有时我们需要控制进程执行的速率，以避免对系统资源造成过大压力，或者满足特定的业务需求，比如避免频繁调用 API 导致超出限制。实现速率限制（Rate Limit）可以帮助我们有效地管理多进程任务的执行频率。本文将详细介绍为 Python 多进程实现速率限制的相关概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
### 速率限制
速率限制是一种控制单位时间内操作执行次数的机制。在多进程场景中，它可以限制每个进程或整个进程池在一定时间内执行任务的频率。例如，我们可能希望每秒钟最多执行 10 个特定任务，或者每分钟最多启动 5 个新进程。

### Python 多进程
Python 的 `multiprocessing` 模块提供了一种简单的方式来创建和管理多个进程。进程是操作系统中独立运行的实体，与线程不同，每个进程都有自己独立的内存空间。通过多进程，可以充分利用多核 CPU 的优势，提高程序的执行效率。

## 使用方法
### 使用 `time.sleep` 实现简单速率限制
这是一种最基本的实现速率限制的方法。通过在进程执行任务之间插入 `time.sleep` 语句，可以控制任务执行的频率。

```python
import multiprocessing
import time


def task_with_rate_limit(task_id):
    print(f"Task {task_id} starts")
    # 模拟任务执行
    time.sleep(1)
    print(f"Task {task_id} ends")


if __name__ == '__main__':
    process_list = []
    for i in range(5):
        p = multiprocessing.Process(target=task_with_rate_limit, args=(i,))
        p.start()
        process_list.append(p)
        # 每启动一个进程，等待 2 秒，实现简单的速率限制
        time.sleep(2)

    for p in process_list:
        p.join()


```

### 使用 `multiprocessing.Semaphore` 实现更灵活的速率限制
`Semaphore` 是一种信号量机制，可以用来控制同时访问共享资源的进程数量。我们可以利用它来实现更灵活的速率限制。

```python
import multiprocessing
import time


def task_with_semaphore(task_id, sem):
    with sem:
        print(f"Task {task_id} starts")
        time.sleep(1)
        print(f"Task {task_id} ends")


if __name__ == '__main__':
    sem = multiprocessing.Semaphore(2)  # 最多允许 2 个进程同时执行
    process_list = []
    for i in range(5):
        p = multiprocessing.Process(target=task_with_semaphore, args=(i, sem))
        p.start()
        process_list.append(p)

    for p in process_list:
        p.join()


```

## 常见实践
### 限制 API 调用频率
在进行网络请求时，许多 API 都有限制调用频率的要求。通过对多进程中调用 API 的任务进行速率限制，可以避免因超出限制而导致的封禁或错误。

```python
import multiprocessing
import time
import requests


def api_call_task(task_id, sem):
    with sem:
        print(f"Task {task_id} starts API call")
        response = requests.get('https://example.com/api')
        print(f"Task {task_id} got response: {response.status_code}")


if __name__ == '__main__':
    sem = multiprocessing.Semaphore(3)  # 每秒钟最多允许 3 个 API 调用
    process_list = []
    for i in range(10):
        p = multiprocessing.Process(target=api_call_task, args=(i, sem))
        p.start()
        process_list.append(p)
        time.sleep(1)  # 控制整体调用频率

    for p in process_list:
        p.join()


```

### 控制资源密集型任务
对于一些资源密集型的任务，如文件读写、大数据处理等，通过速率限制可以避免系统资源被耗尽。

```python
import multiprocessing
import time


def resource_intensive_task(task_id, sem):
    with sem:
        print(f"Task {task_id} starts resource intensive task")
        # 模拟资源密集型任务
        for _ in range(1000000):
            pass
        print(f"Task {task_id} ends resource intensive task")


if __name__ == '__main__':
    sem = multiprocessing.Semaphore(2)  # 最多允许 2 个资源密集型任务同时执行
    process_list = []
    for i in range(5):
        p = multiprocessing.Process(target=resource_intensive_task, args=(i, sem))
        p.start()
        process_list.append(p)

    for p in process_list:
        p.join()


```

## 最佳实践
### 使用专门的速率限制库
除了手动实现速率限制，还可以使用一些专门的库，如 `ratelimit`。这个库提供了更高级的速率限制功能，并且易于使用。

```python
import multiprocessing
from ratelimit import limits, sleep_and_retry


CALLS = 5
PERIOD = 10  # 每 10 秒最多允许 5 次调用


@sleep_and_retry
@limits(calls=CALLS, period=PERIOD)
def limited_task(task_id):
    print(f"Task {task_id} is running")


if __name__ == '__main__':
    process_list = []
    for i in range(10):
        p = multiprocessing.Process(target=limited_task, args=(i,))
        p.start()
        process_list.append(p)

    for p in process_list:
        p.join()


```

### 动态调整速率
根据系统的运行状态或任务的优先级，可以动态调整速率限制。例如，在系统负载较低时，增加任务执行的频率；在负载较高时，降低频率。

```python
import multiprocessing
import time
import psutil


def task_with_dynamic_rate(task_id, sem):
    with sem:
        print(f"Task {task_id} starts")
        time.sleep(1)
        print(f"Task {task_id} ends")


if __name__ == '__main__':
    initial_sem_value = 2
    sem = multiprocessing.Semaphore(initial_sem_value)
    process_list = []
    for i in range(10):
        p = multiprocessing.Process(target=task_with_dynamic_rate, args=(i, sem))
        p.start()
        process_list.append(p)

        cpu_percent = psutil.cpu_percent()
        if cpu_percent < 50:
            if sem._value < 5:  # 最大允许 5 个进程同时执行
                sem.release()
        else:
            if sem._value > 1:
                sem.acquire()

        time.sleep(1)

    for p in process_list:
        p.join()


```

## 小结
为 Python 多进程实现速率限制是一项重要的技术，它可以帮助我们更好地管理系统资源，满足业务需求。通过简单的 `time.sleep` 方法、灵活的 `Semaphore` 机制，以及专门的速率限制库，我们可以实现不同程度的速率控制。在实际应用中，根据具体情况选择合适的方法，并结合动态调整策略，可以使程序更加稳定和高效。

## 参考资料
- 《Python 并发编程实战》
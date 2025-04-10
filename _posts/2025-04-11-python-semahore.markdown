---
title: "Python 信号量（Semaphore）：原理、用法与最佳实践"
description: "在多线程和多进程编程中，协调不同线程或进程之间的资源访问是一个关键问题。Python 中的信号量（Semaphore）是一种同步原语，它提供了一种控制对共享资源访问的有效方式。通过使用信号量，我们可以限制同时访问特定资源的线程或进程数量，从而避免资源竞争和数据不一致的问题。本文将深入探讨 Python 信号量的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要的同步工具。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在多线程和多进程编程中，协调不同线程或进程之间的资源访问是一个关键问题。Python 中的信号量（Semaphore）是一种同步原语，它提供了一种控制对共享资源访问的有效方式。通过使用信号量，我们可以限制同时访问特定资源的线程或进程数量，从而避免资源竞争和数据不一致的问题。本文将深入探讨 Python 信号量的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要的同步工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **线程中的信号量**
    - **进程中的信号量**
3. **常见实践**
    - **控制并发访问数量**
    - **资源池管理**
4. **最佳实践**
    - **信号量的初始化**
    - **异常处理**
    - **避免死锁**
5. **小结**
6. **参考资料**

## 基础概念
信号量本质上是一个计数器，它的值表示可以同时访问共享资源的数量。当一个线程或进程想要访问共享资源时，它会先尝试获取信号量。如果信号量的值大于 0，获取成功，信号量的值减 1；如果信号量的值为 0，获取操作将被阻塞，直到有其他线程或进程释放信号量。当线程或进程使用完共享资源后，它需要释放信号量，此时信号量的值加 1。

在 Python 中，信号量的实现位于 `threading` 模块（用于线程）和 `multiprocessing` 模块（用于进程）中。这两个模块提供了类似的接口来创建和使用信号量。

## 使用方法

### 线程中的信号量
在 `threading` 模块中，通过 `Semaphore` 类来创建和使用信号量。以下是一个简单的示例：

```python
import threading
import time


def worker(semaphore):
    semaphore.acquire()
    print(f"{threading.current_thread().name} 获取到信号量，开始工作")
    time.sleep(1)
    print(f"{threading.current_thread().name} 工作完成，释放信号量")
    semaphore.release()


if __name__ == "__main__":
    semaphore = threading.Semaphore(2)  # 初始化信号量，允许同时 2 个线程访问
    threads = []
    for i in range(5):
        t = threading.Thread(target=worker, args=(semaphore,))
        threads.append(t)
        t.start()

    for t in threads:
        t.join()
```

在这个示例中，我们创建了一个信号量 `semaphore`，并将其初始化为 2，表示最多允许 2 个线程同时访问共享资源。每个线程在开始工作前调用 `acquire()` 方法获取信号量，工作完成后调用 `release()` 方法释放信号量。

### 进程中的信号量
在 `multiprocessing` 模块中，同样使用 `Semaphore` 类来创建和使用信号量。示例如下：

```python
import multiprocessing
import time


def worker(semaphore):
    semaphore.acquire()
    print(f"{multiprocessing.current_process().name} 获取到信号量，开始工作")
    time.sleep(1)
    print(f"{multiprocessing.current_process().name} 工作完成，释放信号量")
    semaphore.release()


if __name__ == "__main__":
    semaphore = multiprocessing.Semaphore(2)  # 初始化信号量，允许同时 2 个进程访问
    processes = []
    for i in range(5):
        p = multiprocessing.Process(target=worker, args=(semaphore,))
        processes.append(p)
        p.start()

    for p in processes:
        p.join()
```

这个示例与线程的示例类似，只是将 `threading` 模块替换为 `multiprocessing` 模块，用于进程间的同步。

## 常见实践

### 控制并发访问数量
信号量最常见的用途之一是控制对共享资源的并发访问数量。例如，在一个网络爬虫程序中，为了避免对目标服务器造成过大的压力，我们可以限制同时发起的请求数量。

```python
import threading
import requests


def crawl(semaphore, url):
    semaphore.acquire()
    try:
        response = requests.get(url)
        print(f"爬取 {url} 成功，状态码: {response.status_code}")
    except Exception as e:
        print(f"爬取 {url} 失败: {e}")
    finally:
        semaphore.release()


if __name__ == "__main__":
    semaphore = threading.Semaphore(3)  # 最多同时允许 3 个请求
    urls = ["http://example.com", "http://example.org", "http://example.net", "http://example.edu", "http://example.gov"]
    threads = []
    for url in urls:
        t = threading.Thread(target=crawl, args=(semaphore, url))
        threads.append(t)
        t.start()

    for t in threads:
        t.join()
```

在这个示例中，我们使用信号量限制了同时发起的 HTTP 请求数量为 3，从而避免了对目标服务器的过度请求。

### 资源池管理
信号量还可以用于管理资源池，例如数据库连接池。我们可以创建一个固定大小的资源池，并使用信号量来控制对资源的获取和释放。

```python
import threading
import queue


class ResourcePool:
    def __init__(self, size):
        self.pool = queue.Queue(maxsize=size)
        self.semaphore = threading.Semaphore(size)
        for _ in range(size):
            self.pool.put(self.create_resource())

    def create_resource(self):
        # 这里创建实际的资源，例如数据库连接
        return "资源实例"

    def get_resource(self):
        self.semaphore.acquire()
        return self.pool.get()

    def release_resource(self, resource):
        self.pool.put(resource)
        self.semaphore.release()


def worker(pool):
    resource = pool.get_resource()
    try:
        print(f"{threading.current_thread().name} 获取到资源: {resource}")
        # 使用资源
    finally:
        pool.release_resource(resource)


if __name__ == "__main__":
    pool = ResourcePool(3)  # 创建大小为 3 的资源池
    threads = []
    for i in range(5):
        t = threading.Thread(target=worker, args=(pool,))
        threads.append(t)
        t.start()

    for t in threads:
        t.join()
```

在这个示例中，`ResourcePool` 类管理一个资源池，并使用信号量来控制资源的获取和释放。每个线程通过 `get_resource()` 方法获取资源，使用完后通过 `release_resource()` 方法释放资源。

## 最佳实践

### 信号量的初始化
在初始化信号量时，需要根据实际需求合理设置信号量的初始值。如果初始值设置过大，可能无法有效控制并发访问；如果初始值设置过小，可能会导致线程或进程长时间等待，影响性能。例如，在控制并发访问数量时，需要根据系统资源和目标服务器的承受能力来确定合适的并发数。

### 异常处理
在获取和释放信号量时，需要进行适当的异常处理。例如，在获取信号量时可能会因为超时而失败，在使用资源时可能会发生其他异常。为了确保信号量的正确释放，建议在 `try...finally` 块中进行信号量的获取和释放操作。

```python
semaphore = threading.Semaphore(1)
try:
    semaphore.acquire()
    # 使用共享资源
except Exception as e:
    print(f"发生异常: {e}")
finally:
    semaphore.release()
```

### 避免死锁
死锁是多线程和多进程编程中常见的问题，当两个或多个线程或进程相互等待对方释放资源时，就会发生死锁。为了避免死锁，需要遵循以下原则：
- **按顺序获取资源**：所有线程或进程按照相同的顺序获取资源，避免交叉获取。
- **限时获取资源**：在获取信号量时设置超时时间，避免无限期等待。
- **及时释放资源**：在使用完资源后，尽快释放信号量，避免长时间占用。

## 小结
Python 信号量是一种强大的同步原语，它在多线程和多进程编程中起着重要的作用。通过控制对共享资源的并发访问数量，信号量可以有效避免资源竞争和数据不一致的问题。在实际应用中，我们需要根据具体需求合理初始化信号量，进行适当的异常处理，并注意避免死锁。掌握信号量的使用方法和最佳实践，将有助于我们编写更加健壮和高效的多线程和多进程程序。

## 参考资料
- [Python 官方文档 - threading 模块](https://docs.python.org/3/library/threading.html){: rel="nofollow"}
- [Python 官方文档 - multiprocessing 模块](https://docs.python.org/3/library/multiprocessing.html){: rel="nofollow"}
- 《Python 并发编程实战》
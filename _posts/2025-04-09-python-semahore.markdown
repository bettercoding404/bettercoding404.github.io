---
title: "Python Semaphore：深入理解与高效使用"
description: "在多线程和多进程编程中，资源的访问控制是一个关键问题。Python 的 `Semaphore`（信号量）是一种用于控制对共享资源访问的同步原语。它可以允许多个线程或进程同时访问资源，但限制访问的数量。这在很多实际场景中非常有用，比如限制数据库连接池的并发连接数，控制对有限硬件资源的访问等。本文将详细介绍 Python `Semaphore` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大的同步工具。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在多线程和多进程编程中，资源的访问控制是一个关键问题。Python 的 `Semaphore`（信号量）是一种用于控制对共享资源访问的同步原语。它可以允许多个线程或进程同时访问资源，但限制访问的数量。这在很多实际场景中非常有用，比如限制数据库连接池的并发连接数，控制对有限硬件资源的访问等。本文将详细介绍 Python `Semaphore` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大的同步工具。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
`Semaphore` 本质上是一个计数器。它维护一个内部计数器，初始值为指定的资源数量。每次线程或进程请求访问资源（通过调用 `acquire` 方法），计数器减 1；当线程或进程释放资源（通过调用 `release` 方法），计数器加 1。当计数器的值为 0 时，后续的 `acquire` 调用将被阻塞，直到有其他线程或进程调用 `release` 方法增加计数器的值。

## 使用方法
### 导入模块
在使用 `Semaphore` 之前，需要导入 `threading` 模块（用于多线程编程）或 `multiprocessing` 模块（用于多进程编程）。这里以 `threading` 模块为例：

```python
import threading
```

### 创建信号量
可以通过传入一个整数参数来创建 `Semaphore` 对象，该整数表示初始的资源数量。例如，创建一个允许 3 个线程同时访问的信号量：

```python
semaphore = threading.Semaphore(3)
```

### 获取资源（`acquire` 方法）
线程调用 `acquire` 方法来获取资源。如果当前信号量的计数器大于 0，计数器减 1，线程可以继续执行；否则，线程将被阻塞，直到有其他线程释放资源。

```python
semaphore.acquire()
try:
    # 访问共享资源的代码
    print("线程获得资源并执行")
finally:
    semaphore.release()
```

### 释放资源（`release` 方法）
线程在使用完资源后，调用 `release` 方法释放资源，这会使信号量的计数器加 1。注意，`release` 方法通常放在 `finally` 块中，以确保无论代码执行过程中是否发生异常，资源都能被正确释放。

### 完整示例
```python
import threading
import time


def worker(semaphore, name):
    semaphore.acquire()
    try:
        print(f"{name} 获得资源")
        time.sleep(2)  # 模拟工作
        print(f"{name} 完成工作")
    finally:
        semaphore.release()


semaphore = threading.Semaphore(2)  # 允许 2 个线程同时访问

threads = []
for i in range(5):
    t = threading.Thread(target=worker, args=(semaphore, f"线程{i}"))
    threads.append(t)
    t.start()

for t in threads:
    t.join()
```

在这个示例中，我们创建了一个允许 2 个线程同时访问的信号量。5 个线程尝试获取资源，每次最多有 2 个线程可以同时进入临界区执行任务。

## 常见实践
### 控制数据库连接池并发数
在数据库操作中，数据库连接是有限的资源。可以使用 `Semaphore` 来限制并发连接数，防止过多的连接导致数据库性能下降。

```python
import threading
import sqlite3


class DatabasePool:
    def __init__(self, max_connections):
        self.max_connections = max_connections
        self.semaphore = threading.Semaphore(max_connections)
        self.connections = [sqlite3.connect('example.db') for _ in range(max_connections)]

    def get_connection(self):
        self.semaphore.acquire()
        return self.connections.pop()

    def release_connection(self, connection):
        self.connections.append(connection)
        self.semaphore.release()


db_pool = DatabasePool(5)  # 最大 5 个连接


def query_database():
    conn = db_pool.get_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM your_table")
        results = cursor.fetchall()
        print(results)
    finally:
        db_pool.release_connection(conn)


threads = []
for _ in range(10):
    t = threading.Thread(target=query_database)
    threads.append(t)
    t.start()

for t in threads:
    t.join()
```

### 限制文件写入并发
在多线程环境下同时写入文件时，可能会导致数据混乱。可以使用 `Semaphore` 来确保同一时间只有一定数量的线程可以写入文件。

```python
import threading


file_semaphore = threading.Semaphore(2)  # 允许 2 个线程同时写入


def write_to_file(content):
    file_semaphore.acquire()
    try:
        with open('output.txt', 'a') as f:
            f.write(content + '\n')
    finally:
        file_semaphore.release()


threads = []
data = ["数据 1", "数据 2", "数据 3", "数据 4", "数据 5"]
for d in data:
    t = threading.Thread(target=write_to_file, args=(d,))
    threads.append(t)
    t.start()

for t in threads:
    t.join()
```

## 最佳实践
### 合理设置信号量初始值
信号量的初始值应该根据实际的资源数量和预期的并发访问量来合理设置。如果设置过小，可能会导致过多的线程或进程阻塞，降低系统性能；如果设置过大，可能无法有效控制资源访问，达不到同步的目的。

### 使用上下文管理器
Python 的 `with` 语句可以用于创建上下文管理器，简化 `acquire` 和 `release` 的操作，提高代码的可读性和可维护性。

```python
import threading


semaphore = threading.Semaphore(1)


def task():
    with semaphore:
        # 访问共享资源的代码
        print("执行任务")


thread = threading.Thread(target=task)
thread.start()
thread.join()
```

### 错误处理
在 `acquire` 和 `release` 过程中可能会出现异常，需要进行适当的错误处理。特别是在多进程环境中，异常处理更为重要，以确保系统的稳定性。

```python
import threading


semaphore = threading.Semaphore(1)


def task():
    try:
        semaphore.acquire()
        # 访问共享资源的代码
        print("执行任务")
    except Exception as e:
        print(f"发生异常: {e}")
    finally:
        semaphore.release()


thread = threading.Thread(target=task)
thread.start()
thread.join()
```

## 小结
Python 的 `Semaphore` 是多线程和多进程编程中非常有用的同步工具，通过控制对共享资源的访问数量，能够有效避免资源竞争和数据不一致等问题。本文介绍了 `Semaphore` 的基础概念、使用方法、常见实践以及最佳实践，希望读者能够通过这些内容深入理解并在实际项目中高效使用 `Semaphore`。

## 参考资料
- [Python 官方文档 - threading 模块](https://docs.python.org/3/library/threading.html){: rel="nofollow"}
- [Python 官方文档 - multiprocessing 模块](https://docs.python.org/3/library/multiprocessing.html){: rel="nofollow"}
- 《Python 并发编程实战》
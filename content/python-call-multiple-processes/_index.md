---
title: "Python 中调用多个进程：深入解析与实践"
description: "在Python编程中，处理多任务时调用多个进程是一项强大的技术。多进程可以充分利用多核CPU的优势，提高程序的执行效率，尤其适用于计算密集型任务。本文将详细介绍Python中调用多个进程的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技术并在实际项目中高效运用。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在Python编程中，处理多任务时调用多个进程是一项强大的技术。多进程可以充分利用多核CPU的优势，提高程序的执行效率，尤其适用于计算密集型任务。本文将详细介绍Python中调用多个进程的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技术并在实际项目中高效运用。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `multiprocessing` 模块创建进程**
    - **传递参数给进程**
    - **等待进程完成**
3. **常见实践**
    - **计算密集型任务**
    - **I/O 密集型任务**
4. **最佳实践**
    - **避免全局变量共享问题**
    - **合理设置进程数量**
    - **进程间通信与同步**
5. **小结**
6. **参考资料**

## 基础概念
在操作系统中，进程是程序在操作系统中的一次执行过程，是系统进行资源分配和调度的基本单位。每个进程都有自己独立的内存空间、系统资源等。Python中的 `multiprocessing` 模块提供了创建和管理多进程的功能，使得我们可以在Python程序中充分利用多核CPU的计算能力。与线程不同，进程之间的通信相对复杂，但进程之间相互独立，不会因为一个进程的崩溃影响其他进程。

## 使用方法

### 使用 `multiprocessing` 模块创建进程
`multiprocessing` 模块是Python标准库中用于处理多进程的模块。以下是一个简单的示例，展示如何创建并启动多个进程：

```python
import multiprocessing


def worker():
    print("Worker process started")


if __name__ == '__main__':
    processes = []
    for _ in range(3):
        p = multiprocessing.Process(target=worker)
        processes.append(p)
        p.start()

    for p in processes:
        p.join()
```

在这个示例中：
1. 我们定义了一个 `worker` 函数，这是每个进程要执行的任务。
2. 在 `if __name__ == '__main__':` 块中，我们创建了一个空列表 `processes` 用于存储进程对象。
3. 使用循环创建了3个进程，每个进程都以 `worker` 函数作为目标函数，并将进程对象添加到 `processes` 列表中，然后启动每个进程。
4. 最后，通过 `join` 方法等待所有进程完成。

### 传递参数给进程
可以向进程的目标函数传递参数，如下所示：

```python
import multiprocessing


def worker(num):
    print(f"Worker {num} started")


if __name__ == '__main__':
    processes = []
    for i in range(3):
        p = multiprocessing.Process(target=worker, args=(i,))
        processes.append(p)
        p.start()

    for p in processes:
        p.join()
```

在这个示例中，`args` 参数是一个元组，用于向 `worker` 函数传递参数。

### 等待进程完成
`join` 方法用于等待进程完成。在前面的示例中，我们使用 `for p in processes: p.join()` 等待所有进程执行完毕。这确保了主进程在所有子进程完成后才继续执行后续代码。

## 常见实践

### 计算密集型任务
对于计算密集型任务，多进程可以显著提高执行效率。例如，计算一个大数组的平方和：

```python
import multiprocessing
import numpy as np


def calculate_square_sum(arr):
    return np.sum(arr ** 2)


if __name__ == '__main__':
    data = np.random.rand(1000000)
    num_processes = multiprocessing.cpu_count()
    chunk_size = len(data) // num_processes
    processes = []

    for i in range(num_processes):
        start = i * chunk_size
        end = start + chunk_size if i < num_processes - 1 else len(data)
        p = multiprocessing.Process(target=calculate_square_sum, args=(data[start:end],))
        processes.append(p)
        p.start()

    results = []
    for p in processes:
        p.join()
        results.append(p.exitcode)

    total_sum = sum(results)
    print(f"Total square sum: {total_sum}")
```

在这个示例中，我们将数据分成多个块，每个进程处理一块数据，最后汇总结果。

### I/O 密集型任务
对于 I/O 密集型任务，多进程也可以提高效率，例如同时读取多个文件：

```python
import multiprocessing


def read_file(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
        print(f"Read {len(content)} bytes from {file_path}")


if __name__ == '__main__':
    file_paths = ['file1.txt', 'file2.txt', 'file3.txt']
    processes = []

    for file_path in file_paths:
        p = multiprocessing.Process(target=read_file, args=(file_path,))
        processes.append(p)
        p.start()

    for p in processes:
        p.join()
```

这个示例中，每个进程负责读取一个文件，从而实现并发读取。

## 最佳实践

### 避免全局变量共享问题
在多进程中，每个进程都有自己独立的内存空间，全局变量不会在进程间共享。如果需要共享数据，应该使用 `multiprocessing` 模块提供的共享内存、队列等机制。例如：

```python
import multiprocessing


def update_shared_value(shared_value):
    shared_value.value += 1


if __name__ == '__main__':
    shared_value = multiprocessing.Value('i', 0)
    processes = []

    for _ in range(3):
        p = multiprocessing.Process(target=update_shared_value, args=(shared_value,))
        processes.append(p)
        p.start()

    for p in processes:
        p.join()

    print(f"Shared value: {shared_value.value}")
```

在这个示例中，我们使用 `multiprocessing.Value` 来创建一个共享的整数值。

### 合理设置进程数量
进程数量并非越多越好，过多的进程会导致系统资源竞争加剧，反而降低性能。通常可以根据CPU核心数来设置进程数量，例如：

```python
num_processes = multiprocessing.cpu_count()
```

### 进程间通信与同步
在需要进程间通信和同步的场景下，可以使用队列（`Queue`）、管道（`Pipe`）等工具。例如，使用队列在进程间传递数据：

```python
import multiprocessing


def producer(queue):
    for i in range(5):
        queue.put(i)


def consumer(queue):
    while True:
        item = queue.get()
        if item is None:
            break
        print(f"Consumed {item}")


if __name__ == '__main__':
    queue = multiprocessing.Queue()
    producer_process = multiprocessing.Process(target=producer, args=(queue,))
    consumer_process = multiprocessing.Process(target=consumer, args=(queue,))

    producer_process.start()
    consumer_process.start()

    producer_process.join()
    queue.put(None)  # 向队列中放入结束信号
    consumer_process.join()
```

在这个示例中，生产者进程将数据放入队列，消费者进程从队列中取出数据进行处理。

## 小结
本文详细介绍了Python中调用多个进程的相关知识，包括基础概念、使用方法、常见实践和最佳实践。通过合理运用多进程技术，可以显著提高Python程序的执行效率，特别是在处理计算密集型和I/O密集型任务时。在实际应用中，需要注意避免全局变量共享问题，合理设置进程数量，并正确使用进程间通信和同步机制。

## 参考资料
- [Python官方文档 - multiprocessing模块](https://docs.python.org/3/library/multiprocessing.html)
- 《Python并发编程实战》
- [Real Python - Multiprocessing in Python](https://realpython.com/python-multiprocessing/)
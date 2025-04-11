---
title: "Python 子进程中的日志记录"
description: "在 Python 编程中，我们经常需要创建子进程来并行执行任务或者隔离特定的工作负载。而在子进程中进行日志记录是一个重要的环节，它有助于我们追踪子进程的执行情况、调试代码以及监控系统运行状态。本文将深入探讨 Python 中在子进程里进行日志记录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 编程中，我们经常需要创建子进程来并行执行任务或者隔离特定的工作负载。而在子进程中进行日志记录是一个重要的环节，它有助于我们追踪子进程的执行情况、调试代码以及监控系统运行状态。本文将深入探讨 Python 中在子进程里进行日志记录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `logging` 模块
    - 跨进程日志记录配置
3. 常见实践
    - 独立日志文件
    - 日志级别控制
4. 最佳实践
    - 避免日志冲突
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
### 子进程
在操作系统中，子进程是由父进程创建的新进程。在 Python 里，可以使用 `multiprocessing` 模块或者 `subprocess` 模块来创建子进程。子进程拥有自己独立的内存空间和系统资源，这意味着它与父进程在一定程度上是隔离的。

### 日志记录
日志记录是一种记录程序运行过程中重要事件的机制。Python 提供了强大的 `logging` 模块来进行日志记录。通过日志记录，我们可以记录程序的运行状态、错误信息、调试信息等，方便在程序出现问题时进行排查和分析。

## 使用方法

### 使用 `logging` 模块
`logging` 模块是 Python 内置的标准日志记录模块，它提供了灵活的日志记录功能。以下是一个简单的示例，展示如何在子进程中使用 `logging` 模块：

```python
import logging
import multiprocessing


def child_process():
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    ch = logging.StreamHandler()
    ch.setFormatter(formatter)
    logger.addHandler(ch)

    logger.info("This is a log message from child process")


if __name__ == '__main__':
    p = multiprocessing.Process(target=child_process)
    p.start()
    p.join()
```

在上述代码中：
1. 首先导入了 `logging` 和 `multiprocessing` 模块。
2. 定义了一个 `child_process` 函数，在这个函数中：
    - 获取了一个日志记录器 `logger`。
    - 设置了日志记录器的级别为 `INFO`。
    - 创建了一个日志格式化器 `formatter`，用于定义日志的输出格式。
    - 创建了一个流处理器 `ch`，并将格式化器设置给它，然后将这个处理器添加到日志记录器中。
    - 最后使用日志记录器记录了一条信息日志。
3. 在 `if __name__ == '__main__':` 块中，创建并启动了一个子进程，执行 `child_process` 函数。

### 跨进程日志记录配置
在实际应用中，我们可能需要多个子进程共享相同的日志配置，或者将日志记录到同一个文件中。这时可以使用 `Queue` 来实现跨进程的日志记录。以下是一个示例：

```python
import logging
import multiprocessing


def setup_logging():
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    ch = logging.StreamHandler()
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    return logger


def log_worker(log_queue):
    while True:
        record = log_queue.get()
        if record is None:
            break
        logger = logging.getLogger(record.name)
        logger.handle(record)


def child_process(log_queue):
    logger = logging.getLogger(__name__)
    logger.info("This is a log message from child process")
    log_queue.put(logger.makeRecord(logger.name, logging.INFO, "", 0, "Message from child", (), None))


if __name__ == '__main__':
    log_queue = multiprocessing.Queue()

    log_worker_process = multiprocessing.Process(target=log_worker, args=(log_queue,))
    log_worker_process.start()

    child_processes = []
    for _ in range(3):
        p = multiprocessing.Process(target=child_process, args=(log_queue,))
        p.start()
        child_processes.append(p)

    for p in child_processes:
        p.join()

    log_queue.put(None)
    log_worker_process.join()
```

在这个示例中：
1. `setup_logging` 函数用于设置日志记录的基本配置。
2. `log_worker` 函数是一个独立的进程，它从 `log_queue` 中获取日志记录并进行处理。
3. `child_process` 函数在子进程中创建日志记录，并将其放入 `log_queue` 中。
4. 在主程序中，创建了 `log_queue` 和 `log_worker_process`，然后启动多个子进程，最后停止日志处理进程。

## 常见实践

### 独立日志文件
为每个子进程创建独立的日志文件可以方便地追踪每个子进程的活动。可以在子进程中根据进程 ID 或者其他唯一标识来命名日志文件。以下是一个示例：

```python
import logging
import multiprocessing


def child_process(process_id):
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    file_handler = logging.FileHandler(f'child_{process_id}.log')
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)

    logger.info(f"This is a log message from child process {process_id}")


if __name__ == '__main__':
    for i in range(3):
        p = multiprocessing.Process(target=child_process, args=(i,))
        p.start()
```

### 日志级别控制
可以根据子进程的运行环境或者需求来动态调整日志级别。例如，在开发环境中可以记录更多的调试信息，而在生产环境中只记录重要的错误信息。

```python
import logging
import multiprocessing


def child_process(log_level):
    logger = logging.getLogger(__name__)
    logger.setLevel(log_level)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    ch = logging.StreamHandler()
    ch.setFormatter(formatter)
    logger.addHandler(ch)

    logger.info("This is an info message")
    logger.debug("This is a debug message")


if __name__ == '__main__':
    p1 = multiprocessing.Process(target=child_process, args=(logging.DEBUG,))
    p2 = multiprocessing.Process(target=child_process, args=(logging.ERROR,))

    p1.start()
    p2.start()

    p1.join()
    p2.join()
```

## 最佳实践

### 避免日志冲突
在多个子进程同时进行日志记录时，可能会出现日志冲突的情况，特别是在写入同一个日志文件时。为了避免这种情况，可以使用线程安全的日志处理器，或者采用异步日志记录的方式。

### 性能优化
日志记录会带来一定的性能开销，特别是在高并发的子进程环境中。可以通过以下方式进行性能优化：
- 合理设置日志级别，减少不必要的日志记录。
- 使用内存缓存来批量处理日志记录，减少磁盘 I/O 操作。

## 小结
在 Python 中进行子进程的日志记录是一个复杂但重要的任务。通过合理使用 `logging` 模块和跨进程通信机制，我们可以有效地管理子进程的日志信息。同时，遵循常见实践和最佳实践可以提高日志记录的效率和可靠性，帮助我们更好地调试和监控程序的运行。

## 参考资料
- 《Python 并发编程实战》
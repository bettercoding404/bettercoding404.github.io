---
title: "Python 子进程中的日志记录"
description: "在 Python 开发中，我们经常会创建子进程来处理一些独立的任务，比如并行计算、执行外部命令等。而在这些子进程中进行有效的日志记录对于调试、监控和故障排查至关重要。本文将深入探讨在 Python 子进程中进行日志记录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助你更好地处理子进程中的日志信息。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 开发中，我们经常会创建子进程来处理一些独立的任务，比如并行计算、执行外部命令等。而在这些子进程中进行有效的日志记录对于调试、监控和故障排查至关重要。本文将深入探讨在 Python 子进程中进行日志记录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助你更好地处理子进程中的日志信息。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 2.1 简单的日志记录
    - 2.2 配置日志格式
    - 2.3 在子进程中使用日志记录
3. 常见实践
    - 3.1 日志文件分割
    - 3.2 日志级别管理
    - 3.3 多子进程日志区分
4. 最佳实践
    - 4.1 集中式日志管理
    - 4.2 日志安全
    - 4.3 性能优化
5. 小结
6. 参考资料

## 基础概念
在 Python 中，子进程是通过 `multiprocessing` 模块或 `subprocess` 模块创建的独立进程。日志记录是一种将程序运行过程中的信息记录下来的机制，通过日志我们可以了解程序的执行情况、追踪错误等。在子进程中进行日志记录，就是要确保每个子进程都能正确地记录其相关的信息，并且这些信息能够方便地被收集和分析。

`logging` 模块是 Python 标准库中用于日志记录的工具，它提供了灵活的日志记录功能，我们可以使用它来配置和管理子进程中的日志。

## 使用方法

### 简单的日志记录
首先，我们来看一个简单的日志记录示例。以下代码展示了如何使用 `logging` 模块进行基本的日志记录：

```python
import logging

# 配置基本日志记录
logging.basicConfig(level=logging.INFO)

# 记录日志
logging.info("这是一条 INFO 级别的日志")
logging.warning("这是一条 WARNING 级别的日志")
```

### 配置日志格式
我们可以通过 `basicConfig` 方法来配置日志的格式，例如：

```python
import logging

# 配置日志格式
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

logging.info("这是一条格式化后的 INFO 日志")
```

### 在子进程中使用日志记录
使用 `multiprocessing` 模块创建子进程并进行日志记录：

```python
import logging
import multiprocessing


def child_process():
    logging.info("子进程开始执行")
    # 子进程的其他逻辑
    logging.info("子进程执行结束")


if __name__ == '__main__':
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s'
    )
    p = multiprocessing.Process(target=child_process)
    p.start()
    p.join()
```

在上述代码中，我们定义了一个子进程函数 `child_process`，在这个函数中进行了日志记录。主进程配置好日志后启动子进程，子进程会按照配置的日志格式进行日志记录。

## 常见实践

### 日志文件分割
随着程序的运行，日志文件可能会变得非常大，影响性能和查看效率。我们可以使用 `TimedRotatingFileHandler` 来按时间分割日志文件：

```python
import logging
from logging.handlers import TimedRotatingFileHandler


def setup_logging():
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)

    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

    file_handler = TimedRotatingFileHandler('app.log', when='midnight', interval=1, backupCount=7)
    file_handler.setFormatter(formatter)

    logger.addHandler(file_handler)

    return logger


if __name__ == '__main__':
    logger = setup_logging()
    logger.info("这是一条写入日志文件的信息")
```

在上述代码中，`TimedRotatingFileHandler` 会在每天午夜创建一个新的日志文件，并保留 7 天的备份。

### 日志级别管理
合理设置日志级别可以控制日志的详细程度。在开发过程中，我们可以将日志级别设置为 `DEBUG`，以便获取更多的调试信息；在生产环境中，将日志级别设置为 `INFO` 或 `WARNING` 以减少日志量。

```python
import logging

# 设置日志级别为 DEBUG
logging.basicConfig(level=logging.DEBUG)
logging.debug("这是一条 DEBUG 级别的日志")
logging.info("这是一条 INFO 级别的日志")

# 之后在生产环境中可以将级别改为 INFO
logging.basicConfig(level=logging.INFO)
logging.debug("这条 DEBUG 日志不会被记录")
logging.info("这是一条 INFO 级别的日志")
```

### 多子进程日志区分
当有多个子进程时，为了便于区分每个子进程的日志，可以在日志消息中添加子进程的标识。

```python
import logging
import multiprocessing


def child_process(process_id):
    logger = logging.getLogger()
    logger.info(f"子进程 {process_id} 开始执行")
    # 子进程的其他逻辑
    logger.info(f"子进程 {process_id} 执行结束")


if __name__ == '__main__':
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s'
    )

    processes = []
    for i in range(3):
        p = multiprocessing.Process(target=child_process, args=(i,))
        processes.append(p)
        p.start()

    for p in processes:
        p.join()
```

在上述代码中，每个子进程的日志消息中都包含了其进程 ID，方便区分不同子进程的日志。

## 最佳实践

### 集中式日志管理
对于大型项目，集中式日志管理可以提高日志的收集、分析和管理效率。可以使用第三方工具如 ELK Stack（Elasticsearch、Logstash、Kibana）或 Graylog 来实现集中式日志管理。Python 可以通过相应的库将日志发送到这些集中式日志管理系统中。

### 日志安全
日志中可能包含敏感信息，如用户密码、数据库连接字符串等。在日志记录时，要确保敏感信息不会被记录到日志中，或者对敏感信息进行加密处理。同时，要控制日志文件的访问权限，防止未经授权的访问。

### 性能优化
过多的日志记录可能会影响程序的性能。在性能敏感的代码段，要谨慎使用日志记录。可以通过条件判断来控制是否记录日志，或者采用异步日志记录的方式来减少对主线程的影响。

## 小结
本文详细介绍了在 Python 子进程中进行日志记录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。通过合理配置和管理日志记录，我们可以更好地调试程序、监控系统运行状态以及排查故障。在实际开发中，需要根据项目的需求和特点，灵活运用这些知识，以实现高效、安全的日志记录。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python官方文档 - multiprocessing模块](https://docs.python.org/3/library/multiprocessing.html){: rel="nofollow"}
- [ELK Stack官方文档](https://www.elastic.co/elk-stack){: rel="nofollow"}
- [Graylog官方文档](https://www.graylog.org/){: rel="nofollow"}
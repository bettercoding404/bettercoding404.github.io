---
title: "Python Logger：强大的日志记录工具"
description: "在软件开发过程中，日志记录是一项至关重要的任务。它可以帮助开发人员追踪程序的执行流程、排查错误、记录重要事件等。Python 提供了内置的 `logging` 模块，也就是我们常说的 `logger`，它为我们提供了灵活且强大的日志记录功能。本文将深入探讨 Python logger 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地利用这一工具。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在软件开发过程中，日志记录是一项至关重要的任务。它可以帮助开发人员追踪程序的执行流程、排查错误、记录重要事件等。Python 提供了内置的 `logging` 模块，也就是我们常说的 `logger`，它为我们提供了灵活且强大的日志记录功能。本文将深入探讨 Python logger 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地利用这一工具。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本配置
    - 记录不同级别的日志
    - 自定义日志格式
    - 日志输出到文件
3. 常见实践
    - 多模块中的日志记录
    - 日志轮转
4. 最佳实践
    - 日志级别设置
    - 日志信息的详细程度
    - 性能考量
5. 小结
6. 参考资料

## 基础概念
`logging` 模块提供了一套完整的日志记录系统，主要包含以下几个核心概念：
- **Logger**：日志记录器，是应用程序代码直接使用的接口，负责发起日志记录操作。
- **Handler**：处理器，负责将日志记录发送到指定的输出位置，例如控制台、文件等。
- **Formatter**：格式化器，用于定义日志记录的输出格式，比如时间、日志级别、消息内容等。

## 使用方法

### 基本配置
在使用 `logging` 模块之前，首先需要进行基本配置。以下是一个简单的示例：
```python
import logging

# 配置日志记录的基本设置
logging.basicConfig(level=logging.INFO)

# 记录一条 INFO 级别的日志
logging.info('这是一条 INFO 级别的日志')
```
在上述代码中，`basicConfig` 方法用于进行基本配置，`level=logging.INFO` 表示设置日志记录的级别为 `INFO`，这意味着只有级别大于等于 `INFO` 的日志才会被记录。

### 记录不同级别的日志
`logging` 模块提供了多种日志级别，常见的有 `DEBUG`、`INFO`、`WARNING`、`ERROR` 和 `CRITICAL`。不同级别用于表示不同重要程度的事件。示例如下：
```python
import logging

logging.basicConfig(level=logging.DEBUG)

logging.debug('这是一条 DEBUG 级别的日志')
logging.info('这是一条 INFO 级别的日志')
logging.warning('这是一条 WARNING 级别的日志')
logging.error('这是一条 ERROR 级别的日志')
logging.critical('这是一条 CRITICAL 级别的日志')
```
运行上述代码，你将看到不同级别的日志按照配置输出到控制台。

### 自定义日志格式
可以通过 `Formatter` 来自定义日志的输出格式。以下是一个示例：
```python
import logging

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 创建一个控制台处理器，并设置格式化器
ch = logging.StreamHandler()
ch.setFormatter(formatter)

# 获取一个日志记录器
logger = logging.getLogger()
logger.addHandler(ch)
logger.setLevel(logging.INFO)

logger.info('这是一条自定义格式的 INFO 日志')
```
在这个示例中，我们创建了一个 `Formatter`，指定了日志的格式为 `时间 - 日志级别 - 消息内容`。然后创建了一个 `StreamHandler`（控制台处理器），并将格式化器设置给它。最后，将处理器添加到日志记录器中，并设置日志记录器的级别为 `INFO`。

### 日志输出到文件
除了输出到控制台，我们还可以将日志记录输出到文件中。示例如下：
```python
import logging

# 配置日志记录到文件
logging.basicConfig(filename='app.log', level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')

logging.info('这是一条输出到文件的 INFO 日志')
```
上述代码中，`filename='app.log'` 指定了日志文件的名称，`basicConfig` 会自动创建该文件并将日志记录写入其中。

## 常见实践

### 多模块中的日志记录
在大型项目中，通常会有多个模块。为了更好地管理日志记录，可以为每个模块创建独立的日志记录器。示例如下：
- **module1.py**
```python
import logging

# 获取名为'module1' 的日志记录器
logger = logging.getLogger('module1')


def module1_function():
    logger.info('module1_function 被调用')
```
- **module2.py**
```python
import logging

# 获取名为'module2' 的日志记录器
logger = logging.getLogger('module2')


def module2_function():
    logger.info('module2_function 被调用')
```
- **main.py**
```python
import logging
from module1 import module1_function
from module2 import module2_function

# 配置日志记录
logging.basicConfig(level=logging.INFO)

module1_function()
module2_function()
```
通过为每个模块创建独立的日志记录器，可以更方便地追踪和管理不同模块的日志信息。

### 日志轮转
随着程序的运行，日志文件可能会变得非常大。为了避免日志文件占用过多磁盘空间，可以使用日志轮转功能。`logging.handlers` 模块提供了多种日志轮转处理器，例如 `RotatingFileHandler` 和 `TimedRotatingFileHandler`。以下是使用 `RotatingFileHandler` 的示例：
```python
import logging
from logging.handlers import RotatingFileHandler

# 创建一个 RotatingFileHandler
handler = RotatingFileHandler('app.log', maxBytes=1024*1024, backupCount=5)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)

# 获取一个日志记录器
logger = logging.getLogger()
logger.addHandler(handler)
logger.setLevel(logging.INFO)

for i in range(100000):
    logger.info(f'这是第 {i} 条日志')
```
在上述代码中，`RotatingFileHandler` 会在日志文件大小达到 `maxBytes`（这里是 1MB）时，将旧的日志文件重命名并创建一个新的日志文件，`backupCount` 表示保留的旧日志文件数量。

## 最佳实践

### 日志级别设置
在开发过程中，应该根据不同的环境和需求合理设置日志级别。在开发环境中，可以将日志级别设置为 `DEBUG`，以便获取更多详细信息，方便调试。而在生产环境中，通常将日志级别设置为 `INFO` 或 `WARNING`，避免过多的日志信息影响系统性能。

### 日志信息的详细程度
日志信息应该足够详细，以便能够快速定位问题。但也要避免记录过于琐碎的信息，以免日志文件过于庞大。在记录错误日志时，应该包含足够的上下文信息，例如错误发生的函数名、参数值等。

### 性能考量
频繁的日志记录可能会对系统性能产生一定影响。因此，在性能敏感的代码段，应该谨慎使用日志记录。可以通过条件判断来控制日志记录的执行，例如只有在特定条件下才记录日志。

## 小结
Python 的 `logging` 模块为我们提供了功能强大且灵活的日志记录工具。通过了解其基础概念、掌握使用方法、熟悉常见实践以及遵循最佳实践，我们能够更好地利用日志记录来辅助开发和维护工作。合理的日志记录可以帮助我们快速定位问题、追踪程序执行流程，提高开发效率和系统的稳定性。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- 《Python核心编程》
- 《Effective Python》
---
title: "Python Logger：日志记录的强大工具"
description: "在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者追踪程序的执行流程、调试代码、记录重要事件以及监控系统运行状态。Python 提供了一个内置的日志记录模块 `logging`，通过它我们可以轻松地实现日志记录功能。本文将深入探讨 Python Logger 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一强大工具。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者追踪程序的执行流程、调试代码、记录重要事件以及监控系统运行状态。Python 提供了一个内置的日志记录模块 `logging`，通过它我们可以轻松地实现日志记录功能。本文将深入探讨 Python Logger 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一强大工具。

<!-- more -->
## 目录
1. **基础概念**
    - **日志级别**
    - **日志记录器（Logger）**
    - **处理器（Handler）**
    - **格式化器（Formatter）**
2. **使用方法**
    - **基本配置与使用**
    - **自定义日志记录器**
    - **使用不同的处理器**
    - **设置日志格式**
3. **常见实践**
    - **记录到文件**
    - **记录到控制台**
    - **同时记录到文件和控制台**
    - **根据日志级别过滤日志**
4. **最佳实践**
    - **全局配置日志**
    - **在不同模块中使用日志记录器**
    - **日志轮转**
    - **安全与隐私考虑**
5. **小结**
6. **参考资料**

## 基础概念
### 日志级别
日志级别用于指定日志信息的重要程度。Python `logging` 模块定义了以下几种日志级别：
- **DEBUG**：最详细的日志级别，用于调试目的，记录程序运行过程中的详细信息。
- **INFO**：用于记录程序正常运行的信息，如启动、停止等事件。
- **WARNING**：表示程序出现了一些非严重的问题，但可能会影响程序的正常运行，如资源即将耗尽等。
- **ERROR**：用于记录程序中发生的错误，这些错误会导致程序部分功能无法正常运行。
- **CRITICAL**：最严重的日志级别，用于记录导致程序无法继续运行的严重错误。

### 日志记录器（Logger）
日志记录器是 `logging` 模块的核心组件，它负责接收日志消息并将其发送给相应的处理器。每个日志记录器都有一个名称，通常使用模块名作为日志记录器的名称，这样可以方便地追踪日志消息的来源。

### 处理器（Handler）
处理器负责处理日志记录器发送过来的日志消息。它可以将日志消息输出到不同的目标，如控制台、文件、网络等。常见的处理器有：
- **StreamHandler**：将日志消息输出到控制台。
- **FileHandler**：将日志消息输出到文件。

### 格式化器（Formatter）
格式化器用于定义日志消息的输出格式。它可以指定日志消息中包含哪些信息，如时间、日志级别、日志记录器名称、消息内容等，以及这些信息的显示方式。

## 使用方法
### 基本配置与使用
```python
import logging

# 基本配置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录日志
logging.debug('这是一条 DEBUG 级别的日志')
logging.info('这是一条 INFO 级别的日志')
logging.warning('这是一条 WARNING 级别的日志')
logging.error('这是一条 ERROR 级别的日志')
logging.critical('这是一条 CRITICAL 级别的日志')
```
在上述代码中，`basicConfig` 方法进行了基本的日志配置，设置了日志级别为 `INFO`，并定义了日志消息的格式。然后使用 `logging` 模块的不同日志级别方法记录了相应的日志消息。由于日志级别设置为 `INFO`，所以 `DEBUG` 级别的日志消息不会被输出。

### 自定义日志记录器
```python
import logging

# 创建一个日志记录器
logger = logging.getLogger('my_logger')
logger.setLevel(logging.DEBUG)

# 创建一个处理器并设置日志级别
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# 创建一个格式化器并将其添加到处理器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(ch)

# 记录日志
logger.debug('这是自定义日志记录器的 DEBUG 日志')
logger.info('这是自定义日志记录器的 INFO 日志')
```
在这段代码中，首先创建了一个名为 `my_logger` 的日志记录器，并设置其日志级别为 `DEBUG`。然后创建了一个 `StreamHandler` 处理器，也将其日志级别设置为 `DEBUG`，并为处理器设置了格式化器。最后将处理器添加到日志记录器中，这样就可以使用自定义的日志记录器记录日志了。

### 使用不同的处理器
```python
import logging

# 创建一个日志记录器
logger = logging.getLogger('my_file_logger')
logger.setLevel(logging.DEBUG)

# 创建一个文件处理器
fh = logging.FileHandler('app.log')
fh.setLevel(logging.DEBUG)

# 创建一个格式化器并将其添加到文件处理器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
fh.setFormatter(formatter)

# 将文件处理器添加到日志记录器
logger.addHandler(fh)

# 记录日志
logger.debug('这是记录到文件的 DEBUG 日志')
logger.info('这是记录到文件的 INFO 日志')
```
此代码创建了一个日志记录器 `my_file_logger`，并创建了一个 `FileHandler` 处理器，将日志消息输出到 `app.log` 文件中。通过这种方式，可以将重要的日志信息记录到文件中，方便后续查看和分析。

### 设置日志格式
```python
import logging

# 创建一个日志记录器
logger = logging.getLogger('format_logger')
logger.setLevel(logging.DEBUG)

# 创建一个处理器
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# 创建一个自定义格式化器
formatter = logging.Formatter('%(asctime)s - [%(levelname)s] - %(name)s - %(message)s')
ch.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(ch)

# 记录日志
logger.debug('这是自定义格式的 DEBUG 日志')
```
这里定义了一个自定义的格式化器，使得日志消息的格式更加清晰和易读。可以根据实际需求灵活调整格式化器中的字段和格式。

## 常见实践
### 记录到文件
```python
import logging

# 创建一个日志记录器
logger = logging.getLogger('file_logger')
logger.setLevel(logging.DEBUG)

# 创建一个文件处理器
file_handler = logging.FileHandler('application.log')
file_handler.setLevel(logging.DEBUG)

# 创建一个格式化器并添加到文件处理器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)

# 将文件处理器添加到日志记录器
logger.addHandler(file_handler)

# 记录日志
logger.info('应用程序启动')
logger.error('发生了一个错误')
```
通过上述代码，将日志消息记录到了 `application.log` 文件中，方便对应用程序的运行情况进行追踪和分析。

### 记录到控制台
```python
import logging

# 创建一个日志记录器
logger = logging.getLogger('console_logger')
logger.setLevel(logging.DEBUG)

# 创建一个控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.DEBUG)

# 创建一个格式化器并添加到控制台处理器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
console_handler.setFormatter(formatter)

# 将控制台处理器添加到日志记录器
logger.addHandler(console_handler)

# 记录日志
logger.info('这是输出到控制台的 INFO 日志')
```
此代码将日志消息输出到了控制台，便于在开发过程中实时查看程序的运行信息。

### 同时记录到文件和控制台
```python
import logging

# 创建一个日志记录器
logger = logging.getLogger('both_logger')
logger.setLevel(logging.DEBUG)

# 创建文件处理器
file_handler = logging.FileHandler('both.log')
file_handler.setLevel(logging.DEBUG)

# 创建控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 将格式化器添加到文件处理器和控制台处理器
file_handler.setFormatter(formatter)
console_handler.setFormatter(formatter)

# 将文件处理器和控制台处理器添加到日志记录器
logger.addHandler(file_handler)
logger.addHandler(console_handler)

# 记录日志
logger.info('同时记录到文件和控制台的 INFO 日志')
```
这段代码展示了如何同时将日志消息记录到文件和输出到控制台，兼顾了实时查看和长期保存日志的需求。

### 根据日志级别过滤日志
```python
import logging

# 创建一个日志记录器
logger = logging.getLogger('filtered_logger')
logger.setLevel(logging.DEBUG)

# 创建一个文件处理器，只记录 ERROR 及以上级别的日志
error_file_handler = logging.FileHandler('error.log')
error_file_handler.setLevel(logging.ERROR)

# 创建一个控制台处理器，只记录 INFO 及以上级别的日志
info_console_handler = logging.StreamHandler()
info_console_handler.setLevel(logging.INFO)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
error_file_handler.setFormatter(formatter)
info_console_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(error_file_handler)
logger.addHandler(info_console_handler)

# 记录日志
logger.debug('DEBUG 日志，不会被记录')
logger.info('INFO 日志，会输出到控制台')
logger.error('ERROR 日志，会输出到控制台并记录到文件')
```
在这个例子中，通过设置不同处理器的日志级别，实现了对日志消息的过滤。`error.log` 文件只会记录 `ERROR` 及以上级别的日志，而控制台只会输出 `INFO` 及以上级别的日志。

## 最佳实践
### 全局配置日志
可以创建一个专门的日志配置模块，在其中进行全局的日志配置，然后在各个模块中导入该配置。例如：
```python
# log_config.py
import logging

def setup_logging():
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )

# main.py
import logging
from log_config import setup_logging

setup_logging()
logging.info('这是主程序中的 INFO 日志')
```
这样可以保证整个项目的日志配置一致，便于维护和管理。

### 在不同模块中使用日志记录器
在不同的模块中，可以使用与模块名相同的日志记录器名称，以便更好地追踪日志来源。例如：
```python
# module1.py
import logging

logger = logging.getLogger(__name__)

def module1_function():
    logger.info('这是 module1 中的 INFO 日志')

# main.py
import logging
import module1

logging.basicConfig(level=logging.INFO)
module1.module1_function()
```
### 日志轮转
随着程序的运行，日志文件可能会变得非常大，影响系统性能和存储空间。可以使用 `TimedRotatingFileHandler` 或 `RotatingFileHandler` 进行日志轮转。
```python
import logging
from logging.handlers import TimedRotatingFileHandler

# 创建一个日志记录器
logger = logging.getLogger('rotating_logger')
logger.setLevel(logging.DEBUG)

# 创建一个按时间轮转的文件处理器
file_handler = TimedRotatingFileHandler('rotating.log', when='midnight', interval=1, backupCount=7)
file_handler.setLevel(logging.DEBUG)

# 创建一个格式化器并添加到文件处理器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)

# 将文件处理器添加到日志记录器
logger.addHandler(file_handler)

# 记录日志
for i in range(100):
    logger.info(f'这是第 {i} 条日志')
```
在这个例子中，`TimedRotatingFileHandler` 会在每天午夜创建一个新的日志文件，并保留 7 天的日志备份。

### 安全与隐私考虑
在记录日志时，要注意保护敏感信息，如用户密码、信用卡号等。对于敏感信息，可以进行加密或掩码处理后再记录到日志中。

## 小结
Python 的 `logging` 模块提供了丰富而灵活的日志记录功能。通过了解日志级别、日志记录器、处理器和格式化器等基础概念，掌握基本的使用方法和常见实践，并遵循最佳实践原则，我们可以有效地记录和管理程序运行过程中的日志信息，从而更好地进行调试、监控和维护。希望本文能够帮助你在 Python 开发中熟练运用日志记录功能，提高开发效率和程序的稳定性。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html)
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html)
---
title: "Python日志模块logging：深入理解与高效使用"
description: "在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助我们追踪程序的执行流程、排查错误、了解系统运行状态等。Python提供了强大的内置日志模块 `logging`，可以方便地实现日志记录功能。本文将深入探讨Python `logging` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用该模块进行项目开发。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助我们追踪程序的执行流程、排查错误、了解系统运行状态等。Python提供了强大的内置日志模块 `logging`，可以方便地实现日志记录功能。本文将深入探讨Python `logging` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用该模块进行项目开发。

<!-- more -->
## 目录
1. **基础概念**
    - **日志级别**
    - **日志记录器（Logger）**
    - **处理器（Handler）**
    - **格式化器（Formatter）**
2. **使用方法**
    - **简单配置**
    - **基本使用示例**
    - **配置文件方式**
3. **常见实践**
    - **记录不同级别的日志**
    - **日志输出到文件**
    - **多模块日志记录**
4. **最佳实践**
    - **设置合适的日志级别**
    - **日志文件管理**
    - **日志安全**
5. **小结**
6. **参考资料**

## 基础概念
### 日志级别
`logging` 模块定义了几个日志级别，用于区分日志的重要性和类型：
- `DEBUG`：最详细的日志级别，用于调试过程中记录详细信息。
- `INFO`：用于记录程序运行过程中的重要信息，如启动、停止等。
- `WARNING`：用于表示一些可能的问题，但不影响程序正常运行。
- `ERROR`：用于记录程序运行过程中发生的错误。
- `CRITICAL`：表示严重的错误，可能导致程序无法正常运行。

### 日志记录器（Logger）
日志记录器是 `logging` 模块的核心，它负责记录日志。每个日志记录器都有一个名称，用于标识日志的来源。可以通过 `logging.getLogger(name)` 方法获取日志记录器实例，其中 `name` 通常使用模块名 `__name__`，这样可以方便地追踪日志来源。

### 处理器（Handler）
处理器负责将日志记录发送到指定的目的地，例如控制台、文件等。常见的处理器有：
- `StreamHandler`：将日志输出到控制台。
- `FileHandler`：将日志输出到文件。

### 格式化器（Formatter）
格式化器用于定义日志记录的输出格式，例如时间、日志级别、消息等信息的显示方式。可以通过创建 `Formatter` 实例并设置格式字符串来定制日志格式。

## 使用方法
### 简单配置
`logging` 模块提供了简单的配置方法 `basicConfig`，可以快速设置日志的基本参数，如日志级别、输出格式等。

```python
import logging

# 简单配置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 使用根日志记录器记录日志
logging.debug('这是一条DEBUG级别的日志')
logging.info('这是一条INFO级别的日志')
logging.warning('这是一条WARNING级别的日志')
logging.error('这是一条ERROR级别的日志')
logging.critical('这是一条CRITICAL级别的日志')
```

### 基本使用示例
```python
import logging

# 获取日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建处理器
stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
stream_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(stream_handler)

# 记录日志
logger.debug('这是一条DEBUG级别的日志')
logger.info('这是一条INFO级别的日志')
logger.warning('这是一条WARNING级别的日志')
logger.error('这是一条ERROR级别的日志')
logger.critical('这是一条CRITICAL级别的日志')
```

### 配置文件方式
为了更好地管理日志配置，可以将配置信息存储在配置文件中，然后通过 `fileConfig` 方法加载配置。

创建一个 `logging.conf` 文件：
```ini
[loggers]
keys=root

[handlers]
keys=consoleHandler

[formatters]
keys=simpleFormatter

[logger_root]
level=DEBUG
handlers=consoleHandler

[handler_consoleHandler]
class=StreamHandler
level=DEBUG
formatter=simpleFormatter
args=(sys.stdout,)

[formatter_simpleFormatter]
format=%(asctime)s - %(name)s - %(levelname)s - %(message)s
```

加载配置文件：
```python
import logging
from logging.config import fileConfig

# 加载配置文件
fileConfig('logging.conf')

# 获取日志记录器
logger = logging.getLogger()

# 记录日志
logger.debug('这是一条DEBUG级别的日志')
logger.info('这是一条INFO级别的日志')
logger.warning('这是一条WARNING级别的日志')
logger.error('这是一条ERROR级别的日志')
logger.critical('这是一条CRITICAL级别的日志')
```

## 常见实践
### 记录不同级别的日志
在实际开发中，根据不同的场景记录不同级别的日志可以帮助我们快速定位问题。例如，在开发阶段可以记录 `DEBUG` 级别的日志，而在生产环境中只记录 `INFO` 及以上级别的日志。

```python
import logging

# 获取日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建控制台处理器并设置级别为INFO
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)

# 创建文件处理器并设置级别为DEBUG
file_handler = logging.FileHandler('app.log')
file_handler.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
console_handler.setFormatter(formatter)
file_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(console_handler)
logger.addHandler(file_handler)

# 记录日志
logger.debug('这是一条DEBUG级别的日志，将输出到文件')
logger.info('这是一条INFO级别的日志，将输出到控制台和文件')
logger.warning('这是一条WARNING级别的日志，将输出到控制台和文件')
logger.error('这是一条ERROR级别的日志，将输出到控制台和文件')
logger.critical('这是一条CRITICAL级别的日志，将输出到控制台和文件')
```

### 日志输出到文件
将日志输出到文件可以方便我们后续查看和分析。可以使用 `FileHandler` 实现这一功能。

```python
import logging

# 获取日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建文件处理器
file_handler = logging.FileHandler('app.log')
file_handler.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
file_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)

# 记录日志
logger.debug('这是一条DEBUG级别的日志，将输出到app.log文件')
logger.info('这是一条INFO级别的日志，将输出到app.log文件')
logger.warning('这是一条WARNING级别的日志，将输出到app.log文件')
logger.error('这是一条ERROR级别的日志，将输出到app.log文件')
logger.critical('这是一条CRITICAL级别的日志，将输出到app.log文件')
```

### 多模块日志记录
在大型项目中，通常会有多个模块。为了方便追踪日志来源，可以为每个模块创建独立的日志记录器。

假设项目结构如下：
```
project/
    ├── main.py
    ├── module1.py
    └── module2.py
```

`module1.py`：
```python
import logging

# 获取模块级别的日志记录器
logger = logging.getLogger(__name__)


def module1_function():
    logger.info('Module 1 function is running')
```

`module2.py`：
```python
import logging

# 获取模块级别的日志记录器
logger = logging.getLogger(__name__)


def module2_function():
    logger.info('Module 2 function is running')
```

`main.py`：
```python
import logging
from module1 import module1_function
from module2 import module2_function

# 获取主模块的日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# 创建控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
console_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(console_handler)

if __name__ == '__main__':
    logger.info('Main program started')
    module1_function()
    module2_function()
    logger.info('Main program ended')
```

## 最佳实践
### 设置合适的日志级别
在开发阶段，使用 `DEBUG` 级别记录详细的日志信息，方便调试。在生产环境中，根据实际情况调整日志级别，一般设置为 `INFO` 或 `WARNING`，避免过多的日志输出影响系统性能。

### 日志文件管理
定期清理日志文件，避免日志文件过大占用过多磁盘空间。可以使用日志轮转工具，如 `logging.handlers.TimedRotatingFileHandler` 按时间进行日志文件的分割和清理。

```python
import logging
from logging.handlers import TimedRotatingFileHandler

# 获取日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建按天轮转的文件处理器
file_handler = TimedRotatingFileHandler('app.log', when='D', interval=1, backupCount=7)
file_handler.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
file_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)

# 记录日志
logger.debug('这是一条DEBUG级别的日志，将输出到按天轮转的文件')
```

### 日志安全
在处理敏感信息时，要注意日志的安全性。避免在日志中记录密码、信用卡号等敏感信息。如果必须记录，对敏感信息进行加密处理。

## 小结
Python的 `logging` 模块提供了丰富的功能和灵活的配置方式，能够满足不同项目的日志记录需求。通过理解日志级别、日志记录器、处理器和格式化器等基础概念，并掌握常见的使用方法和最佳实践，我们可以更加高效地进行日志记录，为项目的开发、调试和维护提供有力支持。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
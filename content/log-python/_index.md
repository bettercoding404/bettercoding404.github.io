---
title: "Python 日志记录（logging）：从基础到最佳实践"
description: "在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者在程序运行时记录重要信息，如程序的执行流程、错误信息等。Python 提供了强大的 `logging` 模块，使得开发者可以方便地实现日志记录功能。本文将深入探讨 `logging` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地利用日志记录来提升开发效率和调试能力。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者在程序运行时记录重要信息，如程序的执行流程、错误信息等。Python 提供了强大的 `logging` 模块，使得开发者可以方便地实现日志记录功能。本文将深入探讨 `logging` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地利用日志记录来提升开发效率和调试能力。

<!-- more -->
## 目录
1. **基础概念**
    - **日志级别**
    - **日志记录器（Logger）**
    - **处理器（Handler）**
    - **格式化器（Formatter）**
2. **使用方法**
    - **基本配置**
    - **自定义日志记录器**
    - **使用不同的处理器**
    - **格式化日志输出**
3. **常见实践**
    - **记录错误信息**
    - **记录程序运行流程**
    - **日志文件管理**
4. **最佳实践**
    - **配置文件管理**
    - **多模块日志记录**
    - **日志安全与隐私**
5. **小结**
6. **参考资料**

## 基础概念
### 日志级别
Python 的 `logging` 模块定义了几个日志级别，用于控制日志记录的重要性和详细程度。常见的日志级别有：
- `DEBUG`：详细的调试信息，通常在开发阶段使用。
- `INFO`：一般性的信息，用于记录程序的正常运行状态。
- `WARNING`：表示可能出现问题，但程序仍能继续运行的警告信息。
- `ERROR`：记录程序运行过程中发生的错误信息。
- `CRITICAL`：严重的错误，通常表示程序无法继续运行。

### 日志记录器（Logger）
日志记录器是 `logging` 模块的核心，它负责处理日志消息。开发者可以通过 `logging.getLogger()` 方法获取一个日志记录器实例。每个日志记录器都有一个名称，通常使用模块名作为日志记录器的名称，以便更好地追踪日志来源。

### 处理器（Handler）
处理器负责将日志记录器产生的日志消息发送到指定的目的地，如控制台、文件等。常见的处理器有：
- `StreamHandler`：将日志消息输出到控制台。
- `FileHandler`：将日志消息写入文件。

### 格式化器（Formatter）
格式化器用于定义日志消息的输出格式。开发者可以通过自定义格式化器来控制日志消息中包含的信息，如时间、日志级别、消息内容等。

## 使用方法
### 基本配置
使用 `logging` 模块的最简单方式是使用 `basicConfig()` 方法进行基本配置。以下是一个简单的示例：
```python
import logging

# 配置日志记录
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录日志
logging.debug('这是一条调试信息')
logging.info('这是一条信息')
logging.warning('这是一条警告信息')
logging.error('这是一条错误信息')
logging.critical('这是一条严重错误信息')
```
在上述代码中，`basicConfig()` 方法设置了日志级别为 `INFO`，日志格式包含时间、日志级别和消息内容。运行这段代码，你将在控制台看到输出的日志信息。

### 自定义日志记录器
除了使用基本配置，开发者还可以自定义日志记录器。以下是一个示例：
```python
import logging

# 获取日志记录器
logger = logging.getLogger('my_logger')
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
logger.debug('这是一条自定义的调试信息')
logger.info('这是一条自定义的信息')
```
在这个示例中，我们创建了一个名为 `my_logger` 的日志记录器，并设置了日志级别为 `DEBUG`。然后创建了一个 `StreamHandler` 处理器，并设置了相同的日志级别。接着创建了一个格式化器，并将其添加到处理器中。最后，将处理器添加到日志记录器中。这样，我们就完成了一个自定义日志记录器的配置。

### 使用不同的处理器
除了 `StreamHandler`，`logging` 模块还提供了其他处理器，如 `FileHandler`。以下是一个将日志消息写入文件的示例：
```python
import logging

# 获取日志记录器
logger = logging.getLogger('file_logger')
logger.setLevel(logging.INFO)

# 创建文件处理器
file_handler = logging.FileHandler('app.log')
file_handler.setLevel(logging.INFO)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
file_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)

# 记录日志
logger.info('这是一条写入文件的信息')
```
在这个示例中，我们创建了一个 `FileHandler` 处理器，并将其配置为将日志消息写入 `app.log` 文件。运行这段代码后，你将在当前目录下看到生成的日志文件。

### 格式化日志输出
开发者可以通过自定义格式化器来控制日志消息的输出格式。以下是一个更复杂的格式化器示例：
```python
import logging

# 获取日志记录器
logger = logging.getLogger('formatted_logger')
logger.setLevel(logging.DEBUG)

# 创建处理器
stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(module)s - %(funcName)s - %(message)s')

# 将格式化器添加到处理器
stream_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(stream_handler)

# 定义一个函数
def my_function():
    logger.debug('这是在函数中记录的调试信息')

# 调用函数
my_function()
```
在这个示例中，格式化器的格式字符串包含了时间、日志记录器名称、日志级别、模块名、函数名和消息内容。通过这种方式，开发者可以更详细地了解日志消息的来源。

## 常见实践
### 记录错误信息
在程序运行过程中，记录错误信息是非常重要的。以下是一个在捕获异常时记录错误信息的示例：
```python
import logging

# 获取日志记录器
logger = logging.getLogger('error_logger')
logger.setLevel(logging.ERROR)

# 创建处理器
stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.ERROR)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
stream_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(stream_handler)

try:
    result = 1 / 0
except ZeroDivisionError as e:
    logger.error(f'发生错误: {str(e)}', exc_info=True)
```
在这个示例中，我们使用 `try - except` 语句捕获了一个 `ZeroDivisionError` 异常，并使用日志记录器记录了错误信息。`exc_info=True` 参数表示将异常堆栈信息也记录到日志中，这对于调试非常有帮助。

### 记录程序运行流程
记录程序的运行流程可以帮助开发者更好地理解程序的执行情况。以下是一个在函数中记录程序运行流程的示例：
```python
import logging

# 获取日志记录器
logger = logging.getLogger('process_logger')
logger.setLevel(logging.INFO)

# 创建处理器
stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.INFO)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
stream_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(stream_handler)

def process_data():
    logger.info('开始处理数据')
    # 模拟数据处理
    logger.info('数据处理完成')

# 调用函数
process_data()
```
在这个示例中，我们在 `process_data` 函数中使用日志记录器记录了函数的开始和结束信息，从而可以了解程序的运行流程。

### 日志文件管理
随着程序的运行，日志文件可能会变得非常大。为了管理日志文件，可以使用 `RotatingFileHandler` 处理器。以下是一个示例：
```python
import logging
from logging.handlers import RotatingFileHandler

# 获取日志记录器
logger = logging.getLogger('rotating_logger')
logger.setLevel(logging.INFO)

# 创建旋转文件处理器
file_handler = RotatingFileHandler('app_rotating.log', maxBytes=1024*1024, backupCount=5)
file_handler.setLevel(logging.INFO)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
file_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)

# 记录日志
for i in range(10000):
    logger.info(f'这是第 {i} 条日志信息')
```
在这个示例中，`RotatingFileHandler` 处理器会在日志文件大小达到 `maxBytes` 时，将旧的日志文件重命名并创建一个新的日志文件。`backupCount` 参数指定了保留的旧日志文件数量。

## 最佳实践
### 配置文件管理
将日志配置信息存储在配置文件中可以方便地进行管理和修改。以下是一个使用 `configparser` 模块读取日志配置文件的示例：
```python
import logging
import configparser

# 读取配置文件
config = configparser.ConfigParser()
config.read('logging_config.ini')

# 获取日志级别
log_level = config.get('logging', 'level')

# 获取日志格式
log_format = config.get('logging', 'format')

# 配置日志记录
logging.basicConfig(level=getattr(logging, log_level), format=log_format)

# 记录日志
logging.info('这是一条从配置文件读取配置的日志信息')
```
在 `logging_config.ini` 文件中，可以配置如下内容：
```ini
[logging]
level = INFO
format = %(asctime)s - %(levelname)s - %(message)s
```
通过这种方式，开发者可以在不修改代码的情况下调整日志配置。

### 多模块日志记录
在大型项目中，通常会有多个模块。为了更好地管理日志记录，可以为每个模块创建独立的日志记录器。以下是一个示例：
```python
# module1.py
import logging

logger = logging.getLogger(__name__)

def module1_function():
    logger.info('这是 module1 中的函数')

# module2.py
import logging

logger = logging.getLogger(__name__)

def module2_function():
    logger.info('这是 module2 中的函数')

# main.py
import logging
import module1
import module2

# 配置日志记录
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

module1.module1_function()
module2.module2_function()
```
在这个示例中，每个模块都使用 `__name__` 作为日志记录器的名称，这样可以方便地追踪日志来源。

### 日志安全与隐私
在处理日志记录时，需要注意保护敏感信息。例如，避免在日志中记录用户密码、信用卡号等敏感信息。如果必须记录某些敏感信息，可以考虑对其进行加密处理。

## 小结
本文详细介绍了 Python 中 `logging` 模块的基础概念、使用方法、常见实践以及最佳实践。通过合理使用日志记录，开发者可以更好地追踪程序的运行状态、调试错误以及管理项目。希望读者通过本文的学习，能够在自己的项目中高效地运用日志记录功能。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html)
- [Python Logging Cookbook](https://fangpenlin.com/posts/2012/08/26/good-logging-practice-in-python/)
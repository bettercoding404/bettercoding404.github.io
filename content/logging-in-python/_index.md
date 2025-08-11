---
title: "Python 中的日志记录（Logging）：全面解析与实践"
description: "在软件开发过程中，日志记录是一项至关重要的技术。它能够帮助开发者记录程序运行时的关键信息，如程序的执行流程、错误发生的位置和原因等。Python 提供了强大且灵活的内置日志记录模块 `logging`，通过它可以方便地控制日志的记录级别、输出格式以及输出位置等。本文将深入探讨 Python 中 `logging` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用日志记录来优化和调试自己的程序。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在软件开发过程中，日志记录是一项至关重要的技术。它能够帮助开发者记录程序运行时的关键信息，如程序的执行流程、错误发生的位置和原因等。Python 提供了强大且灵活的内置日志记录模块 `logging`，通过它可以方便地控制日志的记录级别、输出格式以及输出位置等。本文将深入探讨 Python 中 `logging` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用日志记录来优化和调试自己的程序。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 简单配置
    - 高级配置
3. 常见实践
    - 记录不同级别的日志
    - 日志输出到文件
    - 自定义日志格式
4. 最佳实践
    - 日志级别规范
    - 日志模块化
    - 日志安全
5. 小结
6. 参考资料

## 基础概念
### 日志记录器（Logger）
日志记录器是 `logging` 模块的核心，它负责捕获日志信息。每个日志记录器都有一个名称，用于标识该记录器，并且可以设置不同的日志级别。

### 日志处理器（Handler）
日志处理器负责将日志记录器捕获的日志信息发送到指定的目的地，如控制台、文件等。不同的处理器可以处理不同级别的日志信息。

### 日志格式化器（Formatter）
日志格式化器用于定义日志信息的输出格式，例如时间、日志级别、日志消息等信息的排列方式。

### 日志级别
Python 的 `logging` 模块定义了多个日志级别，从低到高依次为：
- `DEBUG`：用于详细的调试信息。
- `INFO`：用于记录程序运行的正常信息。
- `WARNING`：表示可能存在问题，但不影响程序的正常运行。
- `ERROR`：表示发生了错误，程序可能无法正常执行。
- `CRITICAL`：表示严重错误，可能导致程序崩溃。

## 使用方法
### 简单配置
使用 `logging` 模块的最简单方式是直接调用 `basicConfig` 方法进行基本配置，然后使用 `getLogger` 获取日志记录器并记录日志。

```python
import logging

# 基本配置
logging.basicConfig(level=logging.INFO)

# 获取日志记录器
logger = logging.getLogger(__name__)

# 记录日志
logger.debug('这是一条调试信息')
logger.info('这是一条信息')
logger.warning('这是一条警告信息')
logger.error('这是一条错误信息')
logger.critical('这是一条严重错误信息')
```

在上述代码中：
1. `logging.basicConfig(level=logging.INFO)` 设置了日志的基本配置，日志级别为 `INFO`，这意味着只有级别大于等于 `INFO` 的日志信息才会被记录。
2. `logging.getLogger(__name__)` 获取了一个名为当前模块名的日志记录器。
3. 使用不同级别的日志记录方法记录相应的日志信息。

### 高级配置
对于更复杂的需求，可以进行高级配置，例如将日志输出到文件，自定义日志格式等。

```python
import logging

# 创建日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建文件处理器
file_handler = logging.FileHandler('app.log')
file_handler.setLevel(logging.DEBUG)

# 创建控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)

# 创建日志格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 为处理器设置格式化器
file_handler.setFormatter(formatter)
console_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)
logger.addHandler(console_handler)

# 记录日志
logger.debug('这是一条调试信息')
logger.info('这是一条信息')
logger.warning('这是一条警告信息')
logger.error('这是一条错误信息')
logger.critical('这是一条严重错误信息')
```

在这个示例中：
1. 创建了一个名为 `__name__` 的日志记录器，并将其日志级别设置为 `DEBUG`。
2. 分别创建了文件处理器 `file_handler` 和控制台处理器 `console_handler`，并设置了不同的日志级别。
3. 定义了一个自定义的日志格式化器 `formatter`，指定了日志的输出格式。
4. 将格式化器应用到处理器上，并将处理器添加到日志记录器中。

## 常见实践
### 记录不同级别的日志
根据程序的运行状态和需求，记录不同级别的日志。在开发阶段，可以大量使用 `DEBUG` 级别日志来辅助调试；在生产环境中，通常将日志级别设置为 `INFO` 或更高，以减少日志输出量。

```python
import logging

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

def divide_numbers(a, b):
    try:
        logger.debug(f'开始执行除法运算，a={a}, b={b}')
        result = a / b
        logger.info(f'除法运算结果: {result}')
        return result
    except ZeroDivisionError as e:
        logger.error(f'发生除零错误: {e}')
        return None

divide_numbers(10, 2)
divide_numbers(10, 0)
```

### 日志输出到文件
将日志输出到文件可以方便后续查看和分析程序运行的历史记录。通过 `FileHandler` 可以实现这一功能。

```python
import logging

# 创建日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建文件处理器
file_handler = logging.FileHandler('app.log')
file_handler.setLevel(logging.DEBUG)

# 创建日志格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 为处理器设置格式化器
file_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)

# 记录日志
logger.debug('这是一条调试信息')
logger.info('这是一条信息')
logger.warning('这是一条警告信息')
logger.error('这是一条错误信息')
logger.critical('这是一条严重错误信息')
```

### 自定义日志格式
根据实际需求，可以自定义日志的输出格式，使其包含更多有用的信息。

```python
import logging

# 创建日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.DEBUG)

# 创建自定义日志格式化器
formatter = logging.Formatter('%(asctime)s - [%(filename)s:%(lineno)d] - %(levelname)s - %(message)s')

# 为处理器设置格式化器
console_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(console_handler)

# 记录日志
logger.debug('这是一条调试信息')
logger.info('这是一条信息')
logger.warning('这是一条警告信息')
logger.error('这是一条错误信息')
logger.critical('这是一条严重错误信息')
```

## 最佳实践
### 日志级别规范
在整个项目中，要保持日志级别的一致性和规范性。例如，只在开发环境中使用 `DEBUG` 级别日志，在测试环境和生产环境中根据需要调整为 `INFO` 或更高级别。

### 日志模块化
将日志记录功能模块化，每个模块有自己独立的日志记录器，方便定位问题和管理日志。

```python
# module1.py
import logging

logger = logging.getLogger(__name__)

def module1_function():
    logger.info('module1_function 被调用')

# module2.py
import logging

logger = logging.getLogger(__name__)

def module2_function():
    logger.info('module2_function 被调用')

# main.py
import logging
import module1
import module2

logging.basicConfig(level=logging.INFO)

module1.module1_function()
module2.module2_function()
```

### 日志安全
在处理敏感信息时，要注意日志的安全性。避免在日志中记录密码、信用卡号等敏感信息。如果必须记录，可以进行加密或脱敏处理。

## 小结
Python 的 `logging` 模块为开发者提供了强大而灵活的日志记录功能。通过理解日志记录器、处理器和格式化器等基础概念，掌握简单配置和高级配置的使用方法，以及遵循常见实践和最佳实践，开发者可以有效地记录程序运行的关键信息，方便调试和维护程序。合理运用日志记录，不仅可以提高开发效率，还能提升程序的稳定性和可靠性。

## 参考资料
- [Python 官方文档 - logging 模块](https://docs.python.org/3/library/logging.html)
- 《Python 核心编程》
- 《Effective Python》
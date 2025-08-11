---
title: "Python日志记录（logging）：全面解析与最佳实践"
description: "在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者追踪程序的执行流程、排查错误以及监控系统的运行状态。Python 标准库中的 `logging` 模块提供了灵活且强大的日志记录功能，使得开发者可以方便地控制日志的生成、格式以及输出目的地。本文将深入探讨 `logging` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用日志记录来提升开发效率和代码质量。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者追踪程序的执行流程、排查错误以及监控系统的运行状态。Python 标准库中的 `logging` 模块提供了灵活且强大的日志记录功能，使得开发者可以方便地控制日志的生成、格式以及输出目的地。本文将深入探讨 `logging` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用日志记录来提升开发效率和代码质量。

<!-- more -->
## 目录
1. **基础概念**
    - **日志级别**
    - **日志记录器（Logger）**
    - **处理器（Handler）**
    - **格式化器（Formatter）**
2. **使用方法**
    - **简单配置与使用**
    - **自定义日志记录器**
    - **日志输出到文件**
3. **常见实践**
    - **不同模块的日志记录**
    - **日志滚动（Rotating Logs）**
4. **最佳实践**
    - **日志格式规范**
    - **合理使用日志级别**
    - **避免日志记录对性能的影响**
5. **小结**
6. **参考资料**

## 基础概念
### 日志级别
`logging` 模块定义了几个日志级别，用于表示日志的重要性或紧急程度。常见的日志级别有：
- `DEBUG`：详细的信息，通常仅在调试时使用。
- `INFO`：确认程序按预期运行的信息。
- `WARNING`：表示可能出现问题，但不影响程序正常运行的警告信息。
- `ERROR`：由于某些错误导致程序部分功能无法正常运行的错误信息。
- `CRITICAL`：严重错误，通常表示程序无法继续运行。

### 日志记录器（Logger）
日志记录器是 `logging` 模块的核心，它负责处理日志记录的操作。每个日志记录器都有一个名称，通常采用模块名作为日志记录器的名称，以便更好地追踪日志来源。日志记录器可以设置不同的日志级别，只有级别大于或等于日志记录器设置级别的日志才会被处理。

### 处理器（Handler）
处理器负责将日志记录发送到指定的输出目的地，例如控制台、文件等。不同的处理器可以处理不同级别的日志，并且可以有不同的格式化方式。常见的处理器有：
- `StreamHandler`：将日志输出到控制台。
- `FileHandler`：将日志输出到文件。

### 格式化器（Formatter）
格式化器用于定义日志记录的格式，例如时间、日志级别、消息内容等。开发者可以根据自己的需求自定义格式化器，以获得清晰、易读的日志输出。

## 使用方法
### 简单配置与使用
在 Python 中，使用 `logging` 模块的最简单方式是使用 `basicConfig` 函数进行基本配置。以下是一个示例：

```python
import logging

# 配置日志记录
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录不同级别的日志
logging.debug('这是一条DEBUG级别的日志')
logging.info('这是一条INFO级别的日志')
logging.warning('这是一条WARNING级别的日志')
logging.error('这是一条ERROR级别的日志')
logging.critical('这是一条CRITICAL级别的日志')
```

在上述代码中，`basicConfig` 函数设置了日志级别为 `INFO`，并定义了日志的格式。由于日志级别为 `INFO`，因此 `DEBUG` 级别的日志不会被输出。

### 自定义日志记录器
除了使用 `basicConfig` 进行简单配置，还可以自定义日志记录器，以获得更灵活的控制。以下是一个示例：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个控制台处理器，并设置级别为INFO
ch = logging.StreamHandler()
ch.setLevel(logging.INFO)

# 创建一个文件处理器，并设置级别为DEBUG
fh = logging.FileHandler('app.log')
fh.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
ch.setFormatter(formatter)
fh.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(ch)
logger.addHandler(fh)

# 记录日志
logger.debug('这是一条DEBUG级别的日志')
logger.info('这是一条INFO级别的日志')
logger.warning('这是一条WARNING级别的日志')
logger.error('这是一条ERROR级别的日志')
logger.critical('这是一条CRITICAL级别的日志')
```

在上述代码中，首先创建了一个自定义的日志记录器 `logger`，并设置其级别为 `DEBUG`。然后创建了一个控制台处理器 `ch` 和一个文件处理器 `fh`，分别设置了不同的级别和格式化器。最后将处理器添加到日志记录器中，这样日志记录器就可以将不同级别的日志输出到控制台和文件中。

### 日志输出到文件
将日志输出到文件是非常常见的需求。可以使用 `FileHandler` 来实现这一功能。以下是一个简化的示例：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个文件处理器
fh = logging.FileHandler('app.log')
fh.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
fh.setFormatter(formatter)

# 将文件处理器添加到日志记录器
logger.addHandler(fh)

# 记录日志
logger.debug('这是一条DEBUG级别的日志')
logger.info('这是一条INFO级别的日志')
```

在上述代码中，创建了一个 `FileHandler`，并将其添加到日志记录器中，这样日志就会被输出到 `app.log` 文件中。

## 常见实践
### 不同模块的日志记录
在大型项目中，通常会有多个模块。为了更好地管理和追踪日志，可以为每个模块创建独立的日志记录器。以下是一个示例：

```python
# module1.py
import logging

logger = logging.getLogger(__name__)

def function1():
    logger.info('function1 被调用')

# module2.py
import logging

logger = logging.getLogger(__name__)

def function2():
    logger.warning('function2 中出现了一个警告')

# main.py
import logging
import module1
import module2

# 配置日志记录
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

module1.function1()
module2.function2()
```

在上述代码中，`module1` 和 `module2` 分别创建了自己的日志记录器，通过日志记录器的名称可以清晰地分辨出日志的来源。

### 日志滚动（Rotating Logs）
当日志文件不断增大时，可能需要对日志进行滚动，以避免占用过多的磁盘空间。`logging.handlers` 模块提供了 `RotatingFileHandler` 来实现这一功能。以下是一个示例：

```python
import logging
from logging.handlers import RotatingFileHandler

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个滚动文件处理器
rfh = RotatingFileHandler('app.log', maxBytes=1024*1024, backupCount=5)
rfh.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
rfh.setFormatter(formatter)

# 将滚动文件处理器添加到日志记录器
logger.addHandler(rfh)

# 记录大量日志
for i in range(10000):
    logger.debug(f'这是第 {i} 条DEBUG级别的日志')
```

在上述代码中，`RotatingFileHandler` 会在日志文件大小达到 `maxBytes` 时，将旧的日志文件重命名并创建一个新的日志文件，最多保留 `backupCount` 个旧日志文件。

## 最佳实践
### 日志格式规范
为了使日志易于阅读和分析，应该遵循一定的格式规范。例如，在日志中包含时间、日志级别、模块名称、函数名称以及详细的消息内容。以下是一个推荐的日志格式：

```python
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(funcName)s - %(message)s')
```

### 合理使用日志级别
根据不同的场景合理使用日志级别，避免过多的低级别日志影响性能和可读性。例如，在开发过程中可以使用 `DEBUG` 级别来记录详细的调试信息，而在生产环境中可以将日志级别设置为 `INFO` 或 `WARNING`。

### 避免日志记录对性能的影响
频繁的日志记录可能会对程序性能产生一定的影响。因此，在生产环境中应该尽量避免不必要的日志记录。可以通过条件判断来控制日志的输出，例如：

```python
if logging.getLogger(__name__).isEnabledFor(logging.DEBUG):
    logger.debug('这是一条DEBUG级别的日志，只有在DEBUG级别启用时才会输出')
```

## 小结
本文详细介绍了 Python 中 `logging` 模块的基础概念、使用方法、常见实践以及最佳实践。通过合理使用日志记录，可以有效地追踪程序的执行流程、排查错误以及监控系统的运行状态。希望读者通过本文的学习，能够在实际开发中更加熟练地运用 `logging` 模块，提升代码的质量和可维护性。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html)
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html)
---
title: "Python Logging Level：深入理解与高效应用"
description: "在 Python 开发中，日志记录是一项至关重要的任务。它不仅能帮助我们调试代码，追踪程序的执行流程，还能在生产环境中监控应用程序的运行状态。`logging` 模块是 Python 标准库中用于日志记录的工具，而日志级别（logging level）则是控制日志记录详细程度的关键因素。本文将深入探讨 Python logging level 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大的工具。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 开发中，日志记录是一项至关重要的任务。它不仅能帮助我们调试代码，追踪程序的执行流程，还能在生产环境中监控应用程序的运行状态。`logging` 模块是 Python 标准库中用于日志记录的工具，而日志级别（logging level）则是控制日志记录详细程度的关键因素。本文将深入探讨 Python logging level 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大的工具。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是日志级别
    - 标准日志级别
2. **使用方法**
    - 基本配置
    - 设置不同级别的日志记录
    - 自定义日志级别
3. **常见实践**
    - 开发环境中的日志记录
    - 生产环境中的日志记录
4. **最佳实践**
    - 合理设置日志级别
    - 日志记录的格式化
    - 日志输出位置
5. **小结**
6. **参考资料**

## 基础概念
### 什么是日志级别
日志级别是一种用于区分日志信息重要性或详细程度的机制。通过设置不同的日志级别，可以控制哪些日志信息会被记录下来，哪些会被忽略。这在不同的开发阶段和运行环境中非常有用，例如在开发阶段，我们可能希望记录所有详细的信息以便调试，而在生产环境中，只需要记录关键的错误信息。

### 标准日志级别
Python 的 `logging` 模块定义了以下几个标准的日志级别，按照重要性从低到高排列：
- **DEBUG**：最详细的日志级别，用于调试目的。通常包含大量的信息，有助于追踪程序的执行流程和查找问题。
- **INFO**：用于记录一般的信息，例如程序的启动、关闭，以及一些重要的操作步骤。
- **WARNING**：表示可能会出现问题，但不会影响程序的正常运行。例如，文件即将过期、资源接近耗尽等情况。
- **ERROR**：表示程序发生了错误，但仍能继续运行。通常用于记录导致部分功能无法正常工作的问题。
- **CRITICAL**：最严重的日志级别，表示程序发生了严重的错误，可能无法继续运行。例如，数据库连接失败、系统资源耗尽等情况。

## 使用方法
### 基本配置
在使用 `logging` 模块之前，需要进行基本的配置。以下是一个简单的示例：

```python
import logging

# 配置日志记录的基本设置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录不同级别的日志
logging.debug('这是一条 DEBUG 级别的日志')
logging.info('这是一条 INFO 级别的日志')
logging.warning('这是一条 WARNING 级别的日志')
logging.error('这是一条 ERROR 级别的日志')
logging.critical('这是一条 CRITICAL 级别的日志')
```

在上述代码中：
- `logging.basicConfig` 用于配置日志记录的基本设置。
    - `level` 参数设置了日志记录的级别，这里设置为 `logging.INFO`，意味着只有 INFO 级别及以上的日志信息才会被记录。
    - `format` 参数定义了日志信息的格式，这里包含了时间、日志级别和日志消息。

### 设置不同级别的日志记录
可以根据需要随时更改日志记录的级别。例如，在开发阶段，可以将日志级别设置为 `DEBUG`，以便获取更多详细信息：

```python
import logging

# 配置日志记录的基本设置
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录不同级别的日志
logging.debug('这是一条 DEBUG 级别的日志')
logging.info('这是一条 INFO 级别的日志')
logging.warning('这是一条 WARNING 级别的日志')
logging.error('这是一条 ERROR 级别的日志')
logging.critical('这是一条 CRITICAL 级别的日志')
```

### 自定义日志级别
除了标准的日志级别，还可以自定义日志级别。例如：

```python
import logging

# 自定义日志级别
MY_LEVEL = 25
logging.addLevelName(MY_LEVEL, 'MY_LEVEL')

def my_log(self, message, *args, **kwargs):
    if self.isEnabledFor(MY_LEVEL):
        self._log(MY_LEVEL, message, args, **kwargs)

logging.Logger.my_log = my_log

# 配置日志记录的基本设置
logging.basicConfig(level=MY_LEVEL, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录自定义级别的日志
logging.getLogger().my_log('这是一条自定义级别的日志')
```

在上述代码中：
- `logging.addLevelName` 用于添加一个自定义的日志级别。
- 定义了一个新的日志记录方法 `my_log`，并将其添加到 `logging.Logger` 类中。

## 常见实践
### 开发环境中的日志记录
在开发环境中，通常希望记录尽可能多的信息，以便快速定位和解决问题。因此，一般将日志级别设置为 `DEBUG`。例如：

```python
import logging

# 配置日志记录的基本设置
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

def my_function():
    logging.debug('进入 my_function 函数')
    result = 1 + 2
    logging.debug('计算结果为 %d', result)
    return result

my_function()
```

### 生产环境中的日志记录
在生产环境中，过多的日志信息可能会导致性能问题和存储压力。因此，通常将日志级别设置为 `INFO` 或 `WARNING`，只记录关键的信息和潜在的问题。例如：

```python
import logging

# 配置日志记录的基本设置
logging.basicConfig(level=logging.WARNING, format='%(asctime)s - %(levelname)s - %(message)s')

def my_function():
    try:
        result = 1 / 0
    except ZeroDivisionError as e:
        logging.error('发生除零错误: %s', str(e))

my_function()
```

## 最佳实践
### 合理设置日志级别
根据不同的环境和需求，合理设置日志级别。在开发环境中，可以使用 `DEBUG` 级别获取详细信息；在测试环境中，可以使用 `INFO` 级别记录重要操作；在生产环境中，尽量使用 `WARNING` 及以上级别，避免过多的日志记录影响性能。

### 日志记录的格式化
使用清晰、易读的日志格式，包含时间、日志级别、模块名称、函数名称等信息，以便快速定位问题。例如：

```python
import logging

# 配置日志记录的基本设置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(funcName)s - %(message)s')

def my_function():
    logging.info('执行 my_function 函数')

my_function()
```

### 日志输出位置
将日志输出到合适的位置，例如文件、控制台或日志服务器。可以根据需要同时输出到多个位置。例如，将重要的日志信息输出到文件，将一般的信息输出到控制台：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个文件处理器
file_handler = logging.FileHandler('app.log')
file_handler.setLevel(logging.ERROR)

# 创建一个控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)

# 创建一个日志格式器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式器添加到处理器
file_handler.setFormatter(formatter)
console_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)
logger.addHandler(console_handler)

# 记录日志
logger.debug('这是一条 DEBUG 级别的日志')
logger.info('这是一条 INFO 级别的日志')
logger.warning('这是一条 WARNING 级别的日志')
logger.error('这是一条 ERROR 级别的日志')
logger.critical('这是一条 CRITICAL 级别的日志')
```

## 小结
Python 的 `logging` 模块提供了强大的日志记录功能，而日志级别是控制日志记录详细程度的关键。通过合理设置日志级别、格式化日志信息以及选择合适的日志输出位置，可以有效地进行调试和监控应用程序的运行状态。在不同的开发阶段和运行环境中，灵活运用日志级别能够提高开发效率和系统的稳定性。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
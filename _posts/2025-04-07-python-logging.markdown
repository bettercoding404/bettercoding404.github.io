---
title: "Python Logging：强大的日志记录工具"
description: "在软件开发过程中，日志记录是一项至关重要的任务。它可以帮助我们追踪程序的执行流程、排查错误、监控系统运行状态等。Python 的 `logging` 模块提供了灵活且强大的日志记录功能，让开发者能够方便地管理和记录程序运行过程中的各种信息。本文将深入介绍 Python `logging` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用日志记录来提升开发效率和程序稳定性。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在软件开发过程中，日志记录是一项至关重要的任务。它可以帮助我们追踪程序的执行流程、排查错误、监控系统运行状态等。Python 的 `logging` 模块提供了灵活且强大的日志记录功能，让开发者能够方便地管理和记录程序运行过程中的各种信息。本文将深入介绍 Python `logging` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用日志记录来提升开发效率和程序稳定性。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 简单配置
    - 自定义配置
3. 常见实践
    - 记录不同级别的日志
    - 日志输出到文件
    - 日志格式化
4. 最佳实践
    - 多模块日志记录
    - 日志级别管理
    - 日志轮转
5. 小结
6. 参考资料

## 基础概念
- **日志记录器（Logger）**：是 `logging` 模块的核心对象，用于记录日志信息。每个日志记录器都有一个名称，通过名称来区分不同的日志记录器，方便管理和配置。
- **处理器（Handler）**：负责将日志记录发送到指定的目的地，例如控制台、文件、网络等。不同的处理器可以实现不同的输出功能。
- **格式化器（Formatter）**：用于定义日志记录的格式，例如时间、日志级别、消息内容等。通过格式化器可以定制日志的显示样式，使其更易于阅读和分析。
- **日志级别（Level）**：定义了日志记录的重要性级别，从低到高依次为 `DEBUG`、`INFO`、`WARNING`、`ERROR`、`CRITICAL`。开发者可以根据需要设置日志记录器的级别，只记录特定级别的日志信息。

## 使用方法
### 简单配置
Python `logging` 模块提供了一个简单的配置方式，通过 `basicConfig` 函数可以快速设置基本的日志配置。以下是一个简单的示例：

```python
import logging

# 配置基本日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录不同级别的日志
logging.debug('这是一条 DEBUG 级别的日志')
logging.info('这是一条 INFO 级别的日志')
logging.warning('这是一条 WARNING 级别的日志')
logging.error('这是一条 ERROR 级别的日志')
logging.critical('这是一条 CRITICAL 级别的日志')
```

### 自定义配置
除了简单配置，我们还可以通过创建日志记录器、处理器和格式化器来进行更精细的自定义配置。

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger('my_logger')
logger.setLevel(logging.DEBUG)

# 创建一个控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)

# 创建一个文件处理器
file_handler = logging.FileHandler('app.log')
file_handler.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
console_handler.setFormatter(formatter)
file_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(console_handler)
logger.addHandler(file_handler)

# 记录日志
logger.debug('这是一条 DEBUG 级别的日志')
logger.info('这是一条 INFO 级别的日志')
logger.warning('这是一条 WARNING 级别的日志')
logger.error('这是一条 ERROR 级别的日志')
logger.critical('这是一条 CRITICAL 级别的日志')
```

## 常见实践
### 记录不同级别的日志
在实际开发中，我们通常会根据不同的场景记录不同级别的日志。例如，在开发和调试阶段，可以记录 `DEBUG` 级别的详细信息；在生产环境中，只记录 `INFO` 及以上级别的日志，以减少日志输出量。

```python
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 模拟业务逻辑
def process_data():
    logger.debug('开始处理数据')
    # 数据处理代码
    logger.info('数据处理完成')

try:
    process_data()
except Exception as e:
    logger.error(f'处理数据时发生错误: {e}')
```

### 日志输出到文件
将日志输出到文件可以方便我们后续查看和分析程序运行过程中的信息。通过 `FileHandler` 可以很容易地实现这一功能。

```python
import logging

# 创建日志记录器
logger = logging.getLogger('file_logger')
logger.setLevel(logging.DEBUG)

# 创建文件处理器
file_handler = logging.FileHandler('app.log')
file_handler.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)

# 记录日志
logger.debug('这是一条 DEBUG 级别的日志')
logger.info('这是一条 INFO 级别的日志')
```

### 日志格式化
通过自定义格式化器，可以让日志输出更加清晰和易读。例如，我们可以在日志中添加时间戳、日志记录器名称、日志级别等信息。

```python
import logging

# 创建日志记录器
logger = logging.getLogger('formatted_logger')
logger.setLevel(logging.DEBUG)

# 创建控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
console_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(console_handler)

# 记录日志
logger.debug('这是一条 DEBUG 级别的日志')
```

## 最佳实践
### 多模块日志记录
在大型项目中，通常会有多个模块，每个模块都需要记录日志。为了方便管理和定位问题，每个模块应该有自己独立的日志记录器。

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
    logger.warning('module2_function 中发生了一个警告')

# main.py
import logging
import module1
import module2

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

module1.module1_function()
module2.module2_function()
```

### 日志级别管理
在不同的环境中（开发、测试、生产），我们可能需要动态调整日志级别。可以通过配置文件或者命令行参数来实现日志级别的管理。

```python
import logging
import argparse

def setup_logging(level):
    logging.basicConfig(level=level, format='%(asctime)s - %(levelname)s - %(message)s')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--log-level', default='INFO', choices=['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'])
    args = parser.parse_args()

    log_level = getattr(logging, args.log_level)
    setup_logging(log_level)

    logging.debug('这是一条 DEBUG 级别的日志')
    logging.info('这是一条 INFO 级别的日志')
```

### 日志轮转
随着程序的运行，日志文件可能会越来越大，占用大量的磁盘空间。日志轮转可以定期对日志文件进行切割，保留一定数量的历史日志文件。Python 的 `logging.handlers` 模块提供了 `RotatingFileHandler` 和 `TimedRotatingFileHandler` 来实现日志轮转功能。

```python
import logging
from logging.handlers import RotatingFileHandler

# 创建日志记录器
logger = logging.getLogger('rotating_logger')
logger.setLevel(logging.DEBUG)

# 创建 RotatingFileHandler
file_handler = RotatingFileHandler('app.log', maxBytes=1024*1024, backupCount=5)
file_handler.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)

# 记录日志
for i in range(10000):
    logger.debug(f'这是第 {i} 条 DEBUG 级别的日志')
```

## 小结
Python 的 `logging` 模块为开发者提供了丰富且强大的日志记录功能。通过理解日志记录器、处理器、格式化器和日志级别的概念，并掌握基本的使用方法和常见实践，我们可以在开发过程中有效地记录和管理程序运行信息。遵循最佳实践，如多模块日志记录、日志级别管理和日志轮转等，可以进一步提升日志记录的质量和可维护性，帮助我们更好地排查问题和优化程序性能。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
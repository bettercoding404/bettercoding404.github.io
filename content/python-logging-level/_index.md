---
title: "深入理解Python Logging Level"
description: "在Python开发中，日志记录是一项至关重要的任务。它有助于我们追踪程序的执行流程、调试代码以及监控系统运行状态。`logging`模块是Python标准库中用于日志记录的工具，而`logging level`（日志级别）则是该模块的核心概念之一。通过合理设置日志级别，我们可以精确控制日志信息的输出，确保在不同环境下（开发、测试、生产）获取到合适的日志内容。本文将深入探讨Python `logging level`的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python开发中，日志记录是一项至关重要的任务。它有助于我们追踪程序的执行流程、调试代码以及监控系统运行状态。`logging`模块是Python标准库中用于日志记录的工具，而`logging level`（日志级别）则是该模块的核心概念之一。通过合理设置日志级别，我们可以精确控制日志信息的输出，确保在不同环境下（开发、测试、生产）获取到合适的日志内容。本文将深入探讨Python `logging level`的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本配置
    - 自定义日志级别
    - 不同级别日志的输出
3. 常见实践
    - 开发环境中的日志级别设置
    - 生产环境中的日志级别设置
4. 最佳实践
    - 分层日志记录
    - 日志级别与环境变量结合
5. 小结
6. 参考资料

## 基础概念
Python的`logging`模块定义了以下几种日志级别，按照严重程度从低到高排列：
- `DEBUG`：最详细的日志级别，用于开发过程中的调试信息。通常包含程序执行的详细步骤、变量值等信息，帮助开发人员定位问题。
- `INFO`：用于记录程序运行中的重要信息，例如服务启动、数据加载完成等。这些信息对于了解程序的正常运行状态很有帮助。
- `WARNING`：表示程序出现了一些非严重的问题，但可能会影响到程序的正常运行，例如文件即将过期、资源接近耗尽等。
- `ERROR`：用于记录程序中发生的错误，通常是导致程序无法正常执行的问题，例如语法错误、数据库连接失败等。
- `CRITICAL`：最严重的日志级别，用于记录导致程序崩溃或系统无法正常运行的问题，例如服务器故障、内存耗尽等。

每个日志级别都有对应的整数值，`DEBUG`为10，`INFO`为20，`WARNING`为30，`ERROR`为40，`CRITICAL`为50。这使得我们可以通过整数值来灵活控制日志级别。

## 使用方法
### 基本配置
在使用`logging`模块时，首先需要进行基本配置。以下是一个简单的示例：

```python
import logging

# 配置日志基本设置
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')

# 记录不同级别的日志
logging.debug('这是一条DEBUG级别的日志')
logging.info('这是一条INFO级别的日志')
logging.warning('这是一条WARNING级别的日志')
logging.error('这是一条ERROR级别的日志')
logging.critical('这是一条CRITICAL级别的日志')
```

在上述代码中：
- `logging.basicConfig()`用于配置日志的基本参数。
    - `level=logging.INFO`设置了日志级别为`INFO`，这意味着只有级别大于等于`INFO`（即`INFO`、`WARNING`、`ERROR`、`CRITICAL`）的日志才会被输出。
    - `format='%(asctime)s - %(levelname)s - %(message)s'`定义了日志的输出格式，包括时间、日志级别和日志信息。

### 自定义日志级别
除了标准的日志级别，我们还可以自定义日志级别。例如，我们可以定义一个`TRACE`级别，用于更详细的调试信息：

```python
import logging

# 自定义日志级别
TRACE_LEVEL_NUM = 5
logging.addLevelName(TRACE_LEVEL_NUM, "TRACE")


def trace(self, message, *args, **kws):
    if self.isEnabledFor(TRACE_LEVEL_NUM):
        self._log(TRACE_LEVEL_NUM, message, args, **kws)


logging.Logger.trace = trace

# 配置日志基本设置
logging.basicConfig(level=TRACE_LEVEL_NUM,
                    format='%(asctime)s - %(levelname)s - %(message)s')

# 记录自定义级别的日志
logging.trace('这是一条TRACE级别的日志')
```

在这个示例中：
- 首先定义了一个新的日志级别`TRACE_LEVEL_NUM`，值为5。
- 使用`logging.addLevelName()`将新的级别值与名称`TRACE`关联起来。
- 为`logging.Logger`类添加了一个`trace`方法，用于记录`TRACE`级别的日志。

### 不同级别日志的输出
不同的日志级别可以在不同的场景下使用。例如，在开发过程中，我们可能希望输出所有级别的日志，以便更好地调试代码：

```python
import logging

# 配置日志基本设置，级别设为DEBUG
logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(message)s')

# 模拟程序运行
def process_data():
    logging.debug('开始处理数据')
    # 模拟数据处理
    logging.info('数据处理完成')


process_data()
```

而在生产环境中，我们通常只希望输出`WARNING`及以上级别的日志，以避免过多的日志信息影响系统性能：

```python
import logging

# 配置日志基本设置，级别设为WARNING
logging.basicConfig(level=logging.WARNING,
                    format='%(asctime)s - %(levelname)s - %(message)s')

# 模拟程序运行
def process_data():
    logging.debug('开始处理数据')
    logging.info('数据处理完成')
    logging.warning('数据量较大，可能影响性能')


process_data()
```

## 常见实践
### 开发环境中的日志级别设置
在开发环境中，我们通常将日志级别设置为`DEBUG`，以便获取尽可能多的信息来帮助调试。可以通过修改`basicConfig`中的`level`参数来实现：

```python
import logging

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(levelname)s - %(message)s')
```

这样，在开发过程中，我们可以看到详细的调试信息，快速定位和解决问题。

### 生产环境中的日志级别设置
在生产环境中，为了避免过多的日志信息占用系统资源，通常将日志级别设置为`WARNING`或`ERROR`。例如：

```python
import logging

logging.basicConfig(level=logging.WARNING,
                    format='%(asctime)s - %(levelname)s - %(message)s')
```

这样，只有当程序出现潜在问题（`WARNING`）或错误（`ERROR`、`CRITICAL`）时，才会记录日志信息。

## 最佳实践
### 分层日志记录
在大型项目中，可以采用分层日志记录的方式。例如，为不同的模块或功能设置不同的日志记录器，并为每个日志记录器设置不同的日志级别。

```python
import logging

# 创建一个名为'main'的日志记录器
main_logger = logging.getLogger('main')
main_logger.setLevel(logging.INFO)

# 创建一个名为'utils'的日志记录器
utils_logger = logging.getLogger('utils')
utils_logger.setLevel(logging.DEBUG)

# 创建一个控制台处理器
console_handler = logging.StreamHandler()
console_handler.setFormatter(logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s'))

# 将控制台处理器添加到日志记录器
main_logger.addHandler(console_handler)
utils_logger.addHandler(console_handler)

# 使用日志记录器记录日志
main_logger.info('主模块的信息日志')
utils_logger.debug('工具模块的调试日志')
```

在这个示例中：
- 创建了两个不同的日志记录器`main_logger`和`utils_logger`，分别用于主模块和工具模块。
- 为不同的日志记录器设置了不同的日志级别，`main_logger`为`INFO`，`utils_logger`为`DEBUG`。
- 使用一个控制台处理器将日志输出到控制台，并设置了日志格式。

### 日志级别与环境变量结合
为了方便在不同环境下切换日志级别，可以将日志级别与环境变量结合。例如：

```python
import logging
import os

# 获取环境变量中的日志级别
log_level_env = os.getenv('LOG_LEVEL', 'INFO')

# 将环境变量中的日志级别字符串转换为对应的日志级别
log_level_mapping = {
    'DEBUG': logging.DEBUG,
    'INFO': logging.INFO,
    'WARNING': logging.WARNING,
    'ERROR': logging.ERROR,
    'CRITICAL': logging.CRITICAL
}
log_level = log_level_mapping.get(log_level_env, logging.INFO)

# 配置日志基本设置
logging.basicConfig(level=log_level,
                    format='%(asctime)s - %(levelname)s - %(message)s')

# 记录日志
logging.info('这是一条INFO级别的日志')
```

在这个示例中：
- 通过`os.getenv('LOG_LEVEL', 'INFO')`获取环境变量`LOG_LEVEL`的值，如果未设置，则默认为`INFO`。
- 使用一个字典`log_level_mapping`将环境变量中的字符串转换为对应的日志级别。
- 根据获取到的日志级别配置日志记录。

## 小结
Python的`logging level`是日志记录中非常重要的概念，通过合理设置日志级别，我们可以在不同的环境下获取到合适的日志信息。在开发过程中，通常使用`DEBUG`级别来获取详细的调试信息；而在生产环境中，一般将日志级别设置为`WARNING`或`ERROR`，以减少日志输出对系统性能的影响。同时，我们还介绍了一些最佳实践，如分层日志记录和将日志级别与环境变量结合，这些方法可以帮助我们更好地管理和控制日志记录。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html)
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html)
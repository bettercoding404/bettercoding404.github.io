---
title: "Python中的日志记录（Logging）"
description: "在软件开发过程中，日志记录是一项至关重要的技术。它可以帮助开发者记录程序运行过程中的各种信息，包括调试信息、错误信息、运行状态等。Python提供了强大的内置日志记录模块`logging`，通过它我们可以方便地控制日志的输出内容、输出格式以及输出位置等。本文将详细介绍Python中日志记录的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在软件开发过程中，日志记录是一项至关重要的技术。它可以帮助开发者记录程序运行过程中的各种信息，包括调试信息、错误信息、运行状态等。Python提供了强大的内置日志记录模块`logging`，通过它我们可以方便地控制日志的输出内容、输出格式以及输出位置等。本文将详细介绍Python中日志记录的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本配置
    - 记录不同级别的日志
    - 日志格式定制
    - 输出到文件
3. 常见实践
    - 模块内的日志记录
    - 多模块项目中的日志记录
4. 最佳实践
    - 合理设置日志级别
    - 日志文件管理
    - 日志安全
5. 小结
6. 参考资料

## 基础概念
### 日志级别
Python的`logging`模块定义了几个标准的日志级别，用于区分日志的重要性和类型。
- `DEBUG`：最详细的日志级别，用于调试目的，记录程序运行中的详细信息。
- `INFO`：用于记录程序运行的正常信息，比如某个功能开始执行或结束执行。
- `WARNING`：表示程序运行中出现了一些不影响程序整体运行，但可能需要关注的情况，例如某个功能即将过时。
- `ERROR`：记录程序运行过程中发生的错误，这些错误会导致部分功能无法正常执行。
- `CRITICAL`：最严重的日志级别，用于记录程序运行中发生的严重错误，可能导致程序崩溃。

### 日志记录器（Logger）
日志记录器是`logging`模块的核心组件，它负责处理日志记录请求。每个日志记录器都有一个名称，通常使用模块名作为日志记录器的名称，以便于定位日志来源。

### 处理器（Handler）
处理器负责将日志记录发送到指定的输出位置，比如控制台、文件等。`logging`模块提供了多种处理器，如`StreamHandler`（输出到控制台）、`FileHandler`（输出到文件）等。

### 格式化器（Formatter）
格式化器用于定义日志记录的输出格式，比如包含时间、日志级别、日志消息等信息。通过格式化器可以使日志输出更加规范和易于阅读。

## 使用方法

### 基本配置
在使用`logging`模块之前，我们需要进行基本配置。以下是一个简单的示例：

```python
import logging

# 基本配置
logging.basicConfig(level=logging.INFO)

# 记录日志
logging.debug('这是一条DEBUG级别的日志')
logging.info('这是一条INFO级别的日志')
logging.warning('这是一条WARNING级别的日志')
logging.error('这是一条ERROR级别的日志')
logging.critical('这是一条CRITICAL级别的日志')
```

在上述代码中，`basicConfig`方法进行了基本配置，设置日志级别为`INFO`。这意味着只有`INFO`级别及以上的日志才会被输出。

### 记录不同级别的日志
如上述示例所示，通过调用`logging`模块提供的不同方法（`debug`、`info`、`warning`、`error`、`critical`）可以记录不同级别的日志。在实际应用中，我们可以根据需要在代码的不同位置记录相应级别的日志。

### 日志格式定制
我们可以通过`Formatter`类来自定义日志格式。以下是一个示例：

```python
import logging

# 创建日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# 创建处理器并设置格式
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
ch = logging.StreamHandler()
ch.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(ch)

# 记录日志
logger.debug('这是一条DEBUG级别的日志')
logger.info('这是一条INFO级别的日志')
logger.warning('这是一条WARNING级别的日志')
logger.error('这是一条ERROR级别的日志')
logger.critical('这是一条CRITICAL级别的日志')
```

在上述代码中，我们创建了一个自定义的`Formatter`，设置日志格式为`%(asctime)s - %(levelname)s - %(message)s`，分别表示时间、日志级别和日志消息。然后创建了一个`StreamHandler`并将格式化器应用到处理器上，最后将处理器添加到日志记录器中。

### 输出到文件
除了输出到控制台，我们还可以将日志输出到文件。以下是一个示例：

```python
import logging

# 创建日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# 创建文件处理器并设置格式
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
fh = logging.FileHandler('app.log')
fh.setFormatter(formatter)

# 将文件处理器添加到日志记录器
logger.addHandler(fh)

# 记录日志
logger.debug('这是一条DEBUG级别的日志')
logger.info('这是一条INFO级别的日志')
logger.warning('这是一条WARNING级别的日志')
logger.error('这是一条ERROR级别的日志')
logger.critical('这是一条CRITICAL级别的日志')
```

在上述代码中，我们创建了一个`FileHandler`，并将其添加到日志记录器中，这样日志就会输出到`app.log`文件中。

## 常见实践

### 模块内的日志记录
在一个模块中使用日志记录时，通常将日志记录器的名称设置为模块名。这样可以方便在多模块项目中定位日志来源。以下是一个模块示例：

```python
# module_example.py
import logging

# 创建日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建处理器并设置格式
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch = logging.StreamHandler()
ch.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(ch)

def module_function():
    logger.debug('模块函数开始执行')
    # 函数逻辑
    logger.info('模块函数执行完毕')

```

### 多模块项目中的日志记录
在多模块项目中，我们需要统一管理日志记录。可以在项目的主模块中进行日志的基本配置，然后在各个子模块中获取对应的日志记录器。以下是一个简单的项目结构示例：

```
project/
├── main.py
├── module1.py
└── module2.py
```

`main.py`：
```python
import logging
import module1
import module2

# 主模块日志配置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

def main():
    module1.module1_function()
    module2.module2_function()

if __name__ == '__main__':
    main()

```

`module1.py`：
```python
import logging

# 获取日志记录器
logger = logging.getLogger(__name__)

def module1_function():
    logger.info('module1_function开始执行')
    # 函数逻辑
    logger.info('module1_function执行完毕')

```

`module2.py`：
```python
import logging

# 获取日志记录器
logger = logging.getLogger(__name__)

def module2_function():
    logger.info('module2_function开始执行')
    # 函数逻辑
    logger.info('module2_function执行完毕')

```

在上述示例中，主模块`main.py`进行了日志的基本配置，然后在`module1.py`和`module2.py`中通过`logging.getLogger(__name__)`获取各自的日志记录器，这样可以保证日志记录的一致性和可维护性。

## 最佳实践

### 合理设置日志级别
在开发阶段，可以将日志级别设置为`DEBUG`，以便获取更多的调试信息。在生产环境中，应将日志级别设置为`INFO`或更高，避免过多的日志信息影响系统性能。

### 日志文件管理
对于输出到文件的日志，需要定期进行清理和归档，避免日志文件过大占用过多磁盘空间。可以使用一些工具，如`logrotate`来进行日志文件的管理。

### 日志安全
在处理敏感信息的日志记录时，需要注意日志的安全性。避免在日志中记录密码、敏感数据等信息。如果必须记录，可以进行加密处理。

## 小结
Python的`logging`模块提供了丰富的功能和灵活的配置选项，通过合理使用日志记录，我们可以更好地调试和监控程序的运行状态。在实际开发中，需要根据项目的需求和环境，合理设置日志级别、定制日志格式，并注意日志文件的管理和安全。希望本文能帮助读者深入理解并高效使用Python中的日志记录。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html)
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html)
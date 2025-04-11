---
title: "Python Logger：深入理解与高效使用"
description: "在软件开发过程中，日志记录是一项至关重要的任务。它可以帮助我们追踪程序的执行流程、调试代码、监控系统运行状态以及在出现问题时进行故障排查。Python 的 `logging` 模块提供了强大而灵活的日志记录功能，也就是我们常说的 `logger`。通过合理使用 `logger`，我们能够更好地管理和理解程序的行为。本文将深入探讨 Python logger 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要工具。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在软件开发过程中，日志记录是一项至关重要的任务。它可以帮助我们追踪程序的执行流程、调试代码、监控系统运行状态以及在出现问题时进行故障排查。Python 的 `logging` 模块提供了强大而灵活的日志记录功能，也就是我们常说的 `logger`。通过合理使用 `logger`，我们能够更好地管理和理解程序的行为。本文将深入探讨 Python logger 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要工具。

<!-- more -->
## 目录
1. **基础概念**
    - **日志级别**
    - **日志记录器（Logger）**
    - **处理器（Handler）**
    - **格式化器（Formatter）**
2. **使用方法**
    - **基本配置与简单使用**
    - **自定义日志记录器**
    - **多模块中的日志记录**
3. **常见实践**
    - **记录到文件**
    - **同时记录到文件和控制台**
    - **根据日志级别过滤日志**
4. **最佳实践**
    - **日志命名规范**
    - **配置文件管理日志设置**
    - **避免日志记录影响性能**
5. **小结**
6. **参考资料**

## 基础概念
### 日志级别
Python 的 `logging` 模块定义了以下几个日志级别，从低到高依次为：
- `DEBUG`：详细的信息，通常仅在调试时使用。
- `INFO`：确认程序按预期运行的信息。
- `WARNING`：表示可能会出现问题，但程序仍可继续运行的警告信息。
- `ERROR`：由于严重问题导致程序某些功能无法正常运行的错误信息。
- `CRITICAL`：严重错误，通常意味着程序将无法继续运行。

### 日志记录器（Logger）
日志记录器是 `logging` 模块的核心，它负责接收日志消息并根据配置决定如何处理这些消息。我们可以通过 `logging.getLogger(name)` 方法获取一个日志记录器实例，其中 `name` 是一个字符串，通常使用模块名作为 `name`，这样可以方便地追踪日志来源。

### 处理器（Handler）
处理器决定了日志消息的输出位置和方式。常见的处理器有：
- `StreamHandler`：将日志输出到控制台。
- `FileHandler`：将日志输出到文件。

我们可以为日志记录器添加多个处理器，以便将日志同时输出到不同的地方。

### 格式化器（Formatter）
格式化器负责定义日志消息的格式。我们可以通过 `Formatter` 类创建格式化器实例，并设置日志消息的格式，例如包含时间、日志级别、模块名和消息内容等。

## 使用方法
### 基本配置与简单使用
```python
import logging

# 基本配置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 获取日志记录器
logger = logging.getLogger(__name__)

# 记录不同级别的日志
logger.debug('这是一条 DEBUG 级别的日志')
logger.info('这是一条 INFO 级别的日志')
logger.warning('这是一条 WARNING 级别的日志')
logger.error('这是一条 ERROR 级别的日志')
logger.critical('这是一条 CRITICAL 级别的日志')
```
在上述代码中，我们首先使用 `basicConfig` 进行了基本的日志配置，设置日志级别为 `INFO`，并定义了日志消息的格式。然后获取了一个名为 `__name__` 的日志记录器，并使用该记录器记录了不同级别的日志消息。由于日志级别设置为 `INFO`，所以 `DEBUG` 级别的日志消息不会被输出。

### 自定义日志记录器
```python
import logging

# 创建日志记录器
logger = logging.getLogger('my_custom_logger')
logger.setLevel(logging.DEBUG)

# 创建处理器
stream_handler = logging.StreamHandler()
file_handler = logging.FileHandler('my_log.log')

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 为处理器设置格式化器
stream_handler.setFormatter(formatter)
file_handler.setFormatter(formatter)

# 为日志记录器添加处理器
logger.addHandler(stream_handler)
logger.addHandler(file_handler)

# 记录日志
logger.debug('这是一条自定义日志记录器的 DEBUG 日志')
logger.info('这是一条自定义日志记录器的 INFO 日志')
```
在这个例子中，我们创建了一个自定义的日志记录器 `my_custom_logger`，设置其日志级别为 `DEBUG`。然后创建了一个控制台处理器和一个文件处理器，并为它们设置了相同的格式化器。最后将这两个处理器添加到日志记录器中，这样日志消息就会同时输出到控制台和文件 `my_log.log` 中。

### 多模块中的日志记录
假设我们有一个项目结构如下：
```
project/
├── main.py
└── utils/
    └── helper.py
```
在 `helper.py` 中：
```python
import logging

logger = logging.getLogger(__name__)


def helper_function():
    logger.info('这是来自 helper 模块的 INFO 日志')
```
在 `main.py` 中：
```python
import logging
from utils.helper import helper_function

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 获取日志记录器
main_logger = logging.getLogger(__name__)

main_logger.info('这是主模块的 INFO 日志')
helper_function()
```
通过这种方式，在不同模块中使用 `__name__` 作为日志记录器的名称，可以清晰地区分日志来源，方便调试和维护。

## 常见实践
### 记录到文件
```python
import logging

# 创建日志记录器
logger = logging.getLogger('file_logger')
logger.setLevel(logging.INFO)

# 创建文件处理器
file_handler = logging.FileHandler('app.log')

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 为文件处理器设置格式化器
file_handler.setFormatter(formatter)

# 为日志记录器添加文件处理器
logger.addHandler(file_handler)

# 记录日志
logger.info('这是一条记录到文件的 INFO 日志')
```
上述代码创建了一个日志记录器，并将日志消息记录到 `app.log` 文件中。

### 同时记录到文件和控制台
```python
import logging

# 创建日志记录器
logger = logging.getLogger('both_logger')
logger.setLevel(logging.INFO)

# 创建文件处理器
file_handler = logging.FileHandler('both.log')

# 创建控制台处理器
stream_handler = logging.StreamHandler()

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 为处理器设置格式化器
file_handler.setFormatter(formatter)
stream_handler.setFormatter(formatter)

# 为日志记录器添加处理器
logger.addHandler(file_handler)
logger.addHandler(stream_handler)

# 记录日志
logger.info('这是一条同时记录到文件和控制台的 INFO 日志')
```
这段代码让日志消息同时输出到控制台和 `both.log` 文件中。

### 根据日志级别过滤日志
```python
import logging

# 创建日志记录器
logger = logging.getLogger('filtered_logger')
logger.setLevel(logging.DEBUG)

# 创建控制台处理器
stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.WARNING)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

# 为控制台处理器设置格式化器
stream_handler.setFormatter(formatter)

# 为日志记录器添加控制台处理器
logger.addHandler(stream_handler)

# 记录日志
logger.debug('这是 DEBUG 级别的日志，不会在控制台显示')
logger.warning('这是 WARNING 级别的日志，会在控制台显示')
```
在这个例子中，我们设置了控制台处理器的日志级别为 `WARNING`，因此只有 `WARNING` 及以上级别的日志消息才会在控制台输出。

## 最佳实践
### 日志命名规范
为了便于管理和识别日志，建议使用有意义的名称来命名日志记录器。通常使用模块名或应用程序组件名作为日志记录器的名称，例如：
```python
logger = logging.getLogger('my_app.database')
logger = logging.getLogger('my_app.api')
```

### 配置文件管理日志设置
将日志配置信息放在配置文件中，这样可以方便地在不修改代码的情况下调整日志设置。例如，可以使用 `configparser` 模块读取配置文件：
```python
import logging
import configparser


def setup_logging():
    config = configparser.ConfigParser()
    config.read('logging_config.ini')

    log_level = config.get('logging', 'level', fallback='INFO')
    log_format = config.get('logging', 'format', fallback='%(asctime)s - %(levelname)s - %(message)s')

    logging.basicConfig(level=getattr(logging, log_level), format=log_format)


if __name__ == '__main__':
    setup_logging()
    logger = logging.getLogger(__name__)
    logger.info('使用配置文件设置日志')
```
在 `logging_config.ini` 中：
```ini
[logging]
level = DEBUG
format = %(asctime)s - %(name)s - %(levelname)s - %(message)s
```

### 避免日志记录影响性能
在高并发或性能敏感的应用中，过多或过于频繁的日志记录可能会影响程序性能。可以通过以下方法避免：
- 合理设置日志级别，在生产环境中尽量使用较高的日志级别，减少不必要的日志记录。
- 使用异步日志记录，例如使用 `QueueHandler` 和 `QueueListener` 来实现异步日志处理，避免日志记录阻塞主线程。

## 小结
Python 的 `logging` 模块提供了丰富而强大的日志记录功能。通过理解日志级别、日志记录器、处理器和格式化器等基础概念，掌握基本的使用方法，以及遵循常见实践和最佳实践，我们能够有效地管理和利用日志信息，提高程序的可维护性和可调试性。希望本文能够帮助读者在实际项目中更好地使用 Python logger。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
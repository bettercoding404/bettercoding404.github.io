---
title: "Python 中的日志记录（Logging）"
description: "在软件开发过程中，日志记录是一项至关重要的技术。它能够帮助开发者记录程序运行过程中的关键信息，包括程序的执行流程、错误发生的位置以及各种调试信息等。Python 提供了强大的内置日志记录模块 `logging`，使得开发者可以方便地在程序中添加日志记录功能。通过合理使用日志记录，不仅可以提高代码的可维护性和调试效率，还能在生产环境中及时发现和解决问题。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在软件开发过程中，日志记录是一项至关重要的技术。它能够帮助开发者记录程序运行过程中的关键信息，包括程序的执行流程、错误发生的位置以及各种调试信息等。Python 提供了强大的内置日志记录模块 `logging`，使得开发者可以方便地在程序中添加日志记录功能。通过合理使用日志记录，不仅可以提高代码的可维护性和调试效率，还能在生产环境中及时发现和解决问题。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本配置
    - 记录不同级别的日志
    - 自定义日志格式
3. 常见实践
    - 日志记录到文件
    - 日志记录到控制台
    - 多模块中的日志记录
4. 最佳实践
    - 合理设置日志级别
    - 日志文件的管理
    - 安全和隐私问题
5. 小结
6. 参考资料

## 基础概念
日志记录是一种将程序运行过程中的信息记录下来的机制。在 Python 中，`logging` 模块提供了一个灵活的框架来生成日志记录。日志记录包含以下几个重要概念：
- **日志级别（Log Levels）**：用于区分日志的重要性。Python 中定义了多个日志级别，从低到高依次为 `DEBUG`、`INFO`、`WARNING`、`ERROR` 和 `CRITICAL`。不同的日志级别可以帮助开发者筛选和查看不同重要程度的日志信息。
- **日志记录器（Logger）**：负责产生日志记录的对象。每个日志记录器都有一个名称，通常使用模块名作为日志记录器的名称，以便于追踪日志的来源。
- **处理器（Handler）**：负责将日志记录发送到不同的目标，例如控制台、文件等。一个日志记录器可以关联多个处理器，从而实现将日志记录同时发送到多个地方。
- **格式化器（Formatter）**：用于定义日志记录的输出格式，例如日志记录的时间、日志级别、日志信息等的显示方式。

## 使用方法
### 基本配置
在使用 `logging` 模块之前，需要进行基本的配置。以下是一个简单的示例：

```python
import logging

# 配置日志记录的基本设置
logging.basicConfig(level=logging.INFO)

# 记录一条 INFO 级别的日志
logging.info('这是一条 INFO 级别的日志')
```

在上述代码中，`logging.basicConfig(level=logging.INFO)` 用于配置日志记录的基本设置，设置日志级别为 `INFO`。`logging.info('这是一条 INFO 级别的日志')` 则用于记录一条 `INFO` 级别的日志。运行这段代码，会在控制台输出：

```
INFO:root:这是一条 INFO 级别的日志
```

### 记录不同级别的日志
`logging` 模块提供了不同的方法来记录不同级别的日志，示例如下：

```python
import logging

# 配置日志记录的基本设置
logging.basicConfig(level=logging.DEBUG)

# 记录不同级别的日志
logging.debug('这是一条 DEBUG 级别的日志')
logging.info('这是一条 INFO 级别的日志')
logging.warning('这是一条 WARNING 级别的日志')
logging.error('这是一条 ERROR 级别的日志')
logging.critical('这是一条 CRITICAL 级别的日志')
```

运行上述代码，会在控制台输出不同级别的日志信息：

```
DEBUG:root:这是一条 DEBUG 级别的日志
INFO:root:这是一条 INFO 级别的日志
WARNING:root:这是一条 WARNING 级别的日志
ERROR:root:这是一条 ERROR 级别的日志
CRITICAL:root:这是一条 CRITICAL 级别的日志
```

### 自定义日志格式
可以通过 `Formatter` 来自定义日志记录的输出格式。以下是一个示例：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 创建一个控制台处理器
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)
ch.setFormatter(formatter)

# 将控制台处理器添加到日志记录器
logger.addHandler(ch)

# 记录一条 DEBUG 级别的日志
logger.debug('这是一条自定义格式的 DEBUG 级别的日志')
```

在上述代码中：
- `logging.getLogger(__name__)` 创建了一个以当前模块名命名的日志记录器。
- `logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')` 定义了日志记录的格式，其中 `%(asctime)s` 表示时间，`%(name)s` 表示日志记录器名称，`%(levelname)s` 表示日志级别，`%(message)s` 表示日志信息。
- `logging.StreamHandler()` 创建了一个控制台处理器，并设置了日志级别和格式化器。
- `logger.addHandler(ch)` 将控制台处理器添加到日志记录器。

运行这段代码，会在控制台输出自定义格式的日志信息：

```
2023-XX-XX XX:XX:XX - __main__ - DEBUG - 这是一条自定义格式的 DEBUG 级别的日志
```

## 常见实践
### 日志记录到文件
将日志记录到文件中可以方便后续查看和分析。以下是一个将日志记录到文件的示例：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 创建一个文件处理器
fh = logging.FileHandler('app.log')
fh.setLevel(logging.DEBUG)
fh.setFormatter(formatter)

# 将文件处理器添加到日志记录器
logger.addHandler(fh)

# 记录一条 DEBUG 级别的日志
logger.debug('这是一条记录到文件的 DEBUG 级别的日志')
```

运行上述代码后，会在当前目录下生成一个名为 `app.log` 的文件，文件内容为：

```
2023-XX-XX XX:XX:XX - __main__ - DEBUG - 这是一条记录到文件的 DEBUG 级别的日志
```

### 日志记录到控制台
前面已经介绍了将日志记录到控制台的方法，通过 `logging.StreamHandler` 可以实现。以下是一个完整的示例：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 创建一个控制台处理器
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)
ch.setFormatter(formatter)

# 将控制台处理器添加到日志记录器
logger.addHandler(ch)

# 记录一条 DEBUG 级别的日志
logger.debug('这是一条记录到控制台的 DEBUG 级别的日志')
```

运行上述代码，会在控制台输出日志信息：

```
2023-XX-XX XX:XX:XX - __main__ - DEBUG - 这是一条记录到控制台的 DEBUG 级别的日志
```

### 多模块中的日志记录
在大型项目中，通常会有多个模块。在每个模块中正确配置日志记录器可以方便地追踪日志来源。以下是一个示例：

**模块 1：`module1.py`**

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)


def module1_function():
    logger.info('这是 module1 中的一条 INFO 级别的日志')
```

**模块 2：`module2.py`**

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)


def module2_function():
    logger.warning('这是 module2 中的一条 WARNING 级别的日志')
```

**主程序：`main.py`**

```python
import logging
from module1 import module1_function
from module2 import module2_function

# 配置日志记录的基本设置
logging.basicConfig(level=logging.INFO)

module1_function()
module2_function()
```

运行 `main.py`，会在控制台输出：

```
INFO:module1:这是 module1 中的一条 INFO 级别的日志
WARNING:module2:这是 module2 中的一条 WARNING 级别的日志
```

## 最佳实践
### 合理设置日志级别
在开发过程中，应根据实际需求合理设置日志级别。在开发和调试阶段，可以将日志级别设置为 `DEBUG`，以便获取更多详细信息。在生产环境中，应将日志级别设置为 `INFO` 或更高，避免记录过多不必要的信息，影响系统性能和日志文件大小。

### 日志文件的管理
对于日志文件，应定期进行清理和归档。可以使用第三方库（如 `logging.handlers.TimedRotatingFileHandler`）来实现按时间或文件大小进行日志文件的分割和归档。例如：

```python
import logging
from logging.handlers import TimedRotatingFileHandler

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 创建一个按天滚动的文件处理器
fh = TimedRotatingFileHandler('app.log', when='midnight', interval=1, backupCount=7)
fh.setLevel(logging.DEBUG)
fh.setFormatter(formatter)

# 将文件处理器添加到日志记录器
logger.addHandler(fh)

# 记录一条 DEBUG 级别的日志
logger.debug('这是一条使用滚动文件处理器的 DEBUG 级别的日志')
```

上述代码中，`TimedRotatingFileHandler` 会在每天午夜创建一个新的日志文件，并保留最近 7 天的日志文件。

### 安全和隐私问题
在记录日志时，应注意保护敏感信息，如用户密码、信用卡号等。避免将这些敏感信息记录到日志中。如果必须记录某些敏感信息，应进行加密或脱敏处理。

## 小结
Python 的 `logging` 模块提供了丰富的功能来实现日志记录。通过合理配置日志记录器、处理器和格式化器，可以方便地将日志记录到不同的目标，并自定义日志记录的格式。在实际开发中，遵循最佳实践可以提高日志记录的效率和安全性，帮助开发者更好地维护和调试程序。

## 参考资料
- [Python 官方文档 - logging 模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
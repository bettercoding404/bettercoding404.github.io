---
title: "Python Logger：日志记录的强大工具"
description: "在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者追踪程序的执行流程、调试代码、监控系统运行状态以及在出现问题时进行故障排查。Python 提供了一个内置的 `logging` 模块，通过这个模块，我们可以轻松地实现日志记录功能。本文将深入探讨 Python Logger 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大工具。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在软件开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者追踪程序的执行流程、调试代码、监控系统运行状态以及在出现问题时进行故障排查。Python 提供了一个内置的 `logging` 模块，通过这个模块，我们可以轻松地实现日志记录功能。本文将深入探讨 Python Logger 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大工具。

<!-- more -->
## 目录
1. **基础概念**
    - 日志级别
    - 日志记录器
    - 处理器
    - 格式化器
2. **使用方法**
    - 基本配置
    - 记录不同级别的日志
    - 自定义日志记录器
3. **常见实践**
    - 日志输出到文件
    - 日志同时输出到文件和控制台
    - 多模块中的日志记录
4. **最佳实践**
    - 日志级别设置策略
    - 日志格式设计
    - 日志文件管理
5. **小结**
6. **参考资料**

## 基础概念
### 日志级别
Python `logging` 模块定义了以下几个日志级别，按照严重程度从低到高排列：
- `DEBUG`：用于调试目的，记录详细的信息，通常在开发阶段使用。
- `INFO`：用于记录一般的信息，如程序的启动、关闭，重要事件的发生等。
- `WARNING`：用于记录可能的问题或异常情况，但程序仍能继续运行。
- `ERROR`：用于记录错误信息，当程序发生错误导致部分功能无法正常运行时使用。
- `CRITICAL`：用于记录严重的错误，通常表示程序无法继续运行。

### 日志记录器
日志记录器（`Logger`）是 `logging` 模块的核心对象，它负责记录日志信息。每个日志记录器都有一个名称，用于标识该记录器，通常使用模块名作为日志记录器的名称。通过日志记录器，我们可以设置日志级别、添加处理器等。

### 处理器
处理器（`Handler`）负责将日志记录发送到指定的目的地，例如控制台、文件、网络等。常见的处理器有：
- `StreamHandler`：将日志记录输出到控制台。
- `FileHandler`：将日志记录输出到文件。

### 格式化器
格式化器（`Formatter`）用于定义日志记录的格式，例如时间、日志级别、消息内容等。我们可以根据需求自定义格式化器，使日志记录更加清晰易读。

## 使用方法
### 基本配置
在使用 `logging` 模块之前，我们需要进行基本配置。以下是一个简单的示例：

```python
import logging

# 配置日志记录的基本设置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录日志
logging.debug('这是一条 DEBUG 级别的日志')
logging.info('这是一条 INFO 级别的日志')
logging.warning('这是一条 WARNING 级别的日志')
logging.error('这是一条 ERROR 级别的日志')
logging.critical('这是一条 CRITICAL 级别的日志')
```

在上述代码中：
- `logging.basicConfig` 方法用于进行基本配置，设置了日志级别为 `INFO`，日志格式包含时间、日志级别和消息内容。
- 随后通过 `logging` 模块提供的不同级别方法记录了各种级别的日志。由于日志级别设置为 `INFO`，所以 `DEBUG` 级别的日志不会被记录。

### 记录不同级别的日志
除了上述使用 `logging` 模块直接记录日志外，我们还可以通过获取日志记录器对象来记录日志。这样可以更灵活地控制日志记录。

```python
import logging

# 获取日志记录器对象
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建处理器
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
ch.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(ch)

# 记录日志
logger.debug('这是一条 DEBUG 级别的日志')
logger.info('这是一条 INFO 级别的日志')
logger.warning('这是一条 WARNING 级别的日志')
logger.error('这是一条 ERROR 级别的日志')
logger.critical('这是一条 CRITICAL 级别的日志')
```

在这个示例中：
- 使用 `logging.getLogger(__name__)` 获取了一个以当前模块名命名的日志记录器。
- 设置了日志记录器的级别为 `DEBUG`。
- 创建了一个 `StreamHandler` 处理器，并设置其级别为 `DEBUG`。
- 创建了一个自定义的格式化器，并将其添加到处理器。
- 最后将处理器添加到日志记录器，然后使用日志记录器记录不同级别的日志。

### 自定义日志记录器
我们还可以创建多个自定义的日志记录器，每个日志记录器可以有不同的配置。

```python
import logging

# 创建第一个日志记录器
logger1 = logging.getLogger('logger1')
logger1.setLevel(logging.INFO)

# 创建第一个处理器
ch1 = logging.StreamHandler()
ch1.setLevel(logging.INFO)

# 创建第一个格式化器
formatter1 = logging.Formatter('%(asctime)s - logger1 - %(levelname)s - %(message)s')
ch1.setFormatter(formatter1)
logger1.addHandler(ch1)

# 创建第二个日志记录器
logger2 = logging.getLogger('logger2')
logger2.setLevel(logging.WARNING)

# 创建第二个处理器
ch2 = logging.StreamHandler()
ch2.setLevel(logging.WARNING)

# 创建第二个格式化器
formatter2 = logging.Formatter('%(asctime)s - logger2 - %(levelname)s - %(message)s')
ch2.setFormatter(formatter2)
logger2.addHandler(ch2)

# 记录日志
logger1.info('这是 logger1 的 INFO 级别的日志')
logger1.warning('这是 logger1 的 WARNING 级别的日志')
logger2.warning('这是 logger2 的 WARNING 级别的日志')
logger2.error('这是 logger2 的 ERROR 级别的日志')
```

在这个例子中，我们创建了两个不同的日志记录器 `logger1` 和 `logger2`，它们有不同的日志级别和格式化器，分别记录不同级别的日志。

## 常见实践
### 日志输出到文件
将日志输出到文件可以方便我们后续查看和分析。以下是一个将日志记录到文件的示例：

```python
import logging

# 获取日志记录器对象
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建文件处理器
fh = logging.FileHandler('app.log')
fh.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
fh.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(fh)

# 记录日志
logger.debug('这是一条 DEBUG 级别的日志')
logger.info('这是一条 INFO 级别的日志')
logger.warning('这是一条 WARNING 级别的日志')
logger.error('这是一条 ERROR 级别的日志')
logger.critical('这是一条 CRITICAL 级别的日志')
```

在上述代码中，创建了一个 `FileHandler` 并将其添加到日志记录器，这样日志就会被记录到 `app.log` 文件中。

### 日志同时输出到文件和控制台
在实际开发中，我们通常希望日志既能输出到控制台方便调试，又能保存到文件以便后续分析。以下是实现方法：

```python
import logging

# 获取日志记录器对象
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建文件处理器
fh = logging.FileHandler('app.log')
fh.setLevel(logging.DEBUG)

# 创建控制台处理器
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
fh.setFormatter(formatter)
ch.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(fh)
logger.addHandler(ch)

# 记录日志
logger.debug('这是一条 DEBUG 级别的日志')
logger.info('这是一条 INFO 级别的日志')
logger.warning('这是一条 WARNING 级别的日志')
logger.error('这是一条 ERROR 级别的日志')
logger.critical('这是一条 CRITICAL 级别的日志')
```

### 多模块中的日志记录
在一个大型项目中，通常会有多个模块。为了更好地管理日志，每个模块可以有自己独立的日志记录器。

假设项目结构如下：
```
project/
    ├── main.py
    └── module1.py
```

`module1.py` 代码如下：

```python
import logging

# 获取模块级别的日志记录器
logger = logging.getLogger(__name__)

def module_function():
    logger.info('这是 module1 中的一条 INFO 级别的日志')
```

`main.py` 代码如下：

```python
import logging
import module1

# 获取主模块的日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# 创建控制台处理器
ch = logging.StreamHandler()
ch.setLevel(logging.INFO)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
ch.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(ch)

logger.info('程序开始运行')
module1.module_function()
logger.info('程序运行结束')
```

在这个示例中，每个模块都使用 `logging.getLogger(__name__)` 获取了自己的日志记录器，这样可以避免不同模块的日志记录混淆。

## 最佳实践
### 日志级别设置策略
在开发阶段，建议将日志级别设置为 `DEBUG`，以便获取详细的调试信息。在生产环境中，应将日志级别设置为 `INFO` 或 `WARNING`，避免过多的日志信息影响系统性能。同时，对于关键业务逻辑和可能出现问题的地方，可以适当提高日志级别，如使用 `ERROR` 或 `CRITICAL` 级别记录重要错误。

### 日志格式设计
日志格式应包含必要的信息，如时间、日志级别、模块名、函数名以及具体的日志消息。这样在排查问题时能够快速定位到问题所在。例如：`%(asctime)s - %(name)s - %(levelname)s - %(funcName)s - %(message)s`。

### 日志文件管理
对于长时间运行的系统，日志文件可能会不断增大。因此需要定期清理或归档日志文件。可以使用 Python 的 `logging.handlers.TimedRotatingFileHandler` 或 `logging.handlers.MemoryHandler` 等工具来实现日志文件的自动管理。

```python
import logging
from logging.handlers import TimedRotatingFileHandler

# 获取日志记录器对象
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建按时间滚动的文件处理器
fh = TimedRotatingFileHandler('app.log', when='midnight', interval=1, backupCount=7)
fh.setLevel(logging.DEBUG)

# 创建格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 将格式化器添加到处理器
fh.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(fh)

# 记录日志
logger.debug('这是一条 DEBUG 级别的日志')
```

在上述代码中，`TimedRotatingFileHandler` 会在每天午夜创建一个新的日志文件，并保留 7 天的日志备份。

## 小结
Python 的 `logging` 模块提供了丰富的功能，通过合理使用日志记录器、处理器和格式化器，我们可以实现灵活、高效的日志记录。在实际开发中，遵循最佳实践可以使日志记录更加规范、易于管理，从而提高开发效率和系统的可维护性。希望本文能帮助读者更好地掌握 Python Logger 的使用，在项目中充分发挥其优势。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
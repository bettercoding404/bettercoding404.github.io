---
title: "深入理解 Python Logging Level"
description: "在 Python 开发中，日志记录是一项至关重要的任务。它能够帮助我们追踪程序的执行流程、调试代码以及监控系统运行状态。`logging` 模块是 Python 标准库中用于日志记录的工具，而 `logging level`（日志级别）则是控制日志记录详细程度的关键因素。通过合理设置日志级别，我们可以灵活地控制哪些日志信息被记录下来，哪些被忽略，从而提高开发和运维的效率。本文将深入探讨 Python `logging level` 的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 开发中，日志记录是一项至关重要的任务。它能够帮助我们追踪程序的执行流程、调试代码以及监控系统运行状态。`logging` 模块是 Python 标准库中用于日志记录的工具，而 `logging level`（日志级别）则是控制日志记录详细程度的关键因素。通过合理设置日志级别，我们可以灵活地控制哪些日志信息被记录下来，哪些被忽略，从而提高开发和运维的效率。本文将深入探讨 Python `logging level` 的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **简单配置**
    - **自定义配置**
3. **常见实践**
    - **在不同开发阶段使用不同日志级别**
    - **日志级别在模块中的应用**
4. **最佳实践**
    - **日志级别与性能**
    - **多环境下的日志级别管理**
5. **小结**
6. **参考资料**

## 基础概念
Python `logging` 模块定义了以下几个标准的日志级别，按照严重程度从低到高排列：
- **DEBUG**：最详细的日志级别，用于调试目的。记录所有可能有助于调试的信息。
- **INFO**：用于记录程序正常运行过程中的重要信息，例如程序启动、关闭，或者某个功能模块开始或结束执行。
- **WARNING**：表示程序出现了一些非严重的问题，但可能会影响到程序的正常运行，需要开发人员关注。
- **ERROR**：表示程序发生了错误，导致某个功能无法正常执行，但程序可能仍然可以继续运行。
- **CRITICAL**：最严重的日志级别，用于记录导致程序无法继续运行的严重错误，例如系统崩溃、资源耗尽等。

每个日志级别都对应一个整数值，开发人员可以通过这些整数值来进行一些自定义的配置和操作。例如，`DEBUG` 的值是 10，`INFO` 是 20，`WARNING` 是 30，`ERROR` 是 40，`CRITICAL` 是 50。

## 使用方法
### 简单配置
Python `logging` 模块提供了一个简单的配置方式，使得我们可以快速开始记录日志。以下是一个简单的示例：

```python
import logging

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录不同级别的日志
logging.debug('这是一条 DEBUG 级别的日志')
logging.info('这是一条 INFO 级别的日志')
logging.warning('这是一条 WARNING 级别的日志')
logging.error('这是一条 ERROR 级别的日志')
logging.critical('这是一条 CRITICAL 级别的日志')
```

在上述代码中：
1. 首先导入 `logging` 模块。
2. 使用 `basicConfig` 方法进行简单的日志配置，设置日志级别为 `INFO`，并指定日志格式。
3. 然后分别使用不同级别的日志记录函数（`debug`、`info`、`warning`、`error`、`critical`）来记录日志。由于日志级别设置为 `INFO`，所以只有 `INFO` 级别及以上的日志会被记录下来，`DEBUG` 级别的日志将被忽略。

### 自定义配置
除了简单配置，我们还可以进行更复杂的自定义配置，例如将日志输出到文件、设置不同的日志格式等。以下是一个自定义配置的示例：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

# 创建一个文件处理器
file_handler = logging.FileHandler('app.log')
file_handler.setLevel(logging.DEBUG)

# 创建一个控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)

# 创建日志格式
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)
console_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)
logger.addHandler(console_handler)

# 记录不同级别的日志
logger.debug('这是一条 DEBUG 级别的日志')
logger.info('这是一条 INFO 级别的日志')
logger.warning('这是一条 WARNING 级别的日志')
logger.error('这是一条 ERROR 级别的日志')
logger.critical('这是一条 CRITICAL 级别的日志')
```

在这个示例中：
1. 使用 `getLogger` 方法创建一个日志记录器，并设置其日志级别为 `DEBUG`。
2. 创建了一个文件处理器 `file_handler`，并将其日志级别设置为 `DEBUG`，同时创建了一个控制台处理器 `console_handler`，将其日志级别设置为 `INFO`。
3. 定义了一个日志格式 `formatter`，并将其应用到文件处理器和控制台处理器上。
4. 最后将两个处理器添加到日志记录器中，这样日志信息就会同时输出到文件和控制台。由于控制台处理器的日志级别为 `INFO`，所以只有 `INFO` 级别及以上的日志会在控制台输出，而文件中会记录所有 `DEBUG` 级别及以上的日志。

## 常见实践
### 在不同开发阶段使用不同日志级别
- **开发阶段**：在开发过程中，我们通常希望获取尽可能多的信息来帮助调试代码。因此，将日志级别设置为 `DEBUG` 是一个不错的选择。这样可以记录所有详细的信息，包括变量的值、函数的调用栈等，方便开发人员快速定位问题。
```python
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
```
- **测试阶段**：在测试阶段，我们需要关注程序的正常运行情况以及是否有潜在的问题。此时，将日志级别设置为 `INFO` 或 `WARNING` 比较合适。`INFO` 级别可以记录程序的关键操作和状态变化，`WARNING` 级别则可以提醒我们注意一些可能影响程序运行的问题。
```python
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
```
- **生产阶段**：在生产环境中，我们不希望大量的日志信息影响系统的性能，同时也只需要关注严重的问题。因此，将日志级别设置为 `ERROR` 或 `CRITICAL` 是常见的做法。这样可以确保只有真正的错误信息被记录下来，方便运维人员及时发现和处理问题。
```python
import logging

logging.basicConfig(level=logging.ERROR, format='%(asctime)s - %(levelname)s - %(message)s')
```

### 日志级别在模块中的应用
在一个大型项目中，可能包含多个模块。我们可以为每个模块单独设置日志级别，以便更好地控制日志输出。例如，有一个 `module1` 和一个 `module2`：

```python
# module1.py
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

def module1_function():
    logger.debug('module1_function 被调用')
    logger.info('执行 module1_function')
```

```python
# module2.py
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def module2_function():
    logger.info('module2_function 被调用')
    logger.warning('module2 中可能存在问题')
```

```python
# main.py
import logging
import module1
import module2

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

module1.module1_function()
module2.module2_function()
```

在上述代码中，`module1` 的日志级别设置为 `DEBUG`，`module2` 的日志级别设置为 `INFO`。在 `main.py` 中，整体的日志级别设置为 `INFO`。这样，`module1` 中 `DEBUG` 级别的日志不会被记录，而 `module2` 中的日志会按照其自身设置的 `INFO` 级别进行记录。

## 最佳实践
### 日志级别与性能
日志记录操作会对程序的性能产生一定的影响，尤其是在高并发或性能敏感的场景下。过多的日志记录，特别是 `DEBUG` 级别的日志，可能会导致程序性能下降。因此，在生产环境中，应谨慎使用 `DEBUG` 级别日志。可以通过配置文件或环境变量来动态调整日志级别，以便在需要调试时能够快速获取详细信息，而在正常运行时减少日志记录对性能的影响。

### 多环境下的日志级别管理
在不同的环境（开发、测试、生产）中，我们需要根据实际情况灵活管理日志级别。一种常见的做法是使用配置文件来存储不同环境的日志级别设置。例如，可以使用 `yaml` 或 `json` 格式的配置文件：

```yaml
# logging_config.yaml
development:
  level: DEBUG
test:
  level: INFO
production:
  level: ERROR
```

在代码中读取配置文件并设置日志级别：

```python
import logging
import yaml

def setup_logging(env):
    with open('logging_config.yaml', 'r') as f:
        config = yaml.safe_load(f)
    level = config[env]['level']
    logging.basicConfig(level=getattr(logging, level), format='%(asctime)s - %(levelname)s - %(message)s')

# 使用示例
setup_logging('development')
```

通过这种方式，我们可以方便地在不同环境下切换日志级别，提高开发和运维的效率。

## 小结
Python `logging level` 是控制日志记录详细程度的重要工具。通过合理设置日志级别，我们可以在不同的开发阶段和环境中灵活地管理日志信息，从而提高开发效率、便于调试和监控系统运行状态。在实际应用中，我们需要根据具体需求选择合适的日志级别，并注意日志记录对性能的影响。同时，通过一些最佳实践，如使用配置文件管理日志级别，可以使日志管理更加灵活和高效。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
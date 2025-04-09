---
title: "深入理解 Python Logging Level"
description: "在 Python 开发中，日志记录是一项至关重要的功能。它能帮助开发者在程序运行过程中记录重要信息，方便调试、监控以及追踪程序的执行流程。`logging` 模块是 Python 内置的标准日志记录工具，而 `logging level`（日志级别）则是该模块中控制日志输出的关键部分。通过合理设置日志级别，开发者可以精确控制哪些信息会被记录以及以何种方式记录。本文将深入探讨 Python `logging level` 的相关知识，包括基础概念、使用方法、常见实践和最佳实践。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 开发中，日志记录是一项至关重要的功能。它能帮助开发者在程序运行过程中记录重要信息，方便调试、监控以及追踪程序的执行流程。`logging` 模块是 Python 内置的标准日志记录工具，而 `logging level`（日志级别）则是该模块中控制日志输出的关键部分。通过合理设置日志级别，开发者可以精确控制哪些信息会被记录以及以何种方式记录。本文将深入探讨 Python `logging level` 的相关知识，包括基础概念、使用方法、常见实践和最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是日志级别
    - 标准日志级别
2. **使用方法**
    - 简单配置与使用
    - 自定义日志级别
3. **常见实践**
    - 不同开发阶段的日志级别设置
    - 在模块中使用日志
4. **最佳实践**
    - 日志级别与性能
    - 日志记录的安全性
5. **小结**
6. **参考资料**

## 基础概念
### 什么是日志级别
日志级别是一种机制，用于指定哪些日志消息应该被记录，哪些应该被忽略。不同的日志级别代表了不同的重要程度或详细程度。通过设置日志级别，开发者可以控制日志记录的粒度，从而在不同的场景下获取合适的信息。

### 标准日志级别
Python 的 `logging` 模块定义了以下几个标准日志级别，按照重要程度从低到高排列：
1. **DEBUG**：最详细的日志级别，用于调试目的。通常包含程序运行过程中的详细信息，如变量值、函数调用栈等。在开发过程中，DEBUG 级别的日志可以帮助开发者快速定位问题。
2. **INFO**：用于记录一般性的信息，如程序启动、关闭，或者某个功能模块开始执行等。INFO 级别的日志可以让开发者了解程序的正常运行状态。
3. **WARNING**：表示可能存在问题，但不会影响程序的正常运行。例如，程序遇到了一个不常见的情况，但仍然能够继续执行。WARNING 级别的日志提醒开发者需要关注这些潜在问题。
4. **ERROR**：用于记录程序运行过程中发生的错误。当程序遇到无法正常处理的情况时，应该记录 ERROR 级别的日志，以便开发者及时发现并解决问题。
5. **CRITICAL**：最高级别的日志，用于记录非常严重的错误，通常会导致程序无法继续运行。例如，系统资源耗尽、关键配置错误等情况。

## 使用方法
### 简单配置与使用
下面是一个简单的示例，展示如何使用 `logging` 模块并设置不同的日志级别：

```python
import logging

# 配置日志
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录不同级别的日志
logging.debug('这是一条 DEBUG 级别的日志')
logging.info('这是一条 INFO 级别的日志')
logging.warning('这是一条 WARNING 级别的日志')
logging.error('这是一条 ERROR 级别的日志')
logging.critical('这是一条 CRITICAL 级别的日志')
```

在上述代码中：
1. `logging.basicConfig` 函数用于配置日志的基本设置，`level=logging.DEBUG` 表示将日志级别设置为 DEBUG，这意味着所有级别大于或等于 DEBUG 的日志消息都会被记录。`format='%(asctime)s - %(levelname)s - %(message)s'` 定义了日志消息的格式，其中 `%(asctime)s` 表示时间，`%(levelname)s` 表示日志级别，`%(message)s` 表示日志内容。
2. 接下来分别调用了 `logging` 模块的不同方法来记录不同级别的日志。运行这段代码，你将看到所有级别的日志消息都会被输出到控制台。

### 自定义日志级别
除了标准日志级别，开发者还可以自定义日志级别。以下是一个示例：

```python
import logging

# 自定义日志级别
CUSTOM_LEVEL = 25
logging.addLevelName(CUSTOM_LEVEL, 'CUSTOM')

def custom_log(self, message, *args, **kwargs):
    if self.isEnabledFor(CUSTOM_LEVEL):
        self._log(CUSTOM_LEVEL, message, args, **kwargs)

logging.Logger.custom_log = custom_log

# 配置日志
logging.basicConfig(level=CUSTOM_LEVEL, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录自定义级别的日志
logger = logging.getLogger(__name__)
logger.custom_log('这是一条自定义级别的日志')
```

在这个示例中：
1. 首先定义了一个自定义日志级别 `CUSTOM_LEVEL`，值为 25，并使用 `logging.addLevelName` 方法为其命名为 `CUSTOM`。
2. 然后定义了一个新的日志记录方法 `custom_log`，并将其添加到 `logging.Logger` 类中。
3. 配置日志时，将日志级别设置为自定义级别 `CUSTOM_LEVEL`。
4. 最后使用自定义的 `custom_log` 方法记录一条自定义级别的日志。

## 常见实践
### 不同开发阶段的日志级别设置
1. **开发阶段**：在开发过程中，建议将日志级别设置为 DEBUG，以便获取尽可能多的信息。这样可以方便开发者追踪程序的执行流程，快速定位和解决问题。例如：
```python
import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
```
2. **测试阶段**：测试阶段可以将日志级别设置为 INFO，主要关注程序的正常运行情况和重要的操作信息。此时 DEBUG 级别的日志可能过于详细，会干扰测试人员的视线。例如：
```python
import logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
```
3. **生产阶段**：在生产环境中，为了避免过多的日志信息影响系统性能，通常将日志级别设置为 WARNING 或 ERROR。只记录可能影响系统正常运行的问题。例如：
```python
import logging
logging.basicConfig(level=logging.WARNING, format='%(asctime)s - %(levelname)s - %(message)s')
```

### 在模块中使用日志
在大型项目中，通常会将日志记录功能封装到各个模块中。以下是一个示例：

```python
# module1.py
import logging

logger = logging.getLogger(__name__)

def module_function():
    logger.debug('module_function 开始执行')
    # 模块的具体逻辑
    logger.info('module_function 执行完毕')
```

```python
# main.py
import logging
import module1

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def main():
    module1.module_function()

if __name__ == '__main__':
    main()
```

在上述代码中：
1. 在 `module1.py` 模块中，使用 `logging.getLogger(__name__)` 获取一个 logger 对象，这样不同模块的日志记录可以独立配置。
2. 在 `main.py` 中，配置了日志级别为 INFO，并调用了 `module1` 模块中的函数。由于日志级别为 INFO，`module1` 中 DEBUG 级别的日志不会被记录。

## 最佳实践
### 日志级别与性能
日志记录会对程序性能产生一定影响，尤其是在高并发或性能敏感的场景下。为了减少性能开销，应该根据实际情况合理设置日志级别。在生产环境中，避免使用 DEBUG 级别，因为大量的 DEBUG 日志会占用额外的资源，影响程序的执行效率。

### 日志记录的安全性
在记录日志时，需要注意保护敏感信息。例如，密码、用户隐私数据等不应该被记录到日志中。如果必须记录某些敏感信息，可以进行加密或脱敏处理后再记录。

## 小结
Python 的 `logging level` 是一个强大且灵活的工具，通过合理设置日志级别，开发者可以在不同的开发阶段和场景下有效地控制日志记录的粒度。了解标准日志级别、自定义日志级别的方法，以及在不同阶段和模块中的使用实践，对于提高开发效率和程序的稳定性都非常重要。同时，遵循最佳实践可以确保日志记录既满足需求又不会对系统性能和安全性造成负面影响。

## 参考资料
- [Python 官方文档 - logging 模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
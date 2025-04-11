---
title: "Python 中向标准错误输出（stderr）打印信息"
description: "在 Python 编程中，我们经常需要输出信息来进行调试、记录日志或者向用户反馈运行状态。默认情况下，`print` 函数输出到标准输出（stdout），但有时我们希望将特定的信息发送到标准错误输出（stderr）。标准错误输出通常用于输出错误信息、警告或者其他不应该与正常输出混在一起的重要消息。本文将深入探讨如何在 Python 中实现向 stderr 打印信息，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 编程中，我们经常需要输出信息来进行调试、记录日志或者向用户反馈运行状态。默认情况下，`print` 函数输出到标准输出（stdout），但有时我们希望将特定的信息发送到标准错误输出（stderr）。标准错误输出通常用于输出错误信息、警告或者其他不应该与正常输出混在一起的重要消息。本文将深入探讨如何在 Python 中实现向 stderr 打印信息，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - 标准输出（stdout）与标准错误输出（stderr）的区别
2. **使用方法**
    - 使用 `sys.stderr` 进行打印
    - 使用 `logging` 模块记录到 stderr
3. **常见实践**
    - 区分正常输出和错误输出
    - 记录日志到 stderr
4. **最佳实践**
    - 结合日志级别使用
    - 配置日志格式
5. **小结**
6. **参考资料**

## 基础概念
### 标准输出（stdout）与标准错误输出（stderr）的区别
在 Unix 系统以及类 Unix 系统（包括 Linux 和 macOS）中，每个进程都有三个标准文件描述符：标准输入（stdin）、标准输出（stdout）和标准错误输出（stderr）。

- **标准输出（stdout）**：通常用于程序的正常输出，例如打印计算结果、显示用户提示信息等。它是一种有序的、缓冲的输出流，默认情况下会显示在终端屏幕上。

- **标准错误输出（stderr）**：专门用于输出程序运行过程中产生的错误信息、警告信息以及其他需要立即引起用户注意的重要消息。与 stdout 不同，stderr 是无缓冲的，这意味着它会立即将信息输出到终端，而不会等待缓冲区满或者程序结束。这确保了即使程序崩溃或者输出出现问题，错误信息也能及时显示出来。

## 使用方法
### 使用 `sys.stderr` 进行打印
在 Python 中，可以通过 `sys` 模块的 `stderr` 属性来向标准错误输出打印信息。示例代码如下：

```python
import sys

def print_to_stderr(message):
    sys.stderr.write(message + '\n')

print_to_stderr("这是一条输出到标准错误的消息")
```

在上述代码中，我们定义了一个函数 `print_to_stderr`，它接受一个字符串参数 `message`，并使用 `sys.stderr.write` 方法将消息写入到标准错误输出。注意，`write` 方法不会自动换行，所以我们需要手动添加 `\n`。

### 使用 `logging` 模块记录到 stderr
`logging` 模块是 Python 内置的用于记录日志的模块，它提供了更灵活和强大的日志记录功能，也可以方便地将日志输出到 stderr。示例代码如下：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.ERROR)

# 创建一个输出到 stderr 的处理器
handler = logging.StreamHandler()
handler.setLevel(logging.ERROR)

# 将处理器添加到日志记录器
logger.addHandler(handler)

# 记录错误日志
logger.error("这是一条通过 logging 模块输出到标准错误的消息")
```

在这个例子中，我们首先创建了一个日志记录器 `logger`，并设置其日志级别为 `ERROR`。然后创建了一个 `StreamHandler`，它会将日志输出到 stderr，并设置该处理器的日志级别也为 `ERROR`。最后，将处理器添加到日志记录器中，并使用 `logger.error` 方法记录一条错误日志。

## 常见实践
### 区分正常输出和错误输出
在实际编程中，将正常输出和错误输出分开是非常有用的。例如，在一个命令行工具中，正常的输出可能是命令的执行结果，而错误输出则是在执行过程中遇到的问题。以下是一个简单的示例：

```python
import sys

def divide_numbers(a, b):
    try:
        result = a / b
        print(result)
    except ZeroDivisionError as e:
        sys.stderr.write(f"错误: {e}\n")

divide_numbers(10, 2)  # 正常输出
divide_numbers(10, 0)  # 错误输出到 stderr
```

在这个例子中，`divide_numbers` 函数尝试进行除法运算。如果运算成功，结果会通过 `print` 输出到 stdout；如果遇到除零错误，错误信息会通过 `sys.stderr.write` 输出到 stderr。

### 记录日志到 stderr
在开发大型应用程序时，使用 `logging` 模块记录日志到 stderr 可以方便地追踪程序运行过程中的错误和问题。例如，在一个 Web 应用程序中，可以将所有的错误日志记录到 stderr，以便管理员在查看服务器日志时能够快速定位问题。示例代码如下：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.ERROR)

# 创建一个输出到 stderr 的处理器
handler = logging.StreamHandler()
handler.setLevel(logging.ERROR)

# 设置日志格式
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(handler)

def web_app_function():
    try:
        # 模拟一个可能出错的操作
        result = 1 / 0
    except ZeroDivisionError as e:
        logger.error(f"Web 应用程序错误: {e}")

web_app_function()
```

在这个示例中，我们配置了一个日志记录器，将错误日志输出到 stderr，并设置了日志格式。在 `web_app_function` 中，模拟了一个可能出错的操作，并使用日志记录器记录错误信息。

## 最佳实践
### 结合日志级别使用
`logging` 模块提供了不同的日志级别，如 `DEBUG`、`INFO`、`WARNING`、`ERROR` 和 `CRITICAL`。在实际应用中，应根据信息的重要性和详细程度选择合适的日志级别。例如，在开发和调试阶段，可以将日志级别设置为 `DEBUG`，以便获取更多的详细信息；而在生产环境中，可以将日志级别设置为 `ERROR` 或 `CRITICAL`，只输出重要的错误信息。示例代码如下：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)  # 在开发阶段可以设置为 DEBUG

# 创建一个输出到 stderr 的处理器
handler = logging.StreamHandler()
handler.setLevel(logging.DEBUG)

# 设置日志格式
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(handler)

# 记录不同级别的日志
logger.debug("这是一条 DEBUG 级别的日志")
logger.info("这是一条 INFO 级别的日志")
logger.warning("这是一条 WARNING 级别的日志")
logger.error("这是一条 ERROR 级别的日志")
logger.critical("这是一条 CRITICAL 级别的日志")
```

### 配置日志格式
合理配置日志格式可以使日志信息更加清晰和易于阅读。可以根据实际需求在日志格式中包含时间戳、日志级别、模块名称、函数名称等信息。例如：

```python
import logging

# 创建一个日志记录器
logger = logging.getLogger(__name__)
logger.setLevel(logging.ERROR)

# 创建一个输出到 stderr 的处理器
handler = logging.StreamHandler()
handler.setLevel(logging.ERROR)

# 设置日志格式
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(funcName)s - %(message)s')
handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(handler)

def some_function():
    logger.error("在 some_function 中发生错误")

some_function()
```

在这个例子中，日志格式包含了时间戳、日志记录器名称、日志级别、函数名称和消息内容，这样在查看日志时可以更准确地定位问题。

## 小结
在 Python 中向标准错误输出（stderr）打印信息是一项重要的技能，特别是在调试和日志记录方面。通过使用 `sys.stderr` 和 `logging` 模块，我们可以灵活地控制信息的输出方向和格式。在实际编程中，应根据具体需求选择合适的方法，并遵循最佳实践，如结合日志级别和配置日志格式，以提高程序的可维护性和可读性。

## 参考资料
- [Python 官方文档 - sys 模块](https://docs.python.org/3/library/sys.html){: rel="nofollow"}
- [Python 官方文档 - logging 模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
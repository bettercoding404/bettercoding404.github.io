---
title: "Python 中向标准错误输出打印信息（print to stderr）"
description: "在 Python 编程中，我们经常需要将信息输出到控制台。通常，我们使用 `print` 语句将信息输出到标准输出（stdout），这是正常的程序输出流。然而，在某些情况下，我们希望将错误信息、调试信息或者其他需要与正常输出区分开的信息输出到标准错误输出（stderr）。本文将详细介绍如何在 Python 中实现向标准错误输出打印信息，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，我们经常需要将信息输出到控制台。通常，我们使用 `print` 语句将信息输出到标准输出（stdout），这是正常的程序输出流。然而，在某些情况下，我们希望将错误信息、调试信息或者其他需要与正常输出区分开的信息输出到标准错误输出（stderr）。本文将详细介绍如何在 Python 中实现向标准错误输出打印信息，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - **标准输出（stdout）与标准错误输出（stderr）**
2. **使用方法**
    - **使用 `sys.stderr`**
    - **使用 `logging` 模块**
3. **常见实践**
    - **区分正常输出和错误输出**
    - **调试信息输出**
4. **最佳实践**
    - **日志记录的配置**
    - **根据不同级别输出信息**
5. **小结**
6. **参考资料**

## 基础概念
### 标准输出（stdout）与标准错误输出（stderr）
在 Unix 类操作系统以及 Windows 系统中，每个进程都有三个标准的输入输出流：标准输入（stdin）、标准输出（stdout）和标准错误输出（stderr）。

- **标准输出（stdout）**：通常用于程序的正常输出，例如用户请求的结果、程序的运行状态信息等。当我们在 Python 中使用 `print` 语句时，默认情况下就是将信息输出到标准输出。例如：
```python
print("这是输出到标准输出的信息")
```

- **标准错误输出（stderr）**：专门用于输出程序运行过程中产生的错误信息、警告信息或者其他需要引起用户注意的信息。与标准输出不同，标准错误输出不会被管道或者重定向影响（除非特别指定），这使得错误信息能够更加直观地显示给用户。例如，当程序发生除零错误时，Python 解释器会将错误信息输出到标准错误输出：
```python
print(1 / 0)
```
在命令行中运行上述代码，你会看到错误信息以红色（通常）显示，这就是输出到标准错误输出的效果。

## 使用方法
### 使用 `sys.stderr`
在 Python 中，可以通过 `sys` 模块访问标准错误输出流。`sys.stderr` 是一个类似文件的对象，我们可以使用它的 `write` 方法来输出信息到标准错误输出。

```python
import sys

sys.stderr.write("这是输出到标准错误输出的信息\n")
```
上述代码中，首先导入了 `sys` 模块，然后使用 `sys.stderr.write` 方法将字符串写入到标准错误输出。注意，我们需要手动添加换行符 `\n`，因为 `write` 方法不会自动添加换行。

### 使用 `logging` 模块
`logging` 模块是 Python 内置的用于日志记录的模块，它提供了更加灵活和强大的功能来管理和输出日志信息。我们可以配置 `logging` 模块将特定级别的日志信息输出到标准错误输出。

```python
import logging

# 配置日志记录器
logging.basicConfig(
    level=logging.ERROR,
    format='%(asctime)s - %(levelname)s - %(message)s',
    stream=sys.stderr
)

logging.error("这是一条错误日志信息")
```
在上述代码中：
1. 首先导入了 `logging` 模块。
2. 使用 `logging.basicConfig` 方法配置日志记录器，设置日志级别为 `ERROR`，这意味着只有级别为 `ERROR` 及以上的日志信息才会被输出。日志格式设置为包含时间、日志级别和日志信息。`stream=sys.stderr` 表示将日志信息输出到标准错误输出。
3. 最后使用 `logging.error` 方法输出一条错误日志信息。

## 常见实践
### 区分正常输出和错误输出
在编写命令行工具或者脚本时，将正常输出和错误输出分开是非常重要的。例如，我们编写一个简单的文件读取工具：

```python
import sys


def read_file(file_path):
    try:
        with open(file_path, 'r') as f:
            content = f.read()
            print(content)
    except FileNotFoundError as e:
        sys.stderr.write(f"错误: {e}\n")


if __name__ == "__main__":
    if len(sys.argv)!= 2:
        sys.stderr.write("用法: python script.py <file_path>\n")
    else:
        read_file(sys.argv[1])

```
在上述代码中：
1. `read_file` 函数尝试读取指定路径的文件，并将文件内容输出到标准输出。如果文件不存在，捕获 `FileNotFoundError` 异常，并将错误信息输出到标准错误输出。
2. 在主程序部分，检查命令行参数的数量是否正确。如果不正确，将用法信息输出到标准错误输出。

### 调试信息输出
在开发过程中，我们经常需要输出一些调试信息来帮助我们理解程序的运行状态。可以使用 `logging` 模块将调试信息输出到标准错误输出，同时设置不同的日志级别来控制输出的信息。

```python
import logging


def add_numbers(a, b):
    logging.debug(f"正在计算 {a} + {b}")
    result = a + b
    logging.debug(f"计算结果为 {result}")
    return result


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.DEBUG,
        format='%(asctime)s - %(levelname)s - %(message)s',
        stream=sys.stderr
    )
    add_numbers(3, 5)

```
在上述代码中：
1. `add_numbers` 函数在计算前后输出调试信息。
2. 在主程序部分，将日志级别设置为 `DEBUG`，这样所有级别的日志信息都会被输出到标准错误输出。

## 最佳实践
### 日志记录的配置
为了更好地管理日志信息，建议将日志记录的配置提取到一个单独的函数或者配置文件中。例如：

```python
import logging


def setup_logging():
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        stream=sys.stderr
    )


def main():
    setup_logging()
    logging.info("程序开始运行")
    # 程序逻辑代码


if __name__ == "__main__":
    main()

```
在上述代码中，`setup_logging` 函数负责配置日志记录器，`main` 函数调用该函数进行日志配置，然后开始程序的运行。

### 根据不同级别输出信息
根据程序的运行状态和需求，合理设置日志级别。例如，在开发环境中可以将日志级别设置为 `DEBUG`，以便输出详细的调试信息；在生产环境中，可以将日志级别设置为 `INFO` 或者 `ERROR`，只输出重要的信息和错误信息。

```python
import logging


def setup_logging(level=logging.INFO):
    logging.basicConfig(
        level=level,
        format='%(asctime)s - %(levelname)s - %(message)s',
        stream=sys.stderr
    )


def main():
    setup_logging(logging.DEBUG)  # 在开发环境中设置为 DEBUG
    logging.debug("这是一条调试信息")
    logging.info("这是一条信息")
    logging.warning("这是一条警告信息")
    logging.error("这是一条错误信息")


if __name__ == "__main__":
    main()

```
在上述代码中，`setup_logging` 函数可以接受一个 `level` 参数来设置日志级别，根据不同的环境需求进行调整。

## 小结
在 Python 中，向标准错误输出打印信息是一项重要的技能，特别是在区分正常输出和错误输出、调试程序以及记录日志方面。通过使用 `sys.stderr` 和 `logging` 模块，我们可以灵活地控制信息的输出位置和方式。遵循最佳实践，如合理配置日志记录和根据不同级别输出信息，可以提高程序的可读性和可维护性。希望本文能够帮助你深入理解并高效使用 Python 中向标准错误输出打印信息的方法。

## 参考资料
- [Python 官方文档 - sys 模块](https://docs.python.org/3/library/sys.html){: rel="nofollow"}
- [Python 官方文档 - logging 模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
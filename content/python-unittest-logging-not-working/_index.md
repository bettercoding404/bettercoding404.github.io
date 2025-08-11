---
title: "Python unittest logging not working 问题解析"
description: "在使用 Python 的 `unittest` 框架进行单元测试时，许多开发者会遇到 `logging` 模块似乎不起作用的情况。这篇博客将深入探讨这个问题，从基础概念开始，介绍使用方法，列举常见实践，并给出最佳实践建议，帮助读者更好地理解和解决这个问题。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在使用 Python 的 `unittest` 框架进行单元测试时，许多开发者会遇到 `logging` 模块似乎不起作用的情况。这篇博客将深入探讨这个问题，从基础概念开始，介绍使用方法，列举常见实践，并给出最佳实践建议，帮助读者更好地理解和解决这个问题。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
### unittest
`unittest` 是 Python 内置的标准测试框架，用于编写和运行单元测试。它提供了一组工具和约定，使得编写、组织和执行测试用例变得方便。

### logging
`logging` 是 Python 内置的日志记录模块，用于记录程序运行过程中的各种信息，如调试信息、错误信息等。它可以帮助开发者在程序运行时追踪问题，了解程序的执行流程。

### 为什么 unittest logging 会出现看似不工作的情况
在 `unittest` 中，日志记录的配置和输出可能会受到多种因素的影响。默认情况下，`unittest` 会捕获测试用例中的输出并进行处理，这可能会导致 `logging` 的输出被抑制或重定向，从而给开发者造成 `logging` 不工作的错觉。

## 使用方法
### 简单的 unittest 示例
```python
import unittest


def add(a, b):
    return a + b


class TestAdd(unittest.TestCase):
    def test_add(self):
        result = add(2, 3)
        self.assertEqual(result, 5)


if __name__ == '__main__':
    unittest.main()
```

### 简单的 logging 示例
```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

logger.info("This is an info log")
logger.error("This is an error log")
```

### 在 unittest 中使用 logging
```python
import unittest
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def add(a, b):
    logger.info(f"Adding {a} and {b}")
    return a + b


class TestAdd(unittest.TestCase):
    def test_add(self):
        result = add(2, 3)
        self.assertEqual(result, 5)


if __name__ == '__main__':
    unittest.main()
```
在这个示例中，我们在 `add` 函数中添加了日志记录，但运行测试时，可能看不到日志输出。

## 常见实践
### 重定向日志输出
```python
import unittest
import logging
import sys

logging.basicConfig(stream=sys.stdout, level=logging.INFO)
logger = logging.getLogger(__name__)


def add(a, b):
    logger.info(f"Adding {a} and {b}")
    return a + b


class TestAdd(unittest.TestCase):
    def test_add(self):
        result = add(2, 3)
        self.assertEqual(result, 5)


if __name__ == '__main__':
    unittest.main()
```
通过将 `stream` 参数设置为 `sys.stdout`，我们尝试将日志输出重定向到标准输出，但在某些情况下，这可能仍然不起作用。

### 配置日志格式
```python
import unittest
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def add(a, b):
    logger.info(f"Adding {a} and {b}")
    return a + b


class TestAdd(unittest.TestCase):
    def test_add(self):
        result = add(2, 3)
        self.assertEqual(result, 5)


if __name__ == '__main__':
    unittest.main()
```
配置日志格式可以让日志信息更加清晰，但这并不能直接解决在 `unittest` 中日志不显示的问题。

## 最佳实践
### 使用 TestCase 的 setUp 和 tearDown 方法
```python
import unittest
import logging


def add(a, b):
    logger = logging.getLogger(__name__)
    logger.info(f"Adding {a} and {b}")
    return a + b


class TestAdd(unittest.TestCase):
    def setUp(self):
        logging.basicConfig(level=logging.INFO)

    def test_add(self):
        result = add(2, 3)
        self.assertEqual(result, 5)

    def tearDown(self):
        # 清理日志配置，防止影响其他测试
        logging.getLogger().handlers = []


if __name__ == '__main__':
    unittest.main()
```
在 `setUp` 方法中配置日志，在 `tearDown` 方法中清理日志配置，可以确保每个测试用例都有独立的日志设置，避免相互干扰。

### 使用日志捕获工具
```python
import unittest
import logging
from io import StringIO
import sys


def add(a, b):
    logger = logging.getLogger(__name__)
    logger.info(f"Adding {a} and {b}")
    return a + b


class TestAdd(unittest.TestCase):
    def test_add(self):
        buffer = StringIO()
        handler = logging.StreamHandler(buffer)
        logger = logging.getLogger(__name__)
        logger.addHandler(handler)
        result = add(2, 3)
        self.assertEqual(result, 5)
        log_output = buffer.getvalue().strip()
        self.assertIn("Adding 2 and 3", log_output)
        logger.removeHandler(handler)


if __name__ == '__main__':
    unittest.main()
```
通过使用 `StringIO` 和 `StreamHandler`，我们可以捕获日志输出并进行断言，确保日志信息的正确性。

## 小结
在 Python 的 `unittest` 框架中使用 `logging` 模块时，要注意日志配置和输出的问题。通过合理使用 `setUp` 和 `tearDown` 方法，以及日志捕获工具，可以有效地解决 `logging` 看似不工作的问题，并更好地管理和验证测试过程中的日志信息。

## 参考资料
- [Python官方文档 - unittest](https://docs.python.org/3/library/unittest.html)
- [Python官方文档 - logging](https://docs.python.org/3/library/logging.html)
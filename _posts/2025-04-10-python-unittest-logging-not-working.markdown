---
title: "Python unittest 中日志记录（logging）不工作的问题探讨"
description: "在使用 Python 的 `unittest` 框架进行单元测试时，很多开发者会遇到日志记录（`logging`）不工作的情况。这篇博客将深入探讨这个问题，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和解决在 `unittest` 中日志记录相关的问题。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在使用 Python 的 `unittest` 框架进行单元测试时，很多开发者会遇到日志记录（`logging`）不工作的情况。这篇博客将深入探讨这个问题，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和解决在 `unittest` 中日志记录相关的问题。

<!-- more -->
## 目录
1. **基础概念**
    - `unittest` 框架简介
    - `logging` 模块简介
2. **使用方法**
    - 在 `unittest` 中正常使用 `logging`
    - 配置 `logging`
3. **常见实践**
    - 日志级别设置
    - 日志输出位置
4. **为什么日志记录不工作**
    - 常见原因分析
    - 案例分析
5. **最佳实践**
    - 正确配置日志
    - 结合测试夹具（fixture）
6. **小结**
7. **参考资料**

## 基础概念
### `unittest` 框架简介
`unittest` 是 Python 内置的标准测试框架，用于编写和运行单元测试。它提供了一组工具和约定，使得编写测试用例、组织测试套件以及运行测试变得简单。例如：

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

### `logging` 模块简介
`logging` 模块是 Python 用于记录日志的标准库。它提供了灵活的框架来发出日志消息，支持不同的日志级别（如 `DEBUG`、`INFO`、`WARNING`、`ERROR`、`CRITICAL`），可以将日志输出到文件、控制台等不同的目标。以下是一个简单的 `logging` 示例：

```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

logger.info("This is an info log")
logger.warning("This is a warning log")
```

## 使用方法
### 在 `unittest` 中正常使用 `logging`
在 `unittest` 测试用例中使用 `logging` 与在普通 Python 代码中使用类似。首先导入 `logging` 模块，然后配置日志并获取日志记录器。例如：

```python
import unittest
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def add(a, b):
    return a + b


class TestAdd(unittest.TestCase):
    def test_add(self):
        logger.info("Starting test_add")
        result = add(2, 3)
        logger.info("Test result: %s", result)
        self.assertEqual(result, 5)


if __name__ == '__main__':
    unittest.main()
```

### 配置 `logging`
`logging` 的配置可以更加灵活。例如，可以将日志输出到文件，设置不同的日志格式等。

```python
import unittest
import logging

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    filename='test.log'
)
logger = logging.getLogger(__name__)


def add(a, b):
    return a + b


class TestAdd(unittest.TestCase):
    def test_add(self):
        logger.info("Starting test_add")
        result = add(2, 3)
        logger.info("Test result: %s", result)
        self.assertEqual(result, 5)


if __name__ == '__main__':
    unittest.main()
```

## 常见实践
### 日志级别设置
根据不同的场景设置合适的日志级别。在开发和调试阶段，可以使用 `DEBUG` 级别获取更多详细信息；在生产环境中，通常使用 `INFO` 或更高级别的日志。

```python
import unittest
import logging

# 设置日志级别为 DEBUG
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)


def add(a, b):
    return a + b


class TestAdd(unittest.TestCase):
    def test_add(self):
        logger.debug("Entering test_add")
        result = add(2, 3)
        logger.debug("Test result: %s", result)
        self.assertEqual(result, 5)


if __name__ == '__main__':
    unittest.main()
```

### 日志输出位置
除了输出到控制台和文件，还可以将日志发送到网络日志服务器等。例如，使用 `SocketHandler` 将日志发送到远程服务器：

```python
import unittest
import logging
from logging.handlers import SocketHandler

# 创建 SocketHandler
socket_handler = SocketHandler('localhost', 9020)

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[socket_handler]
)
logger = logging.getLogger(__name__)


def add(a, b):
    return a + b


class TestAdd(unittest.TestCase):
    def test_add(self):
        logger.info("Starting test_add")
        result = add(2, 3)
        logger.info("Test result: %s", result)
        self.assertEqual(result, 5)


if __name__ == '__main__':
    unittest.main()
```

## 为什么日志记录不工作
### 常见原因分析
1. **日志级别设置问题**：如果日志级别设置过高，某些级别的日志消息可能不会被记录。例如，设置 `level=logging.ERROR`，那么 `DEBUG`、`INFO` 和 `WARNING` 级别的日志将不会显示。
2. **日志记录器配置错误**：不正确的日志记录器实例化或配置可能导致日志无法正常工作。例如，没有正确获取日志记录器或没有正确配置日志处理器。
3. **测试框架的影响**：`unittest` 框架在运行测试时可能会对日志记录产生一些影响，例如重定向标准输出等。

### 案例分析
假设我们有如下代码：

```python
import unittest
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def divide(a, b):
    return a / b


class TestDivide(unittest.TestCase):
    def test_divide(self):
        logger.info("Starting test_divide")
        try:
            result = divide(10, 0)
        except ZeroDivisionError:
            logger.error("Division by zero error")


if __name__ == '__main__':
    unittest.main()
```

在这个例子中，日志记录可能不显示在控制台。原因是 `unittest` 框架默认会捕获测试用例中的异常并进行处理，这可能会影响日志的正常输出。

## 最佳实践
### 正确配置日志
确保日志记录器的配置正确，根据实际需求设置日志级别、格式和输出位置。可以使用配置文件来管理日志配置，提高代码的可维护性。

### 结合测试夹具（fixture）
使用测试夹具来设置和清理日志相关的资源。例如，在测试用例执行前初始化日志记录器，在测试用例执行后清理日志资源。

```python
import unittest
import logging


def setup_logging():
    logging.basicConfig(level=logging.INFO)
    return logging.getLogger(__name__)


def teardown_logging(logger):
    for handler in logger.handlers[:]:
        handler.close()
        logger.removeHandler(handler)


def add(a, b):
    return a + b


class TestAdd(unittest.TestCase):
    def setUp(self):
        self.logger = setup_logging()

    def tearDown(self):
        teardown_logging(self.logger)

    def test_add(self):
        self.logger.info("Starting test_add")
        result = add(2, 3)
        self.logger.info("Test result: %s", result)
        self.assertEqual(result, 5)


if __name__ == '__main__':
    unittest.main()
```

## 小结
在 `unittest` 中使用日志记录（`logging`）时，正确的配置和理解其工作原理是关键。通过合理设置日志级别、正确配置日志记录器以及结合测试夹具等最佳实践，可以有效地解决日志记录不工作的问题，提高测试的可调试性和可维护性。

## 参考资料
- [Python官方文档 - unittest](https://docs.python.org/3/library/unittest.html){: rel="nofollow"}
- [Python官方文档 - logging](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python unittest and logging](https://www.blog.pythonlibrary.org/2012/08/02/python-unittest-and-logging/){: rel="nofollow"}
---
title: "Python Logger：日志记录的强大工具"
description: "在软件开发过程中，日志记录是一项至关重要的任务。它可以帮助开发者追踪程序的执行流程、排查错误、分析性能问题等。Python 的 `logging` 模块提供了灵活的日志记录工具，即 `logger`。通过合理使用 `logger`，我们可以更好地管理和维护代码，确保程序的稳定性和可维护性。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在软件开发过程中，日志记录是一项至关重要的任务。它可以帮助开发者追踪程序的执行流程、排查错误、分析性能问题等。Python 的 `logging` 模块提供了灵活的日志记录工具，即 `logger`。通过合理使用 `logger`，我们可以更好地管理和维护代码，确保程序的稳定性和可维护性。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **简单配置与使用**
    - **配置日志格式**
    - **设置日志级别**
3. **常见实践**
    - **记录到文件**
    - **多模块日志记录**
4. **最佳实践**
    - **避免重复日志记录**
    - **动态配置日志**
    - **日志安全**
5. **小结**
6. **参考资料**

## 基础概念
`logger` 是 `logging` 模块中的核心组件，它负责记录日志信息。一个 `logger` 有以下几个关键属性：
- **名称（name）**：用于标识 `logger`，通常采用模块名作为 `logger` 的名称，以便更好地追踪日志来源。
- **日志级别（level）**：决定了哪些日志信息会被记录。常见的日志级别有 `DEBUG`、`INFO`、`WARNING`、`ERROR` 和 `CRITICAL`，级别依次升高。只有级别大于等于 `logger` 当前设置级别的日志信息才会被处理。
- **处理器（handlers）**：负责将日志信息输出到不同的目标，如控制台、文件等。
- **格式化器（formatters）**：用于定义日志信息的输出格式。

## 使用方法
### 简单配置与使用
```python
import logging

# 获取一个logger实例
logger = logging.getLogger(__name__)

# 配置基本的日志记录
logging.basicConfig(level=logging.INFO)

# 记录不同级别的日志
logger.debug('这是一条DEBUG级别的日志')
logger.info('这是一条INFO级别的日志')
logger.warning('这是一条WARNING级别的日志')
logger.error('这是一条ERROR级别的日志')
logger.critical('这是一条CRITICAL级别的日志')
```
在上述代码中：
1. 使用 `logging.getLogger(__name__)` 获取一个 `logger` 实例，`__name__` 是当前模块的名称。
2. `logging.basicConfig(level=logging.INFO)` 配置了基本的日志记录，设置日志级别为 `INFO`，这意味着只有 `INFO` 及以上级别的日志会被记录。

### 配置日志格式
```python
import logging

# 获取一个logger实例
logger = logging.getLogger(__name__)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# 创建一个控制台处理器
ch = logging.StreamHandler()
ch.setFormatter(formatter)

# 将处理器添加到logger
logger.addHandler(ch)

# 设置日志级别
logger.setLevel(logging.DEBUG)

# 记录日志
logger.debug('这是一条DEBUG级别的日志')
```
在这段代码中：
1. 创建了一个 `Formatter` 对象，定义了日志的格式，包括时间、`logger` 名称、日志级别和日志消息。
2. 创建了一个 `StreamHandler` 用于将日志输出到控制台，并将格式化器设置给该处理器。
3. 将处理器添加到 `logger`，并设置 `logger` 的日志级别为 `DEBUG`。

### 设置日志级别
可以通过 `logger.setLevel()` 方法动态设置 `logger` 的日志级别。
```python
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.WARNING)

logger.debug('这条日志不会被记录')
logger.warning('这条日志会被记录')
```

## 常见实践
### 记录到文件
```python
import logging

# 获取一个logger实例
logger = logging.getLogger(__name__)

# 创建一个文件处理器
fh = logging.FileHandler('app.log')

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
fh.setFormatter(formatter)

# 将文件处理器添加到logger
logger.addHandler(fh)

# 设置日志级别
logger.setLevel(logging.INFO)

# 记录日志
logger.info('这是一条记录到文件的INFO日志')
```
上述代码创建了一个 `FileHandler`，将日志记录到名为 `app.log` 的文件中。

### 多模块日志记录
在一个大型项目中，通常会有多个模块。每个模块可以有自己独立的 `logger`。
**模块1（module1.py）**：
```python
import logging

logger = logging.getLogger(__name__)

def module1_function():
    logger.info('这是模块1中的日志')
```
**模块2（module2.py）**：
```python
import logging

logger = logging.getLogger(__name__)

def module2_function():
    logger.warning('这是模块2中的日志')
```
**主程序（main.py）**：
```python
import logging
from module1 import module1_function
from module2 import module2_function

# 配置日志
logging.basicConfig(level=logging.INFO)

module1_function()
module2_function()
```
通过使用模块名作为 `logger` 的名称，可以清晰地分辨出日志来自哪个模块。

## 最佳实践
### 避免重复日志记录
在多模块和复杂配置的情况下，可能会出现重复日志记录的问题。可以通过在获取 `logger` 时添加判断来避免。
```python
import logging

def get_logger():
    logger = logging.getLogger(__name__)
    if not logger.handlers:
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        ch = logging.StreamHandler()
        ch.setFormatter(formatter)
        logger.addHandler(ch)
        logger.setLevel(logging.INFO)
    return logger

logger = get_logger()
```

### 动态配置日志
可以根据程序运行时的环境或用户需求动态配置日志。例如，通过命令行参数设置日志级别。
```python
import logging
import argparse

def setup_logging(level):
    logger = logging.getLogger(__name__)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    ch = logging.StreamHandler()
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    logger.setLevel(level)
    return logger

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--level', default='INFO', help='日志级别')
    args = parser.parse_args()

    log_level = getattr(logging, args.level.upper(), logging.INFO)
    logger = setup_logging(log_level)

    logger.info('这是一条动态配置日志级别的日志')
```

### 日志安全
在记录日志时，要注意保护敏感信息，如密码、用户数据等。可以对敏感信息进行掩码处理后再记录。
```python
import logging

logger = logging.getLogger(__name__)

password = '123456'
masked_password = '*' * len(password)

logger.info('用户登录，密码为: %s', masked_password)
```

## 小结
Python 的 `logger` 提供了丰富且灵活的日志记录功能。通过理解其基础概念、掌握使用方法、熟悉常见实践和遵循最佳实践，开发者可以有效地记录和管理程序运行过程中的各类信息，从而提高代码的可维护性和稳定性。无论是小型脚本还是大型项目，合理运用 `logger` 都能为开发和调试工作带来极大的便利。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- 《Python核心编程》
- 各类Python技术论坛和博客文章

希望这篇博客能帮助你深入理解并高效使用Python Logger。如果你有任何问题或建议，欢迎在评论区留言。  
---
title: "深入理解Python Logging Level"
description: "在Python开发中，日志记录是一项至关重要的功能。它不仅能帮助我们追踪程序的执行流程，排查错误，还能在生产环境中提供关键的运行时信息。而`logging level`（日志级别）则是日志记录中的一个核心概念，通过不同的日志级别，我们可以灵活地控制记录哪些信息，以及这些信息的详细程度。本文将深入探讨Python中`logging level`的基础概念、使用方法、常见实践和最佳实践，帮助你更好地运用日志记录功能。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在Python开发中，日志记录是一项至关重要的功能。它不仅能帮助我们追踪程序的执行流程，排查错误，还能在生产环境中提供关键的运行时信息。而`logging level`（日志级别）则是日志记录中的一个核心概念，通过不同的日志级别，我们可以灵活地控制记录哪些信息，以及这些信息的详细程度。本文将深入探讨Python中`logging level`的基础概念、使用方法、常见实践和最佳实践，帮助你更好地运用日志记录功能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **基本配置**
    - **设置日志级别**
    - **在代码中使用不同级别记录日志**
3. **常见实践**
    - **开发环境中的日志级别设置**
    - **生产环境中的日志级别设置**
4. **最佳实践**
    - **日志级别与模块分离**
    - **动态调整日志级别**
5. **小结**
6. **参考资料**

## 基础概念
Python的`logging`模块定义了五个标准的日志级别，从低到高依次为：
- **DEBUG**：最详细的日志级别，用于开发过程中记录调试信息，帮助开发人员追踪代码执行路径和变量值。
- **INFO**：用于记录程序正常运行的信息，例如服务器启动、数据加载完成等。
- **WARNING**：表示程序遇到了一些非严重的问题，但仍能继续运行，例如文件即将过期、资源不足等。
- **ERROR**：用于记录程序发生的错误，这些错误会导致程序的某个功能无法正常执行。
- **CRITICAL**：最高级别的日志，用于记录严重的错误，可能会导致程序完全崩溃。

不同的日志级别可以帮助我们在不同的场景下，快速定位和分析问题。例如，在开发阶段，我们可以将日志级别设置为`DEBUG`，以便获取尽可能多的信息；而在生产环境中，通常将日志级别设置为`INFO`或`WARNING`，避免过多的日志信息影响系统性能。

## 使用方法

### 基本配置
在使用`logging`模块之前，我们需要进行基本的配置。以下是一个简单的示例：

```python
import logging

# 配置日志基本设置
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

# 记录一条INFO级别的日志
logging.info('这是一条INFO级别的日志')
```

在上述代码中：
- `logging.basicConfig()`函数用于配置日志的基本参数。
- `level=logging.INFO`设置了日志级别为`INFO`，这意味着只有`INFO`级别及以上的日志才会被记录。
- `format='%(asctime)s - %(levelname)s - %(message)s'`定义了日志的格式，包括时间、日志级别和日志信息。

### 设置日志级别
我们可以通过多种方式设置日志级别。除了在`basicConfig`中设置全局日志级别外，还可以针对不同的日志记录器（logger）设置不同的级别。

```python
import logging

# 获取一个名为'my_logger'的日志记录器
logger = logging.getLogger('my_logger')

# 设置日志记录器的级别为DEBUG
logger.setLevel(logging.DEBUG)

# 创建一个控制台处理器
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)

# 创建一个格式化器
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)

# 将控制台处理器添加到日志记录器
logger.addHandler(ch)

# 记录不同级别的日志
logger.debug('这是一条DEBUG级别的日志')
logger.info('这是一条INFO级别的日志')
logger.warning('这是一条WARNING级别的日志')
logger.error('这是一条ERROR级别的日志')
logger.critical('这是一条CRITICAL级别的日志')
```

在这个示例中：
- `logging.getLogger('my_logger')`获取了一个名为`my_logger`的日志记录器。
- `logger.setLevel(logging.DEBUG)`将该日志记录器的级别设置为`DEBUG`。
- `ch = logging.StreamHandler()`创建了一个控制台处理器，用于将日志输出到控制台。
- `ch.setLevel(logging.DEBUG)`设置了控制台处理器的日志级别为`DEBUG`。
- `formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')`定义了日志的格式化器。
- `ch.setFormatter(formatter)`将格式化器应用到控制台处理器。
- `logger.addHandler(ch)`将控制台处理器添加到日志记录器。

### 在代码中使用不同级别记录日志
在实际代码中，我们可以根据不同的业务逻辑，在合适的位置记录不同级别的日志。

```python
import logging

def divide_numbers(a, b):
    logger = logging.getLogger(__name__)
    try:
        result = a / b
        logger.info(f'成功计算 {a} / {b} = {result}')
        return result
    except ZeroDivisionError as e:
        logger.error(f'发生除零错误: {e}')
        return None

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    divide_numbers(10, 2)
    divide_numbers(10, 0)
```

在这个示例中：
- 在`divide_numbers`函数中，我们使用`logger = logging.getLogger(__name__)`获取了一个与当前模块相关的日志记录器。
- 在`try`块中，计算成功后记录`INFO`级别的日志，表示操作成功。
- 在`except`块中，捕获到`ZeroDivisionError`时，记录`ERROR`级别的日志，详细描述错误信息。

## 常见实践

### 开发环境中的日志级别设置
在开发环境中，我们希望获取尽可能多的信息，以便快速定位和解决问题。因此，通常将日志级别设置为`DEBUG`。这样，我们可以看到程序执行过程中的每一个细节，包括函数调用、变量值的变化等。

```python
import logging

logging.basicConfig(level=logging.DEBUG)

# 你的开发代码
def my_function():
    a = 10
    b = 5
    logging.debug(f'a的值为 {a}，b的值为 {b}')
    result = a + b
    logging.debug(f'计算结果为 {result}')
    return result

my_function()
```

### 生产环境中的日志级别设置
在生产环境中，过多的日志信息可能会影响系统性能，并且大量的日志数据也会增加存储和管理的成本。因此，通常将日志级别设置为`INFO`或`WARNING`。

```python
import logging

logging.basicConfig(level=logging.INFO)

# 你的生产代码
def process_request(request):
    logging.info(f'接收到请求: {request}')
    # 处理请求的逻辑
    if not request.is_valid():
        logging.warning(f'请求无效: {request}')
    # 其他业务逻辑
```

## 最佳实践

### 日志级别与模块分离
为了更好地管理日志，建议为每个模块设置独立的日志记录器，并根据模块的需求设置不同的日志级别。

```python
# module1.py
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

def module1_function():
    logger.debug('这是module1中的DEBUG日志')
    logger.info('这是module1中的INFO日志')

# module2.py
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def module2_function():
    logger.info('这是module2中的INFO日志')
    logger.warning('这是module2中的WARNING日志')

# main.py
import logging
import module1
import module2

logging.basicConfig(level=logging.INFO)

module1.module1_function()
module2.module2_function()
```

在这个示例中，`module1`和`module2`分别有自己的日志记录器，并且设置了不同的日志级别。这样可以更灵活地控制每个模块的日志输出。

### 动态调整日志级别
在一些情况下，我们可能需要在运行时动态调整日志级别。可以通过配置文件或命令行参数来实现这一点。

```python
import logging
import argparse

def setup_logging(level):
    logging.basicConfig(
        level=level,
        format='%(asctime)s - %(levelname)s - %(message)s'
    )

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='动态调整日志级别')
    parser.add_argument('--level', choices=['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'], default='INFO')
    args = parser.parse_args()

    log_level = getattr(logging, args.level)
    setup_logging(log_level)

    logging.info('日志记录已启动')
    logging.debug('这是一条DEBUG日志')
```

在上述代码中，通过`argparse`模块解析命令行参数，动态设置日志级别。

## 小结
Python的`logging level`为我们提供了一种灵活且强大的方式来控制日志记录的详细程度。通过合理设置日志级别，我们可以在开发和生产环境中更好地追踪程序执行流程、排查问题以及监控系统运行状态。在实际应用中，我们应该根据不同的场景和需求，运用最佳实践，确保日志记录既能够提供足够的信息，又不会对系统性能造成过大的影响。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
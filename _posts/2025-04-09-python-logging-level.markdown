---
title: "Python Logging Level：深入理解与高效应用"
description: "在Python开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者在程序运行时捕捉关键信息、排查错误以及监控程序的运行状态。而`logging level`（日志级别）则是日志记录中的一个核心概念，它决定了哪些日志信息会被记录下来，哪些会被忽略。本文将深入探讨Python中`logging level`的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用日志记录来提升开发效率和程序稳定性。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在Python开发过程中，日志记录是一项至关重要的任务。它能够帮助开发者在程序运行时捕捉关键信息、排查错误以及监控程序的运行状态。而`logging level`（日志级别）则是日志记录中的一个核心概念，它决定了哪些日志信息会被记录下来，哪些会被忽略。本文将深入探讨Python中`logging level`的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用日志记录来提升开发效率和程序稳定性。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **基本配置**
    - **设置不同级别日志**
3. **常见实践**
    - **在脚本中使用**
    - **在模块中使用**
4. **最佳实践**
    - **根据环境调整日志级别**
    - **日志文件管理**
5. **小结**
6. **参考资料**

## 基础概念
Python的`logging`模块提供了不同的日志级别，用于区分日志信息的重要程度。这些级别从低到高分别为：
- **DEBUG**：详细的信息，通常只在调试阶段使用，用于追踪程序执行过程中的每一个细节。
- **INFO**：用于记录程序运行过程中的一般信息，比如程序启动、某个功能模块开始执行等。
- **WARNING**：表示可能会导致问题的情况，但目前程序还能正常运行，例如文件即将达到最大容量等。
- **ERROR**：用于记录程序运行过程中发生的错误，这些错误会导致程序的部分功能无法正常执行。
- **CRITICAL**：严重错误，通常意味着程序无法继续运行，例如数据库连接失败、系统资源耗尽等。

## 使用方法
### 基本配置
在使用`logging`模块前，需要进行基本配置。以下是一个简单的示例：

```python
import logging

# 基本配置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录不同级别的日志
logging.debug('这是一条DEBUG级别的日志')
logging.info('这是一条INFO级别的日志')
logging.warning('这是一条WARNING级别的日志')
logging.error('这是一条ERROR级别的日志')
logging.critical('这是一条CRITICAL级别的日志')
```

在上述代码中：
1. `import logging` 导入`logging`模块。
2. `logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')` 进行基本配置，设置日志级别为`INFO`，并定义了日志输出的格式，包括时间、日志级别和日志信息。
3. 后续分别调用不同级别的日志记录函数，由于设置的日志级别为`INFO`，所以只有`INFO`级别及以上的日志会被记录并输出。

### 设置不同级别日志
可以通过修改`basicConfig`中的`level`参数来改变日志级别。例如，将日志级别设置为`DEBUG`：

```python
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

logging.debug('这是一条DEBUG级别的日志')
logging.info('这是一条INFO级别的日志')
logging.warning('这是一条WARNING级别的日志')
logging.error('这是一条ERROR级别的日志')
logging.critical('这是一条CRITICAL级别的日志')
```

此时，所有级别的日志都会被记录并输出，因为`DEBUG`是最低级别。

## 常见实践
### 在脚本中使用
在单个Python脚本中，日志记录可以帮助开发者快速了解脚本的执行情况。例如，一个简单的文件读取脚本：

```python
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def read_file(file_path):
    try:
        with open(file_path, 'r') as f:
            content = f.read()
            logging.info(f'成功读取文件 {file_path}')
            return content
    except FileNotFoundError as e:
        logging.error(f'文件未找到: {e}')
        return None

file_content = read_file('example.txt')
```

在这个脚本中，通过日志记录可以清楚地看到文件读取操作是否成功，如果失败，也能获取到具体的错误信息。

### 在模块中使用
当项目包含多个模块时，每个模块可以有自己独立的日志配置。例如，有一个名为`module1.py`的模块：

```python
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

file_handler = logging.FileHandler('module1.log')
file_handler.setFormatter(formatter)

logger.addHandler(file_handler)

def module_function():
    logger.debug('这是module1中的DEBUG日志')
    logger.info('这是module1中的INFO日志')
```

在主程序中调用这个模块：

```python
import logging
from module1 import module_function

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

module_function()
```

在这个例子中，`module1.py`模块有自己独立的日志记录器，将日志输出到`module1.log`文件中，同时主程序也有自己的日志配置，互不影响。

## 最佳实践
### 根据环境调整日志级别
在开发环境中，通常希望记录更多详细信息，以便快速定位问题，所以可以将日志级别设置为`DEBUG`。而在生产环境中，为了避免过多的日志信息影响系统性能和安全性，一般将日志级别设置为`INFO`或`WARNING`。可以通过环境变量来动态调整日志级别：

```python
import logging
import os

log_level = os.getenv('LOG_LEVEL', 'INFO')

if log_level == 'DEBUG':
    level = logging.DEBUG
elif log_level == 'INFO':
    level = logging.INFO
elif log_level == 'WARNING':
    level = logging.WARNING
elif log_level == 'ERROR':
    level = logging.ERROR
elif log_level == 'CRITICAL':
    level = logging.CRITICAL
else:
    level = logging.INFO

logging.basicConfig(level=level, format='%(asctime)s - %(levelname)s - %(message)s')

logging.debug('这是一条DEBUG级别的日志')
logging.info('这是一条INFO级别的日志')
logging.warning('这是一条WARNING级别的日志')
logging.error('这是一条ERROR级别的日志')
logging.critical('这是一条CRITICAL级别的日志')
```

在启动程序时，可以通过设置环境变量`LOG_LEVEL`来改变日志级别，例如：`export LOG_LEVEL=DEBUG`。

### 日志文件管理
随着程序的运行，日志文件可能会不断增大，占用大量磁盘空间。因此，需要对日志文件进行管理。可以使用`logging.handlers.RotatingFileHandler`来实现日志文件的滚动：

```python
import logging
from logging.handlers import RotatingFileHandler

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

file_handler = RotatingFileHandler('app.log', maxBytes=1024*1024, backupCount=5)
file_handler.setFormatter(formatter)

logger.addHandler(file_handler)

for i in range(10000):
    logger.debug(f'这是第 {i} 条DEBUG日志')
```

在上述代码中，`RotatingFileHandler`设置了日志文件的最大大小为1MB，当文件达到这个大小时，会自动创建新的日志文件，并保留5个备份文件。

## 小结
Python的`logging level`为开发者提供了灵活控制日志记录的能力。通过合理设置日志级别，能够在不同的开发和生产环境中有效地记录关键信息，帮助排查问题和监控程序运行状态。同时，遵循最佳实践，如根据环境调整日志级别和进行日志文件管理，可以进一步提升日志记录的效率和可靠性。希望本文能够帮助读者更好地掌握和运用Python的日志记录功能。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
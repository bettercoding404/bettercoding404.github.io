---
title: "Python Logging Level：深入理解与高效应用"
description: "在Python开发中，日志记录（logging）是一项至关重要的技术，它能够帮助开发者追踪程序的执行流程、调试代码以及监控系统运行状态。而日志级别（logging level）则是日志记录中的关键概念，通过不同的日志级别，我们可以灵活控制日志信息的详细程度，以便在不同的开发和生产环境中获取到最有用的信息。本文将深入探讨Python logging level的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大工具。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python开发中，日志记录（logging）是一项至关重要的技术，它能够帮助开发者追踪程序的执行流程、调试代码以及监控系统运行状态。而日志级别（logging level）则是日志记录中的关键概念，通过不同的日志级别，我们可以灵活控制日志信息的详细程度，以便在不同的开发和生产环境中获取到最有用的信息。本文将深入探讨Python logging level的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **基本配置**
    - **设置日志级别**
    - **记录不同级别的日志**
3. **常见实践**
    - **在不同环境中使用不同日志级别**
    - **日志记录到文件**
    - **格式化日志输出**
4. **最佳实践**
    - **合理设置默认日志级别**
    - **避免过多的日志记录**
    - **使用日志级别进行调试**
5. **小结**
6. **参考资料**

## 基础概念
Python的`logging`模块定义了几个标准的日志级别，每个级别代表了不同的严重程度和信息类型。这些级别从低到高依次为：
- **DEBUG**：最详细的日志级别，通常用于开发过程中的调试。它会记录所有可能的信息，帮助开发者追踪代码执行流程，排查问题。
- **INFO**：用于记录一般的信息，比如程序启动、关闭，或者某些重要操作的执行情况。这些信息对于了解程序的正常运行状态很有帮助。
- **WARNING**：表示程序遇到了一些潜在的问题，但并不影响程序的正常运行。例如，可能是一些即将过期的配置，或者是某个操作的结果不符合预期，但仍然可以继续执行。
- **ERROR**：当程序发生错误，导致某些功能无法正常执行时，使用这个级别记录错误信息。通过查看ERROR级别的日志，可以快速定位程序中的错误点。
- **CRITICAL**：这是最高级别的日志，用于记录非常严重的错误，通常会导致程序无法继续运行。比如系统崩溃、数据库连接失败等情况。

## 使用方法

### 基本配置
在使用`logging`模块之前，需要进行基本的配置。可以使用`basicConfig`方法来设置日志的基本参数，如日志格式、输出位置等。以下是一个简单的示例：

```python
import logging

# 基本配置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录一条INFO级别的日志
logging.info('This is an info log')
```

在上述代码中：
- `logging.basicConfig`方法进行了基本配置，`level=logging.INFO`设置了日志级别为INFO，这意味着只有INFO级别及以上的日志才会被记录。`format='%(asctime)s - %(levelname)s - %(message)s'`定义了日志的格式，分别包含时间、日志级别和日志信息。
- `logging.info('This is an info log')`语句记录了一条INFO级别的日志。

### 设置日志级别
可以通过`basicConfig`方法的`level`参数来设置全局的日志级别，也可以在运行时动态地更改日志级别。例如：

```python
import logging

# 基本配置
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录不同级别的日志
logging.debug('This is a debug log')
logging.info('This is an info log')
logging.warning('This is a warning log')
logging.error('This is an error log')
logging.critical('This is a critical log')

# 动态更改日志级别
logging.getLogger().setLevel(logging.ERROR)

# 再次记录日志
logging.debug('This is a debug log after change')
logging.info('This is an info log after change')
logging.warning('This is a warning log after change')
logging.error('This is an error log after change')
logging.critical('This is a critical log after change')
```

在这个示例中：
- 首先将日志级别设置为DEBUG，所以所有级别的日志都会被记录。
- 然后使用`logging.getLogger().setLevel(logging.ERROR)`将日志级别动态地更改为ERROR，此时只有ERROR和CRITICAL级别的日志会被记录。

### 记录不同级别的日志
`logging`模块提供了与各个日志级别对应的方法，用于记录不同级别的日志。示例如下：

```python
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录DEBUG级别的日志
logging.debug('Debugging information')

# 记录INFO级别的日志
logging.info('Informational message')

# 记录WARNING级别的日志
logging.warning('This is a warning')

# 记录ERROR级别的日志
logging.error('An error occurred')

# 记录CRITICAL级别的日志
logging.critical('Critical error! System is down')
```

上述代码分别使用`logging`模块的`debug`、`info`、`warning`、`error`和`critical`方法记录了不同级别的日志。

## 常见实践

### 在不同环境中使用不同日志级别
在开发环境中，通常希望获取尽可能多的信息，以便快速定位和解决问题，所以可以将日志级别设置为DEBUG。而在生产环境中，过多的日志信息可能会影响系统性能，并且会使日志文件变得庞大难以管理，因此一般将日志级别设置为INFO或WARNING。

可以通过环境变量来动态地设置日志级别，示例如下：

```python
import logging
import os

# 获取环境变量中的日志级别
log_level = os.getenv('LOG_LEVEL', 'INFO')

# 将日志级别字符串转换为logging模块中的常量
level_mapping = {
    'DEBUG': logging.DEBUG,
    'INFO': logging.INFO,
    'WARNING': logging.WARNING,
    'ERROR': logging.ERROR,
    'CRITICAL': logging.CRITICAL
}
logging.basicConfig(level=level_mapping[log_level], format='%(asctime)s - %(levelname)s - %(message)s')

# 记录日志
logging.debug('This is a debug log')
logging.info('This is an info log')
logging.warning('This is a warning log')
logging.error('This is an error log')
logging.critical('This is a critical log')
```

在上述代码中，通过`os.getenv('LOG_LEVEL', 'INFO')`获取环境变量`LOG_LEVEL`的值，如果没有设置，则默认使用`INFO`级别。然后根据`level_mapping`字典将字符串转换为`logging`模块中的常量，从而设置日志级别。

### 日志记录到文件
除了将日志输出到控制台，还可以将日志记录到文件中，方便后续查看和分析。可以通过`basicConfig`方法的`filename`参数来指定日志文件的路径。示例如下：

```python
import logging

# 配置日志记录到文件
logging.basicConfig(filename='app.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 记录日志
logging.info('This is an info log written to file')
logging.warning('This is a warning log written to file')
```

上述代码将INFO级别及以上的日志记录到`app.log`文件中。

### 格式化日志输出
可以通过`basicConfig`方法的`format`参数来定制日志的输出格式。除了前面提到的`%(asctime)s`（时间）、`%(levelname)s`（日志级别）和`%(message)s`（日志信息），还有其他一些常用的格式占位符，如`%(name)s`（记录器名称）、`%(lineno)d`（日志记录所在的行号）等。示例如下：

```python
import logging

# 自定义日志格式
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(lineno)d - %(message)s')

# 获取名为'my_app'的记录器
logger = logging.getLogger('my_app')

# 记录日志
logger.info('This is an info log with custom format')
```

在上述代码中，自定义的日志格式包含了时间、记录器名称、日志级别、行号和日志信息。

## 最佳实践

### 合理设置默认日志级别
在项目开始时，应根据项目的特点和需求合理设置默认的日志级别。对于开发过程中的项目，可以将默认日志级别设置为DEBUG，以便获取更多的调试信息。而在生产环境中，应将默认日志级别设置为INFO或WARNING，避免过多的日志记录影响系统性能。

### 避免过多的日志记录
虽然日志记录可以帮助我们了解程序的运行情况，但过多的日志记录会占用系统资源，并且会使日志文件变得庞大难以管理。因此，在记录日志时应遵循“必要且适度”的原则，只记录那些对了解程序运行状态和排查问题有帮助的信息。

### 使用日志级别进行调试
在调试代码时，可以通过动态更改日志级别来获取更多或更少的信息。例如，在定位某个问题时，可以将日志级别设置为DEBUG，查看详细的执行过程和变量值。问题解决后，再将日志级别恢复到原来的设置。

## 小结
Python的`logging`模块提供了丰富的功能来管理日志记录，而日志级别是控制日志信息详细程度的关键。通过合理设置日志级别、格式化日志输出以及将日志记录到文件等方法，我们可以更好地追踪程序的执行流程、调试代码以及监控系统运行状态。在实际开发中，遵循最佳实践可以帮助我们更高效地使用日志记录，提高开发效率和系统的稳定性。

## 参考资料
- [Python官方文档 - logging模块](https://docs.python.org/3/library/logging.html){: rel="nofollow"}
- [Python Logging Cookbook](https://docs.python.org/3/howto/logging-cookbook.html){: rel="nofollow"}
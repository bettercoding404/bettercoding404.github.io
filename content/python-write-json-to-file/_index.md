---
title: "Python 中写入 JSON 数据到文件"
description: "在 Python 开发中，处理 JSON 数据是一项常见的任务。JSON（JavaScript Object Notation）是一种轻量级的数据交换格式，因其简洁易读的特点，被广泛应用于各种领域，特别是在 Web 开发和数据存储中。将 JSON 数据写入文件，能方便地保存和持久化数据，以便后续读取和使用。本文将详细介绍在 Python 中如何将 JSON 数据写入文件，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 开发中，处理 JSON 数据是一项常见的任务。JSON（JavaScript Object Notation）是一种轻量级的数据交换格式，因其简洁易读的特点，被广泛应用于各种领域，特别是在 Web 开发和数据存储中。将 JSON 数据写入文件，能方便地保存和持久化数据，以便后续读取和使用。本文将详细介绍在 Python 中如何将 JSON 数据写入文件，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `json` 模块**
    - **处理复杂数据结构**
3. **常见实践**
    - **保存配置文件**
    - **记录日志数据**
4. **最佳实践**
    - **错误处理**
    - **文件权限与路径管理**
5. **小结**
6. **参考资料**

## 基础概念
### JSON 数据格式
JSON 数据以键值对的形式组织，类似于 Python 中的字典。例如：
```json
{
    "name": "John",
    "age": 30,
    "city": "New York"
}
```
### Python 中的 JSON 处理模块
Python 标准库中的 `json` 模块提供了处理 JSON 数据的功能。它包含了将 Python 对象转换为 JSON 格式（序列化）和将 JSON 数据转换为 Python 对象（反序列化）的方法。

## 使用方法
### 使用 `json` 模块
要将 JSON 数据写入文件，首先需要导入 `json` 模块。以下是一个简单的示例，将一个 Python 字典转换为 JSON 格式并写入文件：

```python
import json

data = {
    "name": "Alice",
    "age": 25,
    "hobbies": ["reading", "painting"]
}

with open('data.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)
```

在上述代码中：
- `import json` 导入了 JSON 处理模块。
- `data` 是一个 Python 字典，我们要将其转换为 JSON 并写入文件。
- `open('data.json', 'w', encoding='utf-8')` 以写入模式打开一个名为 `data.json` 的文件，并指定编码为 `utf - 8`。
- `json.dump(data, f, ensure_ascii=False, indent=4)` 将 `data` 字典写入文件 `f`。`ensure_ascii=False` 确保非 ASCII 字符按原字符写入文件，而不是转义为 ASCII 码；`indent=4` 使生成的 JSON 数据具有缩进，更加易读。

### 处理复杂数据结构
如果数据结构包含更复杂的对象，如日期、自定义类等，需要进行额外的处理。例如，处理日期对象：

```python
import json
from datetime import datetime

data = {
    "name": "Bob",
    "age": 32,
    "last_update": datetime.now()
}

def serialize_datetime(obj):
    if isinstance(obj, datetime):
        return obj.isoformat()
    raise TypeError(f"Object of type {obj.__class__.__name__} is not JSON serializable")

with open('data_with_date.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, default=serialize_datetime, ensure_ascii=False, indent=4)
```

在这个例子中，定义了 `serialize_datetime` 函数来处理 `datetime` 对象，将其转换为 ISO 格式的字符串。`default` 参数指定了处理非标准 JSON 可序列化对象的函数。

## 常见实践
### 保存配置文件
在开发应用程序时，通常需要保存配置信息。使用 JSON 格式保存配置文件清晰且易于修改。

```python
import json

config = {
    "database": {
        "host": "localhost",
        "port": 3306,
        "username": "root",
        "password": "password"
    },
    "logging_level": "INFO"
}

with open('config.json', 'w', encoding='utf-8') as f:
    json.dump(config, f, ensure_ascii=False, indent=4)
```

### 记录日志数据
将日志数据以 JSON 格式保存，方便后续分析和处理。

```python
import json
import logging

logging.basicConfig(filename='app.log', level=logging.INFO)

def log_event(event):
    log_data = {
        "timestamp": datetime.now().isoformat(),
        "event_type": event["type"],
        "details": event["details"]
    }
    with open('log.json', 'a', encoding='utf-8') as f:
        json.dump(log_data, f, ensure_ascii=False)
        f.write('\n')

event = {
    "type": "user_login",
    "details": {
        "username": "user1",
        "ip": "192.168.1.1"
    }
}

log_event(event)
```

## 最佳实践
### 错误处理
在写入 JSON 数据到文件时，可能会遇到各种错误，如文件权限不足、磁盘空间不足等。因此，需要进行适当的错误处理。

```python
import json

data = {
    "message": "Hello, World!"
}

try:
    with open('output.json', 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)
except IOError as e:
    print(f"An error occurred while writing to the file: {e}")
except json.JSONDecodeError as e:
    print(f"An error occurred while serializing JSON data: {e}")
```

### 文件权限与路径管理
确保程序有足够的权限写入文件，并且文件路径是有效的。可以使用 `os` 模块来处理路径相关的操作。

```python
import json
import os

data = {
    "message": "Data to be written"
}

file_path = os.path.join('output', 'data.json')
os.makedirs(os.path.dirname(file_path), exist_ok=True)

try:
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)
except IOError as e:
    print(f"An error occurred while writing to the file: {e}")
```

## 小结
本文介绍了在 Python 中写入 JSON 数据到文件的相关知识，包括基础概念、使用方法、常见实践和最佳实践。通过使用 `json` 模块，我们可以轻松地将 Python 数据结构转换为 JSON 格式并保存到文件中。在实际应用中，要注意处理复杂数据结构、进行错误处理以及合理管理文件权限和路径。掌握这些知识和技巧，能帮助开发者更加高效地处理 JSON 数据的持久化操作。

## 参考资料
- [Python 官方文档 - json 模块](https://docs.python.org/3/library/json.html)
- [JSON 官方网站](https://www.json.org/json-zh.html)
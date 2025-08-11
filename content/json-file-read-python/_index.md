---
title: "Python 中读取 JSON 文件的全面指南"
description: "在现代软件开发和数据处理中，JSON（JavaScript Object Notation）是一种广泛使用的数据交换格式。它以简洁、易读的文本形式表示数据结构，并且在不同编程语言之间具有良好的兼容性。Python 作为一种强大的编程语言，提供了丰富的库和方法来处理 JSON 文件。本文将深入探讨在 Python 中读取 JSON 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在现代软件开发和数据处理中，JSON（JavaScript Object Notation）是一种广泛使用的数据交换格式。它以简洁、易读的文本形式表示数据结构，并且在不同编程语言之间具有良好的兼容性。Python 作为一种强大的编程语言，提供了丰富的库和方法来处理 JSON 文件。本文将深入探讨在 Python 中读取 JSON 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技能。

<!-- more -->
## 目录
1. **基础概念**
    - JSON 简介
    - Python 与 JSON 的关系
2. **使用方法**
    - 使用 `json` 模块读取 JSON 文件
    - 处理 JSON 数据中的不同数据类型
3. **常见实践**
    - 从本地文件读取 JSON 数据
    - 从网络获取 JSON 数据
4. **最佳实践**
    - 错误处理
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
### JSON 简介
JSON 是一种轻量级的数据交换格式，它基于 JavaScript 的对象字面量表示法。JSON 数据由键值对组成，使用花括号 `{}` 表示对象，方括号 `[]` 表示数组。例如：
```json
{
    "name": "John Doe",
    "age": 30,
    "hobbies": ["reading", "traveling"]
}
```
### Python 与 JSON 的关系
Python 提供了内置的 `json` 模块来处理 JSON 数据。该模块允许将 Python 对象转换为 JSON 格式的字符串（序列化），也可以将 JSON 格式的字符串转换为 Python 对象（反序列化）。

## 使用方法
### 使用 `json` 模块读取 JSON 文件
在 Python 中，使用 `json` 模块读取 JSON 文件通常需要以下步骤：
1. 打开 JSON 文件。
2. 使用 `json.load()` 方法将文件内容解析为 Python 对象。

以下是一个简单的示例：
```python
import json

# 打开 JSON 文件
with open('data.json', 'r', encoding='utf-8') as file:
    # 读取文件内容并解析为 Python 对象
    data = json.load(file)

print(data)
```
### 处理 JSON 数据中的不同数据类型
JSON 支持多种数据类型，包括字符串、数字、布尔值、数组、对象和 `null`。在 Python 中，这些 JSON 数据类型会被转换为相应的 Python 数据类型：
- JSON 字符串 -> Python 字符串
- JSON 数字 -> Python 整数或浮点数
- JSON 布尔值 -> Python 布尔值
- JSON 数组 -> Python 列表
- JSON 对象 -> Python 字典
- JSON `null` -> Python `None`

例如：
```python
import json

json_data = '{"name": "Alice", "age": 25, "is_student": false, "hobbies": ["music", "sports"], "pet": null}'
python_obj = json.loads(json_data)

print(type(python_obj["name"]))  # <class'str'>
print(type(python_obj["age"]))   # <class 'int'>
print(type(python_obj["is_student"]))  # <class 'bool'>
print(type(python_obj["hobbies"]))  # <class 'list'>
print(type(python_obj["pet"]))  # <class 'NoneType'>
```

## 常见实践
### 从本地文件读取 JSON 数据
这是最常见的场景之一。假设我们有一个名为 `data.json` 的文件，内容如下：
```json
{
    "employees": [
        {
            "name": "Alice",
            "age": 28,
            "department": "Engineering"
        },
        {
            "name": "Bob",
            "age": 32,
            "department": "Sales"
        }
    ]
}
```
读取该文件并处理数据的代码如下：
```python
import json

with open('data.json', 'r', encoding='utf-8') as file:
    data = json.load(file)

for employee in data["employees"]:
    print(f"Name: {employee['name']}, Age: {employee['age']}, Department: {employee['department']}")
```
### 从网络获取 JSON 数据
在许多情况下，我们需要从网络 API 中获取 JSON 数据。可以使用 `requests` 库来发送 HTTP 请求并获取响应。例如，获取一个公开 API 的 JSON 数据：
```python
import requests

url = 'https://api.example.com/data'
response = requests.get(url)

if response.status_code == 200:
    data = response.json()
    print(data)
else:
    print(f"Error: {response.status_code}")
```

## 最佳实践
### 错误处理
在读取 JSON 文件或解析 JSON 数据时，可能会发生各种错误，如文件不存在、JSON 格式不正确等。因此，进行适当的错误处理非常重要。
```python
import json

try:
    with open('data.json', 'r', encoding='utf-8') as file:
        data = json.load(file)
    print(data)
except FileNotFoundError:
    print("File not found.")
except json.JSONDecodeError as e:
    print(f"JSON decoding error: {e}")
```
### 性能优化
对于大型 JSON 文件，逐行读取并解析可能会提高性能。可以使用 `ijson` 库来实现流式解析。
```python
import ijson

with open('large_data.json', 'r', encoding='utf-8') as file:
    parser = ijson.parse(file)
    for prefix, event, value in parser:
        if event =='map_key':
            key = value
        elif event == 'end_map':
            # 处理解析后的 JSON 对象
            pass
```

## 小结
在 Python 中读取 JSON 文件是一项基本且重要的技能。通过使用 `json` 模块，我们可以轻松地将 JSON 数据转换为 Python 对象进行处理。在实际应用中，需要注意处理不同的数据类型、从本地文件或网络获取 JSON 数据，并且遵循最佳实践，如错误处理和性能优化，以确保程序的稳定性和高效性。

## 参考资料
- [Python 官方文档 - json 模块](https://docs.python.org/3/library/json.html)
- [requests 库官方文档](https://requests.readthedocs.io/en/latest/)
- [ijson 库官方文档](https://pypi.org/project/ijson/)
---
title: "Python 中读取 JSON 文件的全面指南"
description: "在现代软件开发和数据处理中，JSON（JavaScript Object Notation）作为一种轻量级的数据交换格式，被广泛应用。Python 作为一种强大且灵活的编程语言，提供了便捷的方式来读取和处理 JSON 文件。本文将深入探讨在 Python 中读取 JSON 文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一重要技能。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在现代软件开发和数据处理中，JSON（JavaScript Object Notation）作为一种轻量级的数据交换格式，被广泛应用。Python 作为一种强大且灵活的编程语言，提供了便捷的方式来读取和处理 JSON 文件。本文将深入探讨在 Python 中读取 JSON 文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一重要技能。

<!-- more -->
## 目录
1. **JSON 文件基础概念**
2. **Python 读取 JSON 文件的使用方法**
    - **使用 `json` 模块**
    - **处理文件路径**
3. **常见实践**
    - **解析 JSON 数据**
    - **处理嵌套 JSON 结构**
    - **处理 JSON 数据中的错误**
4. **最佳实践**
    - **优化性能**
    - **确保数据安全**
5. **小结**
6. **参考资料**

## JSON 文件基础概念
JSON 是一种基于文本的开放标准格式，它使用人类可读的文本表示对象、数组、数字、字符串等数据结构。JSON 数据以键值对的形式组织，非常适合在不同的编程语言和系统之间交换数据。

以下是一个简单的 JSON 文件示例：
```json
{
    "name": "John Doe",
    "age": 30,
    "city": "New York",
    "hobbies": ["reading", "traveling"]
}
```
在这个示例中，`name`、`age`、`city` 和 `hobbies` 是键，对应的值分别是字符串、数字、字符串和数组。

## Python 读取 JSON 文件的使用方法
### 使用 `json` 模块
Python 的标准库中提供了 `json` 模块，用于处理 JSON 数据。要读取 JSON 文件，首先需要导入 `json` 模块，然后使用 `json.load()` 函数。

以下是一个简单的示例代码：
```python
import json

# 打开 JSON 文件
with open('data.json', 'r') as json_file:
    data = json.load(json_file)

# 打印读取的数据
print(data)
```
在上述代码中：
1. 使用 `import json` 导入 `json` 模块。
2. 使用 `open('data.json', 'r')` 以只读模式打开名为 `data.json` 的文件，并使用 `with` 语句确保文件在使用后正确关闭。
3. 使用 `json.load(json_file)` 读取文件内容并将其解析为 Python 数据结构（通常是字典或列表）。
4. 最后打印读取的数据。

### 处理文件路径
在实际应用中，文件路径可能会比较复杂。可以使用 `os` 模块来处理文件路径，以确保代码在不同操作系统上的兼容性。

以下是一个示例：
```python
import json
import os

# 获取当前目录
current_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(current_dir, 'data.json')

with open(file_path, 'r') as json_file:
    data = json.load(json_file)

print(data)
```
在这个示例中，使用 `os.path.dirname(os.path.abspath(__file__))` 获取当前脚本的目录，然后使用 `os.path.join()` 拼接文件路径，确保在不同操作系统上都能正确找到 JSON 文件。

## 常见实践
### 解析 JSON 数据
读取 JSON 文件后，通常需要对数据进行解析和处理。可以根据 JSON 数据的结构，使用字典和列表的操作方法来提取所需信息。

以下是一个示例：
```python
import json

with open('data.json', 'r') as json_file:
    data = json.load(json_file)

# 提取 name 和 age
name = data.get('name')
age = data.get('age')

print(f"Name: {name}, Age: {age}")
```
在这个示例中，使用 `data.get('name')` 和 `data.get('age')` 从 JSON 数据中提取 `name` 和 `age` 字段的值，并打印出来。

### 处理嵌套 JSON 结构
JSON 数据可能包含嵌套的结构，例如嵌套的字典或列表。处理这种情况时，需要递归地访问数据。

以下是一个嵌套 JSON 数据的示例：
```json
{
    "name": "John Doe",
    "age": 30,
    "address": {
        "street": "123 Main St",
        "city": "New York",
        "country": "USA"
    },
    "hobbies": [
        {
            "name": "reading",
            "description": "Enjoys reading books"
        },
        {
            "name": "traveling",
            "description": "Loves to explore new places"
        }
    ]
}
```
以下是处理该嵌套 JSON 数据的 Python 代码：
```python
import json

with open('nested_data.json', 'r') as json_file:
    data = json.load(json_file)

# 提取嵌套数据
street = data.get('address', {}).get('street')
hobby_name = data.get('hobbies', [])[0].get('name')

print(f"Street: {street}, First Hobby: {hobby_name}")
```
在这个示例中，使用 `data.get('address', {}).get('street')` 来安全地获取嵌套的 `street` 字段的值，使用 `data.get('hobbies', [])[0].get('name')` 来获取第一个爱好的名称。

### 处理 JSON 数据中的错误
在读取和解析 JSON 文件时，可能会遇到各种错误，例如文件不存在、JSON 格式错误等。可以使用 `try - except` 块来捕获并处理这些错误。

以下是一个示例：
```python
import json

try:
    with open('invalid_data.json', 'r') as json_file:
        data = json.load(json_file)
except FileNotFoundError:
    print("The JSON file was not found.")
except json.JSONDecodeError as e:
    print(f"Error decoding JSON: {e}")
```
在这个示例中，使用 `try - except` 块捕获 `FileNotFoundError` 和 `json.JSONDecodeError` 错误，并分别进行相应的处理。

## 最佳实践
### 优化性能
对于大型 JSON 文件，读取和解析可能会消耗较多的时间和内存。可以考虑使用 `ijson` 库进行流式处理，以提高性能。

以下是一个使用 `ijson` 库的示例：
```python
import ijson

with open('large_data.json', 'r') as json_file:
    parser = ijson.parse(json_file)
    for prefix, event, value in parser:
        if event =='map_key':
            key = value
        elif event == 'end_map':
            # 处理一个完整的 JSON 对象
            pass
```
在这个示例中，`ijson.parse()` 以流式方式解析 JSON 文件，逐块处理数据，避免一次性将整个文件加载到内存中。

### 确保数据安全
在读取 JSON 文件时，要注意数据的安全性。避免直接信任来自不可信源的 JSON 数据，防止 JSON 注入攻击。可以使用 `json.JSONDecoder` 的 `object_hook` 参数来验证和清理数据。

以下是一个示例：
```python
import json

def validate_data(dct):
    # 验证和清理数据
    valid_dct = {}
    for key, value in dct.items():
        if isinstance(key, str) and isinstance(value, (str, int, float, bool, list, dict)):
            valid_dct[key] = value
    return valid_dct

with open('data.json', 'r') as json_file:
    data = json.load(json_file, object_hook=validate_data)

print(data)
```
在这个示例中，`object_hook=validate_data` 会在解析 JSON 数据时调用 `validate_data` 函数，对每个 JSON 对象进行验证和清理，确保数据的安全性。

## 小结
在 Python 中读取 JSON 文件是一项常见且重要的任务。通过掌握 `json` 模块的基本使用方法，了解处理文件路径、解析数据、处理嵌套结构和错误处理等常见实践，以及性能优化和数据安全等最佳实践，读者能够更加高效、安全地处理 JSON 文件。希望本文提供的内容能够帮助读者在实际项目中更好地运用这些知识。

## 参考资料
- [Python 官方文档 - json 模块](https://docs.python.org/3/library/json.html){: rel="nofollow"}
- [ijson 库官方文档](https://pypi.org/project/ijson/){: rel="nofollow"}
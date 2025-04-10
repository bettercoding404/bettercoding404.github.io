---
title: "Python 读取 JSON 文件：从基础到最佳实践"
description: "在当今的数据驱动时代，JSON（JavaScript Object Notation）作为一种轻量级的数据交换格式，被广泛应用于各种领域。Python 作为一门强大的编程语言，提供了便捷的方式来读取 JSON 文件。掌握如何在 Python 中读取 JSON 文件是数据处理、Web 开发等众多场景中的必备技能。本文将深入探讨 Python 读取 JSON 文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者全面理解并高效运用这一功能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在当今的数据驱动时代，JSON（JavaScript Object Notation）作为一种轻量级的数据交换格式，被广泛应用于各种领域。Python 作为一门强大的编程语言，提供了便捷的方式来读取 JSON 文件。掌握如何在 Python 中读取 JSON 文件是数据处理、Web 开发等众多场景中的必备技能。本文将深入探讨 Python 读取 JSON 文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者全面理解并高效运用这一功能。

<!-- more -->
## 目录
1. **基础概念**
    - **什么是 JSON**
    - **JSON 在 Python 中的表示**
2. **使用方法**
    - **使用 `json` 模块读取 JSON 文件**
    - **处理 JSON 文件中的嵌套结构**
3. **常见实践**
    - **从本地文件读取 JSON 数据**
    - **从网络获取 JSON 数据并读取**
4. **最佳实践**
    - **错误处理与异常处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
### 什么是 JSON
JSON 是一种基于文本的开放标准格式，它以易于阅读和编写的方式表示数据。JSON 数据结构主要由两种类型组成：对象（Object）和数组（Array）。对象是一个无序的键值对集合，用花括号 `{}` 表示；数组是一个有序的值列表，用方括号 `[]` 表示。例如：
```json
{
    "name": "John",
    "age": 30,
    "hobbies": ["reading", "swimming"]
}
```
### JSON 在 Python 中的表示
在 Python 中，JSON 数据被映射为字典（dict）和列表（list）。JSON 对象对应 Python 字典，JSON 数组对应 Python 列表。这使得在 Python 中处理 JSON 数据变得非常自然。

## 使用方法
### 使用 `json` 模块读取 JSON 文件
Python 的标准库中提供了 `json` 模块，用于处理 JSON 数据。要读取 JSON 文件，首先需要导入 `json` 模块，然后使用 `json.load()` 函数。以下是一个简单的示例：
```python
import json

# 打开 JSON 文件
with open('data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

print(data)
```
在上述代码中：
1. 首先导入 `json` 模块。
2. 使用 `open()` 函数以只读模式打开名为 `data.json` 的文件，并指定编码为 `utf - 8`。
3. 使用 `json.load()` 函数将文件内容解析为 Python 数据结构（通常是字典或列表），并将结果存储在 `data` 变量中。
4. 最后打印 `data` 变量，查看解析后的 JSON 数据。

### 处理 JSON 文件中的嵌套结构
JSON 文件中常常包含嵌套的对象和数组。在 Python 中读取这样的 JSON 文件时，仍然可以使用 `json.load()` 函数，解析后的结果会保留嵌套结构。例如，考虑以下 JSON 文件内容：
```json
{
    "person": {
        "name": "Alice",
        "age": 25,
        "address": {
            "city": "New York",
            "country": "USA"
        }
    },
    "hobbies": ["dancing", "painting"]
}
```
读取并访问嵌套数据的代码如下：
```python
import json

with open('nested_data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# 访问嵌套数据
person_name = data['person']['name']
city = data['person']['address']['city']
hobbies = data['hobbies']

print(person_name)
print(city)
print(hobbies)
```
在这段代码中，通过层层索引来访问嵌套的 JSON 数据。

## 常见实践
### 从本地文件读取 JSON 数据
这是最常见的场景之一。在实际项目中，可能会有配置文件、数据文件等以 JSON 格式存储。以下是一个更完整的示例，用于读取一个包含多个 JSON 对象的文件，并对数据进行简单处理：
```python
import json

def process_json_data():
    with open('users.json', 'r', encoding='utf-8') as f:
        users = json.load(f)

    for user in users:
        print(f"User: {user['name']}, Age: {user['age']}")

if __name__ == "__main__":
    process_json_data()
```
假设 `users.json` 文件内容如下：
```json
[
    {
        "name": "Bob",
        "age": 28
    },
    {
        "name": "Charlie",
        "age": 32
    }
]
```
上述代码定义了一个函数 `process_json_data`，它读取 `users.json` 文件，遍历其中的每个用户对象，并打印用户的姓名和年龄。

### 从网络获取 JSON 数据并读取
在 Web 开发和数据采集等场景中，经常需要从网络获取 JSON 数据。可以使用 `requests` 库来发送 HTTP 请求并获取 JSON 响应。首先需要安装 `requests` 库（`pip install requests`），然后示例代码如下：
```python
import requests

def get_json_from_web():
    url = "https://example.com/api/data"
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()
        print(data)
    else:
        print(f"Error: {response.status_code}")

if __name__ == "__main__":
    get_json_from_web()
```
在上述代码中：
1. 使用 `requests.get()` 函数发送 GET 请求到指定的 URL。
2. 检查响应状态码，如果状态码为 200，表示请求成功，使用 `response.json()` 方法将响应内容解析为 JSON 数据并打印。
3. 如果状态码不为 200，则打印错误信息。

## 最佳实践
### 错误处理与异常处理
在读取 JSON 文件时，可能会遇到各种错误，如文件不存在、JSON 格式错误等。因此，进行适当的错误处理是非常重要的。以下是一个包含错误处理的示例：
```python
import json

try:
    with open('nonexistent_file.json', 'r', encoding='utf-8') as f:
        data = json.load(f)
except FileNotFoundError:
    print("File not found")
except json.JSONDecodeError as e:
    print(f"JSON decoding error: {e}")
```
在上述代码中，使用 `try - except` 块捕获可能的异常。如果文件不存在，捕获 `FileNotFoundError` 并打印相应信息；如果 JSON 格式错误，捕获 `json.JSONDecodeError` 并打印错误详情。

### 性能优化
对于大型 JSON 文件，性能优化是关键。可以考虑以下几点：
1. **流式处理**：使用 `json.JSONDecoder` 的 `raw_decode()` 方法进行流式处理，避免一次性加载整个文件。例如：
```python
import json

def stream_json(file_path):
    decoder = json.JSONDecoder()
    buffer = ""
    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            buffer += line
            while buffer:
                try:
                    obj, pos = decoder.raw_decode(buffer)
                    buffer = buffer[pos:].lstrip()
                    # 处理 obj
                    print(obj)
                except json.JSONDecodeError:
                    break

if __name__ == "__main__":
    stream_json('large_file.json')
```
2. **内存管理**：及时释放不再使用的内存，避免内存泄漏。例如，在处理完 JSON 数据后，将相关变量设置为 `None`。

## 小结
本文围绕 Python 读取 JSON 文件展开了全面的讨论。首先介绍了 JSON 的基础概念以及在 Python 中的表示方式，接着详细阐述了使用 `json` 模块读取 JSON 文件的方法，包括处理嵌套结构。在常见实践部分，展示了从本地文件和网络获取 JSON 数据的示例。最后，强调了错误处理、异常处理以及性能优化等最佳实践。通过掌握这些知识，读者能够在实际项目中更加高效、稳健地处理 JSON 文件。

## 参考资料
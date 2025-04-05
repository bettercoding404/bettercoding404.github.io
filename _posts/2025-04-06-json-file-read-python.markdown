---
title: "Python 中读取 JSON 文件的全面指南"
description: "在现代软件开发中，JSON（JavaScript Object Notation）是一种广泛用于数据交换和存储的轻量级数据格式。它具有易读性、易于解析和生成的特点，这使得它在各种编程语言和平台之间的数据传输中变得极为流行。Python 作为一种功能强大且简洁的编程语言，提供了内置的库来轻松读取和处理 JSON 文件。本文将深入探讨在 Python 中读取 JSON 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在现代软件开发中，JSON（JavaScript Object Notation）是一种广泛用于数据交换和存储的轻量级数据格式。它具有易读性、易于解析和生成的特点，这使得它在各种编程语言和平台之间的数据传输中变得极为流行。Python 作为一种功能强大且简洁的编程语言，提供了内置的库来轻松读取和处理 JSON 文件。本文将深入探讨在 Python 中读取 JSON 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要技能。

<!-- more -->
## 目录
1. **基础概念**
    - **什么是 JSON 文件**
    - **Python 与 JSON 的关系**
2. **使用方法**
    - **使用 `json` 模块读取 JSON 文件**
    - **处理 JSON 数据中的不同数据类型**
3. **常见实践**
    - **从本地文件读取 JSON 数据**
    - **从网络获取 JSON 数据并读取**
4. **最佳实践**
    - **错误处理与异常管理**
    - **优化 JSON 读取性能**
5. **小结**
6. **参考资料**

## 基础概念
### 什么是 JSON 文件
JSON 是一种基于文本的开放标准格式，它使用人类可读的文本表示数据对象。JSON 文件通常以 `.json` 为扩展名，其结构类似于 Python 中的字典（dictionary）。它由键值对组成，其中键是字符串，值可以是各种数据类型，如字符串、数字、布尔值、数组、对象（另一个 JSON 结构）等。以下是一个简单的 JSON 文件示例：

```json
{
    "name": "John Doe",
    "age": 30,
    "is_student": false,
    "hobbies": ["reading", "swimming"],
    "address": {
        "street": "123 Main St",
        "city": "Anytown",
        "country": "USA"
    }
}
```

### Python 与 JSON 的关系
Python 对 JSON 有很好的支持，通过内置的 `json` 模块可以轻松地将 JSON 数据转换为 Python 对象，反之亦然。在读取 JSON 文件时，`json` 模块将 JSON 数据解析为 Python 的字典或列表对象，使我们能够使用 Python 的强大功能来处理这些数据。

## 使用方法
### 使用 `json` 模块读取 JSON 文件
在 Python 中，`json` 模块提供了 `load()` 函数来读取 JSON 文件并将其解析为 Python 对象。以下是一个基本的示例，展示如何从本地文件读取 JSON 数据：

```python
import json

# 打开 JSON 文件
with open('example.json', 'r', encoding='utf-8') as json_file:
    # 读取文件内容并解析为 Python 对象
    data = json.load(json_file)

# 打印解析后的数据
print(data)
```

在上述代码中：
1. 首先导入 `json` 模块，这是使用 JSON 功能的基础。
2. 使用 `open()` 函数以只读模式打开名为 `example.json` 的文件，并指定编码为 `utf-8`，以确保能够正确处理各种字符。
3. 使用 `json.load()` 函数将文件内容解析为 Python 对象，并将其存储在 `data` 变量中。
4. 最后打印 `data` 变量，输出解析后的 JSON 数据。

### 处理 JSON 数据中的不同数据类型
JSON 支持多种数据类型，当我们读取 JSON 文件后，解析得到的 Python 对象也会包含相应的数据类型。以下是一些常见的数据类型及其在 Python 中的处理方式：

#### 字符串
在 JSON 中，字符串是用双引号包围的文本。解析后，在 Python 中就是普通的字符串类型。例如：

```json
{
    "message": "Hello, World!"
}
```

```python
import json

with open('string_example.json', 'r', encoding='utf-8') as json_file:
    data = json.load(json_file)
    message = data["message"]
    print(message)  # 输出: Hello, World!
```

#### 数字
JSON 中的数字可以是整数或浮点数。在 Python 中，它们会被解析为相应的 `int` 或 `float` 类型。例如：

```json
{
    "count": 10,
    "price": 9.99
}
```

```python
import json

with open('number_example.json', 'r', encoding='utf-8') as json_file:
    data = json.load(json_file)
    count = data["count"]
    price = data["price"]
    print(count, price)  # 输出: 10 9.99
```

#### 布尔值
JSON 中的布尔值 `true` 和 `false` 在 Python 中会被解析为 `True` 和 `False`。例如：

```json
{
    "is_active": true
}
```

```python
import json

with open('boolean_example.json', 'r', encoding='utf-8') as json_file:
    data = json.load(json_file)
    is_active = data["is_active"]
    print(is_active)  # 输出: True
```

#### 数组
JSON 中的数组在 Python 中被解析为列表。例如：

```json
{
    "fruits": ["apple", "banana", "cherry"]
}
```

```python
import json

with open('array_example.json', 'r', encoding='utf-8') as json_file:
    data = json.load(json_file)
    fruits = data["fruits"]
    for fruit in fruits:
        print(fruit) 
    # 输出:
    # apple
    # banana
    # cherry
```

#### 对象
JSON 中的对象在 Python 中被解析为字典。例如：

```json
{
    "person": {
        "name": "Alice",
        "age": 25
    }
}
```

```python
import json

with open('object_example.json', 'r', encoding='utf-8') as json_file:
    data = json.load(json_file)
    person = data["person"]
    name = person["name"]
    age = person["age"]
    print(name, age)  # 输出: Alice 25
```

## 常见实践
### 从本地文件读取 JSON 数据
在实际开发中，经常需要从本地文件读取 JSON 数据。除了前面提到的基本示例，还可以进行更复杂的操作，比如处理多层嵌套的 JSON 结构。

```json
{
    "students": [
        {
            "name": "Tom",
            "age": 20,
            "grades": {
                "math": 90,
                "english": 85
            }
        },
        {
            "name": "Jerry",
            "age": 21,
            "grades": {
                "math": 88,
                "english": 92
            }
        }
    ]
}
```

```python
import json

with open('students.json', 'r', encoding='utf-8') as json_file:
    data = json.load(json_file)
    for student in data["students"]:
        name = student["name"]
        age = student["age"]
        math_grade = student["grades"]["math"]
        english_grade = student["grades"]["english"]
        print(f"Name: {name}, Age: {age}, Math Grade: {math_grade}, English Grade: {english_grade}")

# 输出:
# Name: Tom, Age: 20, Math Grade: 90, English Grade: 85
# Name: Jerry, Age: 21, Math Grade: 88, English Grade: 92
```

### 从网络获取 JSON 数据并读取
在许多情况下，我们需要从网络 API 中获取 JSON 数据。可以使用 `requests` 库来发送 HTTP 请求并获取响应，然后使用 `json` 模块解析响应数据。

首先，安装 `requests` 库（如果尚未安装）：
```bash
pip install requests
```

以下是一个示例，从一个公开的 API 获取 JSON 数据并解析：

```python
import requests
import json

url = "https://jsonplaceholder.typicode.com/todos/1"
response = requests.get(url)

if response.status_code == 200:
    data = json.loads(response.text)
    print(data)
else:
    print(f"Error: {response.status_code}")

# 输出示例（根据 API 返回数据）：
# {'userId': 1, 'id': 1, 'title': 'delectus aut autem', 'completed': false}
```

在上述代码中：
1. 使用 `requests.get()` 函数发送 GET 请求到指定的 URL。
2. 检查响应的状态码，如果状态码为 200，表示请求成功。
3. 使用 `json.loads()` 函数将响应的文本内容解析为 Python 对象，因为 `requests` 获取的响应是字符串形式。

## 最佳实践
### 错误处理与异常管理
在读取 JSON 文件或处理 JSON 数据时，可能会遇到各种错误，如文件不存在、JSON 格式错误等。因此，进行适当的错误处理和异常管理是非常重要的。

```python
import json

try:
    with open('nonexistent_file.json', 'r', encoding='utf-8') as json_file:
        data = json.load(json_file)
except FileNotFoundError:
    print("The file was not found.")
except json.JSONDecodeError as e:
    print(f"JSON decoding error: {e}")
```

在上述代码中：
1. 使用 `try - except` 块来捕获可能的异常。
2. `FileNotFoundError` 用于处理文件不存在的情况。
3. `json.JSONDecodeError` 用于处理 JSON 格式错误的情况，通过捕获该异常并打印错误信息，可以帮助我们快速定位和解决问题。

### 优化 JSON 读取性能
对于大型 JSON 文件，读取性能可能会成为一个问题。以下是一些优化建议：
- **逐块读取**：对于非常大的 JSON 文件，可以使用 `json.JSONDecoder` 逐块解析数据，而不是一次性读取整个文件。

```python
import json

def read_large_json(file_path):
    decoder = json.JSONDecoder()
    buffer = ""
    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            buffer += line
            while buffer:
                try:
                    obj, pos = decoder.raw_decode(buffer)
                    buffer = buffer[pos:].lstrip()
                    yield obj
                except json.JSONDecodeError:
                    break

for data in read_large_json('large_file.json'):
    # 处理每一块 JSON 数据
    print(data)
```

- **使用 `ijson` 库**：`ijson` 是一个用于增量解析 JSON 数据的库，适用于处理超大型 JSON 文件。可以通过以下命令安装：
```bash
pip install ijson
```

使用示例：

```python
import ijson

with open('large_file.json', 'r', encoding='utf-8') as f:
    objects = ijson.items(f, 'item')
    for obj in objects:
        # 处理每一个 JSON 对象
        print(obj)
```

## 小结
在本文中，我们深入探讨了在 Python 中读取 JSON 文件的各个方面。首先介绍了 JSON 文件的基本概念以及 Python 与 JSON 的关系，然后详细讲解了使用 `json` 模块读取 JSON 文件的方法，包括处理不同的数据类型。接着通过实际示例展示了从本地文件和网络获取 JSON 数据的常见实践。最后，我们分享了错误处理、异常管理以及优化 JSON 读取性能的最佳实践。掌握这些知识和技能，将使读者能够更加高效、稳健地处理 JSON 数据，在开发中充分发挥 JSON 的优势。

## 参考资料
- [Python 官方文档 - json 模块](https://docs.python.org/3/library/json.html){: rel="nofollow"}
- [requests 库官方文档](https://requests.readthedocs.io/en/latest/){: rel="nofollow"}
- [ijson 库官方文档](https://pypi.org/project/ijson/){: rel="nofollow"}
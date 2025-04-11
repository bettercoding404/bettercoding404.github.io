---
title: "用 Python 解析 JSON：从基础到最佳实践"
description: "在现代软件开发中，数据交换无处不在，而 JSON（JavaScript Object Notation）作为一种轻量级的数据交换格式，因其简洁性和广泛的兼容性，被广泛应用于各种应用程序之间的数据传输和存储。Python 作为一门功能强大的编程语言，提供了简单而高效的方法来处理 JSON 数据。本文将深入探讨如何在 Python 中解析 JSON 数据，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技能。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在现代软件开发中，数据交换无处不在，而 JSON（JavaScript Object Notation）作为一种轻量级的数据交换格式，因其简洁性和广泛的兼容性，被广泛应用于各种应用程序之间的数据传输和存储。Python 作为一门功能强大的编程语言，提供了简单而高效的方法来处理 JSON 数据。本文将深入探讨如何在 Python 中解析 JSON 数据，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技能。

<!-- more -->
## 目录
1. JSON 基础概念
2. 在 Python 中解析 JSON 的方法
    - 使用 `json` 模块
    - 解析 JSON 字符串
    - 解析 JSON 文件
3. 常见实践
    - 访问 JSON 数据中的值
    - 修改 JSON 数据
    - 将 Python 对象转换为 JSON
4. 最佳实践
    - 错误处理
    - 格式化 JSON 输出
    - 处理大型 JSON 文件
5. 小结
6. 参考资料

## JSON 基础概念
JSON 是一种基于文本的开放标准格式，它以键值对的形式组织数据，类似于 Python 中的字典。JSON 数据结构支持多种数据类型，包括字符串、数字、布尔值、数组、对象（字典）以及 `null`。以下是一个简单的 JSON 示例：
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
在这个示例中，外层是一个 JSON 对象，包含了不同类型的键值对。`hobbies` 是一个 JSON 数组，而 `address` 是一个嵌套的 JSON 对象。

## 在 Python 中解析 JSON 的方法
### 使用 `json` 模块
Python 的标准库中提供了 `json` 模块，用于处理 JSON 数据。要使用该模块，只需在代码开头导入它：
```python
import json
```

### 解析 JSON 字符串
使用 `json.loads()` 方法可以将 JSON 格式的字符串解析为 Python 对象。例如：
```python
import json

json_str = '{"name": "John Doe", "age": 30, "is_student": false}'
data = json.loads(json_str)
print(data)
print(type(data))  
```
在上述代码中，`json.loads()` 将 JSON 字符串转换为一个 Python 字典，打印结果将显示字典内容，并且 `type(data)` 会返回 `<class 'dict'>`。

### 解析 JSON 文件
如果 JSON 数据存储在文件中，可以使用 `json.load()` 方法来解析。假设我们有一个名为 `data.json` 的文件，内容如下：
```json
{
    "name": "Jane Smith",
    "age": 25,
    "is_student": true,
    "hobbies": ["dancing", "painting"]
}
```
可以使用以下代码解析该文件：
```python
import json

with open('data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    print(data)
```
`json.load()` 方法从打开的文件对象中读取 JSON 数据并将其转换为 Python 对象。

## 常见实践
### 访问 JSON 数据中的值
一旦将 JSON 数据解析为 Python 对象（通常是字典或列表），就可以像访问普通 Python 对象一样访问其中的值。对于字典类型的 JSON 数据，可以使用键来获取对应的值：
```python
import json

json_str = '{"name": "John Doe", "age": 30, "is_student": false}'
data = json.loads(json_str)

print(data["name"])  
print(data["age"])  
```
如果 JSON 数据包含嵌套结构，例如数组或嵌套对象，可以通过多层索引来访问值：
```python
import json

json_str = '{"name": "John Doe", "hobbies": ["reading", "swimming"], "address": {"city": "Anytown"}}'
data = json.loads(json_str)

print(data["hobbies"][0])  
print(data["address"]["city"])  
```

### 修改 JSON 数据
可以像修改普通 Python 对象一样修改解析后的 JSON 数据。例如，修改上面示例中的年龄：
```python
import json

json_str = '{"name": "John Doe", "age": 30, "is_student": false}'
data = json.loads(json_str)

data["age"] = 31
print(data)
```

### 将 Python 对象转换为 JSON
使用 `json.dumps()` 方法可以将 Python 对象转换为 JSON 格式的字符串。例如：
```python
import json

python_dict = {"name": "Alice", "age": 28, "is_student": true}
json_str = json.dumps(python_dict)
print(json_str)
```
`json.dumps()` 还支持一些参数，如 `indent` 用于格式化输出，使 JSON 字符串更易读：
```python
import json

python_dict = {"name": "Alice", "age": 28, "is_student": true}
json_str = json.dumps(python_dict, indent=4)
print(json_str)
```

## 最佳实践
### 错误处理
在解析 JSON 数据时，可能会遇到格式不正确的情况。因此，进行错误处理是很重要的。可以使用 `try-except` 块来捕获并处理 `json.JSONDecodeError` 异常：
```python
import json

json_str = '{"name": "John Doe", age": 30, "is_student": false}'  # 故意写错格式

try:
    data = json.loads(json_str)
except json.JSONDecodeError as e:
    print(f"解析 JSON 时出错: {e}")
```

### 格式化 JSON 输出
为了使 JSON 数据更易读和调试，可以使用 `json.dumps()` 的 `indent` 参数进行格式化。此外，`sort_keys=True` 参数可以按字母顺序对键进行排序：
```python
import json

python_dict = {"c": 3, "a": 1, "b": 2}
json_str = json.dumps(python_dict, indent=4, sort_keys=True)
print(json_str)
```

### 处理大型 JSON 文件
对于大型 JSON 文件，一次性将整个文件读入内存可能会导致内存不足。可以使用迭代器逐块读取和处理 JSON 数据。例如，使用 `ijson` 库：
```bash
pip install ijson
```
```python
import ijson

with open('large_file.json', 'r', encoding='utf-8') as f:
    parser = ijson.parse(f)
    for prefix, event, value in parser:
        if event =='map_key':
            key = value
        elif event == 'end_map':
            # 处理一个 JSON 对象
            pass
```

## 小结
本文全面介绍了在 Python 中解析 JSON 的相关知识，从 JSON 的基础概念入手，详细讲解了使用 `json` 模块解析 JSON 字符串和文件的方法，展示了常见的访问、修改 JSON 数据以及将 Python 对象转换为 JSON 的实践，最后分享了错误处理、格式化输出和处理大型 JSON 文件的最佳实践。掌握这些技能将使读者在处理 JSON 数据时更加得心应手，提高开发效率。

## 参考资料
- [Python 官方文档 - json 模块](https://docs.python.org/3/library/json.html){: rel="nofollow"}
- [ijson 库官方文档](https://pypi.org/project/ijson/){: rel="nofollow"}
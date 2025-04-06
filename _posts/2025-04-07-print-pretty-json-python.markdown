---
title: "深入探索 Python 中漂亮打印 JSON 数据"
description: "在处理 JSON 数据时，原始的 JSON 格式通常是紧凑且难以阅读的。在 Python 中，“print pretty json”指的是将 JSON 数据以一种更易读、更美观的格式打印出来。这对于调试、分析数据以及与他人共享数据结构等场景非常有用。本文将详细介绍如何在 Python 中实现漂亮打印 JSON 数据。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在处理 JSON 数据时，原始的 JSON 格式通常是紧凑且难以阅读的。在 Python 中，“print pretty json”指的是将 JSON 数据以一种更易读、更美观的格式打印出来。这对于调试、分析数据以及与他人共享数据结构等场景非常有用。本文将详细介绍如何在 Python 中实现漂亮打印 JSON 数据。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `json` 模块
    - 使用 `pprint` 模块
3. 常见实践
    - 处理文件中的 JSON 数据
    - 处理 API 响应中的 JSON 数据
4. 最佳实践
    - 定制格式化选项
    - 处理大型 JSON 数据
5. 小结
6. 参考资料

## 基础概念
JSON（JavaScript Object Notation）是一种轻量级的数据交换格式，它基于 JavaScript 语言的一个子集。JSON 数据以键值对的形式表示，使用花括号 `{}` 表示对象，方括号 `[]` 表示数组。例如：

```json
{
    "name": "John",
    "age": 30,
    "city": "New York",
    "hobbies": ["reading", "swimming"]
}
```

在 Python 中，我们可以使用 `json` 模块来处理 JSON 数据。`json` 模块提供了将 Python 对象转换为 JSON 字符串（序列化）以及将 JSON 字符串转换为 Python 对象（反序列化）的函数。

## 使用方法

### 使用 `json` 模块
Python 的 `json` 模块提供了 `dump()` 和 `dumps()` 函数来格式化 JSON 数据。`dump()` 函数用于将 JSON 数据写入文件，`dumps()` 函数用于将 Python 对象转换为格式化的 JSON 字符串。

```python
import json

data = {
    "name": "John",
    "age": 30,
    "city": "New York",
    "hobbies": ["reading", "swimming"]
}

# 使用 json.dumps() 进行漂亮打印
formatted_json = json.dumps(data, indent=4, sort_keys=True)
print(formatted_json)
```

在上述代码中：
- `json.dumps()` 函数的第一个参数是要转换的 Python 对象。
- `indent` 参数指定缩进的空格数，这里设置为 4，使 JSON 数据有更好的层次结构显示。
- `sort_keys=True` 表示按键名排序，使输出更具一致性。

### 使用 `pprint` 模块
`pprint` 模块（pretty print）提供了更美观的打印方式，它不仅适用于 JSON 数据，还能处理其他复杂的 Python 数据结构。

```python
import json
from pprint import pprint

data = {
    "name": "John",
    "age": 30,
    "city": "New York",
    "hobbies": ["reading", "swimming"]
}

# 先将 Python 对象转换为 JSON 字符串，再解析为 Python 对象进行漂亮打印
parsed_data = json.loads(json.dumps(data))
pprint(parsed_data)
```

`pprint` 模块的 `pprint()` 函数会自动对数据进行格式化，使输出更易读。不过需要注意的是，`pprint` 模块本身不直接支持 JSON 数据，所以我们先将 Python 对象转换为 JSON 字符串，再解析回 Python 对象，然后使用 `pprint` 进行打印。

## 常见实践

### 处理文件中的 JSON 数据
假设我们有一个包含 JSON 数据的文件，我们可以读取文件内容并进行漂亮打印。

```python
import json

# 读取文件内容
with open('data.json', 'r') as file:
    json_data = json.load(file)

# 漂亮打印 JSON 数据
formatted_json = json.dumps(json_data, indent=4, sort_keys=True)
print(formatted_json)
```

在上述代码中：
- 使用 `open()` 函数以只读模式打开 JSON 文件。
- `json.load()` 函数将文件内容解析为 Python 对象。
- 然后使用 `json.dumps()` 函数对解析后的对象进行漂亮打印。

### 处理 API 响应中的 JSON 数据
在与 API 交互时，我们通常会得到 JSON 格式的响应。以下是处理 API 响应并漂亮打印 JSON 数据的示例：

```python
import json
import requests

# 发送 API 请求
response = requests.get('https://api.example.com/data')

if response.status_code == 200:
    json_data = response.json()
    formatted_json = json.dumps(json_data, indent=4, sort_keys=True)
    print(formatted_json)
else:
    print(f"请求失败，状态码: {response.status_code}")
```

在上述代码中：
- 使用 `requests` 库发送 GET 请求到 API 端点。
- 如果响应状态码为 200，表示请求成功，使用 `response.json()` 方法将响应内容解析为 Python 对象。
- 然后对解析后的对象进行漂亮打印。

## 最佳实践

### 定制格式化选项
除了基本的缩进和按键名排序，`json.dumps()` 还支持其他格式化选项。例如，我们可以设置 `separators` 参数来指定键值对和元素之间的分隔符。

```python
import json

data = {
    "name": "John",
    "age": 30,
    "city": "New York",
    "hobbies": ["reading", "swimming"]
}

# 定制分隔符
formatted_json = json.dumps(data, indent=4, sort_keys=True, separators=(',', ': '))
print(formatted_json)
```

在上述代码中，`separators=(',', ': ')` 表示使用逗号和空格来分隔 JSON 元素，使用冒号和空格来分隔键值对。

### 处理大型 JSON 数据
对于大型 JSON 数据，一次性加载和打印可能会导致内存问题。我们可以逐行处理 JSON 数据。

```python
import json

# 逐行处理大型 JSON 文件
with open('large_data.json', 'r') as file:
    for line in file:
        try:
            json_obj = json.loads(line)
            formatted_json = json.dumps(json_obj, indent=4, sort_keys=True)
            print(formatted_json)
        except json.JSONDecodeError:
            print(f"解析 JSON 时出错: {line}")
```

在上述代码中：
- 逐行读取大型 JSON 文件。
- 使用 `json.loads()` 函数解析每一行数据。
- 对解析后的对象进行漂亮打印，并处理可能的 JSON 解析错误。

## 小结
在 Python 中，漂亮打印 JSON 数据可以通过 `json` 模块和 `pprint` 模块来实现。`json` 模块提供了简单直接的方式来格式化 JSON 数据，而 `pprint` 模块则能处理更复杂的数据结构。在实际应用中，我们可以根据具体需求定制格式化选项，并采用合适的方法处理大型 JSON 数据。掌握这些技巧将有助于我们更高效地处理和分析 JSON 数据。

## 参考资料
- [Python 官方文档 - json 模块](https://docs.python.org/3/library/json.html){: rel="nofollow"}
- [Python 官方文档 - pprint 模块](https://docs.python.org/3/library/pprint.html){: rel="nofollow"}
- [requests 库官方文档](https://requests.readthedocs.io/en/latest/){: rel="nofollow"}
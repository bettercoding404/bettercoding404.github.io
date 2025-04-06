---
title: "Python 中漂亮打印 JSON 的技巧与实践"
description: "在处理 JSON 数据时，原始的 JSON 格式可能非常紧凑且难以阅读，特别是当数据结构复杂时。“漂亮打印（Pretty Print）” JSON 能够以一种更易读、层次分明的格式展示 JSON 数据，这对于调试、分析和理解数据内容极为有帮助。Python 提供了强大的工具和方法来实现 JSON 的漂亮打印，本文将深入探讨这些技术。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在处理 JSON 数据时，原始的 JSON 格式可能非常紧凑且难以阅读，特别是当数据结构复杂时。“漂亮打印（Pretty Print）” JSON 能够以一种更易读、层次分明的格式展示 JSON 数据，这对于调试、分析和理解数据内容极为有帮助。Python 提供了强大的工具和方法来实现 JSON 的漂亮打印，本文将深入探讨这些技术。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `json.dumps` 进行漂亮打印**
    - **使用 `pprint` 模块**
3. **常见实践**
    - **处理文件中的 JSON 数据**
    - **与 API 响应数据结合**
4. **最佳实践**
    - **设置合适的缩进**
    - **处理大型 JSON 数据**
5. **小结**
6. **参考资料**

## 基础概念
JSON（JavaScript Object Notation）是一种轻量级的数据交换格式，它以键值对的形式存储数据，广泛应用于 Web 开发和数据传输中。Python 内置了 `json` 模块来处理 JSON 数据。漂亮打印 JSON 意味着将原本紧凑的 JSON 字符串转换为具有适当缩进、换行和格式化的文本，使得数据结构一目了然。

## 使用方法
### 使用 `json.dumps` 进行漂亮打印
Python 的 `json` 模块中的 `dumps` 函数可以将 Python 对象转换为 JSON 字符串。通过设置一些参数，我们可以实现漂亮打印。

```python
import json

data = {
    "name": "Alice",
    "age": 30,
    "city": "New York",
    "hobbies": ["reading", "painting", "dancing"]
}

# 使用 json.dumps 进行漂亮打印
pretty_json = json.dumps(data, indent=4, sort_keys=True)
print(pretty_json)
```

在上述代码中：
- `json.dumps(data)` 将 Python 字典 `data` 转换为 JSON 字符串。
- `indent=4` 参数指定了缩进的空格数为 4，这使得 JSON 数据的层次结构更加清晰。
- `sort_keys=True` 参数表示按键的字母顺序对 JSON 数据进行排序，这在数据量较大时有助于查找和比较。

### 使用 `pprint` 模块
`pprint` 模块（Pretty Printer）提供了一个 `pprint` 函数，用于更美观地打印 Python 数据结构，包括可以间接用于打印 JSON 数据。首先，我们需要将 JSON 字符串转换为 Python 对象，然后使用 `pprint` 打印。

```python
import json
from pprint import pprint

json_str = '{"name": "Bob", "age": 25, "city": "Los Angeles", "hobbies": ["swimming", "cycling"]}'
data = json.loads(json_str)

pprint(data)
```

在这段代码中：
- `json.loads(json_str)` 将 JSON 字符串转换为 Python 字典。
- `pprint(data)` 以一种更易读的格式打印出 Python 字典，这种格式也很适合查看类似 JSON 结构的数据。

## 常见实践
### 处理文件中的 JSON 数据
在实际应用中，我们常常需要从文件中读取 JSON 数据并进行漂亮打印。

```python
import json

try:
    with open('data.json', 'r') as file:
        data = json.load(file)
        pretty_json = json.dumps(data, indent=4, sort_keys=True)
        print(pretty_json)
except FileNotFoundError:
    print("文件未找到")
except json.JSONDecodeError:
    print("JSON 解码错误")
```

在这个示例中：
- `with open('data.json', 'r') as file` 打开名为 `data.json` 的文件进行读取。
- `json.load(file)` 将文件中的 JSON 数据加载为 Python 对象。
- 然后使用 `json.dumps` 对加载的数据进行漂亮打印，并处理了可能出现的文件未找到和 JSON 解码错误。

### 与 API 响应数据结合
当从 API 获取 JSON 格式的响应数据时，漂亮打印可以帮助我们快速了解数据结构。

```python
import json
import requests

url = "https://api.example.com/data"
response = requests.get(url)

if response.status_code == 200:
    data = response.json()
    pretty_json = json.dumps(data, indent=4, sort_keys=True)
    print(pretty_json)
else:
    print(f"请求失败，状态码: {response.status_code}")
```

在这个代码片段中：
- `requests.get(url)` 发送 GET 请求到指定的 API 端点。
- `response.json()` 将 API 响应的 JSON 数据转换为 Python 对象。
- 接着使用 `json.dumps` 对数据进行漂亮打印，并根据响应状态码判断请求是否成功。

## 最佳实践
### 设置合适的缩进
在使用 `json.dumps` 时，根据数据的复杂程度选择合适的缩进值。对于简单的数据结构，2 个空格的缩进可能就足够了；对于复杂的嵌套结构，4 个或更多空格的缩进能更好地展示层次关系。

```python
# 简单结构，缩进 2 个空格
data_simple = {"key": "value"}
pretty_simple = json.dumps(data_simple, indent=2)
print(pretty_simple)

# 复杂结构，缩进 4 个空格
data_complex = {
    "outer_key": {
        "inner_key1": [1, 2, 3],
        "inner_key2": {
            "sub_key1": "sub_value1",
            "sub_key2": "sub_value2"
        }
    }
}
pretty_complex = json.dumps(data_complex, indent=4)
print(pretty_complex)
```

### 处理大型 JSON 数据
对于非常大的 JSON 数据，一次性加载和打印可能会占用大量内存。可以考虑分块读取和处理数据。例如，使用 `ijson` 库进行增量解析。

```python
import ijson

with open('large_data.json', 'r') as file:
    parser = ijson.parse(file)
    for prefix, event, value in parser:
        if event =='map_key':
            print(f"{prefix}{value}:")
        elif event == 'end_map' or event == 'end_array':
            print("")
        elif event not in ['map_key', 'end_map', 'end_array']:
            print(f"  {value}")
```

在这个示例中，`ijson.parse` 以增量方式解析 JSON 文件，减少了内存占用。

## 小结
在 Python 中漂亮打印 JSON 数据是一项非常实用的技能，无论是在开发过程中的调试，还是对数据进行分析理解。通过 `json.dumps` 和 `pprint` 模块等工具，我们可以轻松实现 JSON 数据的格式化输出。在实际应用中，根据数据的特点和使用场景，选择合适的方法和参数，能够更高效地处理和展示 JSON 数据。

## 参考资料
- [Python 官方文档 - json 模块](https://docs.python.org/3/library/json.html){: rel="nofollow"}
- [Python 官方文档 - pprint 模块](https://docs.python.org/3/library/pprint.html){: rel="nofollow"}
- [ijson 库文档](https://pypi.org/project/ijson/){: rel="nofollow"}
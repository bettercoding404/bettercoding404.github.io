---
title: "Python 中漂亮打印字典（Pretty Print Dict）"
description: "在 Python 编程中，字典（dictionary）是一种非常常用的数据结构，用于存储键值对。当我们需要查看字典的内容时，普通的打印方式可能会导致输出格式不美观、难以阅读，尤其是对于嵌套较深或者内容较多的字典。这时候，“漂亮打印（Pretty Print）”字典就显得尤为重要，它能够以一种更加整齐、易读的格式展示字典内容，方便我们调试代码和理解数据结构。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常常用的数据结构，用于存储键值对。当我们需要查看字典的内容时，普通的打印方式可能会导致输出格式不美观、难以阅读，尤其是对于嵌套较深或者内容较多的字典。这时候，“漂亮打印（Pretty Print）”字典就显得尤为重要，它能够以一种更加整齐、易读的格式展示字典内容，方便我们调试代码和理解数据结构。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `pprint` 模块
    - 使用 `json` 模块
3. 常见实践
    - 打印嵌套字典
    - 控制缩进和格式
4. 最佳实践
    - 根据需求选择合适的模块
    - 自定义格式化输出
5. 小结
6. 参考资料

## 基础概念
“漂亮打印” 简单来说，就是将数据以一种格式化的、易于人类阅读的方式展示出来。对于字典而言，普通的 `print()` 函数输出的字典可能是一行紧凑的文本，所有的键值对都挤在一起，难以快速分辨不同的键值对和层次结构。而漂亮打印则会将字典的内容进行分行、缩进等处理，使得每个键值对都清晰可见，嵌套的字典也能有明显的层次区分。

## 使用方法

### 使用 `pprint` 模块
`pprint` 模块（pretty printer）是 Python 标准库的一部分，专门用于漂亮打印数据结构。以下是使用 `pprint` 模块打印字典的基本示例：

```python
import pprint

my_dict = {
    "name": "Alice",
    "age": 30,
    "city": "New York",
    "hobbies": ["reading", "painting", "dancing"]
}

pprint.pprint(my_dict)
```

在上述代码中：
1. 首先导入 `pprint` 模块。
2. 定义一个字典 `my_dict`。
3. 使用 `pprint.pprint()` 函数来打印字典，该函数会自动对字典进行格式化输出，使得每个键值对独占一行，看起来更加清晰。

### 使用 `json` 模块
`json` 模块主要用于处理 JSON 数据，但也可以用来漂亮打印字典。不过需要注意的是，字典中的键必须是字符串类型才能使用 `json` 模块进行格式化打印（JSON 数据要求键为字符串）。示例代码如下：

```python
import json

my_dict = {
    "name": "Bob",
    "age": 25,
    "city": "Los Angeles",
    "hobbies": ["swimming", "cycling"]
}

print(json.dumps(my_dict, indent=4))
```

在这段代码中：
1. 导入 `json` 模块。
2. 使用 `json.dumps()` 函数将字典转换为 JSON 格式的字符串，并通过 `indent` 参数指定缩进的空格数为 4。这样输出的结果就会有明显的缩进，看起来更加美观。

## 常见实践

### 打印嵌套字典
实际应用中，字典常常包含嵌套结构，例如字典中包含字典或列表。使用 `pprint` 模块可以很好地处理这种情况。以下是一个嵌套字典的示例：

```python
import pprint

nested_dict = {
    "person1": {
        "name": "Alice",
        "age": 30,
        "address": {
            "street": "123 Main St",
            "city": "New York",
            "state": "NY"
        }
    },
    "person2": {
        "name": "Bob",
        "age": 25,
        "address": {
            "street": "456 Elm St",
            "city": "Los Angeles",
            "state": "CA"
        }
    }
}

pprint.pprint(nested_dict)
```

上述代码中，`nested_dict` 是一个包含两个子字典的字典，每个子字典又包含了嵌套的地址字典。`pprint.pprint()` 函数能够自动对这种嵌套结构进行格式化，使得层次分明，易于阅读。

### 控制缩进和格式
`pprint` 模块还提供了一些参数来控制缩进和其他格式选项。例如，可以使用 `width` 参数来指定每行输出的最大宽度，使用 `depth` 参数来限制打印的嵌套深度。示例如下：

```python
import pprint

my_complex_dict = {
    "key1": "value1",
    "key2": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    "key3": {
        "sub_key1": "sub_value1",
        "sub_key2": {
            "nested_sub_key1": "nested_sub_value1",
            "nested_sub_key2": "nested_sub_value2"
        }
    }
}

pprint.pprint(my_complex_dict, width=40, depth=2)
```

在这个示例中：
- `width=40` 表示每行输出的最大宽度为 40 个字符，当内容超过这个宽度时会自动换行。
- `depth=2` 表示只打印到嵌套层次为 2 的内容，更深层次的内容会被省略，这样可以避免输出过于复杂的内容。

## 最佳实践

### 根据需求选择合适的模块
如果只是简单地需要漂亮打印 Python 字典，并且字典的键可以是任意类型，`pprint` 模块是一个很好的选择，它功能强大且使用方便。

如果需要将字典转换为 JSON 格式的字符串（例如，用于与其他支持 JSON 的系统进行数据交互），那么 `json` 模块更合适。虽然 `json` 模块对字典键有一定要求，但它可以方便地将字典转换为符合 JSON 规范的字符串，并且在网络传输和数据存储等场景中广泛应用。

### 自定义格式化输出
对于一些特殊的需求，标准库提供的功能可能无法完全满足。这时候可以考虑自定义格式化输出。例如，如果你希望对字典的键值对进行特定的颜色标记或者添加额外的注释，可以编写自己的格式化函数。以下是一个简单的示例，使用 ANSI 转义序列来为字典的键添加颜色：

```python
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def custom_pprint(dictionary):
    for key, value in dictionary.items():
        print(f"{bcolors.OKBLUE}{key}{bcolors.ENDC}: {value}")


my_dict = {
    "name": "Charlie",
    "age": 28,
    "city": "Chicago"
}

custom_pprint(my_dict)
```

在上述代码中：
1. 定义了一个 `bcolors` 类，用于存储 ANSI 转义序列，这些序列可以用来设置文本的颜色。
2. 编写了 `custom_pprint` 函数，该函数遍历字典的键值对，并使用 ANSI 转义序列为键添加蓝色，然后打印键值对。

这种自定义的方式可以根据具体需求灵活地对字典进行格式化输出。

## 小结
在 Python 中，漂亮打印字典是一项非常实用的技能，能够帮助我们更高效地调试代码和理解数据结构。通过 `pprint` 模块和 `json` 模块，我们可以轻松地实现字典的格式化输出。在实际应用中，要根据具体需求选择合适的方法，并且可以通过自定义格式化函数来满足特殊的要求。希望本文的介绍能帮助读者更好地掌握 Python 中漂亮打印字典的技巧。

## 参考资料
- [Python 官方文档 - pprint 模块](https://docs.python.org/3/library/pprint.html){: rel="nofollow"}
- [Python 官方文档 - json 模块](https://docs.python.org/3/library/json.html){: rel="nofollow"}
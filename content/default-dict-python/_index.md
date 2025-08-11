---
title: "深入理解 Python 中的 defaultdict"
description: "在 Python 编程中，字典（`dict`）是一种非常常用的数据结构，用于存储键值对。然而，在处理一些特定场景时，标准的字典可能会显得不够灵活。`defaultdict` 作为 `collections` 模块中的一员，为我们提供了更便捷、高效的字典操作方式。本文将详细介绍 `defaultdict` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大的工具。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，字典（`dict`）是一种非常常用的数据结构，用于存储键值对。然而，在处理一些特定场景时，标准的字典可能会显得不够灵活。`defaultdict` 作为 `collections` 模块中的一员，为我们提供了更便捷、高效的字典操作方式。本文将详细介绍 `defaultdict` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大的工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **创建 `defaultdict`**
    - **访问和修改元素**
3. **常见实践**
    - **统计元素出现次数**
    - **分组数据**
4. **最佳实践**
    - **选择合适的默认值类型**
    - **避免不必要的默认值创建**
5. **小结**
6. **参考资料**

## 基础概念
`defaultdict` 是 Python 标准库 `collections` 模块中的一个类，它继承自内置的 `dict` 类。与普通字典不同的是，`defaultdict` 在访问一个不存在的键时，会自动创建一个默认值。这个默认值是通过一个用户提供的可调用对象（例如函数）来生成的。这样可以避免在每次访问新键时手动检查键是否存在并初始化值的繁琐操作。

## 使用方法

### 创建 `defaultdict`
要创建一个 `defaultdict`，首先需要导入 `collections` 模块中的 `defaultdict` 类。然后，在创建 `defaultdict` 对象时，需要传入一个可调用对象作为默认值生成器。以下是创建 `defaultdict` 的基本语法：

```python
from collections import defaultdict

# 创建一个默认值为 0 的 defaultdict
dd = defaultdict(int)

# 创建一个默认值为列表的 defaultdict
dd_list = defaultdict(list)

# 创建一个默认值为字典的 defaultdict
dd_dict = defaultdict(dict)
```

在上述代码中，`int`、`list` 和 `dict` 都是可调用对象，它们分别用于生成默认值 0、空列表和空字典。

### 访问和修改元素
访问 `defaultdict` 中的元素与普通字典类似，使用方括号 `[]` 加上键名即可。如果键不存在，`defaultdict` 会自动调用默认值生成器来创建默认值，并将其作为该键的值返回。

```python
from collections import defaultdict

dd = defaultdict(int)

# 访问不存在的键
value = dd['new_key']
print(value)  # 输出 0

# 修改键的值
dd['new_key'] = 10
print(dd['new_key'])  # 输出 10
```

在上述代码中，当访问 `dd['new_key']` 时，由于 `new_key` 不存在，`defaultdict` 会自动调用 `int()` 生成默认值 0。之后，可以像普通字典一样修改该键的值。

## 常见实践

### 统计元素出现次数
`defaultdict` 在统计元素出现次数的场景中非常实用。可以使用 `defaultdict(int)` 来创建一个字典，其默认值为 0。每次遇到一个元素，就将其对应的值加 1。

```python
from collections import defaultdict

words = ['apple', 'banana', 'apple', 'cherry', 'banana', 'cherry']

word_count = defaultdict(int)
for word in words:
    word_count[word] += 1

for word, count in word_count.items():
    print(f'{word}: {count}')
```

在上述代码中，`word_count` 是一个 `defaultdict(int)`，每次遍历到一个单词，就将其在字典中的值加 1。最终输出每个单词及其出现的次数。

### 分组数据
使用 `defaultdict(list)` 可以方便地对数据进行分组。例如，将一个列表中的数字按照奇偶性进行分组。

```python
from collections import defaultdict

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

grouped_numbers = defaultdict(list)
for num in numbers:
    if num % 2 == 0:
        grouped_numbers['even'].append(num)
    else:
        grouped_numbers['odd'].append(num)

print(grouped_numbers['even'])  # 输出 [2, 4, 6, 8, 10]
print(grouped_numbers['odd'])   # 输出 [1, 3, 5, 7, 9]
```

在上述代码中，`grouped_numbers` 是一个 `defaultdict(list)`，遍历 `numbers` 列表时，根据数字的奇偶性将其添加到对应的列表中。

## 最佳实践

### 选择合适的默认值类型
在使用 `defaultdict` 时，要根据实际需求选择合适的默认值类型。例如，如果需要统计次数，选择 `int` 作为默认值生成器；如果需要分组数据，选择 `list` 作为默认值生成器。选择合适的默认值类型可以简化代码逻辑，提高代码的可读性和效率。

### 避免不必要的默认值创建
虽然 `defaultdict` 会自动创建默认值，但在某些情况下，可能会创建一些不必要的默认值。例如，在统计元素出现次数时，如果只需要统计部分元素的次数，而不是所有可能的元素，那么可以在访问键之前先进行条件判断，避免为不需要统计的元素创建默认值。

```python
from collections import defaultdict

words = ['apple', 'banana', 'apple', 'cherry', 'banana', 'cherry']
target_words = ['apple', 'cherry']

word_count = defaultdict(int)
for word in words:
    if word in target_words:
        word_count[word] += 1

for word, count in word_count.items():
    print(f'{word}: {count}')
```

在上述代码中，只统计 `target_words` 中的单词出现次数，避免了为其他单词创建默认值。

## 小结
`defaultdict` 是 Python 中一个非常实用的数据结构，它在处理字典操作时提供了许多便利。通过自动创建默认值，`defaultdict` 简化了代码逻辑，减少了手动检查键是否存在并初始化值的操作。在实际编程中，合理使用 `defaultdict` 可以提高代码的可读性和效率。希望本文介绍的基础概念、使用方法、常见实践以及最佳实践能够帮助读者更好地理解和运用 `defaultdict`。

## 参考资料
- [Python 官方文档 - collections.defaultdict](https://docs.python.org/3/library/collections.html#collections.defaultdict)
- 《Python 核心编程》
- 《Effective Python》
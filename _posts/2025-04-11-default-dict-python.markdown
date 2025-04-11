---
title: "深入理解 Python 中的 defaultdict"
description: "在 Python 的数据处理中，`defaultdict` 是一个强大且实用的工具，它属于 `collections` 模块。与普通的字典 `dict` 不同，`defaultdict` 能够在访问不存在的键时提供一个默认值，而不会引发 `KeyError`，这大大简化了代码逻辑，尤其在处理需要预先初始化值的情况。本文将全面介绍 `defaultdict` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握和运用这个工具。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 的数据处理中，`defaultdict` 是一个强大且实用的工具，它属于 `collections` 模块。与普通的字典 `dict` 不同，`defaultdict` 能够在访问不存在的键时提供一个默认值，而不会引发 `KeyError`，这大大简化了代码逻辑，尤其在处理需要预先初始化值的情况。本文将全面介绍 `defaultdict` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握和运用这个工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 创建 `defaultdict`
    - 访问和修改 `defaultdict`
3. **常见实践**
    - 统计元素出现次数
    - 分组数据
4. **最佳实践**
    - 选择合适的默认值工厂函数
    - 避免不必要的嵌套
5. **小结**
6. **参考资料**

## 基础概念
`defaultdict` 是 Python 标准库 `collections` 模块中的一个类。它继承自普通的字典类 `dict`，并添加了一个特殊的功能：当访问一个不存在的键时，`defaultdict` 会自动调用一个用户提供的默认值工厂函数来生成一个默认值，并将这个键值对添加到字典中。这个默认值工厂函数可以是任何可调用对象，例如函数、类等。

## 使用方法
### 创建 `defaultdict`
要创建一个 `defaultdict`，需要导入 `collections` 模块，并使用 `defaultdict` 类。`defaultdict` 类的构造函数接受一个参数，即默认值工厂函数。以下是创建一个简单 `defaultdict` 的示例：

```python
from collections import defaultdict

# 创建一个默认值为 0 的 defaultdict
dd = defaultdict(int)
```

在这个例子中，`int` 是默认值工厂函数。由于 `int()` 调用时返回 0，所以当访问不存在的键时，`dd` 会自动为该键创建一个值为 0 的键值对。

### 访问和修改 `defaultdict`
访问和修改 `defaultdict` 的方式与普通字典类似。可以使用方括号 `[]` 来获取或设置值：

```python
from collections import defaultdict

dd = defaultdict(int)

# 访问不存在的键
value = dd['key1']
print(value)  # 输出 0

# 设置键值对
dd['key2'] = 10
print(dd['key2'])  # 输出 10
```

当访问 `dd['key1']` 时，由于 `key1` 不存在，`defaultdict` 会调用 `int()` 生成默认值 0。然后可以像普通字典一样设置和获取键值对。

## 常见实践
### 统计元素出现次数
`defaultdict` 在统计元素出现次数时非常方便。可以将默认值工厂函数设置为 `int`，然后遍历数据，每次遇到一个元素，就将其对应的值加 1。

```python
from collections import defaultdict

data = ['apple', 'banana', 'apple', 'cherry', 'banana']

count = defaultdict(int)
for fruit in data:
    count[fruit] += 1

print(count)  
# 输出: defaultdict(<class 'int'>, {'apple': 2, 'banana': 2, 'cherry': 1})
```

### 分组数据
可以使用 `defaultdict` 将数据按照某个规则进行分组。例如，将一个列表中的数字按照奇偶性分组：

```python
from collections import defaultdict

numbers = [1, 2, 3, 4, 5, 6]

grouped = defaultdict(list)
for num in numbers:
    if num % 2 == 0:
        grouped['even'].append(num)
    else:
        grouped['odd'].append(num)

print(grouped)  
# 输出: defaultdict(<class 'list'>, {'even': [2, 4, 6], 'odd': [1, 3, 5]})
```

## 最佳实践
### 选择合适的默认值工厂函数
根据实际需求选择合适的默认值工厂函数。例如，如果需要一个默认值为列表的 `defaultdict`，可以使用 `list` 作为默认值工厂函数；如果需要一个默认值为字典的 `defaultdict`，可以使用 `dict` 作为默认值工厂函数。

### 避免不必要的嵌套
在使用 `defaultdict` 时，尽量避免不必要的嵌套。例如，如果需要创建一个嵌套的 `defaultdict`，可以考虑使用一个更简单的数据结构或者函数来实现相同的功能。

## 小结
`defaultdict` 是 Python 中一个非常实用的工具，它能够简化代码逻辑，减少处理不存在键时的错误。通过理解其基础概念、掌握使用方法，并运用常见实践和最佳实践，你可以在数据处理和编程中更加高效地使用 `defaultdict`。

## 参考资料
- [Python 官方文档 - collections.defaultdict](https://docs.python.org/3/library/collections.html#collections.defaultdict){: rel="nofollow"}
- 《Python 核心编程》
- 《Effective Python》
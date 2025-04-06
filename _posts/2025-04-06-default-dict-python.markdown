---
title: "Python中的`defaultdict`：深入理解与高效运用"
description: "在Python编程中，字典（`dict`）是一种极为常用的数据结构，用于存储键值对。然而，当访问一个不存在的键时，标准字典会引发`KeyError`。`defaultdict`作为Python标准库`collections`模块中的一员，为解决这一问题提供了便利。它能在访问不存在的键时，自动为其创建一个默认值，从而简化了代码逻辑，提高了编程效率。本文将详细介绍`defaultdict`的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大工具。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，字典（`dict`）是一种极为常用的数据结构，用于存储键值对。然而，当访问一个不存在的键时，标准字典会引发`KeyError`。`defaultdict`作为Python标准库`collections`模块中的一员，为解决这一问题提供了便利。它能在访问不存在的键时，自动为其创建一个默认值，从而简化了代码逻辑，提高了编程效率。本文将详细介绍`defaultdict`的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一强大工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **创建`defaultdict`对象**
    - **访问和修改`defaultdict`中的元素**
3. **常见实践**
    - **统计元素出现次数**
    - **分组数据**
4. **最佳实践**
    - **选择合适的默认值类型**
    - **避免不必要的默认值创建**
5. **小结**
6. **参考资料**

## 基础概念
`defaultdict`是`collections`模块中的一个类，它继承自内置的`dict`类。与普通字典不同的是，`defaultdict`在实例化时需要传入一个可调用对象（如函数、类等）作为默认值工厂。当访问一个不存在的键时，`defaultdict`会调用这个默认值工厂来生成一个默认值，并将其作为该键的值存储在字典中。这样，后续对该键的操作就如同对已存在的键一样。

## 使用方法

### 创建`defaultdict`对象
要创建一个`defaultdict`对象，首先需要导入`collections`模块，然后调用`defaultdict`类，并传入默认值工厂。以下是创建一个默认值为0的`defaultdict`对象的示例：

```python
from collections import defaultdict

# 创建一个默认值为0的defaultdict
dd = defaultdict(int)
```

在上述代码中，`int`作为默认值工厂被传入`defaultdict`。由于`int()`调用时返回0，所以当访问不存在的键时，`defaultdict`会自动为其创建一个值为0的键值对。

除了使用内置类型作为默认值工厂，也可以使用自定义函数。例如，创建一个默认值为列表的`defaultdict`：

```python
from collections import defaultdict

def create_list():
    return []

# 创建一个默认值为列表的defaultdict
dd = defaultdict(create_list)
```

### 访问和修改`defaultdict`中的元素
访问和修改`defaultdict`中的元素与普通字典的操作方式基本相同。可以通过键来获取对应的值，也可以为键赋值。当访问一个不存在的键时，`defaultdict`会自动创建默认值并返回。

```python
from collections import defaultdict

dd = defaultdict(int)

# 访问不存在的键
value = dd['key1']  
print(value)  # 输出: 0

# 为键赋值
dd['key2'] = 2
print(dd['key2'])  # 输出: 2
```

在上述代码中，访问`dd['key1']`时，由于`key1`不存在，`defaultdict`自动调用`int()`生成默认值0并返回。而对`dd['key2']`进行赋值后，再访问该键就能得到正确的值。

## 常见实践

### 统计元素出现次数
在处理数据时，经常需要统计某个元素在序列中出现的次数。使用`defaultdict`可以很方便地实现这一功能。

```python
from collections import defaultdict

data = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
count_dict = defaultdict(int)

for num in data:
    count_dict[num] += 1

print(count_dict)  
# 输出: defaultdict(<class 'int'>, {1: 1, 2: 2, 3: 3, 4: 4})
```

在上述代码中，`count_dict`是一个默认值为0的`defaultdict`。遍历数据列表时，每遇到一个元素，就将其在`count_dict`中的对应值加1。由于`defaultdict`会自动为不存在的键创建默认值0，所以无需在每次访问键之前检查键是否存在。

### 分组数据
`defaultdict`还常用于将数据按照某个特征进行分组。例如，将一个包含学生姓名和成绩的列表，按照成绩分组。

```python
from collections import defaultdict

students = [('Alice', 85), ('Bob', 70), ('Charlie', 85), ('David', 90)]
grouped_students = defaultdict(list)

for name, score in students:
    grouped_students[score].append(name)

print(grouped_students)  
# 输出: defaultdict(<class 'list'>, {85: ['Alice', 'Charlie'], 70: ['Bob'], 90: ['David']})
```

在上述代码中，`grouped_students`是一个默认值为列表的`defaultdict`。遍历学生列表时，根据成绩将学生姓名添加到对应的列表中。同样，`defaultdict`的特性使得我们无需手动检查某个成绩对应的列表是否存在。

## 最佳实践

### 选择合适的默认值类型
在使用`defaultdict`时，选择合适的默认值类型至关重要。不同的应用场景需要不同类型的默认值。例如，统计元素出现次数时，使用`int`类型作为默认值工厂比较合适；而分组数据时，使用`list`类型作为默认值工厂更为恰当。如果选择了不合适的默认值类型，可能会导致代码逻辑混乱或性能下降。

### 避免不必要的默认值创建
虽然`defaultdict`会自动创建默认值，但在某些情况下，频繁创建不必要的默认值可能会影响性能。例如，在大型数据集上进行操作时，如果对大量不存在的键进行访问，会创建大量默认值，占用额外的内存。因此，在可能的情况下，应尽量先判断键是否存在，避免不必要的默认值创建。可以结合`in`关键字来检查键是否存在：

```python
from collections import defaultdict

dd = defaultdict(int)

key = 'test_key'
if key not in dd:
    # 执行一些逻辑，而不是直接访问键
    pass
else:
    value = dd[key]
```

## 小结
`defaultdict`是Python中一个非常实用的数据结构，它在处理字典操作时能够简化代码逻辑，提高编程效率。通过理解其基础概念、掌握使用方法，并遵循最佳实践，我们可以在各种数据处理场景中灵活运用`defaultdict`，使代码更加简洁、高效。希望本文的介绍能帮助读者更好地理解和使用`defaultdict`，在Python编程中发挥其强大的功能。

## 参考资料
- [Python官方文档 - collections模块](https://docs.python.org/3/library/collections.html){: rel="nofollow"}
- 《Python Cookbook》（第3版）

以上就是关于`defaultdict`的详细介绍，希望对你有所帮助。如果你有任何疑问或建议，欢迎留言交流。
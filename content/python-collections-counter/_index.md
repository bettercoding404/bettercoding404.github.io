---
title: "Python Collections Counter：强大的计数工具"
description: "在 Python 的编程世界中，处理数据的计数操作是一项常见任务。`collections.Counter` 模块为我们提供了一种便捷、高效的方式来统计可迭代对象中元素的出现次数。它是 `collections` 模块的一部分，这个模块包含了各种有用的数据结构。`Counter` 类使得计数任务变得轻而易举，无论是简单的列表元素计数，还是复杂文本中的单词统计等场景，都能发挥出它的强大功能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 的编程世界中，处理数据的计数操作是一项常见任务。`collections.Counter` 模块为我们提供了一种便捷、高效的方式来统计可迭代对象中元素的出现次数。它是 `collections` 模块的一部分，这个模块包含了各种有用的数据结构。`Counter` 类使得计数任务变得轻而易举，无论是简单的列表元素计数，还是复杂文本中的单词统计等场景，都能发挥出它的强大功能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 创建 `Counter` 对象
    - 访问元素计数
    - 更新 `Counter` 对象
    - 常见操作
3. 常见实践
    - 列表元素计数
    - 字符串字符计数
    - 文本单词计数
4. 最佳实践
    - 性能优化
    - 与其他数据结构结合使用
5. 小结
6. 参考资料

## 基础概念
`collections.Counter` 是一个专门用于计数的字典子类。它继承自 `dict` 类，因此拥有字典的大部分特性。与普通字典不同的是，`Counter` 类的目的是统计可迭代对象中各个元素的出现次数。它以元素为键，元素出现的次数为值存储在对象中。

## 使用方法

### 创建 `Counter` 对象
可以通过多种方式创建 `Counter` 对象。最常见的是使用可迭代对象作为参数，例如列表：
```python
from collections import Counter

# 使用列表创建 Counter 对象
my_list = [1, 2, 2, 3, 3, 3]
counter_obj = Counter(my_list)
print(counter_obj)  
```
输出：`Counter({3: 3, 2: 2, 1: 1})`

也可以使用字典来创建：
```python
# 使用字典创建 Counter 对象
my_dict = {'a': 3, 'b': 2, 'c': 1}
counter_obj = Counter(my_dict)
print(counter_obj)  
```
输出：`Counter({'a': 3, 'b': 2, 'c': 1})`

### 访问元素计数
访问 `Counter` 对象中元素的计数就像访问字典中的值一样：
```python
from collections import Counter

my_list = [1, 2, 2, 3, 3, 3]
counter_obj = Counter(my_list)

# 访问元素 2 的计数
count_of_2 = counter_obj[2]
print(count_of_2)  
```
输出：`2`

### 更新 `Counter` 对象
可以使用 `update()` 方法来更新 `Counter` 对象，将新的可迭代对象或字典中的计数合并到现有对象中：
```python
from collections import Counter

my_list = [1, 2, 2, 3, 3, 3]
counter_obj = Counter(my_list)

new_list = [2, 3, 4]
counter_obj.update(new_list)
print(counter_obj)  
```
输出：`Counter({3: 4, 2: 3, 1: 1, 4: 1})`

### 常见操作
- **获取最常见的元素**：使用 `most_common()` 方法可以获取出现次数最多的元素及其计数：
```python
from collections import Counter

my_list = [1, 2, 2, 3, 3, 3]
counter_obj = Counter(my_list)

# 获取最常见的元素及其计数
most_common = counter_obj.most_common(2)
print(most_common)  
```
输出：`[(3, 3), (2, 2)]`

- **元素计数的算术运算**：可以对两个 `Counter` 对象进行加、减、交、并等操作：
```python
from collections import Counter

c1 = Counter({'a': 3, 'b': 2})
c2 = Counter({'a': 1, 'b': 3})

# 加法操作
c_add = c1 + c2
print(c_add)  

# 减法操作
c_sub = c1 - c2
print(c_sub)  

# 交集操作
c_intersection = c1 & c2
print(c_intersection)  

# 并集操作
c_union = c1 | c2
print(c_union)  
```
输出：
```
Counter({'b': 5, 'a': 4})
Counter({'a': 2})
Counter({'a': 1, 'b': 2})
Counter({'b': 3, 'a': 3})
```

## 常见实践

### 列表元素计数
假设有一个包含学生成绩的列表，我们想要统计每个成绩出现的次数：
```python
from collections import Counter

grades = [85, 90, 85, 78, 90, 95, 85]
grade_counter = Counter(grades)
print(grade_counter)  
```
输出：`Counter({85: 3, 90: 2, 78: 1, 95: 1})`

### 字符串字符计数
统计一个字符串中每个字符出现的次数：
```python
from collections import Counter

my_string = "hello world"
char_counter = Counter(my_string)
print(char_counter)  
```
输出：`Counter({'l': 3, 'o': 2,'h': 1, 'e': 1,'': 1, 'w': 1, 'r': 1, 'd': 1})`

### 文本单词计数
统计一段文本中每个单词出现的次数：
```python
from collections import Counter
import re

text = "This is a sample text. This text is for testing Counter."
words = re.findall(r'\w+', text.lower())
word_counter = Counter(words)
print(word_counter)  
```
输出：`Counter({'this': 2, 'text': 2, 'is': 2, 'a': 1,'sample': 1, 'for': 1, 'testing': 1, 'counter': 1})`

## 最佳实践

### 性能优化
当处理非常大的数据集时，可以考虑使用生成器来创建 `Counter` 对象，避免一次性将所有数据加载到内存中。例如：
```python
from collections import Counter

def large_data_generator():
    # 模拟从大文件中逐行读取数据
    for line in open('large_file.txt'):
        yield line.strip()

counter = Counter(large_data_generator())
```

### 与其他数据结构结合使用
`Counter` 可以与其他数据结构如 `heapq` 结合使用，以实现更复杂的功能。例如，找到出现次数最少的元素：
```python
from collections import Counter
import heapq

my_list = [1, 2, 2, 3, 3, 3]
counter_obj = Counter(my_list)

# 找到出现次数最少的元素
least_common = heapq.nsmallest(2, counter_obj, key=counter_obj.get)
print(least_common)  
```
输出：`[1, 2]`

## 小结
`collections.Counter` 是 Python 中一个非常实用的工具，它简化了数据计数的操作。通过本文，我们了解了 `Counter` 的基础概念、多种创建和使用方式，以及在常见场景中的实践和一些最佳实践技巧。无论是简单的列表元素计数，还是复杂的文本处理，`Counter` 都能帮助我们高效地完成任务。

## 参考资料
- [Python 官方文档 - collections.Counter](https://docs.python.org/3/library/collections.html#collections.Counter)
- 《Python 核心编程》
- [Real Python - Working with Counters in Python](https://realpython.com/python-counter/)
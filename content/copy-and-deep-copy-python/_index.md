---
title: "Python中的浅拷贝（Shallow Copy）与深拷贝（Deep Copy）"
description: "在Python编程中，对象的复制是一个常见操作。浅拷贝和深拷贝是两种不同的对象复制方式，它们在处理对象层次结构时有着显著的区别。理解这两种复制方式对于正确处理复杂数据结构，避免潜在的编程错误至关重要。本文将详细介绍Python中浅拷贝和深拷贝的概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，对象的复制是一个常见操作。浅拷贝和深拷贝是两种不同的对象复制方式，它们在处理对象层次结构时有着显著的区别。理解这两种复制方式对于正确处理复杂数据结构，避免潜在的编程错误至关重要。本文将详细介绍Python中浅拷贝和深拷贝的概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
    - 浅拷贝
    - 深拷贝
2. 使用方法
    - `copy`模块
    - 浅拷贝示例
    - 深拷贝示例
3. 常见实践
    - 对列表进行浅拷贝
    - 对字典进行深拷贝
4. 最佳实践
    - 何时使用浅拷贝
    - 何时使用深拷贝
5. 小结
6. 参考资料

## 基础概念
### 浅拷贝
浅拷贝是创建一个新对象，这个新对象有着原始对象元素的引用。这意味着如果原始对象包含其他可变对象（如列表、字典），浅拷贝不会递归地复制这些内部对象，而是共享引用。因此，修改原始对象或浅拷贝对象中的可变对象，会影响到彼此。

### 深拷贝
深拷贝会递归地复制对象及其所有嵌套的对象。新对象与原始对象在内存中完全独立，修改其中一个对象不会影响到另一个对象。深拷贝会为每一个层次的对象创建全新的副本。

## 使用方法
### `copy`模块
在Python中，`copy`模块提供了浅拷贝和深拷贝的功能。使用前需要导入该模块：
```python
import copy
```

### 浅拷贝示例
以下是对列表进行浅拷贝的示例：
```python
import copy

original_list = [[1, 2], [3, 4]]
shallow_copied_list = copy.copy(original_list)

print("Original list:", original_list)
print("Shallow copied list:", shallow_copied_list)

# 修改原始列表中的嵌套列表
original_list[0][0] = 99

print("After modification, original list:", original_list)
print("After modification, shallow copied list:", shallow_copied_list)
```
在这个示例中，我们对包含嵌套列表的`original_list`进行浅拷贝。当修改`original_list`中的嵌套列表时，`shallow_copied_list`中的相应部分也会改变，因为它们共享内部嵌套列表的引用。

### 深拷贝示例
下面是对列表进行深拷贝的示例：
```python
import copy

original_list = [[1, 2], [3, 4]]
deep_copied_list = copy.deepcopy(original_list)

print("Original list:", original_list)
print("Deep copied list:", deep_copied_list)

# 修改原始列表中的嵌套列表
original_list[0][0] = 99

print("After modification, original list:", original_list)
print("After modification, deep copied list:", deep_copied_list)
```
在这个例子中，我们使用`copy.deepcopy()`对列表进行深拷贝。修改`original_list`中的嵌套列表后，`deep_copied_list`不受影响，因为它有自己独立的内存副本。

## 常见实践
### 对列表进行浅拷贝
当列表中的元素都是不可变对象（如整数、字符串）时，浅拷贝通常就足够了，因为修改原始列表不会影响到浅拷贝的列表。例如：
```python
import copy

original_list = [1, 2, 3, 4]
shallow_copied_list = copy.copy(original_list)

print("Original list:", original_list)
print("Shallow copied list:", shallow_copied_list)

original_list[0] = 99

print("After modification, original list:", original_list)
print("After modification, shallow copied list:", shallow_copied_list)
```
### 对字典进行深拷贝
如果字典中包含可变对象作为值，并且希望在修改原始字典时不影响到新字典，就需要进行深拷贝。例如：
```python
import copy

original_dict = {'key1': [1, 2], 'key2': {'subkey': 3}}
deep_copied_dict = copy.deepcopy(original_dict)

print("Original dict:", original_dict)
print("Deep copied dict:", deep_copied_dict)

original_dict['key1'][0] = 99

print("After modification, original dict:", original_dict)
print("After modification, deep copied dict:", deep_copied_dict)
```

## 最佳实践
### 何时使用浅拷贝
- **性能优先**：当对象结构简单且内部对象为不可变对象时，浅拷贝的性能更好，因为它不需要递归复制所有层次的对象。
- **共享部分数据**：如果希望新对象和原始对象共享部分数据，并且对共享数据的修改是预期的行为，那么浅拷贝是合适的选择。

### 何时使用深拷贝
- **数据独立性**：当需要确保新对象和原始对象在内存中完全独立，修改一个对象不会影响到另一个对象时，必须使用深拷贝。这在处理复杂数据结构（如嵌套列表、字典）时尤为重要。
- **防止意外修改**：在某些情况下，为了避免函数或代码块内部对传入对象的意外修改，可以使用深拷贝创建一个独立的副本进行操作。

## 小结
浅拷贝和深拷贝是Python中处理对象复制的两种重要方式。浅拷贝创建一个新对象并共享内部可变对象的引用，而深拷贝递归地复制所有层次的对象，创建完全独立的副本。理解何时使用浅拷贝和深拷贝对于编写正确、高效的Python代码至关重要。通过合理选择复制方式，可以避免许多与对象共享和修改相关的错误。

## 参考资料
- [Python官方文档 - copy模块](https://docs.python.org/3/library/copy.html)
- 《Python Cookbook》第三版，关于对象复制的章节。
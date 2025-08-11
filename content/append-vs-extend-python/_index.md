---
title: "Python 中 append 与 extend 的深度剖析"
description: "在 Python 编程中，列表（list）是一种常用且功能强大的数据结构。`append` 和 `extend` 是列表对象的两个重要方法，它们都用于向列表中添加元素，但在行为和使用场景上存在显著差异。理解这两个方法的区别和正确用法，对于编写高效、简洁的 Python 代码至关重要。本文将详细探讨 `append` 和 `extend` 的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，列表（list）是一种常用且功能强大的数据结构。`append` 和 `extend` 是列表对象的两个重要方法，它们都用于向列表中添加元素，但在行为和使用场景上存在显著差异。理解这两个方法的区别和正确用法，对于编写高效、简洁的 Python 代码至关重要。本文将详细探讨 `append` 和 `extend` 的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - `append` 方法
    - `extend` 方法
2. **使用方法**
    - `append` 的使用
    - `extend` 的使用
3. **常见实践**
    - 在不同场景下选择 `append` 或 `extend`
    - 处理嵌套列表
4. **最佳实践**
    - 性能考量
    - 代码可读性
5. **小结**
6. **参考资料**

## 基础概念
### `append` 方法
`append` 是 Python 列表的一个方法，用于在列表的末尾添加一个单个元素。这个元素可以是任何数据类型，包括数字、字符串、列表、字典等。添加后，列表的长度增加 1。

### `extend` 方法
`extend` 方法同样用于向列表末尾添加元素，但它接受一个可迭代对象（如列表、元组、字符串等）作为参数，并将可迭代对象中的每个元素逐个添加到列表中。添加后，列表的长度增加的数量等于可迭代对象中元素的数量。

## 使用方法
### `append` 的使用
```python
# 创建一个空列表
my_list = []

# 使用 append 方法添加元素
my_list.append(1)
my_list.append("hello")
my_list.append([2, 3])

print(my_list)  
# 输出: [1, 'hello', [2, 3]]
```
在上述示例中，我们通过 `append` 方法分别向列表中添加了一个整数、一个字符串和一个列表。每个添加操作都使列表的长度增加 1。

### `extend` 的使用
```python
# 创建一个列表
my_list = [1, 2]

# 使用 extend 方法扩展列表
my_list.extend([3, 4])
my_list.extend((5, 6))
my_list.extend("abc")

print(my_list)  
# 输出: [1, 2, 3, 4, 5, 6, 'a', 'b', 'c']
```
这里我们先创建了一个包含两个元素的列表，然后使用 `extend` 方法依次扩展了一个列表、一个元组和一个字符串。每个扩展操作都将可迭代对象中的元素逐个添加到原列表中。

## 常见实践
### 在不同场景下选择 `append` 或 `extend`
- **添加单个元素时**：如果需要向列表中添加一个独立的元素，无论这个元素是什么数据类型，都应该使用 `append` 方法。例如，在处理数据时，每次获取到一个新的数据项并将其添加到结果列表中，使用 `append` 是自然的选择。
```python
result = []
data = 42
result.append(data)
```
- **合并多个元素时**：当需要将一个可迭代对象中的所有元素添加到列表中时，`extend` 方法更为合适。比如，将多个用户输入的数据合并到一个列表中，或者将两个列表合并成一个。
```python
list1 = [1, 2]
list2 = [3, 4]
list1.extend(list2)
```

### 处理嵌套列表
在处理嵌套列表时，`append` 和 `extend` 的行为也有所不同。
```python
nested_list = []

# 使用 append 添加一个子列表
nested_list.append([1, 2])
print(nested_list)  
# 输出: [[1, 2]]

# 使用 extend 添加子列表的元素
nested_list.extend([3, 4])
print(nested_list)  
# 输出: [[1, 2], 3, 4]
```
可以看到，`append` 将整个子列表作为一个元素添加到列表中，而 `extend` 将子列表中的元素逐个添加进去。

## 最佳实践
### 性能考量
在性能方面，`extend` 方法通常比多次使用 `append` 方法要快。这是因为 `extend` 方法在底层实现上对可迭代对象进行了优化处理，减少了多次调用 `append` 带来的开销。例如，将一个长列表中的元素逐个添加到另一个列表中：
```python
import timeit

# 使用 append 方法
def append_elements():
    list1 = []
    list2 = list(range(1000))
    for element in list2:
        list1.append(element)
    return list1

# 使用 extend 方法
def extend_elements():
    list1 = []
    list2 = list(range(1000))
    list1.extend(list2)
    return list1

# 测量时间
append_time = timeit.timeit(append_elements, number = 1000)
extend_time = timeit.timeit(extend_elements, number = 1000)

print(f"Time taken by append: {append_time} seconds")
print(f"Time taken by extend: {extend_time} seconds")
```
运行上述代码可以发现，`extend` 方法的执行时间明显短于 `append` 方法。

### 代码可读性
从代码可读性角度考虑，选择 `append` 还是 `extend` 应根据代码意图来决定。如果代码逻辑是逐个添加独立的元素，使用 `append` 更清晰；如果是将一组相关的元素合并到现有列表中，`extend` 能更好地表达这种意图。

## 小结
在 Python 中，`append` 和 `extend` 都是用于操作列表的重要方法。`append` 用于向列表末尾添加单个元素，而 `extend` 用于将一个可迭代对象中的所有元素添加到列表末尾。在实际编程中，应根据具体需求选择合适的方法，既要考虑性能优化，也要注重代码的可读性和可维护性。

## 参考资料
- [Python 官方文档 - list.append](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
- [Python 官方文档 - list.extend](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
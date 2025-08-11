---
title: "在 Python 中向列表追加元素"
description: "在 Python 编程中，列表（list）是一种非常常用且灵活的数据结构。能够有效地向列表中追加元素是一项基础且重要的技能。掌握如何向列表追加元素可以极大地提高代码的灵活性和功能性，无论是处理简单的数据集合还是构建复杂的应用程序。本文将深入探讨在 Python 中向列表追加元素的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，列表（list）是一种非常常用且灵活的数据结构。能够有效地向列表中追加元素是一项基础且重要的技能。掌握如何向列表追加元素可以极大地提高代码的灵活性和功能性，无论是处理简单的数据集合还是构建复杂的应用程序。本文将深入探讨在 Python 中向列表追加元素的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - `append()` 方法
    - `extend()` 方法
    - 连接操作符 `+`
    - 解包操作符 `*`
3. 常见实践
    - 在循环中追加元素
    - 根据条件追加元素
4. 最佳实践
    - 性能考量
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
在 Python 中，列表是一个有序的、可变的元素集合。可以包含不同类型的数据，例如整数、字符串、浮点数，甚至是其他列表等。向列表追加元素意味着在列表的末尾添加新的元素，从而改变列表的长度和内容。

## 使用方法

### `append()` 方法
`append()` 是 Python 列表对象的一个内置方法，用于在列表的末尾添加一个单一元素。

```python
my_list = [1, 2, 3]
new_element = 4
my_list.append(new_element)
print(my_list)  
```

### `extend()` 方法
`extend()` 方法用于将一个可迭代对象（如另一个列表、元组、集合等）中的所有元素添加到当前列表的末尾。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
list1.extend(list2)
print(list1)  
```

### 连接操作符 `+`
可以使用 `+` 操作符将两个列表连接起来，生成一个新的列表。

```python
list3 = [1, 2, 3]
list4 = [4, 5, 6]
new_list = list3 + list4
print(new_list)  
```

### 解包操作符 `*`
解包操作符 `*` 可以用于将一个可迭代对象解包，并将其中的元素添加到列表中。

```python
list5 = [1, 2, 3]
new_elements = [4, 5, 6]
list5 = [*list5, *new_elements]
print(list5)  
```

## 常见实践

### 在循环中追加元素
在循环中根据某些逻辑向列表追加元素是很常见的操作。例如，生成一个包含 1 到 10 的平方的列表：

```python
squares = []
for i in range(1, 11):
    squares.append(i ** 2)
print(squares)  
```

### 根据条件追加元素
可以根据特定条件决定是否向列表追加元素。例如，从一个列表中筛选出偶数并添加到新列表中：

```python
numbers = [1, 2, 3, 4, 5, 6]
even_numbers = []
for num in numbers:
    if num % 2 == 0:
        even_numbers.append(num)
print(even_numbers)  
```

## 最佳实践

### 性能考量
- **`append()` 与 `extend()`**：如果要逐个添加元素，`append()` 是合适的选择。但如果要添加多个元素，`extend()` 通常性能更好，因为它避免了多次调整列表的大小。
- **避免在循环中使用 `+` 连接列表**：在循环中使用 `+` 连接列表会产生新的列表对象，导致性能下降。推荐使用 `append()` 或 `extend()` 方法。

### 代码可读性
- **使用有意义的变量名**：在向列表追加元素时，确保变量名能够清晰地表达列表的用途和要追加的元素的含义。
- **适当的注释**：对于复杂的追加操作，添加注释可以帮助他人理解代码的意图。

## 小结
在 Python 中向列表追加元素有多种方法，每种方法都有其适用场景。`append()` 用于添加单个元素，`extend()` 用于添加多个元素，`+` 操作符用于连接列表，解包操作符 `*` 提供了一种灵活的添加元素方式。在实际编程中，要根据性能需求和代码可读性选择合适的方法。

## 参考资料
- [Python 官方文档 - 列表类型](https://docs.python.org/3/library/stdtypes.html#list)
- 《Python 核心编程》
- [Stack Overflow - Python list append 相关问题](https://stackoverflow.com/questions/tagged/python+list+append)
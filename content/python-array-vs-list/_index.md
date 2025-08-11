---
title: "Python Array 与 List 的深入剖析"
description: "在 Python 编程中，`array` 和 `list` 是两种常用的数据结构。虽然它们都可以用于存储多个元素，但在底层实现、性能和使用场景上存在显著差异。深入理解这两者的区别，有助于开发者在不同的编程需求下做出更合适的选择，从而提升代码的效率和质量。本文将详细对比 `array` 和 `list`，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，`array` 和 `list` 是两种常用的数据结构。虽然它们都可以用于存储多个元素，但在底层实现、性能和使用场景上存在显著差异。深入理解这两者的区别，有助于开发者在不同的编程需求下做出更合适的选择，从而提升代码的效率和质量。本文将详细对比 `array` 和 `list`，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
    - List 基础概念
    - Array 基础概念
2. 使用方法
    - List 的使用方法
    - Array 的使用方法
3. 常见实践
    - List 的常见实践
    - Array 的常见实践
4. 最佳实践
    - 何时使用 List
    - 何时使用 Array
5. 小结
6. 参考资料

## 基础概念
### List 基础概念
List 是 Python 中最常用的数据结构之一，它是一个有序的可变序列。可以包含不同类型的元素，例如整数、字符串、浮点数甚至其他列表。List 使用方括号 `[]` 来定义，例如：
```python
my_list = [1, "hello", 3.14]
```
List 是动态分配内存的，这意味着在添加或删除元素时，它可以自动调整大小。

### Array 基础概念
`array` 模块提供了 `array` 类型，它也是一个有序序列，但与 List 不同的是，`array` 中的元素必须是相同类型的。`array` 类型在底层使用更紧凑的内存表示，这使得它在存储大量同类型数据时更加高效。要使用 `array`，需要导入 `array` 模块，例如：
```python
from array import array
my_array = array('i', [1, 2, 3])
```
这里的 `'i'` 是类型码，表示数组中的元素是整数类型。不同的类型码对应不同的数据类型，如 `'f'` 表示浮点数，`'u'` 表示 Unicode 字符等。

## 使用方法
### List 的使用方法
1. **创建 List**：
    ```python
    my_list = [1, 2, 3]
    empty_list = []
    ```
2. **访问元素**：可以通过索引访问 List 中的元素，索引从 0 开始。
    ```python
    my_list = [1, 2, 3]
    print(my_list[0])  # 输出 1
    ```
3. **修改元素**：
    ```python
    my_list = [1, 2, 3]
    my_list[1] = 4
    print(my_list)  # 输出 [1, 4, 3]
    ```
4. **添加元素**：
    - 使用 `append` 方法在 List 末尾添加一个元素。
    ```python
    my_list = [1, 2, 3]
    my_list.append(4)
    print(my_list)  # 输出 [1, 2, 3, 4]
    ```
    - 使用 `extend` 方法将另一个可迭代对象的元素添加到 List 末尾。
    ```python
    my_list = [1, 2, 3]
    another_list = [4, 5]
    my_list.extend(another_list)
    print(my_list)  # 输出 [1, 2, 3, 4, 5]
    ```
5. **删除元素**：
    - 使用 `remove` 方法删除指定值的第一个匹配项。
    ```python
    my_list = [1, 2, 3, 2]
    my_list.remove(2)
    print(my_list)  # 输出 [1, 3, 2]
    ```
    - 使用 `pop` 方法删除指定索引位置的元素，并返回该元素。
    ```python
    my_list = [1, 2, 3]
    removed_element = my_list.pop(1)
    print(my_list)  # 输出 [1, 3]
    print(removed_element)  # 输出 2
    ```

### Array 的使用方法
1. **创建 Array**：
    ```python
    from array import array
    my_array = array('i', [1, 2, 3])
    empty_array = array('i')
    ```
2. **访问元素**：与 List 类似，通过索引访问 Array 中的元素。
    ```python
    from array import array
    my_array = array('i', [1, 2, 3])
    print(my_array[0])  # 输出 1
    ```
3. **修改元素**：
    ```python
    from array import array
    my_array = array('i', [1, 2, 3])
    my_array[1] = 4
    print(my_array)  # 输出 array('i', [1, 4, 3])
    ```
4. **添加元素**：
    - 使用 `append` 方法在 Array 末尾添加一个元素。
    ```python
    from array import array
    my_array = array('i', [1, 2, 3])
    my_array.append(4)
    print(my_array)  # 输出 array('i', [1, 2, 3, 4])
    ```
    - 使用 `extend` 方法将另一个可迭代对象的元素添加到 Array 末尾。
    ```python
    from array import array
    my_array = array('i', [1, 2, 3])
    another_array = array('i', [4, 5])
    my_array.extend(another_array)
    print(my_array)  # 输出 array('i', [1, 2, 3, 4, 5])
    ```
5. **删除元素**：
    - 使用 `remove` 方法删除指定值的第一个匹配项。
    ```python
    from array import array
    my_array = array('i', [1, 2, 3, 2])
    my_array.remove(2)
    print(my_array)  # 输出 array('i', [1, 3, 2])
    ```
    - 使用 `pop` 方法删除指定索引位置的元素，并返回该元素。
    ```python
    from array import array
    my_array = array('i', [1, 2, 3])
    removed_element = my_array.pop(1)
    print(my_array)  # 输出 array('i', [1, 3])
    print(removed_element)  # 输出 2
    ```

## 常见实践
### List 的常见实践
1. **数据收集与处理**：在需要收集和处理不同类型的数据时，List 非常方便。例如，在一个程序中收集用户输入的不同类型的数据：
```python
user_inputs = []
while True:
    input_value = input("请输入一个值（输入 'q' 退出）：")
    if input_value == 'q':
        break
    try:
        num = int(input_value)
        user_inputs.append(num)
    except ValueError:
        user_inputs.append(input_value)
print(user_inputs)
```
2. **动态数据结构**：由于 List 是可变的，可以在程序运行过程中动态地添加、删除和修改元素。这在实现栈、队列等数据结构时非常有用。例如，实现一个简单的栈：
```python
stack = []
stack.append(1)
stack.append(2)
popped_element = stack.pop()
print(popped_element)  # 输出 2
```

### Array 的常见实践
1. **数值计算**：当需要存储大量同类型的数值数据并进行数值计算时，`array` 比 List 更高效。例如，在科学计算中存储大量的浮点数：
```python
from array import array
import math

data = array('f', [1.0, 2.0, 3.0])
result = array('f', [math.sqrt(x) for x in data])
print(result)
```
2. **文件 I/O**：`array` 可以方便地与文件进行交互。例如，将 `array` 中的数据写入二进制文件，然后再读取出来：
```python
from array import array

# 写入文件
data = array('i', [1, 2, 3])
with open('data.bin', 'wb') as f:
    data.tofile(f)

# 读取文件
new_data = array('i')
with open('data.bin', 'rb') as f:
    new_data.fromfile(f, 3)
print(new_data)
```

## 最佳实践
### 何时使用 List
1. **存储不同类型的数据**：如果需要存储包含不同类型元素的数据，如整数、字符串、列表等，List 是首选。
2. **动态操作频繁**：当需要频繁地添加、删除和修改元素，并且数据类型多样时，List 的灵活性使其成为更好的选择。
3. **数据结构实现**：在实现栈、队列、链表等通用数据结构时，List 的易用性和动态特性使其非常适合。

### 何时使用 Array
1. **同类型数值数据存储**：当需要存储大量同类型的数值数据，如整数或浮点数时，`array` 由于其紧凑的内存表示和高效的数值操作，性能更优。
2. **内存敏感场景**：在对内存使用有严格要求的场景下，`array` 可以节省内存空间，提高程序的整体性能。
3. **与文件或二进制数据交互**：如果需要与文件或二进制数据进行交互，`array` 提供了方便的方法来读写数据，使其成为更好的选择。

## 小结
Python 中的 `array` 和 `list` 都是强大的数据结构，但它们适用于不同的场景。`list` 非常灵活，适合存储不同类型的数据和进行动态操作；而 `array` 在存储大量同类型数据时更加高效，并且在数值计算和与文件交互方面具有优势。通过理解它们的基础概念、使用方法、常见实践和最佳实践，开发者可以根据具体的编程需求选择最合适的数据结构，从而编写出更高效、更优质的代码。

## 参考资料
- [Python 官方文档 - List](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
- [Python 官方文档 - Array](https://docs.python.org/3/library/array.html)
- 《Python 数据分析实战》
- 《Python 核心编程》
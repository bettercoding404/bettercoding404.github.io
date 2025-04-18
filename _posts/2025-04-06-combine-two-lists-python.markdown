---
title: "在Python中合并两个列表"
description: "在Python编程中，经常会遇到需要将两个或多个列表合并成一个新列表的情况。合并列表的操作在数据处理、算法实现等众多场景中都非常有用。本文将深入探讨在Python中合并两个列表的基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者熟练掌握这一重要的编程技巧。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，经常会遇到需要将两个或多个列表合并成一个新列表的情况。合并列表的操作在数据处理、算法实现等众多场景中都非常有用。本文将深入探讨在Python中合并两个列表的基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者熟练掌握这一重要的编程技巧。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 方法一：使用 `+` 运算符
    - 方法二：使用 `extend()` 方法
    - 方法三：使用 `append()` 方法
    - 方法四：使用列表推导式
    - 方法五：使用 `itertools.chain()`
3. 常见实践
    - 数据整合
    - 处理数据集
    - 算法应用
4. 最佳实践
    - 性能考量
    - 代码可读性
    - 适用场景
5. 小结
6. 参考资料

## 基础概念
在Python中，列表是一种有序的可变数据类型，用于存储多个元素。合并两个列表，简单来说，就是将两个不同列表中的所有元素组合到一个新的列表中。新列表包含了原来两个列表中的全部元素，并且保留了元素在原始列表中的顺序。

## 使用方法

### 方法一：使用 `+` 运算符
这是最直观和简单的方法。通过 `+` 运算符，可以直接将两个列表合并成一个新列表。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = list1 + list2
print(result)  
```
### 方法二：使用 `extend()` 方法
`extend()` 方法会将一个列表中的所有元素添加到另一个列表的末尾，修改的是调用该方法的列表。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
list1.extend(list2)
print(list1)  
```
### 方法三：使用 `append()` 方法
`append()` 方法每次只能将一个元素添加到列表末尾。因此，如果要使用 `append()` 方法合并两个列表，需要遍历第二个列表并逐个添加元素。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
for element in list2:
    list1.append(element)
print(list1)  
```
### 方法四：使用列表推导式
列表推导式提供了一种简洁的方式来创建新列表。可以通过列表推导式将两个列表合并。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = [element for sublist in [list1, list2] for element in sublist]
print(result)  
```
### 方法五：使用 `itertools.chain()`
`itertools.chain()` 函数来自Python的标准库 `itertools`，它可以将多个可迭代对象连接成一个迭代器。可以将其转换为列表来实现合并效果。

```python
import itertools

list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = list(itertools.chain(list1, list2))
print(result)  
```

## 常见实践

### 数据整合
在数据处理任务中，可能会从不同的数据源获取到数据，以列表的形式存储。需要将这些列表合并起来进行统一的分析和处理。

```python
data1 = [10, 20, 30]
data2 = [40, 50, 60]
combined_data = data1 + data2
# 进一步对 combined_data 进行数据分析操作
```

### 处理数据集
在机器学习或深度学习中，数据集可能被分成多个部分存储在不同的列表中。合并这些列表可以将完整的数据集用于训练或测试模型。

```python
train_data1 = [1, 2, 3]
train_data2 = [4, 5, 6]
train_data = train_data1.extend(train_data2)
# 使用 train_data 进行模型训练
```

### 算法应用
在一些算法实现中，可能需要将不同阶段生成的列表合并起来，作为算法的最终输出或者中间步骤的输入。

```python
# 例如在某种排序算法中
sorted_part1 = [1, 3, 5]
sorted_part2 = [2, 4, 6]
final_sorted_list = sorted_part1 + sorted_part2
```

## 最佳实践

### 性能考量
如果需要合并的列表非常大，不同方法的性能差异就会变得明显。使用 `+` 运算符和 `list(itertools.chain())` 方法相对较快，因为它们避免了重复的内存分配和调整大小的操作。而 `append()` 方法在每次添加元素时都可能需要调整列表的大小，性能相对较差。

### 代码可读性
在编写代码时，代码的可读性非常重要。对于简单的合并操作，使用 `+` 运算符通常是最直观和易读的方式。如果需要在原列表上进行修改，`extend()` 方法更加清晰明了。

### 适用场景
    - **`+` 运算符**：适用于需要创建一个新的合并列表，并且对性能要求较高的场景。
    - **`extend()` 方法**：当需要在原列表基础上添加元素，并且不需要保留原始列表时使用。
    - **`append()` 方法**：适用于逐个添加元素的特殊需求场景，虽然性能不高，但在某些逻辑中可能更符合代码结构。
    - **列表推导式**：在需要同时对合并元素进行一些处理或筛选时使用，增加了代码的灵活性。
    - **`itertools.chain()`**：在处理多个可迭代对象（不仅仅是列表）的连接时非常有用，并且性能较好。

## 小结
在Python中合并两个列表有多种方法，每种方法都有其特点和适用场景。通过 `+` 运算符、`extend()` 方法、`append()` 方法、列表推导式以及 `itertools.chain()` 函数，我们可以根据具体需求选择最合适的方式。在实际编程中，需要综合考虑性能、代码可读性以及具体的应用场景，以实现高效且易于维护的代码。

## 参考资料
- 《Python Cookbook》
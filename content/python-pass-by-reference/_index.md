---
title: "Python中的引用传递（Pass by Reference）"
description: "在Python编程中，理解变量传递的方式对于写出高效且正确的代码至关重要。“引用传递（Pass by Reference）”是一种变量传递机制，本文将深入探讨Python中引用传递的相关知识，包括其概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要特性。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，理解变量传递的方式对于写出高效且正确的代码至关重要。“引用传递（Pass by Reference）”是一种变量传递机制，本文将深入探讨Python中引用传递的相关知识，包括其概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要特性。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
3. **常见实践**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
在Python中，参数传递既不是传统意义上严格的“值传递（Pass by Value）”也不是“引用传递（Pass by Reference）”，而是“对象引用传递（Pass by Object Reference）”。

简单来说，当你将一个对象作为参数传递给函数时，传递的是对象的引用（内存地址）。这意味着函数内部对对象的修改可能会影响到函数外部的原始对象，具体取决于对象的可变性。

- **可变对象（Mutable Objects）**：如列表（list）、字典（dict）、集合（set）等，它们可以在原地进行修改。当传递可变对象的引用时，函数内部对对象的修改会反映到函数外部。
- **不可变对象（Immutable Objects）**：如整数（int）、字符串（str）、元组（tuple）等，它们的值一旦创建就不能被修改。当传递不可变对象的引用时，函数内部对对象的重新赋值不会影响到函数外部的原始对象。

## 使用方法

### 传递可变对象
```python
def modify_list(lst):
    lst.append(4)
    return lst

my_list = [1, 2, 3]
result = modify_list(my_list)
print(result)  # 输出: [1, 2, 3, 4]
print(my_list)  # 输出: [1, 2, 3, 4]
```
在这个例子中，`my_list`是一个可变的列表对象。当它被传递给`modify_list`函数时，函数内部对列表的修改（通过`append`方法）也影响到了函数外部的原始列表。

### 传递不可变对象
```python
def modify_number(num):
    num = num + 1
    return num

my_number = 5
result = modify_number(my_number)
print(result)  # 输出: 6
print(my_number)  # 输出: 5
```
这里`my_number`是一个不可变的整数对象。在`modify_number`函数中，虽然对`num`进行了重新赋值，但这并不会影响到函数外部的`my_number`。

## 常见实践

### 在函数中修改可变对象
在许多实际场景中，我们需要在函数内部修改传递进来的可变对象。例如，对列表进行排序：
```python
def sort_list(lst):
    lst.sort()
    return lst

unsorted_list = [3, 1, 2]
sorted_list = sort_list(unsorted_list)
print(sorted_list)  # 输出: [1, 2, 3]
print(unsorted_list)  # 输出: [1, 2, 3]
```

### 避免意外修改可变对象
有时候我们不希望函数内部对传递进来的可变对象进行修改。可以通过创建对象的副本进行操作：
```python
def process_list(lst):
    new_lst = lst.copy()
    new_lst.append(5)
    return new_lst

original_list = [1, 2, 3]
processed_list = process_list(original_list)
print(processed_list)  # 输出: [1, 2, 3, 5]
print(original_list)  # 输出: [1, 2, 3]
```

## 最佳实践

### 明确函数对参数的修改意图
在编写函数时，应该明确表明函数是否会修改传递进来的参数。如果会修改，在函数文档字符串（docstring）中进行说明，以便其他开发者理解。
```python
def append_to_list(lst, value):
    """
    向列表中追加一个值。
    此函数会修改原始列表。

    参数:
    lst -- 要追加值的列表
    value -- 要追加的值
    """
    lst.append(value)
    return lst
```

### 尽量保持函数的纯洁性
对于不可变对象的操作，尽量返回新的对象而不是修改原始对象。这样可以使函数更具可预测性和易于调试。
```python
def add_numbers(a, b):
    return a + b
```

### 使用防御性编程
当函数接受可变对象作为参数时，考虑创建副本进行操作，以避免意外修改调用者的对象。这在处理外部数据或不可信来源的数据时尤为重要。
```python
def safe_process_dict(dct):
    new_dct = dct.copy()
    new_dct['new_key'] = 'new_value'
    return new_dct
```

## 小结
Python中的对象引用传递机制使得参数传递既灵活又具有一定的复杂性。理解可变对象和不可变对象在传递过程中的行为差异，以及如何正确使用和避免意外修改，是编写高质量Python代码的关键。通过遵循最佳实践，我们可以使代码更具可读性、可维护性和健壮性。

## 参考资料
- [Python官方文档 - 数据模型](https://docs.python.org/3/reference/datamodel.html)
- 《Python 核心编程》
- [Stack Overflow - Python parameter passing](https://stackoverflow.com/questions/986006/how-do-i-pass-a-variable-by-reference)
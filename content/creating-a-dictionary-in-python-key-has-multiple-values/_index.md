---
title: "Python 中创建键拥有多个值的字典"
description: "在 Python 编程中，字典是一种非常强大的数据结构，它以键值对的形式存储数据。通常情况下，一个键对应一个值，但在某些实际场景中，我们需要一个键能够关联多个值。本文将深入探讨如何在 Python 中创建键拥有多个值的字典，介绍其基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地应用这一特性。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，字典是一种非常强大的数据结构，它以键值对的形式存储数据。通常情况下，一个键对应一个值，但在某些实际场景中，我们需要一个键能够关联多个值。本文将深入探讨如何在 Python 中创建键拥有多个值的字典，介绍其基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地应用这一特性。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用列表作为值
    - 使用集合作为值
3. 常见实践
    - 数据分组
    - 统计元素出现次数
4. 最佳实践
    - 选择合适的数据类型
    - 代码的可读性和维护性
5. 小结
6. 参考资料

## 基础概念
在 Python 中，常规字典的键是唯一的，每个键只能对应一个值。但当我们需要一个键关联多个值时，就需要特殊的处理方式。本质上，我们还是使用字典这种数据结构，只不过值的部分不再是单一元素，而是可以容纳多个元素的数据结构，比如列表或集合。

例如，我们想要存储每个班级的学生名单，“班级”作为键，“学生名单”作为多个值。这种情况下，就适合使用键拥有多个值的字典。

## 使用方法
### 使用列表作为值
列表是有序且可重复的数据结构，适合用于需要保留元素顺序或者允许元素重复的场景。

```python
# 创建一个空字典，键将关联多个值（以列表形式）
multi_value_dict = {}

# 向字典中添加键值对，值为列表
class_1 = ['Alice', 'Bob', 'Charlie']
multi_value_dict['Class 1'] = class_1

# 另一种添加方式
multi_value_dict['Class 2'] = ['David', 'Eve', 'Frank']

# 访问值
students_in_class_1 = multi_value_dict['Class 1']
print(students_in_class_1)  # 输出: ['Alice', 'Bob', 'Charlie']

# 向已有列表中添加元素
multi_value_dict['Class 1'].append('Grace')
print(multi_value_dict['Class 1'])  # 输出: ['Alice', 'Bob', 'Charlie', 'Grace']
```

### 使用集合作为值
集合是无序且唯一的数据结构，适合用于需要去重且不关心元素顺序的场景。

```python
# 创建一个空字典，键将关联多个值（以集合形式）
multi_value_set_dict = {}

# 向字典中添加键值对，值为集合
fruits_set = {'apple', 'banana', 'cherry'}
multi_value_set_dict['Fruits'] = fruits_set

# 另一种添加方式
multi_value_set_dict['Vegetables'] = {'carrot', 'broccoli', 'lettuce'}

# 访问值
fruits = multi_value_set_dict['Fruits']
print(fruits)  # 输出: {'apple', 'banana', 'cherry'}

# 向已有集合中添加元素
multi_value_set_dict['Fruits'].add('date')
print(multi_value_set_dict['Fruits'])  # 输出: {'apple', 'banana', 'cherry', 'date'}
```

## 常见实践
### 数据分组
假设我们有一个包含多个学生成绩的列表，每个元素是一个元组，包含学生姓名和成绩。我们想按成绩区间对学生进行分组。

```python
student_scores = [('Alice', 85), ('Bob', 72), ('Charlie', 90), ('David', 78), ('Eve', 88)]

score_groups = {}

for name, score in student_scores:
    if score < 80:
        if '70 - 79' not in score_groups:
            score_groups['70 - 79'] = []
        score_groups['70 - 79'].append(name)
    elif score < 90:
        if '80 - 89' not in score_groups:
            score_groups['80 - 89'] = []
        score_groups['80 - 89'].append(name)
    else:
        if '90 - 100' not in score_groups:
            score_groups['90 - 100'] = []
        score_groups['90 - 100'].append(name)

print(score_groups)
# 输出: {'70 - 79': ['Bob', 'David'], '80 - 89': ['Alice', 'Eve'], '90 - 100': ['Charlie']}
```

### 统计元素出现次数
统计字符串中每个字符出现的位置。

```python
string = "banana"
char_positions = {}

for i, char in enumerate(string):
    if char not in char_positions:
        char_positions[char] = []
    char_positions[char].append(i)

print(char_positions)
# 输出: {'b': [0], 'a': [1, 3, 5], 'n': [2, 4]}
```

## 最佳实践
### 选择合适的数据类型
根据具体需求选择使用列表还是集合作为多值容器。如果需要保留元素顺序或者允许元素重复，使用列表；如果需要去重且不关心元素顺序，使用集合。

### 代码的可读性和维护性
为了提高代码的可读性和维护性，可以将创建和操作键拥有多个值的字典的逻辑封装成函数。例如：

```python
def add_to_multi_value_dict(dictionary, key, value):
    if key not in dictionary:
        dictionary[key] = []
    dictionary[key].append(value)
    return dictionary

my_dict = {}
my_dict = add_to_multi_value_dict(my_dict, 'group1', 'element1')
my_dict = add_to_multi_value_dict(my_dict, 'group1', 'element2')
my_dict = add_to_multi_value_dict(my_dict, 'group2', 'element3')

print(my_dict)
# 输出: {'group1': ['element1', 'element2'], 'group2': ['element3']}
```

## 小结
在 Python 中创建键拥有多个值的字典为我们处理复杂数据关系提供了强大的工具。通过使用列表或集合作为值，我们可以灵活地满足不同的业务需求。在实际应用中，合理选择数据类型以及注重代码的可读性和维护性是高效使用这一特性的关键。

## 参考资料
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries)
- 《Python 核心编程》
- [Stack Overflow - Python 多值字典相关问题](https://stackoverflow.com/questions/tagged/multiple-values-per-key+dictionary+python)
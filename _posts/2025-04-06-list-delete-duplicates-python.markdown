---
title: "Python 中删除列表（List）中的重复元素"
description: "在 Python 编程中，处理列表时经常会遇到需要删除列表中重复元素的情况。这在数据清理、统计分析以及确保数据的唯一性等场景中十分常见。本文将深入探讨在 Python 中删除列表重复元素的相关知识，包括基础概念、多种使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，处理列表时经常会遇到需要删除列表中重复元素的情况。这在数据清理、统计分析以及确保数据的唯一性等场景中十分常见。本文将深入探讨在 Python 中删除列表重复元素的相关知识，包括基础概念、多种使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用集合（Set）
    - 使用字典（Dictionary）
    - 循环遍历判断
3. 常见实践
    - 处理数值型列表
    - 处理字符串列表
    - 处理复杂对象列表
4. 最佳实践
    - 性能考量
    - 代码可读性与维护性
5. 小结
6. 参考资料

## 基础概念
在 Python 中，列表（List）是一种有序的可变序列，可以包含各种数据类型的元素。然而，有时列表中可能会出现重复的元素。例如：`my_list = [1, 2, 2, 3, 4, 4, 5]`，其中 `2` 和 `4` 就是重复元素。删除这些重复元素可以使列表更加简洁，并且在某些情况下能够提高算法的效率。

## 使用方法

### 使用集合（Set）
集合（Set）是 Python 中的一种无序且唯一的数据结构。利用集合的这一特性，可以很方便地删除列表中的重复元素。

```python
my_list = [1, 2, 2, 3, 4, 4, 5]
unique_list = list(set(my_list))
print(unique_list)  
```

### 使用字典（Dictionary）
字典（Dictionary）的键（Key）是唯一的，我们可以利用这一特性来删除列表中的重复元素。

```python
my_list = [1, 2, 2, 3, 4, 4, 5]
unique_list = list(dict.fromkeys(my_list))
print(unique_list)  
```

### 循环遍历判断
通过循环遍历列表，手动判断并删除重复元素。

```python
my_list = [1, 2, 2, 3, 4, 4, 5]
result = []
for element in my_list:
    if element not in result:
        result.append(element)
print(result)  
```

## 常见实践

### 处理数值型列表
在处理数值型列表时，上述方法都可以很好地工作。例如：

```python
number_list = [10, 20, 20, 30, 40, 40, 50]
# 使用集合
unique_number_list1 = list(set(number_list))
# 使用字典
unique_number_list2 = list(dict.fromkeys(number_list))
# 循环遍历
unique_number_list3 = []
for num in number_list:
    if num not in unique_number_list3:
        unique_number_list3.append(num)

print(unique_number_list1)
print(unique_number_list2)
print(unique_number_list3)
```

### 处理字符串列表
对于字符串列表，同样可以使用这些方法。

```python
string_list = ["apple", "banana", "banana", "cherry", "cherry"]
# 使用集合
unique_string_list1 = list(set(string_list))
# 使用字典
unique_string_list2 = list(dict.fromkeys(string_list))
# 循环遍历
unique_string_list3 = []
for string in string_list:
    if string not in unique_string_list3:
        unique_string_list3.append(string)

print(unique_string_list1)
print(unique_string_list2)
print(unique_string_list3)
```

### 处理复杂对象列表
当列表中包含复杂对象（如自定义类的实例）时，情况会稍微复杂一些。集合和字典在处理复杂对象时需要对象是可哈希（hashable）的。如果对象不可哈希，需要重写对象的 `__hash__` 和 `__eq__` 方法。

```python
class MyClass:
    def __init__(self, value):
        self.value = value

    def __hash__(self):
        return hash(self.value)

    def __eq__(self, other):
        return self.value == other.value


object_list = [MyClass(1), MyClass(2), MyClass(2), MyClass(3)]
unique_object_list = list(set(object_list))
print([obj.value for obj in unique_object_list])
```

## 最佳实践

### 性能考量
- **集合（Set）**：在大多数情况下，使用集合来删除重复元素是最快的方法，因为集合的查找操作平均时间复杂度为 O(1)。特别是对于大型列表，使用集合能够显著提高效率。
- **字典（Dictionary）**：使用字典 `fromkeys` 方法的性能也比较高，时间复杂度接近 O(n)。它适用于需要保持元素顺序的情况，因为字典在 Python 3.7+ 中是有序的。
- **循环遍历判断**：循环遍历判断的方法时间复杂度为 O(n^2)，对于大型列表来说效率较低，因此不推荐在大数据量的情况下使用。

### 代码可读性与维护性
- 当对性能要求不高，更注重代码的可读性时，循环遍历判断的方法虽然效率低，但逻辑简单易懂。
- 如果需要保持元素的顺序，使用字典 `fromkeys` 方法是一个不错的选择，代码简洁且能满足需求。
- 对于追求极致性能且不关心元素顺序的场景，集合无疑是最佳选择。

## 小结
在 Python 中删除列表中的重复元素有多种方法，每种方法都有其适用场景。使用集合是最快速的方法，适合不关心元素顺序的场景；使用字典 `fromkeys` 方法可以在保持元素顺序的同时高效地删除重复元素；循环遍历判断方法虽然逻辑简单，但效率较低，适用于小型列表或对性能要求不高的情况。在实际应用中，需要根据具体需求和性能要求选择合适的方法。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- [Python 教程 - 廖雪峰](https://www.liaoxuefeng.com/wiki/1016959663602400){: rel="nofollow"}

希望本文能帮助读者深入理解并高效使用 Python 中删除列表重复元素的方法。如果有任何问题或建议，欢迎在评论区留言。
---
title: "Python 中列表排序（Sort a List）：从基础到最佳实践"
description: "在 Python 编程中，对列表进行排序是一项常见且重要的操作。无论是处理数据集合、整理算法结果还是优化代码逻辑，掌握列表排序的方法都能大大提升编程效率。本文将深入探讨 Python 中列表排序的基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助你全面掌握这一关键技能。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在 Python 编程中，对列表进行排序是一项常见且重要的操作。无论是处理数据集合、整理算法结果还是优化代码逻辑，掌握列表排序的方法都能大大提升编程效率。本文将深入探讨 Python 中列表排序的基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助你全面掌握这一关键技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 列表的 `sort()` 方法
    - `sorted()` 函数
    - 自定义排序规则
3. 常见实践
    - 数字列表排序
    - 字符串列表排序
    - 复杂对象列表排序
4. 最佳实践
    - 性能优化
    - 代码可读性优化
5. 小结
6. 参考资料

## 基础概念
在 Python 中，列表（List）是一种有序且可变的数据结构。排序操作旨在按照特定的顺序重新排列列表中的元素。排序可以是升序（从小到大）或降序（从大到小）。Python 提供了多种内置方法和函数来实现列表排序，每种方法都有其特点和适用场景。

## 使用方法

### 列表的 `sort()` 方法
列表对象本身具有 `sort()` 方法，该方法会直接修改原始列表，使其元素按指定顺序排列。
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
my_list.sort()
print(my_list)  
```
上述代码中，`my_list.sort()` 会将列表 `my_list` 中的元素按升序排列，输出结果为 `[1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]`。

若要按降序排列，可以使用 `reverse=True` 参数：
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
my_list.sort(reverse=True)
print(my_list)  
```
输出结果为 `[9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]`。

### `sorted()` 函数
`sorted()` 函数是一个内置函数，它接受一个可迭代对象（如列表）作为参数，并返回一个新的已排序列表，原始列表不会被修改。
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
new_list = sorted(my_list)
print(new_list)  
print(my_list)  
```
上述代码中，`sorted(my_list)` 会返回一个新的已排序列表 `[1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]`，而原始列表 `my_list` 保持不变。

同样，`sorted()` 函数也支持 `reverse=True` 参数来实现降序排序：
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
new_list = sorted(my_list, reverse=True)
print(new_list)  
```
输出结果为 `[9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]`。

### 自定义排序规则
在某些情况下，我们需要根据自定义的规则对列表进行排序。这可以通过 `key` 参数来实现。`key` 参数接受一个函数，该函数将应用于列表中的每个元素，然后根据函数的返回值进行排序。

例如，对字符串列表按字符串长度进行排序：
```python
string_list = ["banana", "apple", "cherry", "date"]
sorted_by_length = sorted(string_list, key=lambda x: len(x))
print(sorted_by_length)  
```
上述代码中，`key=lambda x: len(x)` 表示按字符串的长度进行排序，输出结果为 `["date", "apple", "cherry", "banana"]`。

## 常见实践

### 数字列表排序
数字列表排序是最常见的场景之一。无论是对成绩列表、价格列表还是其他数值数据进行排序，都可以使用上述提到的方法。
```python
grades = [85, 90, 78, 95, 88]
grades.sort()
print(grades)  
```
输出结果为 `[78, 85, 88, 90, 95]`。

### 字符串列表排序
字符串列表排序可以按字母顺序进行。
```python
fruits = ["banana", "apple", "cherry", "date"]
fruits.sort()
print(fruits)  
```
输出结果为 `["apple", "banana", "cherry", "date"]`。

### 复杂对象列表排序
当列表中的元素是自定义对象时，排序会稍微复杂一些。我们需要定义一个排序规则来告诉 Python 如何比较这些对象。

例如，定义一个 `Person` 类，并按年龄对 `Person` 对象列表进行排序：
```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __repr__(self):
        return f"Person({self.name}, {self.age})"


people = [Person("Alice", 25), Person("Bob", 20), Person("Charlie", 30)]
people.sort(key=lambda p: p.age)
print(people)  
```
上述代码中，`key=lambda p: p.age` 表示按 `Person` 对象的年龄进行排序，输出结果为 `[Person(Bob, 20), Person(Alice, 25), Person(Charlie, 30)]`。

## 最佳实践

### 性能优化
- **选择合适的方法**：如果需要修改原始列表且对性能要求较高，使用列表的 `sort()` 方法。如果需要保留原始列表并获得一个新的已排序列表，使用 `sorted()` 函数。
- **减少不必要的计算**：在使用 `key` 函数时，尽量避免在函数内部进行复杂的计算。如果可能，可以提前计算好需要排序的键值，并将其存储在一个新的列表中，然后使用这个新列表进行排序。

### 代码可读性优化
- **使用具名函数代替匿名函数**：当 `key` 函数的逻辑较为复杂时，使用具名函数可以提高代码的可读性。
```python
def get_age(person):
    return person.age


people = [Person("Alice", 25), Person("Bob", 20), Person("Charlie", 30)]
people.sort(key=get_age)
print(people)  
```
- **添加注释**：在进行复杂的排序操作时，添加注释可以帮助其他开发者理解排序的逻辑。

## 小结
本文详细介绍了 Python 中对列表进行排序的多种方法，包括列表的 `sort()` 方法、`sorted()` 函数以及自定义排序规则的使用。通过常见实践和最佳实践的讲解，希望你能够在实际编程中灵活运用这些知识，高效地处理列表排序问题。

## 参考资料
- 《Python 核心编程》
- 《Effective Python》
---
title: "Python 中的列表（List）与字典（Dictionary）"
description: "在 Python 编程中，列表（List）和字典（Dictionary）是两种极为重要的数据结构。它们各自有着独特的特点和用途，广泛应用于各种程序开发场景中。理解并熟练掌握这两种数据结构的使用方法，对于编写高效、简洁的 Python 代码至关重要。本文将深入探讨 Python 中列表和字典的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用它们解决实际问题。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，列表（List）和字典（Dictionary）是两种极为重要的数据结构。它们各自有着独特的特点和用途，广泛应用于各种程序开发场景中。理解并熟练掌握这两种数据结构的使用方法，对于编写高效、简洁的 Python 代码至关重要。本文将深入探讨 Python 中列表和字典的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用它们解决实际问题。

<!-- more -->
## 目录
1. 列表（List）基础概念
2. 列表的使用方法
    - 创建列表
    - 访问列表元素
    - 修改列表元素
    - 添加和删除元素
    - 列表操作方法
3. 字典（Dictionary）基础概念
4. 字典的使用方法
    - 创建字典
    - 访问字典值
    - 修改字典值
    - 添加和删除键值对
    - 字典操作方法
5. 常见实践
    - 列表的常见实践
    - 字典的常见实践
6. 最佳实践
    - 列表的最佳实践
    - 字典的最佳实践
7. 小结
8. 参考资料

## 列表（List）基础概念
列表是 Python 中一种有序的可变数据结构，它可以存储不同类型的数据，例如整数、字符串、浮点数，甚至可以包含其他列表或字典等复杂数据类型。列表使用方括号 `[]` 来表示，元素之间用逗号 `,` 分隔。

## 列表的使用方法
### 创建列表
```python
# 创建一个空列表
empty_list = []

# 创建一个包含整数的列表
int_list = [1, 2, 3, 4, 5]

# 创建一个包含不同类型数据的列表
mixed_list = [1, "hello", 3.14, [4, 5]]
```

### 访问列表元素
列表中的元素可以通过索引来访问，索引从 0 开始。
```python
fruits = ["apple", "banana", "cherry"]
print(fruits[0])  # 输出 "apple"
print(fruits[2])  # 输出 "cherry"

# 可以使用负索引从列表末尾开始访问元素
print(fruits[-1])  # 输出 "cherry"
print(fruits[-2])  # 输出 "banana"
```

### 修改列表元素
可以通过索引直接修改列表中的元素。
```python
numbers = [1, 2, 3, 4, 5]
numbers[2] = 30
print(numbers)  # 输出 [1, 2, 30, 4, 5]
```

### 添加和删除元素
- **添加元素**
    ```python
    animals = ["cat", "dog"]
    animals.append("rabbit")  # 在列表末尾添加元素
    print(animals)  # 输出 ["cat", "dog", "rabbit"]

    animals.insert(1, "bird")  # 在指定索引位置插入元素
    print(animals)  # 输出 ["cat", "bird", "dog", "rabbit"]
    ```
- **删除元素**
    ```python
    colors = ["red", "green", "blue"]
    del colors[1]  # 删除指定索引位置的元素
    print(colors)  # 输出 ["red", "blue"]

    colors.remove("red")  # 删除指定值的元素
    print(colors)  # 输出 ["blue"]
    ```

### 列表操作方法
列表有许多内置方法，例如 `len()` 用于获取列表长度，`sort()` 用于对列表进行排序，`reverse()` 用于反转列表等。
```python
nums = [5, 2, 8, 1, 9]
print(len(nums))  # 输出 5

nums.sort()
print(nums)  # 输出 [1, 2, 5, 8, 9]

nums.reverse()
print(nums)  # 输出 [9, 8, 5, 2, 1]
```

## 字典（Dictionary）基础概念
字典是 Python 中一种无序的数据结构，它以键值对（key-value pair）的形式存储数据。每个键（key）必须是唯一的，并且不可变（通常是字符串或数字），而值（value）可以是任何类型的数据。字典使用花括号 `{}` 来表示，键值对之间用冒号 `:` 分隔，不同键值对之间用逗号 `,` 分隔。

## 字典的使用方法
### 创建字典
```python
# 创建一个空字典
empty_dict = {}

# 创建一个包含键值对的字典
person = {"name": "Alice", "age": 30, "city": "New York"}
```

### 访问字典值
可以通过键来访问字典中的值。
```python
person = {"name": "Bob", "age": 25, "job": "Engineer"}
print(person["name"])  # 输出 "Bob"

# 如果访问不存在的键，会引发 KeyError 错误
# print(person["country"])  # 这行代码会报错

# 可以使用 get() 方法来避免错误
print(person.get("country"))  # 输出 None
```

### 修改字典值
通过键可以直接修改字典中的值。
```python
car = {"brand": "Toyota", "model": "Corolla", "year": 2020}
car["year"] = 2023
print(car)  # 输出 {"brand": "Toyota", "model": "Corolla", "year": 2023}
```

### 添加和删除键值对
- **添加键值对**
    ```python
    student = {"name": "Charlie", "grade": "A"}
    student["major"] = "Computer Science"  # 添加新的键值对
    print(student)  # 输出 {"name": "Charlie", "grade": "A", "major": "Computer Science"}
    ```
- **删除键值对**
    ```python
    employee = {"name": "David", "department": "Sales", "salary": 5000}
    del employee["department"]  # 删除指定键值对
    print(employee)  # 输出 {"name": "David", "salary": 5000}

    salary = employee.pop("salary")  # 删除指定键并返回对应的值
    print(employee)  # 输出 {"name": "David"}
    print(salary)  # 输出 5000
    ```

### 字典操作方法
字典也有许多有用的方法，例如 `keys()` 用于获取所有键，`values()` 用于获取所有值，`items()` 用于获取所有键值对。
```python
product = {"name": "Laptop", "price": 1000, "quantity": 5}
print(product.keys())  # 输出 dict_keys(['name', 'price', 'quantity'])
print(product.values())  # 输出 dict_values(['Laptop', 1000, 5])
print(product.items())  # 输出 dict_items([('name', 'Laptop'), ('price', 1000), ('quantity', 5)])
```

## 常见实践
### 列表的常见实践
- **遍历列表**
    ```python
    numbers = [1, 2, 3, 4, 5]
    for num in numbers:
        print(num)
    ```
- **列表推导式**
    ```python
    squares = [num ** 2 for num in numbers]
    print(squares)  # 输出 [1, 4, 9, 16, 25]
    ```

### 字典的常见实践
- **遍历字典**
    ```python
    person = {"name": "Eve", "age": 28, "city": "Los Angeles"}
    for key, value in person.items():
        print(f"{key}: {value}")
    ```
- **根据值查找键**
    ```python
    def find_key_by_value(dictionary, target_value):
        for key, value in dictionary.items():
            if value == target_value:
                return key
        return None

    result = find_key_by_value(person, "Los Angeles")
    print(result)  # 输出 "city"
    ```

## 最佳实践
### 列表的最佳实践
- **避免在遍历列表时修改列表**：如果需要在遍历列表的同时修改列表，可以创建一个新的列表来存储修改后的值。
- **使用列表推导式替代循环**：列表推导式通常更加简洁和高效，能提高代码的可读性。
- **对列表进行切片操作时要注意边界**：确保切片的起始和结束索引符合预期，避免出现越界错误。

### 字典的最佳实践
- **使用 `defaultdict` 来处理缺失键**：`defaultdict` 可以在访问不存在的键时返回一个默认值，避免 `KeyError` 错误。
```python
from collections import defaultdict

d = defaultdict(int)
print(d["new_key"])  # 输出 0
```
- **使用 `OrderedDict` 来保持键的插入顺序**：如果需要记住字典中键的插入顺序，可以使用 `OrderedDict`。
```python
from collections import OrderedDict

od = OrderedDict()
od["a"] = 1
od["b"] = 2
for key in od:
    print(key)  # 输出顺序与插入顺序一致
```

## 小结
列表和字典是 Python 编程中不可或缺的数据结构。列表适合存储有序的、可变的数据序列，而字典则更适合处理键值对形式的数据。通过掌握它们的基础概念、使用方法、常见实践和最佳实践，我们能够更加高效地编写 Python 代码，解决各种实际问题。

## 参考资料
- [Python 官方文档 - 列表](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries)
- 《Python 快速上手：让繁琐工作自动化》
- 《Python 核心编程》
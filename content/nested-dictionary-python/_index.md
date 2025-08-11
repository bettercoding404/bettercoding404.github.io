---
title: "深入探索 Python 中的嵌套字典"
description: "在 Python 编程中，字典（dictionary）是一种非常强大的数据结构，它允许我们以键值对（key-value pairs）的形式存储和访问数据。而嵌套字典（nested dictionary）则是字典的一种扩展形式，它让我们能够以一种层次化的方式组织数据。这种结构在处理复杂的数据关系和多维数据时非常有用。本文将深入探讨 Python 中嵌套字典的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一强大的数据结构。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常强大的数据结构，它允许我们以键值对（key-value pairs）的形式存储和访问数据。而嵌套字典（nested dictionary）则是字典的一种扩展形式，它让我们能够以一种层次化的方式组织数据。这种结构在处理复杂的数据关系和多维数据时非常有用。本文将深入探讨 Python 中嵌套字典的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一强大的数据结构。

<!-- more -->
## 目录
1. 嵌套字典基础概念
2. 嵌套字典使用方法
    - 创建嵌套字典
    - 访问嵌套字典中的值
    - 修改嵌套字典中的值
    - 添加新的键值对到嵌套字典
    - 删除嵌套字典中的键值对
3. 嵌套字典常见实践
    - 用于表示层级结构数据
    - 处理多维数据
    - 统计和分组数据
4. 嵌套字典最佳实践
    - 保持结构清晰
    - 使用描述性的键名
    - 避免过度嵌套
    - 适当使用函数封装操作
5. 小结
6. 参考资料

## 嵌套字典基础概念
嵌套字典就是在一个字典中，其值（value）又可以是另一个字典。简单来说，就是字典里面套字典。这种结构可以用来表示具有层次关系的数据，例如一个包含多个部门，每个部门又有多个员工信息的公司结构。

## 嵌套字典使用方法

### 创建嵌套字典
创建嵌套字典有多种方式，最直观的就是直接在大括号内嵌套字典。例如：
```python
# 创建一个简单的嵌套字典
company = {
    "sales": {
        "employee1": "Alice",
        "employee2": "Bob"
    },
    "engineering": {
        "employee3": "Charlie",
        "employee4": "David"
    }
}
print(company)
```

### 访问嵌套字典中的值
要访问嵌套字典中的值，需要使用多层键来定位。例如，要获取 `sales` 部门下 `employee1` 的名字：
```python
print(company["sales"]["employee1"])  
```

### 修改嵌套字典中的值
修改嵌套字典中的值也很简单，通过定位到要修改的键值对，然后重新赋值即可。比如，将 `engineering` 部门下 `employee3` 的名字修改为 `Eve`：
```python
company["engineering"]["employee3"] = "Eve"
print(company["engineering"]["employee3"])  
```

### 添加新的键值对到嵌套字典
可以在已有的嵌套字典中添加新的键值对。例如，给 `sales` 部门添加一个新员工 `employee5`：
```python
company["sales"]["employee5"] = "Frank"
print(company["sales"])  
```

### 删除嵌套字典中的键值对
使用 `del` 关键字可以删除嵌套字典中的键值对。比如，删除 `engineering` 部门下的 `employee4`：
```python
del company["engineering"]["employee4"]
print(company["engineering"])  
```

## 嵌套字典常见实践

### 用于表示层级结构数据
嵌套字典非常适合表示层级结构的数据，比如文件系统中的目录和文件关系：
```python
file_system = {
    "root": {
        "documents": {
            "report.txt": "This is a report file",
            "presentation.pptx": "Presentation file"
        },
        "pictures": {
            "vacation.jpg": "Photo from vacation",
            "family.png": "Family picture"
        }
    }
}
```

### 处理多维数据
在处理多维数据时，嵌套字典也能发挥作用。例如，一个二维矩阵可以用嵌套字典表示：
```python
matrix = {
    0: {0: 1, 1: 2},
    1: {0: 3, 1: 4}
}
print(matrix[0][1])  
```

### 统计和分组数据
嵌套字典可以用于统计和分组数据。例如，统计不同班级学生的成绩：
```python
student_grades = {
    "class1": {
        "Alice": 90,
        "Bob": 85
    },
    "class2": {
        "Charlie": 78,
        "David": 92
    }
}
```

## 嵌套字典最佳实践

### 保持结构清晰
在设计嵌套字典结构时，要确保结构清晰易懂。避免过于复杂的嵌套层次，尽量将相关的数据放在同一层级。

### 使用描述性的键名
使用具有描述性的键名，这样可以提高代码的可读性。例如，用 `employee_name` 而不是简单的 `e1` 作为键名。

### 避免过度嵌套
虽然嵌套字典可以支持多层嵌套，但过度嵌套会使代码难以维护和理解。尽量将复杂的数据结构拆分成多个简单的部分。

### 适当使用函数封装操作
对于频繁操作嵌套字典的代码，可以封装成函数，提高代码的复用性和可维护性。例如：
```python
def get_nested_value(dictionary, key1, key2):
    if key1 in dictionary and key2 in dictionary[key1]:
        return dictionary[key1][key2]
    return None

print(get_nested_value(company, "sales", "employee1"))  
```

## 小结
嵌套字典是 Python 中一种强大的数据结构，它为我们处理复杂的层次化和多维数据提供了便利。通过清晰的创建、访问、修改和删除操作，以及合理的结构设计和最佳实践，我们可以高效地使用嵌套字典来解决各种实际问题。希望本文的介绍能帮助你更好地理解和运用 Python 中的嵌套字典。

## 参考资料
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries)
- 《Python 数据分析实战》

以上博客围绕 `nested dictionary python` 主题，全面介绍了嵌套字典的相关知识，希望能满足你的需求。如果还有其他要求，请随时告诉我。  
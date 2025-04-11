---
title: "Python 中创建键具有多个值的字典"
description: "在 Python 编程中，字典（dictionary）是一种非常有用的数据结构，它以键值对（key-value pairs）的形式存储数据。通常情况下，一个键对应一个值，但在某些实际场景中，我们需要一个键能够关联多个值。本文将深入探讨在 Python 中创建键具有多个值的字典的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技巧并在实际编程中灵活运用。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常有用的数据结构，它以键值对（key-value pairs）的形式存储数据。通常情况下，一个键对应一个值，但在某些实际场景中，我们需要一个键能够关联多个值。本文将深入探讨在 Python 中创建键具有多个值的字典的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技巧并在实际编程中灵活运用。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用列表作为值**
    - **使用集合作为值**
3. **常见实践**
    - **数据分组**
    - **统计元素出现次数**
4. **最佳实践**
    - **选择合适的数据类型**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，常规的字典结构是一个键对应一个值，例如：
```python
normal_dict = {'name': 'Alice', 'age': 25}
```
然而，当一个键需要关联多个值时，我们就需要特殊的处理方式。这种数据结构可以用于许多场景，比如将学生名字作为键，对应的多门课程成绩作为值；将城市作为键，该城市的多个景点作为值等。

## 使用方法

### 使用列表作为值
最常见的方法是使用列表（list）来存储一个键对应的多个值。这样可以保留值的顺序，并且允许重复的值。
```python
# 创建一个键对应多个值的字典，值使用列表存储
multi_value_dict = {}
key = 'fruits'
value1 = 'apple'
value2 = 'banana'
value3 = 'cherry'

# 如果键不存在，创建新的键值对，值为包含新值的列表
if key not in multi_value_dict:
    multi_value_dict[key] = [value1]
else:
    multi_value_dict[key].append(value1)

# 另一种更简洁的方式
multi_value_dict.setdefault(key, []).append(value2)
multi_value_dict.setdefault(key, []).append(value3)

print(multi_value_dict)
```
在上述代码中，我们首先创建了一个空字典 `multi_value_dict`。然后通过 `if` 语句检查键是否存在，如果不存在则创建一个新的列表作为值；如果存在，则将新值追加到已有的列表中。`setdefault` 方法则提供了一种更简洁的方式来实现相同的功能。

### 使用集合作为值
如果我们不关心值的顺序，并且希望避免重复的值，可以使用集合（set）作为值。
```python
# 创建一个键对应多个值的字典，值使用集合存储
set_multi_value_dict = {}
key = 'numbers'
value1 = 1
value2 = 2
value3 = 2  # 这个值会被集合去重

# 使用 setdefault 方法添加值
set_multi_value_dict.setdefault(key, set()).add(value1)
set_multi_value_dict.setdefault(key, set()).add(value2)
set_multi_value_dict.setdefault(key, set()).add(value3)

print(set_multi_value_dict)
```
在这个例子中，我们使用集合来存储值。集合的特性确保了不会有重复的值，并且由于集合是无序的，所以添加值的顺序不会被保留。

## 常见实践

### 数据分组
假设我们有一个包含学生姓名和对应课程的列表，我们想将学生按姓名分组，每个学生对应他所学的所有课程。
```python
student_courses = [('Alice', 'Math'), ('Bob', 'Science'), ('Alice', 'English'), ('Bob', 'History')]
grouped_courses = {}

for student, course in student_courses:
    grouped_courses.setdefault(student, []).append(course)

print(grouped_courses)
```
这段代码遍历学生和课程的列表，使用字典将学生作为键，对应的课程列表作为值进行分组。

### 统计元素出现次数
我们可以使用字典来统计字符串中每个字符出现的次数，每个字符作为键，出现的次数作为值。
```python
string = "hello world"
char_count = {}

for char in string:
    char_count.setdefault(char, 0)
    char_count[char] += 1

print(char_count)
```
这里我们遍历字符串中的每个字符，使用字典统计每个字符出现的次数。

## 最佳实践

### 选择合适的数据类型
在决定使用列表还是集合作为值时，要根据实际需求来选择。如果需要保留值的顺序或者允许重复值，列表是更好的选择；如果不关心顺序并且要去除重复值，集合则更为合适。

### 性能优化
当处理大量数据时，性能是需要考虑的因素。使用 `setdefault` 方法虽然简洁，但在某些情况下可能会影响性能。可以预先初始化字典的键值对，避免在循环中频繁检查键是否存在。例如：
```python
# 预先初始化字典
student_courses = [('Alice', 'Math'), ('Bob', 'Science'), ('Alice', 'English'), ('Bob', 'History')]
students = set([student for student, _ in student_courses])
grouped_courses = {student: [] for student in students}

for student, course in student_courses:
    grouped_courses[student].append(course)

print(grouped_courses)
```
这种方法预先创建了所有的键，并初始化了空列表作为值，避免了在循环中使用 `setdefault` 方法带来的额外开销。

## 小结
在 Python 中创建键具有多个值的字典是一项非常实用的技巧，通过使用列表或集合作为值，我们可以满足不同的业务需求。在实际应用中，我们需要根据具体情况选择合适的数据类型，并注意性能优化。希望本文介绍的基础概念、使用方法、常见实践以及最佳实践能够帮助读者更好地理解和运用这一特性，提高 Python 编程能力。

## 参考资料
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries){: rel="nofollow"}
- [Python 官方文档 - 列表](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python 官方文档 - 集合](https://docs.python.org/3/tutorial/datastructures.html#sets){: rel="nofollow"}
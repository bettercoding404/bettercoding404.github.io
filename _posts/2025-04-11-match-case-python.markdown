---
title: "Python 中的 match case 语句：强大的模式匹配工具"
description: "在 Python 3.10 之前，开发人员主要使用 `if-elif-else` 语句来进行复杂的条件判断。虽然这种方式有效，但对于复杂的多条件匹配场景，代码往往会变得冗长且难以维护。Python 3.10 引入的 `match case` 语句（模式匹配语句）改变了这一局面，它提供了一种更简洁、易读的方式来处理多种条件分支，大大提高了代码的可读性和可维护性。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 3.10 之前，开发人员主要使用 `if-elif-else` 语句来进行复杂的条件判断。虽然这种方式有效，但对于复杂的多条件匹配场景，代码往往会变得冗长且难以维护。Python 3.10 引入的 `match case` 语句（模式匹配语句）改变了这一局面，它提供了一种更简洁、易读的方式来处理多种条件分支，大大提高了代码的可读性和可维护性。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **简单值匹配**
    - **序列匹配**
    - **字典匹配**
    - **类实例匹配**
3. **常见实践**
    - **替代复杂的 if-else 结构**
    - **状态机实现**
4. **最佳实践**
    - **保持模式简洁**
    - **使用 _ 作为通配符**
    - **处理多个匹配分支**
5. **小结**
6. **参考资料**

## 基础概念
`match case` 语句允许你将一个值与一系列模式进行比较，并根据匹配的模式执行相应的代码块。它的基本语法如下：

```python
match subject:
    case <pattern_1>:
        <statement(s)>
    case <pattern_2>:
        <statement(s)>
    case _:
        <statement(s)>
```

- `subject` 是要匹配的值。
- `<pattern_1>`、`<pattern_2>` 等是不同的模式。
- `case _` 是一个通配符模式，当所有其他模式都不匹配时会执行该分支。

## 使用方法

### 简单值匹配
最基本的 `match case` 用法是对简单值（如整数、字符串等）进行匹配。

```python
def get_day_name(day_number):
    match day_number:
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        case 7:
            return "Sunday"
        case _:
            return "Invalid day number"

print(get_day_name(3))  
```

### 序列匹配
`match case` 也可以对序列（如列表、元组）进行匹配。

```python
def process_point(point):
    match point:
        case [0, 0]:
            return "Origin"
        case [x, 0]:
            return f"On the x-axis at x={x}"
        case [0, y]:
            return f"On the y-axis at y={y}"
        case [x, y]:
            return f"At coordinates ({x}, {y})"
        case _:
            return "Invalid point"

print(process_point([2, 3]))  
```

### 字典匹配
对于字典，`match case` 可以根据键值对进行匹配。

```python
def process_person(person):
    match person:
        case {"name": "Alice", "age": 25}:
            return "Alice is 25 years old"
        case {"name": "Bob", "age": 30}:
            return "Bob is 30 years old"
        case {"name": name, "age": age}:
            return f"{name} is {age} years old"
        case _:
            return "Unknown person"

print(process_person({"name": "Charlie", "age": 35}))  
```

### 类实例匹配
`match case` 还能对类实例进行匹配，并根据实例的属性进行模式匹配。

```python
class Shape:
    pass

class Circle(Shape):
    def __init__(self, radius):
        self.radius = radius

class Rectangle(Shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height

def process_shape(shape):
    match shape:
        case Circle(radius=1):
            return "Unit circle"
        case Circle(radius=r):
            return f"Circle with radius {r}"
        case Rectangle(width=w, height=h):
            return f"Rectangle with width {w} and height {h}"
        case _:
            return "Unknown shape"

circle = Circle(5)
rectangle = Rectangle(4, 6)

print(process_shape(circle))  
print(process_shape(rectangle))  
```

## 常见实践

### 替代复杂的 if-else 结构
在处理多个条件判断时，`match case` 语句比传统的 `if-else` 结构更加清晰和易读。

```python
# 传统 if-else 结构
def get_grade(score):
    if 90 <= score <= 100:
        return "A"
    elif 80 <= score < 90:
        return "B"
    elif 70 <= score < 80:
        return "C"
    elif 60 <= score < 70:
        return "D"
    elif 0 <= score < 60:
        return "F"
    else:
        return "Invalid score"

# 使用 match case
def get_grade(score):
    match score:
        case score if 90 <= score <= 100:
            return "A"
        case score if 80 <= score < 90:
            return "B"
        case score if 70 <= score < 80:
            return "C"
        case score if 60 <= score < 70:
            return "D"
        case score if 0 <= score < 60:
            return "F"
        case _:
            return "Invalid score"
```

### 状态机实现
`match case` 可以方便地实现状态机，使代码逻辑更加清晰。

```python
class StateMachine:
    def __init__(self):
        self.state = "start"

    def transition(self, event):
        match (self.state, event):
            case ("start", "button_click"):
                self.state = "paused"
            case ("paused", "button_click"):
                self.state = "running"
            case ("running", "button_click"):
                self.state = "paused"
            case _:
                pass

    def get_state(self):
        return self.state

machine = StateMachine()
machine.transition("button_click")
print(machine.get_state())  
```

## 最佳实践

### 保持模式简洁
模式应该尽可能简洁明了，避免过于复杂的逻辑。如果模式变得过于复杂，可能会降低代码的可读性。

### 使用 _ 作为通配符
在不需要处理所有可能情况时，使用 `case _` 作为通配符来处理默认情况，使代码更加简洁。

### 处理多个匹配分支
如果多个模式需要执行相同的代码块，可以将这些模式写在同一行，用 `|` 分隔。

```python
def process_number(num):
    match num:
        case 1 | 2 | 3:
            return "Small number"
        case 4 | 5 | 6:
            return "Medium number"
        case 7 | 8 | 9:
            return "Large number"
        case _:
            return "Invalid number"

print(process_number(2))  
```

## 小结
Python 的 `match case` 语句为开发人员提供了一种强大而简洁的模式匹配工具。通过使用它，可以替代复杂的 `if-else` 结构，提高代码的可读性和可维护性。在处理序列、字典、类实例等多种数据类型时，`match case` 都能发挥其优势，尤其在状态机实现等场景中表现出色。遵循最佳实践，如保持模式简洁、合理使用通配符等，能让代码更加优雅高效。

## 参考资料
- [Python官方文档 - 3.10新特性](https://docs.python.org/3/whatsnew/3.10.html#pep-634-structural-pattern-matching){: rel="nofollow"}
- [Python Patterns - match-case](https://www.python.org/dev/peps/pep-0634/){: rel="nofollow"}
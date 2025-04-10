---
title: "深入探究 Python 中的 match 语句"
description: "在 Python 3.10 中引入的 `match` 语句，为模式匹配提供了一种简洁而强大的方式。它类似于其他编程语言中的 `switch` 语句，但在 Python 中有着独特的语法和应用场景，极大地提升了代码的可读性和可维护性。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 3.10 中引入的 `match` 语句，为模式匹配提供了一种简洁而强大的方式。它类似于其他编程语言中的 `switch` 语句，但在 Python 中有着独特的语法和应用场景，极大地提升了代码的可读性和可维护性。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **简单模式匹配**
    - **匹配多个值**
    - **使用通配符**
    - **匹配对象属性**
3. **常见实践**
    - **处理枚举类型**
    - **解析命令行参数**
4. **最佳实践**
    - **保持模式的简洁性**
    - **使用注释解释复杂模式**
5. **小结**
6. **参考资料**

## 基础概念
`match` 语句允许你将一个值与一系列模式进行比较。当找到匹配的模式时，执行相应的代码块。它基于结构模式匹配的概念，不仅可以匹配简单的值，还能处理更复杂的数据结构，如元组、列表和对象。

## 使用方法

### 简单模式匹配
```python
def match_number(x):
    match x:
        case 1:
            print("x 等于 1")
        case 2:
            print("x 等于 2")
        case _:
            print("x 是其他值")

match_number(1)
# 输出: x 等于 1
match_number(3)
# 输出: x 是其他值
```
在这个例子中，`match` 语句将变量 `x` 与不同的模式进行比较。`case` 关键字定义了每个模式及其对应的代码块。`_` 是一个通配符，表示匹配任何值。

### 匹配多个值
```python
def match_color(color):
    match color:
        case "red" | "blue" | "green":
            print(f"{color} 是一种基本颜色")
        case _:
            print(f"{color} 不是基本颜色")

match_color("red")
# 输出: red 是一种基本颜色
match_color("purple")
# 输出: purple 不是基本颜色
```
这里使用 `|` 运算符来匹配多个值。

### 使用通配符
```python
def match_shape(shape):
    match shape:
        case ("circle", radius):
            print(f"这是一个半径为 {radius} 的圆")
        case ("rectangle", width, height):
            print(f"这是一个宽为 {width}，高为 {height} 的矩形")
        case _:
            print("未知形状")

match_shape(("circle", 5))
# 输出: 这是一个半径为 5 的圆
match_shape(("triangle", 3, 4, 5))
# 输出: 未知形状
```
在这个例子中，元组模式用于匹配不同的形状信息。

### 匹配对象属性
```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

def match_point(point):
    match point:
        case Point(x=0, y=0):
            print("点在原点")
        case Point(x=0):
            print("点在 y 轴上")
        case Point(y=0):
            print("点在 x 轴上")
        case _:
            print("点在其他位置")

p1 = Point(0, 0)
match_point(p1)
# 输出: 点在原点

p2 = Point(0, 5)
match_point(p2)
# 输出: 点在 y 轴上
```
这里通过匹配对象的属性来执行不同的代码块。

## 常见实践

### 处理枚举类型
```python
from enum import Enum

class Weekday(Enum):
    MONDAY = 1
    TUESDAY = 2
    WEDNESDAY = 3
    THURSDAY = 4
    FRIDAY = 5
    SATURDAY = 6
    SUNDAY = 7

def match_weekday(day):
    match day:
        case Weekday.MONDAY:
            print("周一，开始工作")
        case Weekday.SATURDAY | Weekday.SUNDAY:
            print("周末，好好休息")
        case _:
            print("工作日，努力工作")

match_weekday(Weekday.MONDAY)
# 输出: 周一，开始工作
match_weekday(Weekday.SATURDAY)
# 输出: 周末，好好休息
```
通过 `match` 语句处理枚举类型，使代码更加清晰易读。

### 解析命令行参数
```python
import sys

def parse_args():
    match sys.argv:
        case ["script.py"]:
            print("没有提供参数")
        case ["script.py", arg]:
            print(f"提供了一个参数: {arg}")
        case ["script.py", *args]:
            print(f"提供了多个参数: {args}")

parse_args()
```
这个例子展示了如何使用 `match` 语句解析命令行参数。

## 最佳实践

### 保持模式的简洁性
尽量使模式简单易懂。避免创建过于复杂的模式，以免降低代码的可读性。

### 使用注释解释复杂模式
如果模式比较复杂，添加注释来解释模式的含义和目的，帮助其他开发人员理解代码。

## 小结
Python 的 `match` 语句为模式匹配提供了一种强大且灵活的方式。通过简单的语法，它可以处理各种类型的匹配场景，从简单的值匹配到复杂的数据结构和对象属性匹配。在实际应用中，合理使用 `match` 语句可以提高代码的可读性和可维护性，尤其是在处理大量条件判断的情况下。

## 参考资料
- [Python 官方文档 - 结构模式匹配](https://docs.python.org/3/whatsnew/3.10.html#structural-pattern-matching){: rel="nofollow"}
- [Real Python - Python's New Pattern Matching](https://realpython.com/python310-new-features/#pythons-new-pattern-matching){: rel="nofollow"}
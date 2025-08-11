---
title: "Python 中的 “case” 语句：深入解析与实践"
description: "在许多编程语言中，`switch - case` 语句是一种常用的条件分支结构，用于根据不同的值执行不同的代码块。然而，Python 并没有像其他语言那样直接提供 `switch - case` 语句。不过，Python 提供了多种方式来实现类似的功能，这篇博客将深入探讨这些方法，帮助你在 Python 中高效地处理条件分支逻辑。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在许多编程语言中，`switch - case` 语句是一种常用的条件分支结构，用于根据不同的值执行不同的代码块。然而，Python 并没有像其他语言那样直接提供 `switch - case` 语句。不过，Python 提供了多种方式来实现类似的功能，这篇博客将深入探讨这些方法，帮助你在 Python 中高效地处理条件分支逻辑。

<!-- more -->
## 目录
1. **基础概念**
    - 传统 `switch - case` 的概念
    - Python 中的替代方案
2. **使用方法**
    - 使用 `if - elif - else` 实现类似功能
    - 使用字典映射实现 `case` 功能
    - 使用 `match - case` 语句（Python 3.10+）
3. **常见实践**
    - 简单的数字判断
    - 字符串匹配
    - 结合类和方法
4. **最佳实践**
    - 代码可读性
    - 性能优化
    - 维护性
5. **小结**
6. **参考资料**

## 基础概念
### 传统 `switch - case` 的概念
在 C、Java 等语言中，`switch - case` 语句提供了一种简洁的方式来根据一个表达式的值选择执行不同的代码块。例如：

```java
int num = 2;
switch (num) {
    case 1:
        System.out.println("The number is 1");
        break;
    case 2:
        System.out.println("The number is 2");
        break;
    default:
        System.out.println("Other number");
}
```

### Python 中的替代方案
Python 没有内置的 `switch - case` 语句，但可以通过 `if - elif - else` 语句、字典映射以及从 Python 3.10 引入的 `match - case` 语句来实现类似的功能。

## 使用方法
### 使用 `if - elif - else` 实现类似功能
这是最常见的方法，通过一系列 `if - elif - else` 语句来模拟 `switch - case` 的行为。

```python
num = 2
if num == 1:
    print("The number is 1")
elif num == 2:
    print("The number is 2")
else:
    print("Other number")
```

### 使用字典映射实现 `case` 功能
可以使用字典将值映射到相应的函数或代码块。

```python
def print_one():
    print("The number is 1")

def print_two():
    print("The number is 2")

num = 2
switcher = {
    1: print_one,
    2: print_two
}

func = switcher.get(num, lambda: print("Other number"))
func()
```

### 使用 `match - case` 语句（Python 3.10+）
这是 Python 3.10 引入的新语法，提供了一种更简洁、模式匹配的方式来实现类似 `switch - case` 的功能。

```python
num = 2
match num:
    case 1:
        print("The number is 1")
    case 2:
        print("The number is 2")
    case _:
        print("Other number")
```

## 常见实践
### 简单的数字判断
```python
# 使用 if - elif - else
score = 85
if score >= 90:
    print("A")
elif score >= 80:
    print("B")
elif score >= 70:
    print("C")
else:
    print("D")

# 使用字典映射
def print_a():
    print("A")

def print_b():
    print("B")

def print_c():
    print("C")

def print_d():
    print("D")

score = 85
switcher = {
    range(90, 101): print_a,
    range(80, 90): print_b,
    range(70, 80): print_c
}

for key in switcher.keys():
    if score in key:
        switcher[key]()
        break
else:
    print_d()

# 使用 match - case
score = 85
match score:
    case score if score >= 90:
        print("A")
    case score if score >= 80:
        print("B")
    case score if score >= 70:
        print("C")
    case _:
        print("D")
```

### 字符串匹配
```python
# 使用 if - elif - else
color = "red"
if color == "red":
    print("The color is red")
elif color == "blue":
    print("The color is blue")
else:
    print("Other color")

# 使用字典映射
def print_red():
    print("The color is red")

def print_blue():
    print("The color is blue")

color = "red"
switcher = {
    "red": print_red,
    "blue": print_blue
}

func = switcher.get(color, lambda: print("Other color"))
func()

# 使用 match - case
color = "red"
match color:
    case "red":
        print("The color is red")
    case "blue":
        print("The color is blue")
    case _:
        print("Other color")
```

### 结合类和方法
```python
class Calculator:
    def add(self, a, b):
        return a + b

    def subtract(self, a, b):
        return a - b

    def multiply(self, a, b):
        return a * b

    def divide(self, a, b):
        if b != 0:
            return a / b
        else:
            return "Division by zero error"

operator = "+"
a = 5
b = 3

# 使用字典映射
calc = Calculator()
switcher = {
    "+": lambda: calc.add(a, b),
    "-": lambda: calc.subtract(a, b),
    "*": lambda: calc.multiply(a, b),
    "/": lambda: calc.divide(a, b)
}

result = switcher.get(operator, lambda: "Invalid operator")()
print(result)

# 使用 match - case
match operator:
    case "+":
        result = calc.add(a, b)
        print(result)
    case "-":
        result = calc.subtract(a, b)
        print(result)
    case "*":
        result = calc.multiply(a, b)
        print(result)
    case "/":
        result = calc.divide(a, b)
        print(result)
    case _:
        print("Invalid operator")
```

## 最佳实践
### 代码可读性
- 使用 `match - case` 语句时，确保模式匹配清晰明了，避免复杂的嵌套逻辑。
- 字典映射中，将函数定义放在靠近字典的地方，以便快速理解映射关系。

### 性能优化
- 对于大量的条件判断，字典映射通常比 `if - elif - else` 更高效，因为字典的查找时间复杂度是 O(1)。
- 如果使用 `match - case`，注意模式匹配的顺序，将最常见的情况放在前面，以减少不必要的匹配。

### 维护性
- 尽量将相关的条件逻辑封装在函数或类中，提高代码的可维护性。
- 对于复杂的条件分支，添加注释以解释每个分支的作用。

## 小结
虽然 Python 没有传统意义上的 `switch - case` 语句，但通过 `if - elif - else`、字典映射和 `match - case` 等方法，我们可以实现类似的功能。每种方法都有其优缺点，在实际应用中，应根据具体需求选择最合适的方式，以提高代码的可读性、性能和可维护性。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/)
- [Python 教程](https://www.python.org/about/gettingstarted/)
- [Python 3.10 What's New](https://docs.python.org/3/whatsnew/3.10.html#pep-634-structural-pattern-matching)
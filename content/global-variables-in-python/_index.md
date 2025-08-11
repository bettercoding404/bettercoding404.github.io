---
title: "Python 中的全局变量"
description: "在 Python 编程中，变量的作用域是一个重要的概念。全局变量是指在整个程序的顶层定义的变量，它们可以在程序的多个函数和模块中被访问和修改。理解和正确使用全局变量对于编写高效、可读的 Python 代码至关重要。本文将深入探讨 Python 中全局变量的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，变量的作用域是一个重要的概念。全局变量是指在整个程序的顶层定义的变量，它们可以在程序的多个函数和模块中被访问和修改。理解和正确使用全局变量对于编写高效、可读的 Python 代码至关重要。本文将深入探讨 Python 中全局变量的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 在函数内访问全局变量
    - 在函数内修改全局变量
3. 常见实践
    - 跨函数共享数据
    - 配置参数
4. 最佳实践
    - 限制全局变量的使用
    - 使用常量模块
    - 利用类来管理状态
5. 小结
6. 参考资料

## 基础概念
全局变量是在 Python 脚本的顶级定义的变量，即在任何函数或类之外定义的变量。它们的作用域是整个脚本，这意味着在脚本的任何地方都可以访问到它们。例如：

```python
# 定义全局变量
global_variable = 10


def print_global_variable():
    print(global_variable)


print_global_variable()
```

在这个例子中，`global_variable` 是一个全局变量，在函数 `print_global_variable` 中可以直接访问它。

## 使用方法

### 在函数内访问全局变量
在函数内部访问全局变量是很简单的，不需要额外的声明。Python 会自动在全局作用域中查找变量。例如：

```python
global_number = 5


def access_global_number():
    print(global_number)


access_global_number()
```

### 在函数内修改全局变量
如果要在函数内部修改全局变量，需要使用 `global` 关键字进行声明。例如：

```python
global_counter = 0


def increment_global_counter():
    global global_counter
    global_counter += 1
    print(global_counter)


increment_global_counter()
```

在这个例子中，`global` 关键字告诉 Python，我们要修改的 `global_counter` 是全局变量，而不是在函数内部创建一个新的局部变量。

## 常见实践

### 跨函数共享数据
全局变量可以用于在多个函数之间共享数据。例如，在一个简单的游戏中，我们可能需要一个全局变量来记录玩家的得分：

```python
player_score = 0


def increase_score():
    global player_score
    player_score += 10


def display_score():
    print(f"玩家当前得分: {player_score}")


increase_score()
display_score()
```

### 配置参数
全局变量也可以用于存储配置参数。例如，我们可以定义一个全局变量来指定程序的日志级别：

```python
LOG_LEVEL = "DEBUG"


def log_message(message):
    if LOG_LEVEL == "DEBUG":
        print(f"[DEBUG] {message}")


log_message("这是一条调试信息")
```

## 最佳实践

### 限制全局变量的使用
虽然全局变量很方便，但过度使用会导致代码难以理解和维护。因为全局变量可以在任何地方被修改，很难追踪它们的值是如何变化的。尽量将变量的作用域限制在最小的必要范围内，只有在真正需要全局访问的情况下才使用全局变量。

### 使用常量模块
对于一些不应该被修改的全局值，可以将它们定义在一个单独的模块中，并将模块中的变量视为常量。例如，创建一个 `constants.py` 文件：

```python
# constants.py
PI = 3.14159
MAX_CONNECTIONS = 10
```

在其他模块中可以导入这些常量：

```python
import constants

print(constants.PI)
```

### 利用类来管理状态
如果需要在多个函数之间共享复杂的状态，可以使用类来封装这些状态和相关的操作。例如：

```python
class GameState:
    def __init__(self):
        self.score = 0

    def increase_score(self):
        self.score += 10

    def display_score(self):
        print(f"游戏当前得分: {self.score}")


game = GameState()
game.increase_score()
game.display_score()
```

## 小结
全局变量在 Python 中提供了一种在整个程序中共享数据的方式。理解如何正确地访问和修改全局变量是编写有效 Python 代码的关键。然而，要谨慎使用全局变量，遵循最佳实践，以确保代码的可读性和可维护性。通过合理运用全局变量、常量模块和类，我们可以编写出更健壮、高效的 Python 程序。

## 参考资料
- 《Python 核心编程》
- 《Effective Python》
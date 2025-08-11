---
title: "Python 中的或运算符（or operator）"
description: "在 Python 编程语言中，或运算符（`or`）是一个逻辑运算符，用于组合多个布尔表达式。它在条件判断、逻辑运算等多种场景中发挥着重要作用。理解并熟练运用 `or` 运算符，能够让我们编写出更加简洁、高效且逻辑清晰的代码。本文将深入探讨 Python 中 `or` 运算符的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程语言中，或运算符（`or`）是一个逻辑运算符，用于组合多个布尔表达式。它在条件判断、逻辑运算等多种场景中发挥着重要作用。理解并熟练运用 `or` 运算符，能够让我们编写出更加简洁、高效且逻辑清晰的代码。本文将深入探讨 Python 中 `or` 运算符的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本语法
    - 与布尔值结合使用
    - 与其他数据类型结合使用
3. 常见实践
    - 条件判断
    - 简化代码逻辑
4. 最佳实践
    - 避免混淆
    - 提高代码可读性
5. 小结
6. 参考资料

## 基础概念
`or` 运算符是一个逻辑运算符，它对两个或多个布尔表达式进行逻辑或运算。逻辑或的定义是：只要其中一个表达式为 `True`，整个表达式的结果就为 `True`；只有当所有表达式都为 `False` 时，整个表达式的结果才为 `False`。

## 使用方法

### 基本语法
`or` 运算符的基本语法如下：
```python
expression1 or expression2
```
这里 `expression1` 和 `expression2` 是任意的布尔表达式。Python 会先计算 `expression1`，如果 `expression1` 的值为 `True`，则整个表达式的结果就是 `expression1` 的值（即 `True`），并且不会再计算 `expression2`。这被称为短路求值。如果 `expression1` 的值为 `False`，则会继续计算 `expression2`，整个表达式的结果就是 `expression2` 的值。

### 与布尔值结合使用
```python
# 两个布尔值的 or 运算
result1 = True or False
print(result1)  # 输出 True

result2 = False or False
print(result2)  # 输出 False
```
在上述代码中，`True or False` 中因为第一个值 `True` 已经满足逻辑或的条件，所以整个表达式结果为 `True`；而 `False or False` 中两个值都为 `False`，所以结果为 `False`。

### 与其他数据类型结合使用
在 Python 中，`or` 运算符不仅可以用于布尔值，还可以用于其他数据类型。在这种情况下，Python 会将非零数字、非空字符串、非空列表等视为 `True`，将零、空字符串、空列表等视为 `False`。
```python
# 与数字结合
result3 = 1 or 0
print(result3)  # 输出 1

# 与字符串结合
result4 = "hello" or "world"
print(result4)  # 输出 "hello"

# 与列表结合
result5 = [] or [1, 2]
print(result5)  # 输出 [1, 2]
```
在 `1 or 0` 中，`1` 被视为 `True`，所以结果为 `1`；`"hello" or "world"` 中，`"hello"` 被视为 `True`，结果为 `"hello"`；`[] or [1, 2]` 中，`[]` 被视为 `False`，所以会计算并返回 `[1, 2]`。

## 常见实践

### 条件判断
`or` 运算符在条件判断中非常常见。例如，我们要判断一个数字是否在特定范围内：
```python
number = 15
if number < 10 or number > 20:
    print("数字不在 10 到 20 之间")
else:
    print("数字在 10 到 20 之间")
```
在这个例子中，`number < 10 or number > 20` 是一个复合条件，只要 `number` 小于 10 或者大于 20，条件就为 `True`。

### 简化代码逻辑
`or` 运算符可以用于简化代码逻辑。比如，我们有一个函数，需要返回两个值中的一个非空值：
```python
def get_non_empty_value(value1, value2):
    return value1 or value2

result = get_non_empty_value("", "hello")
print(result)  # 输出 "hello"
```
在这个函数中，如果 `value1` 不为空，就返回 `value1`；如果 `value1` 为空，则返回 `value2`。这样可以避免使用复杂的 `if-else` 语句。

## 最佳实践

### 避免混淆
在使用 `or` 运算符时，要注意避免与其他逻辑运算符（如 `and`、`not`）混淆。例如，在复杂的条件判断中，正确使用括号来明确运算优先级：
```python
# 明确优先级
condition1 = (True or False) and False
condition2 = True or (False and False)
print(condition1)  # 输出 False
print(condition2)  # 输出 True
```
### 提高代码可读性
虽然 `or` 运算符可以简化代码，但也要确保代码的可读性。避免在一个表达式中使用过多的 `or` 运算符，以免代码变得难以理解。如果条件过于复杂，可以考虑将其拆分成多个步骤或者使用注释来解释逻辑。
```python
# 拆分复杂条件
condition3 = number < 10
condition4 = number > 20
if condition3 or condition4:
    print("数字不在 10 到 20 之间")
```

## 小结
Python 中的 `or` 运算符是一个强大的逻辑工具，它在条件判断、逻辑运算以及简化代码逻辑等方面都有着广泛的应用。通过理解其基础概念、掌握使用方法，并遵循最佳实践，我们能够编写出更加简洁、高效且易于维护的代码。

## 参考资料
- [Python 官方文档 - 运算符](https://docs.python.org/3/reference/expressions.html#operators)
- 《Python 快速上手：让繁琐工作自动化》
- 《Python 核心编程》

希望这篇博客能帮助你更好地理解和使用 Python 中的 `or` 运算符。如果你有任何问题或建议，欢迎在评论区留言。  
---
title: "Python 栈数据类型：深入理解与高效应用"
description: "在编程的世界里，数据结构是构建高效算法和程序的基石。栈（Stack）作为一种重要的数据结构，在 Python 中有着广泛的应用。栈遵循后进先出（LIFO, Last In First Out）的原则，就像一叠盘子，最后放上去的盘子会最先被拿走。本文将详细介绍 Python 栈数据类型的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一强大的数据结构。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在编程的世界里，数据结构是构建高效算法和程序的基石。栈（Stack）作为一种重要的数据结构，在 Python 中有着广泛的应用。栈遵循后进先出（LIFO, Last In First Out）的原则，就像一叠盘子，最后放上去的盘子会最先被拿走。本文将详细介绍 Python 栈数据类型的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一强大的数据结构。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 用列表实现栈
    - 用 collections.deque 实现栈
3. 常见实践
    - 表达式求值
    - 括号匹配
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
栈是一种线性数据结构，它按照后进先出的原则存储和访问数据。在栈中，有两个主要操作：
- **入栈（Push）**：将元素添加到栈的顶部。
- **出栈（Pop）**：从栈的顶部移除并返回元素。

此外，还有一些辅助操作，如查看栈顶元素（Peek），检查栈是否为空等。

## 使用方法

### 用列表实现栈
在 Python 中，列表是一种灵活的数据结构，可以很方便地用来实现栈。列表的 `append()` 方法用于将元素入栈，`pop()` 方法用于将元素出栈。

```python
# 创建一个空栈
stack = []

# 入栈操作
stack.append(1)
stack.append(2)
stack.append(3)

# 出栈操作
print(stack.pop())  # 输出 3
print(stack.pop())  # 输出 2

# 查看栈顶元素
if stack:
    print(stack[-1])  # 输出 1

# 检查栈是否为空
print(len(stack) == 0)  # 输出 False
```

### 用 collections.deque 实现栈
`collections.deque` 是 Python 标准库中提供的双端队列，它也可以用来实现栈。`deque` 提供了 `append()` 和 `pop()` 方法，与列表类似，但 `deque` 在两端进行操作的性能更好。

```python
from collections import deque

# 创建一个空栈
stack = deque()

# 入栈操作
stack.append(1)
stack.append(2)
stack.append(3)

# 出栈操作
print(stack.pop())  # 输出 3
print(stack.pop())  # 输出 2

# 查看栈顶元素
if stack:
    print(stack[-1])  # 输出 1

# 检查栈是否为空
print(len(stack) == 0)  # 输出 False
```

## 常见实践

### 表达式求值
栈在表达式求值中有着重要的应用，例如后缀表达式（逆波兰表达式）求值。后缀表达式将运算符紧跟在操作数之后，通过栈可以很方便地进行计算。

```python
def evaluate_postfix(expression):
    stack = []
    for token in expression.split():
        if token.isdigit():
            stack.append(int(token))
        else:
            operand2 = stack.pop()
            operand1 = stack.pop()
            if token == '+':
                result = operand1 + operand2
            elif token == '-':
                result = operand1 - operand2
            elif token == '*':
                result = operand1 * operand2
            elif token == '/':
                result = operand1 / operand2
            stack.append(result)
    return stack[0]

expression = "3 4 + 2 * 1 5 - /"
print(evaluate_postfix(expression))  # 输出 2.0
```

### 括号匹配
栈可以用来检查表达式中的括号是否匹配。遍历表达式，遇到左括号时将其入栈，遇到右括号时从栈中弹出一个左括号进行匹配。

```python
def is_balanced(expression):
    stack = []
    opening_brackets = "([{"
    closing_brackets = ")]}"
    mapping = dict(zip(closing_brackets, opening_brackets))

    for char in expression:
        if char in opening_brackets:
            stack.append(char)
        elif char in closing_brackets:
            if not stack or stack.pop() != mapping[char]:
                return False
    return not stack

print(is_balanced("(([]{}))"))  # 输出 True
print(is_balanced("([)]"))  # 输出 False
```

## 最佳实践
- **性能考量**：如果栈的操作主要集中在一端，使用 `collections.deque` 会比列表有更好的性能，尤其是在频繁进行入栈和出栈操作时。
- **错误处理**：在进行出栈操作前，一定要先检查栈是否为空，以避免 `IndexError` 或 `IndexError: pop from empty list` 等错误。
- **代码可读性**：为了提高代码的可读性，可以将栈操作封装成函数或类，使代码结构更加清晰。

## 小结
本文详细介绍了 Python 栈数据类型，包括基础概念、使用方法、常见实践以及最佳实践。栈作为一种重要的数据结构，在许多算法和应用中都发挥着关键作用。通过掌握栈的使用，你可以更高效地解决诸如表达式求值、括号匹配等问题。希望本文能帮助你深入理解并灵活运用 Python 栈数据类型。

## 参考资料
- [Python 官方文档 - collections.deque](https://docs.python.org/3/library/collections.html#collections.deque)
- [维基百科 - 栈 (数据结构)](https://zh.wikipedia.org/wiki/%E6%A0%88_(%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84))
---
title: "深入探索 Python 中的栈（Stack）"
description: "在计算机科学中，栈是一种重要的数据结构，遵循后进先出（LIFO, Last In First Out）的原则。在 Python 里，虽然没有内置的 `Stack` 类，但可以利用列表（List）和 `collections.deque` 等数据结构来实现栈的功能。理解和掌握栈在 Python 中的使用，对于解决诸如表达式求值、深度优先搜索（DFS）等多种算法问题非常有帮助。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在计算机科学中，栈是一种重要的数据结构，遵循后进先出（LIFO, Last In First Out）的原则。在 Python 里，虽然没有内置的 `Stack` 类，但可以利用列表（List）和 `collections.deque` 等数据结构来实现栈的功能。理解和掌握栈在 Python 中的使用，对于解决诸如表达式求值、深度优先搜索（DFS）等多种算法问题非常有帮助。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用列表实现栈**
    - **使用 `collections.deque` 实现栈**
3. **常见实践**
    - **括号匹配问题**
    - **表达式求值**
4. **最佳实践**
    - **性能考量**
    - **代码可读性**
5. **小结**
6. **参考资料**

## 基础概念
栈是一种特殊的数据结构，它只有一个入口和一个出口。就像一个桶，最后放进去的东西会最先被取出来。栈支持两种主要操作：
- **入栈（Push）**：将元素添加到栈的顶部。
- **出栈（Pop）**：从栈的顶部移除并返回元素。

此外，还有一些辅助操作，如查看栈顶元素（Peek）、检查栈是否为空等。

## 使用方法
### 使用列表实现栈
在 Python 中，列表可以很方便地当作栈来使用。由于列表的 `append()` 方法用于在列表末尾添加元素，`pop()` 方法用于从列表末尾移除并返回元素，正好符合栈的操作特性。

```python
# 创建一个空栈
stack = []

# 入栈操作
stack.append(1)
stack.append(2)
stack.append(3)

# 查看栈顶元素
top_element = stack[-1]
print(f"栈顶元素: {top_element}")

# 出栈操作
popped_element = stack.pop()
print(f"弹出的元素: {popped_element}")

# 检查栈是否为空
is_empty = len(stack) == 0
print(f"栈是否为空: {is_empty}")
```

### 使用 `collections.deque` 实现栈
`collections.deque` 是 Python 标准库中实现的双端队列（double-ended queue），它也可以用来实现栈。`deque` 在两端进行添加和删除操作的性能比列表更好，特别是在频繁操作的场景下。

```python
from collections import deque

# 创建一个空栈
stack = deque()

# 入栈操作
stack.append(1)
stack.append(2)
stack.append(3)

# 查看栈顶元素
top_element = stack[-1]
print(f"栈顶元素: {top_element}")

# 出栈操作
popped_element = stack.pop()
print(f"弹出的元素: {popped_element}")

# 检查栈是否为空
is_empty = len(stack) == 0
print(f"栈是否为空: {is_empty}")
```

## 常见实践
### 括号匹配问题
给定一个只包含括号 `()`、`[]` 和 `{}` 的字符串，判断字符串中的括号是否匹配。

```python
def is_valid_brackets(s):
    stack = []
    bracket_map = {')': '(', ']': '[', '}': '{'}

    for char in s:
        if char in bracket_map.values():
            stack.append(char)
        elif char in bracket_map.keys():
            if not stack or stack.pop() != bracket_map[char]:
                return False
        else:
            continue

    return not stack

# 测试
test_string = "([{}])"
print(f"{test_string} 括号是否匹配: {is_valid_brackets(test_string)}")
```

### 表达式求值
实现一个简单的计算器，能够计算包含加、减、乘、除和括号的表达式。

```python
def precedence(operator):
    if operator in ('+', '-'):
        return 1
    if operator in ('*', '/'):
        return 2
    return 0


def apply_operator(a, b, operator):
    if operator == '+': return a + b
    if operator == '-': return a - b
    if operator == '*': return a * b
    if operator == '/': return a // b


def evaluate(tokens):
    values = []
    ops = []

    for i in range(len(tokens)):
        if tokens[i] == ' ':
            continue
        elif tokens[i].isdigit():
            val = 0
            while (i < len(tokens) and tokens[i].isdigit()):
                val = (val * 10) + int(tokens[i])
                i += 1
            values.append(val)
        elif tokens[i] == '(':
            ops.append(tokens[i])
        elif tokens[i] == ')':
            while len(ops) != 0 and ops[-1] != '(':
                val2 = values.pop()
                val1 = values.pop()
                op = ops.pop()
                values.append(apply_operator(val1, val2, op))
            ops.pop()
        else:
            while (len(ops) != 0 and precedence(ops[-1]) >= precedence(tokens[i])):
                val2 = values.pop()
                val1 = values.pop()
                op = ops.pop()
                values.append(apply_operator(val1, val2, op))
            ops.append(tokens[i])

    while len(ops) != 0:
        val2 = values.pop()
        val1 = values.pop()
        op = ops.pop()
        values.append(apply_operator(val1, val2, op))

    return values[-1]


# 测试
expression = "3 + 5 * ( 2 - 8 ) / 2"
print(f"{expression} 的计算结果: {evaluate(expression)}")
```

## 最佳实践
### 性能考量
- 当需要频繁进行入栈和出栈操作时，`collections.deque` 比列表性能更好，因为列表在频繁的末尾操作时可能需要进行内存重分配。
- 如果栈的大小相对固定，并且操作不是特别频繁，列表实现的栈已经足够高效。

### 代码可读性
- 为了提高代码的可读性，可以将栈的操作封装成函数或类。例如，创建一个 `Stack` 类，将入栈、出栈等操作作为类的方法。

```python
class Stack:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        if not self.is_empty():
            return self.items.pop()

    def peek(self):
        if not self.is_empty():
            return self.items[-1]

    def is_empty(self):
        return len(self.items) == 0

    def size(self):
        return len(self.items)


# 使用示例
stack = Stack()
stack.push(1)
stack.push(2)
print(f"栈顶元素: {stack.peek()}")
print(f"弹出的元素: {stack.pop()}")
```

## 小结
在 Python 中，利用列表和 `collections.deque` 实现栈功能十分便捷。理解栈的基础概念、掌握其使用方法，并在实际应用中遵循最佳实践，能够帮助我们高效地解决各种算法问题。无论是括号匹配还是表达式求值等问题，栈都发挥着重要作用。通过合理选择实现方式和优化代码，我们可以更好地利用栈这一强大的数据结构。

## 参考资料
- [Python 官方文档 - collections.deque](https://docs.python.org/3/library/collections.html#collections.deque)
- 《Python 数据结构与算法分析》

希望这篇博客能帮助你深入理解并高效使用 Python 中的栈。如果有任何问题或建议，欢迎在评论区留言。
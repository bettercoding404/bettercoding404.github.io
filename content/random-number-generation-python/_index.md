---
title: "Python 中的随机数生成"
description: "在许多编程场景中，生成随机数是一项非常有用的功能。无论是开发游戏、进行模拟实验，还是设计加密算法等，随机数都发挥着重要作用。Python 提供了强大且易用的随机数生成工具，本文将深入探讨 Python 中随机数生成的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在许多编程场景中，生成随机数是一项非常有用的功能。无论是开发游戏、进行模拟实验，还是设计加密算法等，随机数都发挥着重要作用。Python 提供了强大且易用的随机数生成工具，本文将深入探讨 Python 中随机数生成的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 生成整数随机数
    - 生成浮点数随机数
    - 从序列中随机选择元素
3. 常见实践
    - 随机洗牌
    - 生成随机密码
4. 最佳实践
    - 设置随机种子
    - 安全的随机数生成
5. 小结
6. 参考资料

## 基础概念
在计算机科学中，随机数生成并不是真正意义上的“随机”，而是“伪随机”。伪随机数是通过一个确定性的算法生成的，这个算法基于一个初始值（称为种子）。如果种子相同，生成的随机数序列也会相同。这在某些情况下是有用的，比如调试代码或者进行可重复的实验。

Python 的 `random` 模块提供了生成伪随机数的功能。这个模块实现了各种分布的伪随机数生成器，包括均匀分布、正态分布等。

## 使用方法

### 生成整数随机数
1. **生成指定范围内的随机整数**
    ```python
    import random

    # 生成 1 到 10 之间（包括 1 和 10）的随机整数
    random_int = random.randint(1, 10)
    print(random_int)
    ```
    在这个例子中，`random.randint(a, b)` 函数返回一个在 `a` 和 `b` 之间（包括 `a` 和 `b`）的随机整数。

2. **生成指定范围内的随机整数（不包括结束值）**
    ```python
    import random

    # 生成 0 到 9 之间的随机整数
    random_int = random.randrange(10)
    print(random_int)

    # 生成 5 到 19 之间，步长为 2 的随机整数
    random_int = random.randrange(5, 20, 2)
    print(random_int)
    ```
    `random.randrange(start, stop[, step])` 函数返回一个在 `start` 到 `stop` 之间（不包括 `stop`），步长为 `step` 的随机整数。如果只提供一个参数，那么默认 `start` 为 0。

### 生成浮点数随机数
1. **生成 0 到 1 之间的随机浮点数**
    ```python
    import random

    random_float = random.random()
    print(random_float)
    ```
    `random.random()` 函数返回一个在 0 到 1 之间（包括 0 但不包括 1）的随机浮点数。

2. **生成指定范围内的随机浮点数**
    ```python
    import random

    # 生成 5 到 10 之间的随机浮点数
    random_float = random.uniform(5, 10)
    print(random_float)
    ```
    `random.uniform(a, b)` 函数返回一个在 `a` 和 `b` 之间的随机浮点数。

### 从序列中随机选择元素
1. **从列表中随机选择一个元素**
    ```python
    import random

    fruits = ['apple', 'banana', 'cherry']
    random_fruit = random.choice(fruits)
    print(random_fruit)
    ```
    `random.choice(seq)` 函数从非空序列 `seq` 中随机选择一个元素并返回。

2. **从序列中随机选择多个元素（不重复）**
    ```python
    import random

    numbers = [1, 2, 3, 4, 5]
    random_numbers = random.sample(numbers, 3)
    print(random_numbers)
    ```
    `random.sample(population, k)` 函数从 `population` 序列中随机选择 `k` 个不重复的元素，并以列表形式返回。

## 常见实践

### 随机洗牌
在很多游戏或者数据分析场景中，需要对数据进行随机洗牌操作。
```python
import random

cards = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
random.shuffle(cards)
print(cards)
```
`random.shuffle(x)` 函数会对序列 `x` 进行原地洗牌，即改变原始序列的顺序。

### 生成随机密码
```python
import random
import string

def generate_password(length):
    all_characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(all_characters) for i in range(length))
    return password

password = generate_password(12)
print(password)
```
在这个例子中，我们定义了一个函数 `generate_password`，它生成一个指定长度的随机密码。密码包含字母、数字和标点符号。

## 最佳实践

### 设置随机种子
如前文所述，伪随机数生成器基于种子生成随机数序列。在调试或者进行可重复实验时，设置种子非常有用。
```python
import random

# 设置种子
random.seed(42)

# 生成随机数
random_int1 = random.randint(1, 10)
print(random_int1)

# 再次设置相同的种子
random.seed(42)

# 生成随机数
random_int2 = random.randint(1, 10)
print(random_int2)
```
在这个例子中，两次设置相同的种子后，生成的随机数是相同的。

### 安全的随机数生成
在一些需要更高安全性的场景中，比如加密、彩票系统等，需要使用更安全的随机数生成器。Python 的 `secrets` 模块提供了用于生成安全随机数的功能。
```python
import secrets

# 生成一个安全的随机整数
secure_random_int = secrets.randbelow(100)
print(secure_random_int)

# 生成一个安全的随机字节序列
secure_random_bytes = secrets.token_bytes(16)
print(secure_random_bytes)
```
`secrets` 模块使用操作系统提供的强随机数源，生成的随机数更适合用于安全相关的应用。

## 小结
本文介绍了 Python 中随机数生成的基础概念、使用方法、常见实践以及最佳实践。通过 `random` 模块和 `secrets` 模块，我们可以在不同的场景下生成各种类型的随机数。在日常编程中，要根据具体需求选择合适的随机数生成方法，并注意设置随机种子和安全随机数生成等最佳实践。

## 参考资料
- [Python 官方文档 - random 模块](https://docs.python.org/3/library/random.html)
- [Python 官方文档 - secrets 模块](https://docs.python.org/3/library/secrets.html)
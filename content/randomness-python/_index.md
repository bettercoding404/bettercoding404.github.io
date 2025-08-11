---
title: "Python中的随机数：Randomness in Python"
description: "在编程中，随机数的生成是一项常见且重要的任务。在Python中，`random`模块提供了生成各种随机数的功能，广泛应用于模拟、游戏开发、数据采样等多个领域。本文将深入探讨Python中`randomness`相关的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握和运用这一强大的工具。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在编程中，随机数的生成是一项常见且重要的任务。在Python中，`random`模块提供了生成各种随机数的功能，广泛应用于模拟、游戏开发、数据采样等多个领域。本文将深入探讨Python中`randomness`相关的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握和运用这一强大的工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 生成随机浮点数
    - 生成随机整数
    - 随机选择元素
    - 打乱序列顺序
3. **常见实践**
    - 模拟掷骰子
    - 抽奖程序
    - 数据采样
4. **最佳实践**
    - 种子设置
    - 安全的随机数生成
5. **小结**
6. **参考资料**

## 基础概念
随机数在计算机中实际上是伪随机数，它们基于一个初始值（称为种子）通过特定的算法生成。如果种子相同，生成的随机数序列也是相同的。`random`模块使用的算法可以生成看似随机的数字序列，但本质上是可预测的。这在某些需要可重复性的场景中非常有用。

## 使用方法
### 生成随机浮点数
`random.random()`函数返回一个在[0, 1)范围内的随机浮点数。
```python
import random

random_float = random.random()
print(random_float)  
```
`random.uniform(a, b)`函数返回一个在[a, b]范围内的随机浮点数。
```python
random_uniform = random.uniform(1, 10)
print(random_uniform)  
```

### 生成随机整数
`random.randint(a, b)`函数返回一个在[a, b]范围内的随机整数，包括a和b。
```python
random_int = random.randint(1, 6)
print(random_int)  
```
`random.randrange(start, stop, step)`函数返回一个在`start`（包含）到`stop`（不包含）之间，以`step`为步长的随机整数。
```python
random_randrange = random.randrange(0, 10, 2)
print(random_randrange)  
```

### 随机选择元素
`random.choice(seq)`函数从非空序列`seq`中随机选择一个元素。
```python
fruits = ['apple', 'banana', 'cherry']
random_fruit = random.choice(fruits)
print(random_fruit)  
```
`random.sample(population, k)`函数从总体`population`中随机选择`k`个唯一的元素。
```python
numbers = [1, 2, 3, 4, 5, 6]
random_sample = random.sample(numbers, 3)
print(random_sample)  
```

### 打乱序列顺序
`random.shuffle(x)`函数用于打乱可变序列`x`的顺序。
```python
cards = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K']
random.shuffle(cards)
print(cards)  
```

## 常见实践
### 模拟掷骰子
```python
import random


def roll_dice():
    return random.randint(1, 6)


result = roll_dice()
print(f"掷骰子的结果是: {result}")
```

### 抽奖程序
```python
import random

participants = ['Alice', 'Bob', 'Charlie', 'David', 'Eve']
winner = random.choice(participants)
print(f"抽奖的获胜者是: {winner}")
```

### 数据采样
```python
import random

data = list(range(1, 101))
sampled_data = random.sample(data, 10)
print("采样后的数据:", sampled_data)
```

## 最佳实践
### 种子设置
为了确保生成的随机数序列具有可重复性，可以设置种子。`random.seed(a=None)`函数用于设置随机数生成器的种子。
```python
import random

random.seed(42)
random_number1 = random.random()
random.seed(42)
random_number2 = random.random()
print(random_number1)  
print(random_number2)  
```
在上述代码中，两次设置相同的种子后，生成的随机数是相同的。

### 安全的随机数生成
在某些安全敏感的应用中，如密码学，需要使用更安全的随机数生成方法。Python的`secrets`模块提供了适用于安全目的的随机数生成函数。
```python
import secrets

# 生成一个安全的随机整数
secure_random_int = secrets.randbelow(100)
print(secure_random_int)

# 生成一个安全的随机字节序列
secure_random_bytes = secrets.token_bytes(16)
print(secure_random_bytes)
```

## 小结
Python的`random`模块提供了丰富的功能来生成各种类型的随机数，满足了不同场景下的需求。通过了解基础概念、掌握使用方法、熟悉常见实践以及遵循最佳实践，你可以在自己的项目中灵活运用随机数，实现诸如模拟、抽奖、数据采样等功能。同时，对于安全敏感的场景，`secrets`模块提供了更可靠的随机数生成方法。

## 参考资料
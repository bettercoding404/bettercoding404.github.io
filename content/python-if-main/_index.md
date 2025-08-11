---
title: "深入理解 Python 中的 `if __name__ == '__main__'`"
description: "在 Python 编程中，`if __name__ == '__main__'` 是一个常见且重要的结构。它允许我们控制 Python 脚本的执行方式，特别是在脚本作为独立程序运行和被其他模块导入时表现出不同的行为。理解这一结构对于编写模块化、可复用的 Python 代码至关重要。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，`if __name__ == '__main__'` 是一个常见且重要的结构。它允许我们控制 Python 脚本的执行方式，特别是在脚本作为独立程序运行和被其他模块导入时表现出不同的行为。理解这一结构对于编写模块化、可复用的 Python 代码至关重要。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 简单示例
    - 模块导入场景
3. **常见实践**
    - 测试代码
    - 命令行接口
4. **最佳实践**
    - 保持代码简洁
    - 遵循代码结构规范
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，每个模块都有一个内置属性 `__name__`。当一个 Python 脚本直接作为主程序运行时，`__name__` 的值会被设置为 `__main__`。而当该脚本被其他模块导入时，`__name__` 的值则是该模块的名称。

`if __name__ == '__main__':` 这一条件语句就是利用了 `__name__` 属性的这一特性。当这个条件为真时，意味着脚本是作为主程序运行，相应的代码块将会被执行；如果脚本被导入到其他模块中，这部分代码则不会被执行。

## 使用方法
### 简单示例
以下是一个简单的 Python 脚本，展示了 `if __name__ == '__main__'` 的基本用法：

```python
def print_hello():
    print("Hello, World!")


if __name__ == '__main__':
    print_hello()
```

在这个示例中，`print_hello` 函数定义了一个简单的打印语句。`if __name__ == '__main__'` 条件判断确保只有在脚本直接运行时，`print_hello` 函数才会被调用。如果将这段代码保存为 `hello.py` 并在命令行中运行 `python hello.py`，将会看到输出 `Hello, World!`。

### 模块导入场景
假设我们有一个模块 `math_operations.py`，包含一些数学运算函数：

```python
def add(a, b):
    return a + b


def subtract(a, b):
    return a - b


if __name__ == '__main__':
    result_add = add(5, 3)
    result_subtract = subtract(5, 3)
    print(f"Addition result: {result_add}")
    print(f"Subtraction result: {result_subtract}")
```

现在，我们可以在另一个脚本 `main.py` 中导入 `math_operations` 模块，并使用其中的函数：

```python
import math_operations

result = math_operations.add(10, 2)
print(f"Imported addition result: {result}")
```

在这个例子中，当运行 `main.py` 时，`math_operations.py` 中的 `if __name__ == '__main__'` 代码块不会被执行，因为 `math_operations` 模块是被导入的，而不是作为主程序运行。只有在直接运行 `math_operations.py` 时，其中的测试代码才会执行。

## 常见实践
### 测试代码
在开发模块时，我们常常希望在模块内部编写一些测试代码，用于验证模块的功能是否正确。使用 `if __name__ == '__main__'`，可以将这些测试代码放在这个条件块内，这样在模块被导入时，测试代码不会干扰其他程序的运行。例如：

```python
def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True


if __name__ == '__main__':
    number = 17
    if is_prime(number):
        print(f"{number} is prime.")
    else:
        print(f"{number} is not prime.")
```

### 命令行接口
许多 Python 脚本提供了命令行接口，允许用户通过命令行输入参数来执行特定的操作。`if __name__ == '__main__'` 可以用来实现这一功能。例如，一个简单的文件复制脚本：

```python
import sys


def copy_file(source, destination):
    with open(source, 'r') as source_file:
        content = source_file.read()
    with open(destination, 'w') as dest_file:
        dest_file.write(content)


if __name__ == '__main__':
    if len(sys.argv)!= 3:
        print("Usage: python script.py <source_file> <destination_file>")
    else:
        source_file = sys.argv[1]
        destination_file = sys.argv[2]
        copy_file(source_file, destination_file)
        print(f"File {source_file} copied to {destination_file}")
```

## 最佳实践
### 保持代码简洁
`if __name__ == '__main__'` 块内的代码应该尽量简洁，只包含与脚本作为主程序运行相关的核心逻辑。避免在这个块内编写过于复杂的代码，以免影响代码的可读性和维护性。

### 遵循代码结构规范
按照 Python 的代码结构规范，将模块的主要功能定义为函数或类，而将 `if __name__ == '__main__'` 块放在模块的末尾。这样可以使代码结构更加清晰，易于理解和扩展。

## 小结
`if __name__ == '__main__'` 是 Python 编程中的一个重要结构，它提供了一种灵活的方式来控制脚本在不同运行场景下的行为。通过理解其基础概念、掌握使用方法，并遵循常见实践和最佳实践，我们能够编写出更加模块化、可复用和易于维护的 Python 代码。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/)
- 《Python 核心编程》
- [Real Python - Understanding Python's if __name__ == '__main__'](https://realpython.com/if-name-main-python/)
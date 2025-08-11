---
title: "深入理解 Python globals"
description: "在 Python 编程中，`globals()` 是一个强大且常用的内置函数，它为开发者提供了对全局符号表的访问。全局符号表存储了模块级别的变量、函数和类等信息。理解和熟练运用 `globals()` 函数，对于深入掌握 Python 的作用域机制、动态编程以及一些高级应用场景至关重要。本文将详细介绍 `globals()` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用这一特性。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，`globals()` 是一个强大且常用的内置函数，它为开发者提供了对全局符号表的访问。全局符号表存储了模块级别的变量、函数和类等信息。理解和熟练运用 `globals()` 函数，对于深入掌握 Python 的作用域机制、动态编程以及一些高级应用场景至关重要。本文将详细介绍 `globals()` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用这一特性。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 获取全局变量
    - 修改全局变量
    - 动态创建全局变量
3. **常见实践**
    - 配置文件加载
    - 模块间共享数据
4. **最佳实践**
    - 谨慎使用动态创建全局变量
    - 保持全局变量命名规范
    - 避免过度依赖全局变量
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，每个模块都有自己的全局符号表。这个符号表本质上是一个字典，其中键是变量、函数或类的名称，值是对应的对象。`globals()` 函数返回的就是当前模块的全局符号表这个字典。通过操作这个字典，我们可以访问、修改甚至动态创建全局变量。

## 使用方法

### 获取全局变量
```python
# 定义一些全局变量
global_variable1 = 10
global_variable2 = "Hello, World!"


def print_globals():
    globals_dict = globals()
    print(globals_dict['global_variable1'])
    print(globals_dict['global_variable2'])


print_globals()
```
在上述代码中，首先定义了两个全局变量 `global_variable1` 和 `global_variable2`。然后在函数 `print_globals` 中，通过 `globals()` 函数获取全局符号表字典 `globals_dict`，并通过键名获取对应的全局变量值并打印。

### 修改全局变量
```python
def modify_global_variable():
    globals_dict = globals()
    globals_dict['global_variable1'] = 20
    globals_dict['global_variable2'] = "New Message"


modify_global_variable()
print(global_variable1)
print(global_variable2)
```
这段代码展示了如何使用 `globals()` 来修改全局变量。在函数 `modify_global_variable` 中，获取全局符号表字典后，通过键名直接修改对应的值。之后打印全局变量，可以看到其值已经被改变。

### 动态创建全局变量
```python
new_variable_name = "new_global_variable"
new_variable_value = 42
globals()[new_variable_name] = new_variable_value
print(new_global_variable)
```
这里通过 `globals()` 动态创建了一个新的全局变量。首先定义了新变量的名称和值，然后将其添加到全局符号表字典中。最后可以直接使用新创建的全局变量。

## 常见实践

### 配置文件加载
在很多项目中，我们会将一些配置参数放在一个单独的配置文件中，然后在程序中动态加载这些配置。例如：
```python
# config.py
config = {
    "database_host": "localhost",
    "database_port": 5432,
    "debug_mode": True
}


# main.py
import config

def load_config():
    config_dict = config.config
    for key, value in config_dict.items():
        globals()[key] = value


load_config()
print(database_host)
print(database_port)
print(debug_mode)
```
在这个例子中，`config.py` 定义了一个配置字典，`main.py` 中的 `load_config` 函数将配置字典中的键值对动态添加为全局变量，方便在整个模块中使用。

### 模块间共享数据
有时候不同模块之间需要共享一些全局数据。例如：
```python
# shared_data.py
shared_variable = 0


# module1.py
import shared_data


def increment_shared_variable():
    global shared_variable
    shared_variable += 1
    globals()['shared_variable'] = shared_variable


# module2.py
import shared_data


def print_shared_variable():
    print(shared_variable)


# main.py
import module1
import module2

module1.increment_shared_variable()
module2.print_shared_variable()
```
在这个示例中，`shared_data.py` 定义了一个共享全局变量 `shared_variable`。`module1.py` 中的函数 `increment_shared_variable` 修改了这个共享变量，`module2.py` 中的函数 `print_shared_variable` 打印这个共享变量的值。

## 最佳实践

### 谨慎使用动态创建全局变量
动态创建全局变量可能会使代码的可读性和维护性变差，因为变量的定义和使用可能在代码中分散得比较远。尽量在模块顶部集中定义全局变量，除非有非常明确的动态需求。

### 保持全局变量命名规范
为了避免命名冲突和提高代码的可读性，给全局变量命名时采用统一的命名规范，例如全部大写字母，单词之间用下划线分隔。

### 避免过度依赖全局变量
过度使用全局变量会使代码的耦合度增加，不利于代码的模块化和单元测试。尽量将数据封装在类或函数内部，只在必要时使用全局变量。

## 小结
`globals()` 函数为 Python 开发者提供了强大的功能，通过它可以访问、修改和动态创建全局变量。在实际应用中，它在配置文件加载、模块间数据共享等场景发挥着重要作用。然而，为了保证代码的质量和可维护性，我们需要遵循最佳实践，谨慎使用这一特性。希望通过本文的介绍，读者能对 `globals()` 有更深入的理解，并在编程中更高效地运用它。

## 参考资料
- [Python 官方文档 - Built-in Functions - globals()](https://docs.python.org/3/library/functions.html#globals)
- 《Python 核心编程》
- 《Effective Python》
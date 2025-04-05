---
title: "Python 中的结构体（Structs）：深入理解与高效运用"
description: "在 Python 编程中，结构体（Structs）是一种强大的数据组织方式，它允许我们将不同类型的数据组合成一个单一的实体。结构体在处理需要将多个相关数据项打包在一起的场景时非常有用，例如处理二进制数据、解析网络数据包或者存储复杂的数据结构。本文将深入探讨 Python 中结构体的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要特性。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 编程中，结构体（Structs）是一种强大的数据组织方式，它允许我们将不同类型的数据组合成一个单一的实体。结构体在处理需要将多个相关数据项打包在一起的场景时非常有用，例如处理二进制数据、解析网络数据包或者存储复杂的数据结构。本文将深入探讨 Python 中结构体的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要特性。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 导入 `struct` 模块
    - 定义结构体格式字符串
    - 打包和解包数据
3. 常见实践
    - 处理二进制文件
    - 解析网络数据包
4. 最佳实践
    - 选择合适的格式字符串
    - 错误处理
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
在 Python 中，结构体并不是像 C 语言那样的内置数据类型。相反，Python 通过 `struct` 模块来提供处理结构体的功能。`struct` 模块允许我们将 Python 的数据类型转换为特定格式的字节序列（打包），以及将字节序列转换回 Python 的数据类型（解包）。

结构体的核心概念在于格式字符串（format string）。格式字符串定义了数据的布局和类型，它使用特定的字符来表示不同的数据类型，例如 `'i'` 表示有符号整数，`'f'` 表示浮点数等。通过组合这些字符，我们可以定义复杂的结构体布局。

## 使用方法

### 导入 `struct` 模块
要使用 Python 的结构体功能，首先需要导入 `struct` 模块：
```python
import struct
```

### 定义结构体格式字符串
格式字符串是使用 `struct` 模块的关键。以下是一些常见的格式字符及其对应的 Python 数据类型：
| 格式字符 | Python 数据类型 | 大小（字节） |
|---|---|---|
| `x` | 填充字节（不读取） | 1 |
| `c` | 字符（字节） | 1 |
| `b` | 有符号字节 | 1 |
| `B` | 无符号字节 | 1 |
| `h` | 有符号短整数 | 2 |
| `H` | 无符号短整数 | 2 |
| `i` | 有符号整数 | 4 |
| `I` | 无符号整数 | 4 |
| `f` | 单精度浮点数 | 4 |
| `d` | 双精度浮点数 | 8 |

例如，定义一个包含一个整数和一个浮点数的结构体格式字符串：
```python
format_string = 'if'
```

### 打包和解包数据
#### 打包数据
使用 `struct.pack()` 函数可以将 Python 的数据按照指定的格式字符串打包成字节序列。例如：
```python
data = (10, 3.14)  # 要打包的数据
packed_data = struct.pack(format_string, *data)
print(packed_data)
```
在上述代码中，`struct.pack()` 函数接受格式字符串和要打包的数据作为参数，将数据打包成字节序列并存储在 `packed_data` 中。

#### 解包数据
使用 `struct.unpack()` 函数可以将字节序列按照指定的格式字符串解包成 Python 的数据。例如：
```python
unpacked_data = struct.unpack(format_string, packed_data)
print(unpacked_data)
```
在上述代码中，`struct.unpack()` 函数接受格式字符串和要解包的字节序列作为参数，将字节序列解包成 Python 的数据并存储在 `unpacked_data` 中。

## 常见实践

### 处理二进制文件
结构体在处理二进制文件时非常有用。例如，我们可以读取一个包含特定格式数据的二进制文件，并将其解包为 Python 的数据类型。以下是一个简单的示例：
```python
import struct

# 打开二进制文件
with open('data.bin', 'rb') as f:
    # 读取文件内容
    data = f.read()

# 定义结构体格式字符串
format_string = 'ii'  # 两个整数

# 解包数据
unpacked_data = struct.unpack(format_string, data)
print(unpacked_data)
```

### 解析网络数据包
在网络编程中，结构体可以用于解析接收到的网络数据包。例如，假设我们接收到一个包含 IP 地址和端口号的数据包，我们可以使用结构体来解析它：
```python
import struct

# 模拟接收到的数据包
packet = b'\x01\x02\x03\x04\x12\x34'  # 假设前 4 个字节是 IP 地址，后 2 个字节是端口号

# 定义结构体格式字符串
format_string = '4sH'  # 4 个字节的字符串（IP 地址）和 1 个无符号短整数（端口号）

# 解包数据
unpacked_data = struct.unpack(format_string, packet)
ip_address = '.'.join(map(str, unpacked_data[0]))
port = unpacked_data[1]
print(f'IP 地址: {ip_address}, 端口号: {port}')
```

## 最佳实践

### 选择合适的格式字符串
在定义格式字符串时，要确保它准确地反映了数据的实际布局和类型。仔细考虑数据的大小和字节顺序（大端序或小端序）。例如，在处理网络数据包时，通常使用大端序，此时可以在格式字符串前加上 `!` 来指定大端序，如 `'!if'`。

### 错误处理
在使用 `struct.pack()` 和 `struct.unpack()` 函数时，要注意可能出现的错误。例如，如果格式字符串与数据不匹配，或者字节序列的长度不正确，会引发 `struct.error` 异常。因此，建议在代码中使用 `try-except` 块来捕获并处理这些异常：
```python
try:
    packed_data = struct.pack(format_string, *data)
    unpacked_data = struct.unpack(format_string, packed_data)
except struct.error as e:
    print(f'结构体操作错误: {e}')
```

### 代码可读性
为了提高代码的可读性，可以将格式字符串和结构体相关的操作封装成函数或类。这样可以使代码结构更加清晰，便于维护和扩展。例如：
```python
import struct


def pack_data(data):
    format_string = 'if'
    return struct.pack(format_string, *data)


def unpack_data(packed_data):
    format_string = 'if'
    return struct.unpack(format_string, packed_data)


data = (10, 3.14)
packed = pack_data(data)
unpacked = unpack_data(packed)
print(unpacked)
```

## 小结
Python 的 `struct` 模块为处理结构体提供了强大的功能。通过定义格式字符串，我们可以灵活地打包和解包数据，适用于处理二进制文件、网络数据包等多种场景。在实际应用中，要注意选择合适的格式字符串、进行错误处理以及提高代码的可读性。掌握这些知识和技巧，将有助于读者更加高效地使用结构体来解决实际问题。

## 参考资料
- [Python 官方文档 - struct 模块](https://docs.python.org/3/library/struct.html){: rel="nofollow"}
- 《Python 核心编程》
- 《Python 高级编程》
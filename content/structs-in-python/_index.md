---
title: "Python 中的结构体（Structs）"
description: "在 Python 中，虽然没有像 C 语言那样原生的结构体类型，但可以通过 `struct` 模块来处理 C 结构体格式的数据。`struct` 模块允许你将 Python 值打包成 C 结构体格式的字符串，以及将这些字符串解包回 Python 值。这在处理二进制数据、网络协议、文件格式等场景中非常有用。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 中，虽然没有像 C 语言那样原生的结构体类型，但可以通过 `struct` 模块来处理 C 结构体格式的数据。`struct` 模块允许你将 Python 值打包成 C 结构体格式的字符串，以及将这些字符串解包回 Python 值。这在处理二进制数据、网络协议、文件格式等场景中非常有用。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 打包（Packing）
    - 解包（Unpacking）
3. 常见实践
    - 处理二进制文件
    - 网络数据传输
4. 最佳实践
    - 提高性能
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
`struct` 模块主要用于处理 C 结构体格式的数据。C 结构体是一种用户自定义的数据类型，它可以将不同类型的数据组合在一起。在 Python 中，`struct` 模块通过格式字符串来指定结构体的布局。格式字符串中的每个字符对应一个 C 数据类型，例如：
- `'c'`：字符（长度为 1 的字节串）
- `'b'`：有符号字符
- `'B'`：无符号字符
- `'h'`：短整型
- `'H'`：无符号短整型
- `'i'`：整型
- `'I'`：无符号整型
- `'f'`：单精度浮点数
- `'d'`：双精度浮点数

## 使用方法
### 打包（Packing）
打包是将 Python 值转换为 C 结构体格式的字符串的过程。使用 `struct.pack()` 函数，其语法如下：
```python
import struct

# 格式字符串，'i' 表示整型，'f' 表示单精度浮点数
format_string = 'if'
values = (10, 3.14)

packed_data = struct.pack(format_string, *values)
print(packed_data)
```
在上述代码中，`struct.pack()` 函数根据格式字符串 `'if'` 将 Python 元组 `(10, 3.14)` 中的值打包成一个字节串。

### 解包（Unpacking）
解包是将 C 结构体格式的字符串转换回 Python 值的过程。使用 `struct.unpack()` 函数，其语法如下：
```python
import struct

format_string = 'if'
packed_data = struct.pack(format_string, 10, 3.14)

unpacked_values = struct.unpack(format_string, packed_data)
print(unpacked_values)
```
在这段代码中，`struct.unpack()` 函数根据格式字符串 `'if'` 将字节串 `packed_data` 解包回 Python 元组。

## 常见实践
### 处理二进制文件
在处理二进制文件时，`struct` 模块可以帮助我们读取和写入特定格式的数据。例如，假设我们有一个二进制文件，其中包含一系列的整数和浮点数：
```python
import struct

# 写入二进制文件
data = [(10, 3.14), (20, 4.16)]
with open('binary_file.bin', 'wb') as f:
    format_string = 'if'
    for values in data:
        packed_data = struct.pack(format_string, *values)
        f.write(packed_data)

# 读取二进制文件
with open('binary_file.bin', 'rb') as f:
    format_string = 'if'
    unpacked_data = []
    while True:
        chunk = f.read(struct.calcsize(format_string))
        if not chunk:
            break
        unpacked_values = struct.unpack(format_string, chunk)
        unpacked_data.append(unpacked_values)

print(unpacked_data)
```
在这个示例中，我们首先将数据打包并写入二进制文件，然后再从文件中读取数据并解包。

### 网络数据传输
在网络编程中，`struct` 模块常用于处理网络协议中的数据格式。例如，在 TCP 套接字通信中：
```python
import struct
import socket

# 创建套接字
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.bind(('localhost', 12345))
sock.listen(1)

# 发送数据
format_string = 'if'
values = (10, 3.14)
packed_data = struct.pack(format_string, *values)

client, addr = sock.accept()
client.sendall(packed_data)
client.close()

# 接收数据
sock.listen(1)
client, addr = sock.accept()
chunk = client.recv(struct.calcsize(format_string))
unpacked_values = struct.unpack(format_string, chunk)
print(unpacked_values)
client.close()
sock.close()
```
在这个示例中，我们使用 `struct` 模块打包数据并通过网络发送，然后接收并解包数据。

## 最佳实践
### 提高性能
- **缓存格式字符串**：如果需要多次使用相同的格式字符串进行打包或解包操作，可以将格式字符串缓存起来，避免重复解析。
```python
import struct

format_string = 'if'
packer = struct.Struct(format_string)

values = (10, 3.14)
packed_data = packer.pack(*values)
unpacked_values = packer.unpack(packed_data)
```
- **使用 `struct.Struct` 类**：`struct.Struct` 类提供了一种更高效的方式来处理结构体，因为它在创建时解析格式字符串，而不是每次调用 `pack()` 或 `unpack()` 时解析。

### 代码可读性
- **使用常量**：将格式字符串定义为常量，这样可以提高代码的可读性和可维护性。
```python
import struct

DATA_FORMAT = 'if'

def pack_data(values):
    return struct.pack(DATA_FORMAT, *values)

def unpack_data(packed_data):
    return struct.unpack(DATA_FORMAT, packed_data)
```
- **添加注释**：在使用 `struct` 模块的地方添加注释，解释格式字符串的含义和数据结构。

## 小结
通过 `struct` 模块，Python 能够处理 C 结构体格式的数据，这在处理二进制数据、网络协议和文件格式等方面非常有用。掌握 `struct` 模块的基础概念、使用方法、常见实践和最佳实践，可以帮助我们更高效地处理复杂的数据结构和二进制数据。

## 参考资料
- 《Python 核心编程》
- 《Python 网络编程基础》
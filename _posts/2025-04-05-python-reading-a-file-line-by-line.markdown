---
title: "Python 逐行读取文件：深入解析与实践"
description: "在 Python 编程中，文件处理是一项常见且重要的任务。逐行读取文件是一种非常实用的操作，它允许我们在处理大文件时避免一次性将整个文件加载到内存中，从而提高程序的效率和稳定性。本文将详细介绍 Python 中逐行读取文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 编程中，文件处理是一项常见且重要的任务。逐行读取文件是一种非常实用的操作，它允许我们在处理大文件时避免一次性将整个文件加载到内存中，从而提高程序的效率和稳定性。本文将详细介绍 Python 中逐行读取文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 使用 `for` 循环
    - 使用 `readline()` 方法
    - 使用 `readlines()` 方法
3. **常见实践**
    - 处理文本文件
    - 处理大文件
4. **最佳实践**
    - 内存管理
    - 异常处理
5. **小结**
6. **参考资料**

## 基础概念
在计算机中，文件是存储在外部存储设备上的数据集合。Python 提供了丰富的文件处理功能，使得我们可以方便地读取、写入和修改文件。逐行读取文件意味着每次从文件中读取一行数据进行处理，而不是一次性读取整个文件内容。这种方式在处理大文件时尤为重要，因为大文件可能无法完全加载到内存中。

## 使用方法

### 使用 `for` 循环
这是最常用的逐行读取文件的方法。`for` 循环会自动迭代文件对象的每一行。
```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        for line in file:
            print(line.strip())  # strip() 方法用于去除每行末尾的换行符
except FileNotFoundError:
    print("文件未找到")
```
在上述代码中：
- 使用 `open()` 函数打开文件，`'r'` 表示以只读模式打开，`encoding='utf-8'` 用于指定文件的编码格式。
- `with` 语句确保在文件使用完毕后自动关闭，避免资源泄漏。
- `for` 循环遍历文件对象 `file` 的每一行，`line` 变量存储当前行的数据。
- `print(line.strip())` 打印每一行数据，并使用 `strip()` 方法去除行末的换行符。

### 使用 `readline()` 方法
`readline()` 方法每次读取文件的一行。
```python
try:
    file = open('example.txt', 'r', encoding='utf-8')
    line = file.readline()
    while line:
        print(line.strip())
        line = file.readline()
    file.close()
except FileNotFoundError:
    print("文件未找到")
```
代码解释：
- 首先使用 `open()` 函数打开文件。
- 调用 `file.readline()` 读取第一行数据并赋值给 `line`。
- `while line` 循环条件检查 `line` 是否为空，如果不为空则执行循环体。
- 在循环体中，打印当前行数据并去除换行符，然后再次调用 `readline()` 读取下一行。
- 最后使用 `file.close()` 关闭文件。

### 使用 `readlines()` 方法
`readlines()` 方法会一次性读取文件的所有行，并返回一个包含所有行的列表。
```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        lines = file.readlines()
        for line in lines:
            print(line.strip())
except FileNotFoundError:
    print("文件未找到")
```
此代码中：
- 打开文件后，使用 `readlines()` 方法将文件所有行读取到 `lines` 列表中。
- 然后通过 `for` 循环遍历 `lines` 列表，打印每一行数据并去除换行符。

## 常见实践

### 处理文本文件
在处理文本文件时，逐行读取可以方便地对每一行进行分析和处理。例如，统计文件中单词的出现次数。
```python
word_count = {}
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        for line in file:
            words = line.split()
            for word in words:
                if word in word_count:
                    word_count[word] += 1
                else:
                    word_count[word] = 1
    for word, count in word_count.items():
        print(f"{word}: {count}")
except FileNotFoundError:
    print("文件未找到")
```
在这段代码中：
- 首先初始化一个空字典 `word_count` 用于存储单词及其出现次数。
- 逐行读取文件，使用 `split()` 方法将每行拆分成单词。
- 遍历每个单词，更新字典中单词的计数。
- 最后打印每个单词及其出现次数。

### 处理大文件
对于大文件，使用 `for` 循环逐行读取是最佳选择，以避免内存不足问题。例如，处理一个超大的日志文件，只打印包含特定关键词的行。
```python
keyword = "error"
try:
    with open('large_log_file.log', 'r', encoding='utf-8') as file:
        for line in file:
            if keyword in line:
                print(line.strip())
except FileNotFoundError:
    print("文件未找到")
```
这段代码逐行读取日志文件，检查每行是否包含关键词 `error`，如果包含则打印该行。

## 最佳实践

### 内存管理
在处理大文件时，应尽量避免一次性将整个文件加载到内存中。使用 `for` 循环逐行读取是最有效的内存管理方式。此外，及时关闭文件对象可以释放系统资源。

### 异常处理
在文件操作过程中，可能会出现各种异常，如文件未找到、权限不足等。使用 `try - except` 块进行异常处理可以提高程序的稳定性和健壮性。

## 小结
本文详细介绍了 Python 中逐行读取文件的方法，包括使用 `for` 循环、`readline()` 方法和 `readlines()` 方法。同时，通过常见实践展示了如何在实际场景中应用这些方法，以及最佳实践中关于内存管理和异常处理的要点。逐行读取文件是 Python 文件处理的重要技能，掌握它可以帮助我们更高效地处理各种文件操作任务。

## 参考资料
- 《Python 核心编程》
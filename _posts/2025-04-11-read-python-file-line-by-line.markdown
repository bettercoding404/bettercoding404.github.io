---
title: "逐行读取 Python 文件：深入解析与实践"
description: "在 Python 编程中，处理文件是一项常见任务。逐行读取文件内容是一种非常实用的操作，它允许我们按顺序处理文件中的每一行数据。这种方法在处理大文件时尤为重要，因为它避免一次性将整个文件加载到内存中，从而节省内存并提高程序效率。本文将深入探讨逐行读取 Python 文件的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 编程中，处理文件是一项常见任务。逐行读取文件内容是一种非常实用的操作，它允许我们按顺序处理文件中的每一行数据。这种方法在处理大文件时尤为重要，因为它避免一次性将整个文件加载到内存中，从而节省内存并提高程序效率。本文将深入探讨逐行读取 Python 文件的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `for` 循环**
    - **使用 `readlines()` 方法**
    - **使用 `readline()` 方法**
3. **常见实践**
    - **处理文本文件数据**
    - **过滤特定行**
4. **最佳实践**
    - **内存管理优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，文件对象提供了多种读取文件内容的方式。逐行读取意味着每次只从文件中读取一行数据，而不是一次性读取整个文件。这对于处理大型文件或需要对每一行数据进行单独处理的场景非常有用。文件对象是通过内置的 `open()` 函数创建的，该函数返回一个文件对象，我们可以使用这个对象的方法来进行文件操作。

## 使用方法

### 使用 `for` 循环
这是逐行读取文件最常用的方法之一。通过直接在文件对象上使用 `for` 循环，Python 会自动逐行迭代文件内容。
```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        for line in file:
            print(line.strip())  # strip() 方法用于去除每行末尾的换行符
except FileNotFoundError:
    print("文件未找到")
```
在这个示例中，我们使用 `with open()` 语句打开文件，这确保在文件操作完成后自动关闭文件。`for` 循环遍历文件对象的每一行，`strip()` 方法用于去除每行末尾的换行符，使输出更加整洁。

### 使用 `readlines()` 方法
`readlines()` 方法会将文件的所有行读取到一个列表中，每个元素是文件中的一行。
```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        lines = file.readlines()
        for line in lines:
            print(line.strip())
except FileNotFoundError:
    print("文件未找到")
```
虽然这种方法也能逐行读取文件，但它会将整个文件内容一次性加载到内存中，对于大文件可能会导致内存问题。

### 使用 `readline()` 方法
`readline()` 方法每次读取文件的一行，返回一个字符串。
```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        line = file.readline()
        while line:
            print(line.strip())
            line = file.readline()
except FileNotFoundError:
    print("文件未找到")
```
在这个示例中，我们使用 `while` 循环来不断读取文件的行，直到读取到空字符串（表示文件末尾）。

## 常见实践

### 处理文本文件数据
假设我们有一个包含学生成绩的文本文件，每行格式为 `姓名:成绩`，我们可以逐行读取文件并计算平均成绩。
```python
total_score = 0
student_count = 0

try:
    with open('scores.txt', 'r', encoding='utf-8') as file:
        for line in file:
            parts = line.strip().split(':')
            if len(parts) == 2:
                name, score = parts
                try:
                    score = float(score)
                    total_score += score
                    student_count += 1
                except ValueError:
                    print(f"无法将 {score} 转换为数字")
except FileNotFoundError:
    print("文件未找到")

if student_count > 0:
    average_score = total_score / student_count
    print(f"平均成绩: {average_score}")
```

### 过滤特定行
如果我们只想读取文件中包含特定关键词的行，可以这样做：
```python
keyword = "error"

try:
    with open('log.txt', 'r', encoding='utf-8') as file:
        for line in file:
            if keyword in line:
                print(line.strip())
except FileNotFoundError:
    print("文件未找到")
```
这个示例会打印出 `log.txt` 文件中包含 `error` 关键词的行。

## 最佳实践

### 内存管理优化
如前所述，使用 `readlines()` 方法会将整个文件加载到内存中，对于大文件不推荐。优先使用 `for` 循环直接遍历文件对象，这样每次只处理一行数据，避免内存过载。

### 错误处理
在进行文件操作时，始终要进行适当的错误处理。例如，使用 `try - except` 块来捕获文件未找到、权限不足等异常，确保程序的稳定性。

## 小结
逐行读取 Python 文件是一项基本且重要的技能。通过本文介绍的基础概念、不同的使用方法、常见实践以及最佳实践，读者应该能够在实际编程中灵活运用这些知识，高效地处理文件内容，特别是在处理大文件或需要对每一行数据进行单独处理的场景下。

## 参考资料
- [Python 官方文档 - 文件 I/O](https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files){: rel="nofollow"}
- 《Python 核心编程》
- 《Effective Python》
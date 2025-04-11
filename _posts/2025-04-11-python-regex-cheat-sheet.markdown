---
title: "Python Regex Cheat Sheet：掌握正则表达式的利器"
description: "正则表达式（Regular Expression，简称 Regex）是一种用于描述字符串模式的工具。在 Python 中，正则表达式的使用非常广泛，无论是数据清洗、文本搜索、替换还是验证，都能发挥巨大的作用。本博客将围绕 Python Regex Cheat Sheet 展开，帮助你快速掌握正则表达式在 Python 中的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
正则表达式（Regular Expression，简称 Regex）是一种用于描述字符串模式的工具。在 Python 中，正则表达式的使用非常广泛，无论是数据清洗、文本搜索、替换还是验证，都能发挥巨大的作用。本博客将围绕 Python Regex Cheat Sheet 展开，帮助你快速掌握正则表达式在 Python 中的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 编译正则表达式
    - 匹配字符串
    - 搜索字符串
    - 查找所有匹配项
    - 替换字符串
    - 分割字符串
3. **常见实践**
    - 验证电子邮件地址
    - 提取电话号码
    - 数据清洗
4. **最佳实践**
    - 性能优化
    - 可读性优化
    - 错误处理
5. **小结**
6. **参考资料**

## 基础概念
### 字符类
- **普通字符**：直接匹配字符本身，例如 `a` 匹配字符串中的 `a`。
- **元字符**：具有特殊含义的字符，例如 `.` 匹配任意一个字符（除了换行符）。
- **预定义字符类**：
    - `\d`：匹配任意一个数字字符，等价于 `[0-9]`。
    - `\w`：匹配任意一个字母、数字或下划线字符，等价于 `[a-zA-Z0-9_]`。
    - `\s`：匹配任意一个空白字符，等价于 `[ \t\n\r\f\v]`。

### 数量词
- `*`：匹配前面的字符零次或多次。
- `+`：匹配前面的字符一次或多次。
- `?`：匹配前面的字符零次或一次。
- `{n}`：匹配前面的字符恰好 `n` 次。
- `{n,}`：匹配前面的字符至少 `n` 次。
- `{n,m}`：匹配前面的字符至少 `n` 次，最多 `m` 次。

### 分组
使用 `()` 将多个字符组合在一起，形成一个分组。分组可以用于提取匹配的子字符串，也可以用于对一组字符应用数量词。例如，`(ab)+` 匹配 `ab` 一次或多次。

## 使用方法
### 编译正则表达式
在 Python 中，使用 `re` 模块来处理正则表达式。首先，需要编译正则表达式，将其转换为一个正则表达式对象。

```python
import re

# 编译正则表达式
pattern = re.compile(r'\d+')
```

### 匹配字符串
使用 `match()` 方法从字符串的开头开始匹配。

```python
import re

pattern = re.compile(r'\d+')
result = pattern.match('123abc')
if result:
    print(result.group())  # 输出: 123
```

### 搜索字符串
使用 `search()` 方法在字符串中搜索第一个匹配的位置。

```python
import re

pattern = re.compile(r'\d+')
result = pattern.search('abc123def')
if result:
    print(result.group())  # 输出: 123
```

### 查找所有匹配项
使用 `findall()` 方法查找字符串中所有匹配的子字符串，并返回一个列表。

```python
import re

pattern = re.compile(r'\d+')
results = pattern.findall('abc123def456')
print(results)  # 输出: ['123', '456']
```

### 替换字符串
使用 `sub()` 方法将匹配的子字符串替换为指定的字符串。

```python
import re

pattern = re.compile(r'\d+')
new_string = pattern.sub('X', 'abc123def456')
print(new_string)  # 输出: abcXdefX
```

### 分割字符串
使用 `split()` 方法根据匹配的正则表达式分割字符串。

```python
import re

pattern = re.compile(r'\d+')
parts = pattern.split('abc123def456')
print(parts)  # 输出: ['abc', 'def', '']
```

## 常见实践
### 验证电子邮件地址
```python
import re

email_pattern = re.compile(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')

def validate_email(email):
    return email_pattern.match(email) is not None

print(validate_email('test@example.com'))  # 输出: True
```

### 提取电话号码
```python
import re

phone_pattern = re.compile(r'(\d{3})-(\d{3})-(\d{4})')

def extract_phone_number(text):
    result = phone_pattern.search(text)
    if result:
        return result.groups()
    return None

print(extract_phone_number('My phone number is 123-456-7890'))  # 输出: ('123', '456', '7890')
```

### 数据清洗
```python
import re

text = '  This is   some   messy text!  '
cleaned_text = re.sub(r'\s+','', text).strip()
print(cleaned_text)  # 输出: This is some messy text!
```

## 最佳实践
### 性能优化
- 尽量复用编译后的正则表达式对象，避免重复编译。
- 使用非贪婪匹配（例如 `*?`、`+?`），如果适用，以提高匹配效率。

### 可读性优化
- 使用注释解释复杂的正则表达式。
- 将长的正则表达式拆分成多个部分，提高代码的可读性。

### 错误处理
- 在编译正则表达式时，捕获 `re.error` 异常，以处理无效的正则表达式。

```python
import re

try:
    pattern = re.compile(r'[')
except re.error as e:
    print(f"Error: {e}")
```

## 小结
通过本博客，我们深入了解了 Python Regex Cheat Sheet 的基础概念、使用方法、常见实践以及最佳实践。正则表达式是处理字符串的强大工具，掌握它可以大大提高我们在文本处理方面的效率。希望读者能够通过不断实践，熟练运用正则表达式解决实际问题。

## 参考资料
- [Python官方文档 - re模块](https://docs.python.org/3/library/re.html){: rel="nofollow"}
- [Regular-Expressions.info](https://www.regular-expressions.info/){: rel="nofollow"}
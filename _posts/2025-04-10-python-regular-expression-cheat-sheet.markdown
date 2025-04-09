---
title: "Python正则表达式速查表：从入门到实践"
description: "正则表达式（Regular Expression）是一种用于描述字符串模式的工具，在Python中，正则表达式模块`re`提供了强大的功能来处理字符串匹配、搜索、替换等操作。本文将通过一份详尽的Python正则表达式速查表，帮助你快速掌握其基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
正则表达式（Regular Expression）是一种用于描述字符串模式的工具，在Python中，正则表达式模块`re`提供了强大的功能来处理字符串匹配、搜索、替换等操作。本文将通过一份详尽的Python正则表达式速查表，帮助你快速掌握其基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
### 字符类
- **普通字符**：直接匹配字符串中的字符，例如`a`匹配字符串中的`a`。
- **元字符**：具有特殊含义的字符，例如`^`表示字符串的开头，`$`表示字符串的结尾。
- **字符组**：用方括号`[]`括起来，表示匹配其中任意一个字符，例如`[abc]`匹配`a`、`b`或`c`。
- **预定义字符组**：
    - `\d`：匹配任意一个数字，等价于`[0-9]`。
    - `\w`：匹配任意一个字母、数字或下划线，等价于`[a-zA-Z0-9_]`。
    - `\s`：匹配任意一个空白字符，包括空格、制表符、换行符等，等价于`[ \t\n\r\f\v]`。
    - `\D`：匹配任意一个非数字字符，等价于`[^0-9]`。
    - `\W`：匹配任意一个非字母、数字和下划线的字符，等价于`[^a-zA-Z0-9_]`。
    - `\S`：匹配任意一个非空白字符，等价于`[^ \t\n\r\f\v]`。

### 量词
- `*`：匹配前面的字符零次或多次，例如`a*`可以匹配空字符串、`a`、`aa`、`aaa`等。
- `+`：匹配前面的字符一次或多次，例如`a+`可以匹配`a`、`aa`、`aaa`等，但不能匹配空字符串。
- `?`：匹配前面的字符零次或一次，例如`a?`可以匹配空字符串或`a`。
- `{n}`：匹配前面的字符恰好`n`次，例如`a{3}`只能匹配`aaa`。
- `{n,}`：匹配前面的字符至少`n`次，例如`a{3,}`可以匹配`aaa`、`aaaa`、`aaaaa`等。
- `{n,m}`：匹配前面的字符至少`n`次，最多`m`次，例如`a{3,5}`可以匹配`aaa`、`aaaa`、`aaaaa`。

### 分组
使用圆括号`()`将正则表达式的一部分括起来，表示一个分组。分组可以用于提取匹配的子字符串，也可以用于对一组字符应用量词。例如，`(ab)+`可以匹配`ab`、`abab`、`ababab`等。

## 使用方法
### 导入`re`模块
在Python中使用正则表达式，首先需要导入`re`模块：
```python
import re
```

### 匹配操作
- **`re.match(pattern, string, flags=0)`**：从字符串的开头开始匹配，如果匹配成功，返回一个匹配对象，否则返回`None`。
```python
pattern = r'hello'
string = 'hello world'
match = re.match(pattern, string)
if match:
    print('匹配成功')
else:
    print('匹配失败')
```

- **`re.search(pattern, string, flags=0)`**：在字符串中搜索第一个匹配的位置，如果找到匹配，返回一个匹配对象，否则返回`None`。
```python
pattern = r'world'
string = 'hello world'
match = re.search(pattern, string)
if match:
    print('匹配成功')
else:
    print('匹配失败')
```

### 查找所有匹配
- **`re.findall(pattern, string, flags=0)`**：返回字符串中所有匹配的子字符串，以列表形式返回。
```python
pattern = r'\d+'
string = '123 abc 456 def 789'
matches = re.findall(pattern, string)
print(matches)  # 输出: ['123', '456', '789']
```

### 替换操作
- **`re.sub(pattern, repl, string, count=0, flags=0)`**：将字符串中所有匹配的子字符串替换为指定的字符串。
```python
pattern = r'\d+'
repl = 'X'
string = '123 abc 456 def 789'
new_string = re.sub(pattern, repl, string)
print(new_string)  # 输出: 'X abc X def X'
```

### 分割操作
- **`re.split(pattern, string, maxsplit=0, flags=0)`**：根据匹配的正则表达式将字符串分割成多个部分，返回一个列表。
```python
pattern = r'\s+'
string = 'hello world how are you'
parts = re.split(pattern, string)
print(parts)  # 输出: ['hello', 'world', 'how', 'are', 'you']
```

## 常见实践
### 验证邮箱地址
```python
import re

def validate_email(email):
    pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    return re.match(pattern, email) is not None

email = 'example@example.com'
if validate_email(email):
    print('有效的邮箱地址')
else:
    print('无效的邮箱地址')
```

### 提取URL
```python
import re

def extract_urls(text):
    pattern = r'https?://[^\s<>"]+|www\.[^\s<>"]+'
    return re.findall(pattern, text)

text = '这是一个包含URL的文本：https://example.com和www.example.org'
urls = extract_urls(text)
print(urls)  # 输出: ['https://example.com', 'www.example.org']
```

## 最佳实践
### 使用原始字符串
在定义正则表达式时，使用原始字符串（在字符串前加上`r`）可以避免反斜杠的转义问题。例如：
```python
pattern = r'\d+'  # 正确
pattern = '\d+'   # 错误，可能会导致反斜杠被转义
```

### 编译正则表达式
如果需要多次使用同一个正则表达式，可以先编译它，以提高效率。
```python
import re

pattern = re.compile(r'\d+')
string1 = '123 abc'
string2 = '456 def'
matches1 = pattern.findall(string1)
matches2 = pattern.findall(string2)
print(matches1)  # 输出: ['123']
print(matches2)  # 输出: ['456']
```

### 避免过度复杂的正则表达式
正则表达式过于复杂会降低代码的可读性和维护性。如果可以通过其他简单的方法实现相同的功能，优先选择其他方法。

## 小结
本文通过Python正则表达式速查表，介绍了正则表达式的基础概念、使用方法、常见实践以及最佳实践。正则表达式是处理字符串的强大工具，掌握它可以提高代码的效率和灵活性。希望读者通过本文的学习，能够在实际项目中熟练运用正则表达式解决各种字符串处理问题。

## 参考资料
- [Python官方文档 - re模块](https://docs.python.org/3/library/re.html){: rel="nofollow"}
- [正则表达式在线测试工具](https://regex101.com/){: rel="nofollow"}
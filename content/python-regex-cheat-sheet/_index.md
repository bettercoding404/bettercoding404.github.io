---
title: "Python正则表达式速查表：从入门到实践"
description: "正则表达式（Regular Expressions，简称Regex）是用于描述字符串模式的工具，在文本处理、数据验证、信息提取等诸多场景中发挥着重要作用。Python通过`re`模块提供了对正则表达式的支持。本文的Python正则表达式速查表将帮助你快速掌握正则表达式在Python中的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
正则表达式（Regular Expressions，简称Regex）是用于描述字符串模式的工具，在文本处理、数据验证、信息提取等诸多场景中发挥着重要作用。Python通过`re`模块提供了对正则表达式的支持。本文的Python正则表达式速查表将帮助你快速掌握正则表达式在Python中的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 匹配操作
    - 搜索操作
    - 替换操作
    - 分割操作
3. 常见实践
    - 验证电子邮件地址
    - 提取URL
    - 查找特定单词
4. 最佳实践
    - 优化正则表达式
    - 错误处理
    - 保持代码可读性
5. 小结
6. 参考资料

## 基础概念
### 字符类
- `.`：匹配任意单个字符（除了换行符）。例如，`a.c`可以匹配`abc`、`aec`等。
- `\d`：匹配任意一个数字字符，等价于`[0-9]`。例如，`\d\d`可以匹配`12`、`34`等。
- `\w`：匹配任意一个字母、数字或下划线字符，等价于`[a-zA-Z0-9_]`。例如，`\w\w`可以匹配`ab`、`1_`等。
- `\s`：匹配任意一个空白字符，包括空格、制表符、换行符等，等价于`[ \t\n\r\f\v]`。例如，`a\sb`可以匹配`a b`。

### 量词
- `*`：匹配前面的字符零次或多次。例如，`a*`可以匹配空字符串、`a`、`aa`等。
- `+`：匹配前面的字符一次或多次。例如，`a+`可以匹配`a`、`aa`等，但不能匹配空字符串。
- `?`：匹配前面的字符零次或一次。例如，`a?`可以匹配空字符串或`a`。
- `{n}`：匹配前面的字符恰好`n`次。例如，`a{3}`可以匹配`aaa`。
- `{n,}`：匹配前面的字符至少`n`次。例如，`a{3,}`可以匹配`aaa`、`aaaa`等。
- `{n,m}`：匹配前面的字符至少`n`次，最多`m`次。例如，`a{2,4}`可以匹配`aa`、`aaa`、`aaaa`。

### 分组
使用圆括号`()`进行分组。例如，`(ab)+`可以匹配`ab`、`abab`、`ababab`等。分组可以用于提取匹配的部分，也可以用于对一组字符应用量词。

## 使用方法
### 匹配操作
```python
import re

pattern = r'hello'
string = 'hello world'
match = re.match(pattern, string)
if match:
    print("匹配成功")
else:
    print("匹配失败")
```
在上述代码中，`re.match`从字符串的开头开始匹配模式。如果找到匹配，则返回一个匹配对象，否则返回`None`。

### 搜索操作
```python
import re

pattern = r'world'
string = 'hello world'
match = re.search(pattern, string)
if match:
    print("找到匹配项：", match.group())
else:
    print("未找到匹配项")
```
`re.search`在整个字符串中搜索模式，找到第一个匹配项后返回匹配对象，否则返回`None`。`match.group()`用于获取匹配的字符串。

### 替换操作
```python
import re

pattern = r'world'
string = 'hello world'
new_string = re.sub(pattern, 'Python', string)
print("替换后的字符串：", new_string)
```
`re.sub`用于将字符串中所有匹配模式的部分替换为指定的字符串。

### 分割操作
```python
import re

pattern = r'\s'
string = 'hello world how are you'
parts = re.split(pattern, string)
print("分割后的部分：", parts)
```
`re.split`根据匹配的模式将字符串分割成多个部分，返回一个列表。

## 常见实践
### 验证电子邮件地址
```python
import re

email_pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
email = 'example@example.com'
if re.match(email_pattern, email):
    print("有效的电子邮件地址")
else:
    print("无效的电子邮件地址")
```

### 提取URL
```python
import re

text = 'Visit my website at https://www.example.com'
url_pattern = r'https?://[^\s]+'
urls = re.findall(url_pattern, text)
print("提取到的URL：", urls)
```

### 查找特定单词
```python
import re

text = 'I love Python programming'
word_pattern = r'\bPython\b'
if re.search(word_pattern, text):
    print("找到单词Python")
else:
    print("未找到单词Python")
```

## 最佳实践
### 优化正则表达式
- 尽量使用原子分组和固化分组来提高匹配效率。
- 避免使用过于复杂的正则表达式，将复杂的任务分解为多个简单的正则表达式。

### 错误处理
在使用正则表达式时，要注意处理可能出现的错误，例如无效的正则表达式语法。可以使用`try-except`块来捕获`re.error`异常。
```python
import re

try:
    pattern = r'[a-z['
    re.match(pattern, 'test')
except re.error as e:
    print("正则表达式错误：", e)
```

### 保持代码可读性
给正则表达式添加注释，使用`re.VERBOSE`标志可以使正则表达式更易读。
```python
import re

pattern = re.compile(r"""
    \d{3}       # 匹配三位数字
    \s          # 匹配一个空格
    \d{3}       # 匹配另外三位数字
    -           # 匹配连字符
    \d{4}       # 匹配四位数字
""", re.VERBOSE)
```

## 小结
通过本文的Python正则表达式速查表，我们学习了正则表达式的基础概念，如字符类、量词、分组等，掌握了在Python中使用正则表达式的常见操作，包括匹配、搜索、替换和分割。同时，我们还探讨了一些常见实践和最佳实践，以帮助你在实际项目中更高效地使用正则表达式进行文本处理。

## 参考资料
- [Python官方文档 - re模块](https://docs.python.org/3/library/re.html)
- [Regular Expressions Tutorial](https://www.regular-expressions.info/)
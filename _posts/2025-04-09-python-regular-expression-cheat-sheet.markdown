---
title: "Python正则表达式速查表：从基础到实践"
description: "正则表达式（Regular Expression，简称Regex）是一种用于描述字符串模式的工具。在Python中，正则表达式是处理文本数据的强大武器，无论是数据清洗、文本匹配、查找替换等任务，都能发挥巨大作用。本文将围绕Python正则表达式速查表展开，深入探讨其基础概念、使用方法、常见实践以及最佳实践，帮助读者快速掌握并灵活运用正则表达式。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
正则表达式（Regular Expression，简称Regex）是一种用于描述字符串模式的工具。在Python中，正则表达式是处理文本数据的强大武器，无论是数据清洗、文本匹配、查找替换等任务，都能发挥巨大作用。本文将围绕Python正则表达式速查表展开，深入探讨其基础概念、使用方法、常见实践以及最佳实践，帮助读者快速掌握并灵活运用正则表达式。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是正则表达式
    - 常用字符类和元字符
2. **使用方法**
    - 导入`re`模块
    - 匹配函数：`match`、`search`、`findall`
    - 替换函数：`sub`
    - 分组与捕获
3. **常见实践**
    - 验证邮箱地址
    - 提取电话号码
    - 数据清洗：去除HTML标签
4. **最佳实践**
    - 优化正则表达式性能
    - 编写可读性强的正则表达式
    - 测试正则表达式
5. **小结**
6. **参考资料**

## 基础概念
### 什么是正则表达式
正则表达式是一种描述字符串模式的工具，它使用特定的字符和符号组合来定义字符串的匹配规则。例如，`\d`表示匹配任意一个数字字符，`[a-zA-Z]`表示匹配任意一个字母字符。

### 常用字符类和元字符
- **字符类**：
    - `\d`：匹配任意一个数字字符，等价于`[0-9]`。
    - `\D`：匹配任意一个非数字字符，等价于`[^0-9]`。
    - `\w`：匹配任意一个字母、数字或下划线字符，等价于`[a-zA-Z0-9_]`。
    - `\W`：匹配任意一个非字母、数字或下划线字符，等价于`[^a-zA-Z0-9_]`。
    - `\s`：匹配任意一个空白字符，包括空格、制表符、换行符等，等价于`[ \t\n\r\f\v]`。
    - `\S`：匹配任意一个非空白字符，等价于`[^ \t\n\r\f\v]`。
- **元字符**：
    - `.`：匹配任意一个字符（除了换行符`\n`）。
    - `^`：匹配字符串的开头。
    - `$`：匹配字符串的结尾。
    - `*`：匹配前面的字符零次或多次。
    - `+`：匹配前面的字符一次或多次。
    - `?`：匹配前面的字符零次或一次。
    - `{n}`：匹配前面的字符恰好`n`次。
    - `{n,}`：匹配前面的字符至少`n`次。
    - `{n,m}`：匹配前面的字符`n`到`m`次。
    - `[]`：用于定义字符类，例如`[0-9]`表示匹配数字字符。
    - `()`：用于分组和捕获，后面会详细介绍。

## 使用方法
### 导入`re`模块
在Python中使用正则表达式，需要先导入`re`模块：
```python
import re
```

### 匹配函数
- **`match`**：从字符串的开头开始匹配模式，如果匹配成功，返回一个匹配对象；如果匹配失败，返回`None`。
```python
pattern = r'hello'
string = 'hello world'
match_obj = re.match(pattern, string)
if match_obj:
    print('匹配成功')
else:
    print('匹配失败')
```
- **`search`**：在字符串中搜索模式，找到第一个匹配的位置，如果匹配成功，返回一个匹配对象；如果匹配失败，返回`None`。
```python
pattern = r'world'
string = 'hello world'
match_obj = re.search(pattern, string)
if match_obj:
    print('匹配成功')
else:
    print('匹配失败')
```
- **`findall`**：在字符串中查找所有匹配的子串，返回一个包含所有匹配子串的列表。
```python
pattern = r'\d+'
string = 'I have 3 apples and 5 bananas'
matches = re.findall(pattern, string)
print(matches)  # 输出: ['3', '5']
```

### 替换函数
**`sub`**：用于在字符串中替换所有匹配的子串。
```python
pattern = r'\d+'
string = 'I have 3 apples and 5 bananas'
new_string = re.sub(pattern, 'X', string)
print(new_string)  # 输出: 'I have X apples and X bananas'
```

### 分组与捕获
使用`()`进行分组，可以捕获匹配的子串。匹配对象的`groups`方法可以获取捕获的子串。
```python
pattern = r'(\d+)-(\d+)-(\d+)'
string = '2023-10-05'
match_obj = re.match(pattern, string)
if match_obj:
    groups = match_obj.groups()
    print(groups)  # 输出: ('2023', '10', '05')
```

## 常见实践
### 验证邮箱地址
```python
import re

def validate_email(email):
    pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    if re.match(pattern, email):
        return True
    else:
        return False

email = 'example@example.com'
print(validate_email(email))  # 输出: True
```

### 提取电话号码
```python
import re

def extract_phone_number(text):
    pattern = r'(\d{3})-(\d{3})-(\d{4})'
    matches = re.findall(pattern, text)
    phone_numbers = []
    for match in matches:
        phone_number = '-'.join(match)
        phone_numbers.append(phone_number)
    return phone_numbers

text = 'My phone number is 123-456-7890 and his number is 987-654-3210'
print(extract_phone_number(text))  # 输出: ['123-456-7890', '987-654-3210']
```

### 数据清洗：去除HTML标签
```python
import re

def remove_html_tags(text):
    pattern = r'<.*?>'
    return re.sub(pattern, '', text)

html_text = '<p>Hello, <b>world</b>!</p>'
print(remove_html_tags(html_text))  # 输出: Hello, world!
```

## 最佳实践
### 优化正则表达式性能
- 尽量使用字符类而不是多个字符的交替，例如`[abc]`比`(a|b|c)`更高效。
- 避免使用过于复杂的正则表达式，尽量将复杂的匹配逻辑拆分成多个简单的正则表达式。

### 编写可读性强的正则表达式
- 使用注释和空白字符来提高正则表达式的可读性，例如：
```python
pattern = r"""
    ^               # 匹配字符串开头
    [a-zA-Z0-9_.+-]  # 匹配邮箱用户名部分
    @               # 匹配@符号
    [a-zA-Z0-9-]+   # 匹配域名部分
  .               # 匹配点号
    [a-zA-Z0-9-.]+  # 匹配顶级域名部分
    $               # 匹配字符串结尾
"""
```
### 测试正则表达式
在实际应用之前，使用测试数据对正则表达式进行充分测试，确保其正确性。可以使用在线正则表达式测试工具，如[Regex101](https://regex101.com/)。

## 小结
本文围绕Python正则表达式速查表，详细介绍了正则表达式的基础概念、使用方法、常见实践以及最佳实践。通过学习这些内容，读者可以掌握正则表达式在Python中的基本应用，并能够运用正则表达式解决实际的文本处理问题。正则表达式是一个强大而灵活的工具，需要不断练习和实践才能熟练掌握。

## 参考资料
- [Python官方文档 - re模块](https://docs.python.org/3/library/re.html){: rel="nofollow"}
- [正则表达式在线测试工具 - Regex101](https://regex101.com/){: rel="nofollow"}
- 《Python核心编程》（第3版）第15章：正则表达式和`re`模块。 
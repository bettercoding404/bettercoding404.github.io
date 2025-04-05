---
title: "Python正则表达式速查表：从基础到实战"
description: "正则表达式（Regular Expression）是用于描述字符串模式的工具，在文本处理、数据验证、信息提取等众多领域都有广泛应用。Python提供了强大的正则表达式模块`re`来处理正则表达式。这份Python正则表达式速查表将帮助你快速掌握正则表达式在Python中的基础概念、使用方法以及最佳实践，让你在处理文本数据时更加得心应手。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
正则表达式（Regular Expression）是用于描述字符串模式的工具，在文本处理、数据验证、信息提取等众多领域都有广泛应用。Python提供了强大的正则表达式模块`re`来处理正则表达式。这份Python正则表达式速查表将帮助你快速掌握正则表达式在Python中的基础概念、使用方法以及最佳实践，让你在处理文本数据时更加得心应手。

<!-- more -->
## 目录
1. **基础概念**
    - 正则表达式字符类
    - 元字符
2. **使用方法**
    - 匹配
    - 搜索
    - 查找所有
    - 替换
    - 分割
3. **常见实践**
    - 验证邮箱地址
    - 提取电话号码
    - 清理文本
4. **最佳实践**
    - 编译正则表达式
    - 处理复杂模式
    - 错误处理
5. **小结**
6. **参考资料**

## 基础概念
### 正则表达式字符类
- **数字类**：`\d` 匹配任何数字字符，等价于 `[0-9]`；`\D` 匹配任何非数字字符，等价于 `[^0-9]`。
- **字母类**：`\w` 匹配任何字母、数字或下划线字符，等价于 `[a-zA-Z0-9_]`；`\W` 匹配任何非字母、数字或下划线字符，等价于 `[^a-zA-Z0-9_]`。
- **空白类**：`\s` 匹配任何空白字符，包括空格、制表符、换行符等，等价于 `[ \t\n\r\f\v]`；`\S` 匹配任何非空白字符，等价于 `[^ \t\n\r\f\v]`。

### 元字符
- `.`：匹配除换行符以外的任何单个字符。
- `*`：匹配前面的字符零次或多次。
- `+`：匹配前面的字符一次或多次。
- `?`：匹配前面的字符零次或一次。
- `{m}`：匹配前面的字符恰好 `m` 次。
- `{m,n}`：匹配前面的字符至少 `m` 次，最多 `n` 次。
- `^`：匹配字符串的开始位置。
- `$`：匹配字符串的结束位置。
- `[]`：用于定义字符类，例如 `[abc]` 匹配 `a`、`b` 或 `c` 中的任意一个字符。
- `()`：用于分组，可用于提取匹配的子字符串。

## 使用方法
### 匹配
使用 `re.match()` 函数从字符串的开始位置匹配正则表达式。
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

### 搜索
`re.search()` 函数在整个字符串中搜索正则表达式的第一个匹配项。
```python
import re

pattern = r'world'
string = 'hello world'
match = re.search(pattern, string)
if match:
    print("找到匹配项:", match.group())
else:
    print("未找到匹配项")
```

### 查找所有
`re.findall()` 函数返回字符串中所有匹配正则表达式的子字符串。
```python
import re

pattern = r'\d+'
string = 'There are 10 apples and 5 oranges'
matches = re.findall(pattern, string)
print("所有匹配项:", matches)
```

### 替换
`re.sub()` 函数用于将字符串中所有匹配正则表达式的子字符串替换为指定的字符串。
```python
import re

pattern = r'\d+'
string = 'There are 10 apples and 5 oranges'
new_string = re.sub(pattern, 'X', string)
print("替换后的字符串:", new_string)
```

### 分割
`re.split()` 函数根据正则表达式分割字符串。
```python
import re

pattern = r'\s+'
string = 'hello world how are you'
parts = re.split(pattern, string)
print("分割后的部分:", parts)
```

## 常见实践
### 验证邮箱地址
```python
import re

email_pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
email = 'example@example.com'
if re.match(email_pattern, email):
    print("有效的邮箱地址")
else:
    print("无效的邮箱地址")
```

### 提取电话号码
```python
import re

phone_pattern = r'(\d{3})-(\d{3})-(\d{4})'
text = 'My phone number is 123-456-7890'
match = re.search(phone_pattern, text)
if match:
    print("区号:", match.group(1))
    print("前缀:", match.group(2))
    print("号码:", match.group(3))
```

### 清理文本
```python
import re

text = 'This is some **bold** and *italic* text.'
cleaned_text = re.sub(r'\*{1,2}', '', text)
print("清理后的文本:", cleaned_text)
```

## 最佳实践
### 编译正则表达式
对于频繁使用的正则表达式，编译可以提高性能。
```python
import re

pattern = re.compile(r'\d+')
string = 'There are 10 apples and 5 oranges'
matches = pattern.findall(string)
print("所有匹配项:", matches)
```

### 处理复杂模式
使用注释和多行模式来提高复杂正则表达式的可读性。
```python
import re

pattern = re.compile(r"""
    \d{3}       # 区号
    -           # 分隔符
    \d{3}       # 前缀
    -           # 分隔符
    \d{4}       # 号码
""", re.VERBOSE)

text = 'My phone number is 123-456-7890'
match = pattern.search(text)
if match:
    print("找到电话号码:", match.group())
```

### 错误处理
在处理正则表达式时，捕获可能的异常。
```python
import re

try:
    pattern = re.compile(r'[')
except re.error as e:
    print("正则表达式错误:", e)
```

## 小结
通过这份Python正则表达式速查表，我们学习了正则表达式的基础概念、使用方法、常见实践以及最佳实践。正则表达式是处理文本数据的强大工具，掌握它们可以极大地提高数据处理效率。希望读者通过不断实践，熟练运用正则表达式解决实际问题。

## 参考资料
- [Python官方文档 - re模块](https://docs.python.org/3/library/re.html){: rel="nofollow"}
- [Regular Expressions 101](https://regex101.com/){: rel="nofollow"}
- 《Python正则表达式实战》
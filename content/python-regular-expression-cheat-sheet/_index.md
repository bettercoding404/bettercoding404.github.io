---
title: "Python正则表达式速查表：从基础到实战"
description: "正则表达式（Regular Expression）是用于描述字符串模式的工具，在文本处理、数据验证、信息提取等众多场景中发挥着关键作用。Python通过`re`模块提供了对正则表达式的支持。本文的Python正则表达式速查表将全面介绍其基础概念、使用方法、常见实践和最佳实践，帮助读者快速掌握并运用这一强大工具。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
正则表达式（Regular Expression）是用于描述字符串模式的工具，在文本处理、数据验证、信息提取等众多场景中发挥着关键作用。Python通过`re`模块提供了对正则表达式的支持。本文的Python正则表达式速查表将全面介绍其基础概念、使用方法、常见实践和最佳实践，帮助读者快速掌握并运用这一强大工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 编译正则表达式
    - 匹配操作
    - 搜索操作
    - 查找所有匹配项
    - 替换操作
    - 分割操作
3. **常见实践**
    - 验证电子邮件地址
    - 提取URL
    - 匹配电话号码
4. **最佳实践**
    - 优化正则表达式
    - 避免过度复杂
    - 测试与调试
5. **小结**
6. **参考资料**

## 基础概念
### 字符类
- **普通字符**：直接匹配对应的字符，例如`a`匹配字符串中的`a`。
- **元字符**：具有特殊含义的字符，如`.`匹配任意单个字符（除换行符外）。
- **字符组**：用方括号`[]`表示，如`[0-9]`匹配任意一个数字，`[a-zA-Z]`匹配任意一个字母。

### 量词
- `*`：匹配前面的字符零次或多次。例如，`a*`可以匹配空字符串、`a`、`aa`、`aaa`等。
- `+`：匹配前面的字符一次或多次。例如，`a+`可以匹配`a`、`aa`、`aaa`等，但不能匹配空字符串。
- `?`：匹配前面的字符零次或一次。例如，`a?`可以匹配空字符串或`a`。
- `{n}`：匹配前面的字符恰好`n`次。例如，`a{3}`只能匹配`aaa`。
- `{n,}`：匹配前面的字符至少`n`次。例如，`a{3,}`可以匹配`aaa`、`aaaa`、`aaaaa`等。
- `{n,m}`：匹配前面的字符至少`n`次，最多`m`次。例如，`a{3,5}`可以匹配`aaa`、`aaaa`、`aaaaa`。

### 锚点
- `^`：匹配字符串的开始位置。例如，`^a`表示字符串必须以`a`开头。
- `$`：匹配字符串的结束位置。例如，`a$`表示字符串必须以`a`结尾。

## 使用方法

### 编译正则表达式
在Python中，使用`re.compile()`函数编译正则表达式，返回一个`Pattern`对象，这样可以提高匹配效率，尤其是在多次使用同一正则表达式时。

```python
import re

pattern = re.compile(r'\d+')  # 编译正则表达式，匹配一个或多个数字
```

### 匹配操作
使用`Pattern`对象的`match()`方法从字符串的起始位置尝试匹配正则表达式。

```python
import re

pattern = re.compile(r'\d+')
result = pattern.match('123abc')  # 从字符串起始位置匹配
if result:
    print(result.group())  # 输出匹配到的内容：123
```

### 搜索操作
`Pattern`对象的`search()`方法在整个字符串中搜索第一个匹配正则表达式的位置。

```python
import re

pattern = re.compile(r'\d+')
result = pattern.search('abc123def')  # 在整个字符串中搜索
if result:
    print(result.group())  # 输出匹配到的内容：123
```

### 查找所有匹配项
`Pattern`对象的`findall()`方法返回字符串中所有匹配正则表达式的子串，以列表形式返回。

```python
import re

pattern = re.compile(r'\d+')
results = pattern.findall('abc123def456')
print(results)  # 输出：['123', '456']
```

### 替换操作
`Pattern`对象的`sub()`方法用于将字符串中所有匹配正则表达式的子串替换为指定的字符串。

```python
import re

pattern = re.compile(r'\d+')
new_string = pattern.sub('X', 'abc123def456')
print(new_string)  # 输出：abcXdefX
```

### 分割操作
`Pattern`对象的`split()`方法根据正则表达式匹配的位置分割字符串，返回分割后的字符串列表。

```python
import re

pattern = re.compile(r'\d+')
parts = pattern.split('abc123def456ghi')
print(parts)  # 输出：['abc', 'def', 'ghi']
```

## 常见实践

### 验证电子邮件地址
```python
import re

email_pattern = re.compile(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
email = 'test@example.com'
if email_pattern.match(email):
    print(f'{email} 是一个有效的电子邮件地址')
else:
    print(f'{email} 不是一个有效的电子邮件地址')
```

### 提取URL
```python
import re

url_pattern = re.compile(r'https?://[^\s]+')
text = '这是一个链接：https://www.example.com'
urls = url_pattern.findall(text)
print(urls)  # 输出：['https://www.example.com']
```

### 匹配电话号码
```python
import re

phone_pattern = re.compile(r'^1[3-9]\d{9}$')  # 简单匹配11位手机号码
phone = '13812345678'
if phone_pattern.match(phone):
    print(f'{phone} 是一个有效的手机号码')
else:
    print(f'{phone} 不是一个有效的手机号码')
```

## 最佳实践

### 优化正则表达式
- **减少回溯**：回溯是正则表达式匹配过程中的一种耗时操作。尽量使用占有优先量词（如`*+`、`++`、`?+`）来避免不必要的回溯。
- **预编译**：如前面所述，使用`re.compile()`预编译正则表达式，尤其是在循环中多次使用时，可以显著提高性能。

### 避免过度复杂
正则表达式很容易变得复杂和难以理解。尽量将复杂的匹配逻辑拆分成多个简单的正则表达式，逐步处理。

### 测试与调试
使用在线正则表达式测试工具（如regex101.com）对正则表达式进行测试和调试，确保其正确性。同时，在代码中添加适当的注释，以提高正则表达式的可读性。

## 小结
本文通过Python正则表达式速查表，系统地介绍了正则表达式的基础概念、使用方法、常见实践和最佳实践。掌握这些知识，读者能够在Python编程中灵活运用正则表达式进行文本处理、数据验证等操作，提高编程效率和代码质量。

## 参考资料
- [Python官方文档 - re模块](https://docs.python.org/3/library/re.html)
- [Regular-Expressions.info](https://www.regular-expressions.info/)
---
title: "Python正则表达式速查表：从入门到精通"
description: "正则表达式（Regular Expression，简称Regex）是一种用于描述字符串模式的工具，在Python编程中被广泛应用于文本匹配、搜索、替换和提取等操作。本文将通过一份详尽的Python正则表达式速查表，帮助你快速掌握正则表达式在Python中的基础概念、使用方法、常见实践以及最佳实践，让你在处理文本数据时更加得心应手。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
正则表达式（Regular Expression，简称Regex）是一种用于描述字符串模式的工具，在Python编程中被广泛应用于文本匹配、搜索、替换和提取等操作。本文将通过一份详尽的Python正则表达式速查表，帮助你快速掌握正则表达式在Python中的基础概念、使用方法、常见实践以及最佳实践，让你在处理文本数据时更加得心应手。

<!-- more -->
## 目录
1. **基础概念**
    - 字符类
    - 量词
    - 分组
2. **使用方法**
    - re模块的基本函数
    - 编译正则表达式
3. **常见实践**
    - 匹配字符串
    - 搜索特定模式
    - 替换文本
    - 提取信息
4. **最佳实践**
    - 优化正则表达式
    - 错误处理
    - 代码可读性
5. **小结**
6. **参考资料**

## 基础概念
### 字符类
字符类用于匹配特定字符集合中的任意一个字符。例如：
- `[abc]`：匹配 `a`、`b` 或 `c` 中的任意一个字符。
- `[0-9]`：匹配任意一个数字字符。
- `[a-zA-Z]`：匹配任意一个字母字符（大写或小写）。
- `[^abc]`：匹配除 `a`、`b` 和 `c` 以外的任意一个字符（取反）。

### 量词
量词用于指定前面的字符或字符类出现的次数。例如：
- `*`：匹配前面的字符或字符类 0 次或多次。
    ```python
    import re
    pattern = re.compile(r'abc*')
    print(pattern.match('ab'))  # 匹配成功，因为 'c' 出现 0 次
    print(pattern.match('abc'))  # 匹配成功，因为 'c' 出现 1 次
    print(pattern.match('abcc'))  # 匹配成功，因为 'c' 出现 2 次
    ```
- `+`：匹配前面的字符或字符类 1 次或多次。
    ```python
    pattern = re.compile(r'abc+')
    print(pattern.match('ab'))  # 匹配失败，因为 'c' 至少要出现 1 次
    print(pattern.match('abc'))  # 匹配成功，因为 'c' 出现 1 次
    print(pattern.match('abcc'))  # 匹配成功，因为 'c' 出现 2 次
    ```
- `?`：匹配前面的字符或字符类 0 次或 1 次。
    ```python
    pattern = re.compile(r'abc?')
    print(pattern.match('ab'))  # 匹配成功，因为 'c' 出现 0 次
    print(pattern.match('abc'))  # 匹配成功，因为 'c' 出现 1 次
    print(pattern.match('abcc'))  # 匹配失败，因为 'c' 出现超过 1 次
    ```
- `{n}`：匹配前面的字符或字符类恰好 `n` 次。
    ```python
    pattern = re.compile(r'abc{2}')
    print(pattern.match('ab'))  # 匹配失败，因为 'c' 要出现 2 次
    print(pattern.match('abc'))  # 匹配失败，因为 'c' 要出现 2 次
    print(pattern.match('abcc'))  # 匹配成功，因为 'c' 出现 2 次
    ```
- `{n,}`：匹配前面的字符或字符类至少 `n` 次。
    ```python
    pattern = re.compile(r'abc{2,}')
    print(pattern.match('ab'))  # 匹配失败，因为 'c' 至少要出现 2 次
    print(pattern.match('abc'))  # 匹配失败，因为 'c' 至少要出现 2 次
    print(pattern.match('abcc'))  # 匹配成功，因为 'c' 出现 2 次
    print(pattern.match('abccc'))  # 匹配成功，因为 'c' 出现 3 次
    ```
- `{n,m}`：匹配前面的字符或字符类 `n` 到 `m` 次。
    ```python
    pattern = re.compile(r'abc{2,4}')
    print(pattern.match('ab'))  # 匹配失败，因为 'c' 至少要出现 2 次
    print(pattern.match('abc'))  # 匹配失败，因为 'c' 至少要出现 2 次
    print(pattern.match('abcc'))  # 匹配成功，因为 'c' 出现 2 次
    print(pattern.match('abccc'))  # 匹配成功，因为 'c' 出现 3 次
    print(pattern.match('abcccc'))  # 匹配成功，因为 'c' 出现 4 次
    print(pattern.match('abccccc'))  # 匹配失败，因为 'c' 最多出现 4 次
    ```

### 分组
分组允许将多个字符组合成一个单元，以便对整个单元应用量词或进行其他操作。例如：
- `(abc)`：将 `abc` 作为一个分组。
    ```python
    pattern = re.compile(r'(abc)+')
    print(pattern.match('abc'))  # 匹配成功，因为 '(abc)' 出现 1 次
    print(pattern.match('abcabc'))  # 匹配成功，因为 '(abc)' 出现 2 次
    ```
- 分组可以通过索引来访问匹配到的内容。在Python中，可以使用 `group()` 方法获取匹配的内容，`group(0)` 表示整个匹配的字符串，`group(1)` 表示第一个分组匹配的内容，以此类推。
    ```python
    pattern = re.compile(r'(\d{3})-(\d{2})-(\d{4})')
    match = pattern.match('123-45-6789')
    if match:
        print(match.group(0))  # 输出: 123-45-6789
        print(match.group(1))  # 输出: 123
        print(match.group(2))  # 输出: 45
        print(match.group(3))  # 输出: 6789
    ```

## 使用方法
### re模块的基本函数
Python的 `re` 模块提供了多个用于处理正则表达式的函数，常用的有：
- `re.match(pattern, string)`：从字符串的开头开始匹配模式，如果匹配成功，返回一个匹配对象；否则返回 `None`。
    ```python
    import re
    pattern = r'hello'
    string = 'hello world'
    match = re.match(pattern, string)
    if match:
        print('匹配成功')
    else:
        print('匹配失败')
    ```
- `re.search(pattern, string)`：在字符串中搜索模式，找到第一个匹配的位置，如果匹配成功，返回一个匹配对象；否则返回 `None`。
    ```python
    pattern = r'world'
    string = 'hello world'
    match = re.search(pattern, string)
    if match:
        print('匹配成功')
    else:
        print('匹配失败')
    ```
- `re.findall(pattern, string)`：在字符串中找到所有匹配模式的子串，并返回一个包含所有匹配子串的列表。
    ```python
    pattern = r'\d+'
    string = 'I have 3 apples and 5 bananas'
    matches = re.findall(pattern, string)
    print(matches)  # 输出: ['3', '5']
    ```
- `re.sub(pattern, repl, string)`：用指定的替换字符串 `repl` 替换字符串中所有匹配模式的子串，并返回替换后的字符串。
    ```python
    pattern = r'\d+'
    repl = 'X'
    string = 'I have 3 apples and 5 bananas'
    new_string = re.sub(pattern, repl, string)
    print(new_string)  # 输出: I have X apples and X bananas
    ```

### 编译正则表达式
在处理复杂的正则表达式或需要多次使用同一个正则表达式时，建议先编译正则表达式，以提高效率。编译后的正则表达式对象具有更多的方法和属性。
```python
import re
pattern = re.compile(r'\d+')
string = 'I have 3 apples and 5 bananas'
matches = pattern.findall(string)
print(matches)  # 输出: ['3', '5']
```

## 常见实践
### 匹配字符串
判断一个字符串是否符合特定的模式，例如判断一个字符串是否为有效的电子邮件地址。
```python
import re
email_pattern = re.compile(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
email = 'example@example.com'
if email_pattern.match(email):
    print('有效的电子邮件地址')
else:
    print('无效的电子邮件地址')
```

### 搜索特定模式
在文本中查找特定的单词或短语，例如在一篇文章中查找所有的电话号码。
```python
phone_pattern = re.compile(r'\d{3}-\d{3}-\d{4}')
text = 'My phone number is 123-456-7890 and his number is 234-567-8901'
phones = phone_pattern.findall(text)
print(phones)  # 输出: ['123-456-7890', '234-567-8901']
```

### 替换文本
将文本中的敏感信息替换为掩码，例如将身份证号码中的部分数字替换为 `*`。
```python
id_pattern = re.compile(r'(\d{6})(\d{8})(\d{4})')
id_number = '123456199001011234'
new_id_number = id_pattern.sub(r'\1********\3', id_number)
print(new_id_number)  # 输出: 123456********1234
```

### 提取信息
从文本中提取有用的信息，例如从一个HTML标签中提取链接地址。
```python
html = '<a href="https://www.example.com">Click here</a>'
link_pattern = re.compile(r'href="([^"]+)"')
link = link_pattern.search(html)
if link:
    print(link.group(1))  # 输出: https://www.example.com
```

## 最佳实践
### 优化正则表达式
- **避免使用贪婪量词**：贪婪量词会尽可能多地匹配字符，有时可能会导致不必要的匹配。可以使用非贪婪量词（在量词后面加上 `?`）来解决这个问题。
    ```python
    pattern = re.compile(r'<.*?>')  # 非贪婪匹配HTML标签
    text = '<p>Hello</p><p>World</p>'
    matches = pattern.findall(text)
    print(matches)  # 输出: ['<p>', '</p>', '<p>', '</p>']
    ```
- **减少不必要的分组**：分组会增加正则表达式的复杂度，尽量避免使用不必要的分组。

### 错误处理
在使用正则表达式时，可能会遇到语法错误或匹配失败的情况。建议进行适当的错误处理，以提高代码的健壮性。
```python
try:
    pattern = re.compile(r'[a-z')  # 故意写错正则表达式
    string = 'hello'
    match = pattern.match(string)
except re.error as e:
    print(f'正则表达式错误: {e}')
```

### 代码可读性
为了提高代码的可读性，建议将复杂的正则表达式拆分成多个部分，并添加注释。
```python
# 匹配有效的IP地址
ip_pattern = re.compile(r'''
    ^
    (\d{1,2}|1\d\d|2[0-4]\d|25[0-5])  # 第一个八位组
  \.
    (\d{1,2}|1\d\d|2[0-4]\d|25[0-5])  # 第二个八位组
  \.
    (\d{1,2}|1\d\d|2[0-4]\d|25[0-5])  # 第三个八位组
  \.
    (\d{1,2}|1\d\d|2[0-4]\d|25[0-5])  # 第四个八位组
    $
''', re.VERBOSE)
ip = '192.168.1.1'
if ip_pattern.match(ip):
    print('有效的IP地址')
else:
    print('无效的IP地址')
```

## 小结
通过本文的Python正则表达式速查表，我们学习了正则表达式的基础概念、使用方法、常见实践以及最佳实践。正则表达式是处理文本数据的强大工具，掌握它可以大大提高文本处理的效率和准确性。在实际应用中，要根据具体需求选择合适的正则表达式模式和函数，并注意优化和错误处理，以编写高质量的代码。

## 参考资料
- [Python官方文档 - re模块](https://docs.python.org/3/library/re.html){: rel="nofollow"}
- [Regular Expressions 101](https://regex101.com/){: rel="nofollow"}
- 《Python Cookbook》

希望这份速查表和详细的解释能帮助你在Python中更加熟练地运用正则表达式！如果你有任何问题或建议，欢迎在评论区留言。
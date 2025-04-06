---
title: "Python String Template：灵活的字符串格式化工具"
description: "在Python编程中，字符串格式化是一项常见任务。`string template` 模块为我们提供了一种简单且灵活的方式来处理字符串替换和格式化。与其他字符串格式化方法（如 `%` 格式化、`str.format()` 方法）不同，`string template` 采用了一种更直观、更易于定制的语法，尤其适用于处理需要用户输入或配置的字符串替换场景。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，字符串格式化是一项常见任务。`string template` 模块为我们提供了一种简单且灵活的方式来处理字符串替换和格式化。与其他字符串格式化方法（如 `%` 格式化、`str.format()` 方法）不同，`string template` 采用了一种更直观、更易于定制的语法，尤其适用于处理需要用户输入或配置的字符串替换场景。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
`string template` 模块提供了 `Template` 类，用于创建可替换变量的字符串模板。模板字符串中使用 `$` 符号来标识变量。例如：
```python
from string import Template

t = Template('Hello, $name!')
```
在上述代码中，`$name` 就是一个变量占位符。当我们需要替换这个变量时，可以使用 `substitute()` 或 `safe_substitute()` 方法。

## 使用方法
### 1. 使用 `substitute()` 方法
`substitute()` 方法用于将模板中的变量替换为实际值。如果变量未提供值，会引发 `KeyError`。
```python
from string import Template

t = Template('Hello, $name!')
result = t.substitute(name='John')
print(result)  # 输出: Hello, John!
```

### 2. 使用 `safe_substitute()` 方法
`safe_substitute()` 方法与 `substitute()` 方法类似，但如果变量未提供值，不会引发错误，而是保留变量占位符。
```python
from string import Template

t = Template('Hello, $name!')
result = t.safe_substitute()
print(result)  # 输出: Hello, $name!
```

### 3. 自定义分隔符
默认情况下，`Template` 类使用 `$` 作为变量分隔符。我们可以通过继承 `Template` 类并修改 `delimiter` 属性来使用自定义分隔符。
```python
from string import Template

class MyTemplate(Template):
    delimiter = '%'

t = MyTemplate('Hello, %name!')
result = t.substitute(name='Jane')
print(result)  # 输出: Hello, Jane!
```

## 常见实践
### 1. 配置文件处理
在处理配置文件时，`string template` 可以用于将配置项替换到字符串中。
```python
from string import Template

config_template = Template('Server: $server, Port: $port')
config = {'server': 'localhost', 'port': 8080}
result = config_template.substitute(config)
print(result)  # 输出: Server: localhost, Port: 8080
```

### 2. 动态生成SQL语句
在数据库操作中，我们可以使用 `string template` 来动态生成SQL语句。
```python
from string import Template

sql_template = Template('SELECT * FROM $table WHERE $condition')
sql_params = {'table': 'users', 'condition': 'age > 30'}
sql = sql_template.substitute(sql_params)
print(sql)  # 输出: SELECT * FROM users WHERE age > 30
```

## 最佳实践
### 1. 安全性
在使用 `substitute()` 方法时，要确保提供的值是经过验证的，以防止注入攻击。对于用户输入，建议使用 `safe_substitute()` 方法，并进行额外的验证。
```python
from string import Template

user_input = "John; DROP TABLE users;"  # 恶意输入
t = Template('Hello, $name!')
# 使用 safe_substitute 防止注入
result = t.safe_substitute(name=user_input)
print(result)  # 输出: Hello, John; DROP TABLE users;!
```

### 2. 代码可读性
在定义模板字符串时，尽量保持简洁和清晰。对于复杂的模板，可以将其拆分为多个部分，提高代码的可读性。
```python
from string import Template

header_template = Template('Header: $header')
body_template = Template('Body: $body')

header = 'Important Information'
body = 'This is the content.'

header_result = header_template.substitute(header=header)
body_result = body_template.substitute(body=body)

full_message = f'{header_result}\n{body_result}'
print(full_message)
```

## 小结
`python string template` 模块为字符串格式化提供了一种简单而强大的方式。通过使用 `Template` 类及其方法，我们可以轻松地进行变量替换，尤其适用于需要动态生成字符串的场景。在实际应用中，要注意安全性和代码可读性，以充分发挥其优势。

## 参考资料
- [Python官方文档 - string template](https://docs.python.org/3/library/string.html#template-strings){: rel="nofollow"}
- 《Python Cookbook》相关章节

希望这篇博客能帮助你更好地理解和使用 `python string template`。如果有任何疑问或建议，欢迎在评论区留言。  
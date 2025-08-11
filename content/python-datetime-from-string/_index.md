---
title: "Python 中从字符串解析日期时间：datetime from string"
description: "在 Python 编程中，经常会遇到需要处理日期和时间的情况。而很多时候，日期和时间数据是以字符串形式存在的，例如从文件读取、用户输入或者 API 返回的数据。如何将这些字符串格式的日期时间数据转换为 Python 中可处理的 `datetime` 对象，是一个重要的基础技能。本文将深入探讨 `python datetime from string` 的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技术点。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，经常会遇到需要处理日期和时间的情况。而很多时候，日期和时间数据是以字符串形式存在的，例如从文件读取、用户输入或者 API 返回的数据。如何将这些字符串格式的日期时间数据转换为 Python 中可处理的 `datetime` 对象，是一个重要的基础技能。本文将深入探讨 `python datetime from string` 的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一技术点。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - `datetime.strptime()` 方法
    - `dateutil.parser.parse()` 方法
3. 常见实践
    - 解析固定格式字符串
    - 处理多种格式字符串
4. 最佳实践
    - 性能优化
    - 错误处理
5. 小结
6. 参考资料

## 基础概念
在 Python 中，`datetime` 模块提供了处理日期和时间的类和函数。`datetime` 类用于表示日期和时间的组合，包含年、月、日、时、分、秒等信息。而将字符串转换为 `datetime` 对象，本质上是根据字符串中日期时间的表示格式，将其解析并构建成 `datetime` 实例。不同地区和应用场景下，日期时间的字符串表示格式千差万别，所以正确理解和处理格式是关键。

## 使用方法
### `datetime.strptime()` 方法
`datetime.strptime()` 是 `datetime` 模块中用于将字符串解析为 `datetime` 对象的标准方法。它的语法如下：
```python
import datetime

date_string = "2023-10-15 14:30:00"
date_format = "%Y-%m-%d %H:%M:%S"

parsed_date = datetime.datetime.strptime(date_string, date_format)
print(parsed_date)  
```
在上述代码中：
- `date_string` 是要解析的字符串。
- `date_format` 是指定字符串格式的模板。其中，`%Y` 表示四位数的年份，`%m` 表示两位数的月份，`%d` 表示两位数的日期，`%H` 表示 24 小时制的小时数，`%M` 表示分钟数，`%S` 表示秒数。

### `dateutil.parser.parse()` 方法
`dateutil` 是一个第三方库，提供了更强大的日期时间处理功能。`dateutil.parser.parse()` 方法可以更智能地解析各种格式的日期时间字符串。首先需要安装 `dateutil` 库：
```bash
pip install python-dateutil
```
使用示例如下：
```python
from dateutil import parser

date_string = "Oct 15, 2023 2:30 PM"
parsed_date = parser.parse(date_string)
print(parsed_date)  
```
`dateutil.parser.parse()` 方法可以自动识别多种常见的日期时间格式，无需显式指定格式字符串，这在处理格式不固定的字符串时非常方便。

## 常见实践
### 解析固定格式字符串
在数据来源格式固定的情况下，使用 `datetime.strptime()` 方法是很好的选择。例如，从日志文件中读取的日期时间通常是固定格式的。
```python
import datetime

log_date_string = "2023-10-16 11:22:33"
log_date_format = "%Y-%m-%d %H:%M:%S"

log_parsed_date = datetime.datetime.strptime(log_date_string, log_date_format)
print(log_parsed_date)  
```
### 处理多种格式字符串
当需要处理多种格式的日期时间字符串时，`dateutil.parser.parse()` 更为合适。例如，从用户输入中获取日期时间，用户输入的格式可能多种多样。
```python
from dateutil import parser

user_date1 = "2023/10/17"
user_date2 = "17th Oct 2023"

parsed_date1 = parser.parse(user_date1)
parsed_date2 = parser.parse(user_date2)

print(parsed_date1)  
print(parsed_date2)  
```

## 最佳实践
### 性能优化
如果需要解析大量的日期时间字符串，`datetime.strptime()` 通常比 `dateutil.parser.parse()` 性能更好，因为 `dateutil.parser.parse()` 需要进行更多的格式推断工作。在性能敏感的场景下，优先考虑使用 `datetime.strptime()`。
```python
import datetime
import timeit

date_string = "2023-10-18 10:10:10"
date_format = "%Y-%m-%d %H:%M:%S"

def parse_with_strptime():
    return datetime.datetime.strptime(date_string, date_format)

def parse_with_dateutil():
    from dateutil import parser
    return parser.parse(date_string)

strptime_time = timeit.timeit(parse_with_strptime, number = 10000)
dateutil_time = timeit.timeit(parse_with_dateutil, number = 10000)

print(f"Time taken by strptime: {strptime_time} seconds")
print(f"Time taken by dateutil: {dateutil_time} seconds")
```
### 错误处理
在解析日期时间字符串时，可能会因为格式不匹配等原因导致解析失败。因此，需要进行适当的错误处理。
```python
import datetime

date_string = "2023-10-19 10:10:10abc"
date_format = "%Y-%m-%d %H:%M:%S"

try:
    parsed_date = datetime.datetime.strptime(date_string, date_format)
    print(parsed_date)
except ValueError as e:
    print(f"Parsing error: {e}")
```

## 小结
本文详细介绍了在 Python 中如何将字符串转换为 `datetime` 对象，涵盖了基础概念、两种主要的使用方法（`datetime.strptime()` 和 `dateutil.parser.parse()`）、常见实践场景以及最佳实践。在实际应用中，应根据数据格式的稳定性和性能需求选择合适的方法，并注意进行错误处理，以确保程序的健壮性。

## 参考资料
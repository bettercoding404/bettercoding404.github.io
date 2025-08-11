---
title: "Python 中字符串到日期时间的转换：深入解析与实践"
description: "在 Python 的数据处理和编程实践中，经常会遇到需要将字符串形式的日期和时间信息转换为日期时间对象的情况。例如，从日志文件、CSV 文件或用户输入中读取到的日期时间通常是以字符串形式存在的，而后续的数据分析、时间序列处理等操作往往需要使用日期时间对象。本文将详细介绍在 Python 中如何将字符串转换为日期时间对象，包括基础概念、使用方法、常见实践和最佳实践，帮助读者更好地掌握这一重要的操作。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 的数据处理和编程实践中，经常会遇到需要将字符串形式的日期和时间信息转换为日期时间对象的情况。例如，从日志文件、CSV 文件或用户输入中读取到的日期时间通常是以字符串形式存在的，而后续的数据分析、时间序列处理等操作往往需要使用日期时间对象。本文将详细介绍在 Python 中如何将字符串转换为日期时间对象，包括基础概念、使用方法、常见实践和最佳实践，帮助读者更好地掌握这一重要的操作。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - `datetime.strptime()` 方法
    - `dateutil.parser.parse()` 方法
3. **常见实践**
    - 从文件中读取并转换日期时间字符串
    - 处理用户输入的日期时间字符串
4. **最佳实践**
    - 处理不同格式的日期时间字符串
    - 提高转换效率
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，`datetime` 模块提供了处理日期和时间的功能。`datetime` 模块包含了几个重要的类，如 `date` 表示日期，`time` 表示时间，`datetime` 类则同时包含日期和时间信息。字符串到日期时间的转换，本质上是将符合某种日期时间格式的文本信息解析为 `datetime` 模块中相应的对象，以便进行后续的日期时间计算、比较等操作。

## 使用方法
### `datetime.strptime()` 方法
`datetime.strptime()` 方法用于将字符串按照指定的格式解析为 `datetime` 对象。其语法如下：

```python
import datetime

date_time_str = "2023-10-15 14:30:00"
date_time_obj = datetime.datetime.strptime(date_time_str, "%Y-%m-%d %H:%M:%S")

print(date_time_obj)
print(type(date_time_obj))
```

在上述代码中：
- `date_time_str` 是需要转换的字符串。
- `%Y-%m-%d %H:%M:%S` 是指定的日期时间格式。其中，`%Y` 表示四位数的年份，`%m` 表示两位数的月份，`%d` 表示两位数的日期，`%H` 表示 24 小时制的小时数，`%M` 表示分钟数，`%S` 表示秒数。
- `datetime.datetime.strptime()` 方法将字符串按照指定格式解析为 `datetime` 对象，并赋值给 `date_time_obj`。

### `dateutil.parser.parse()` 方法
`dateutil` 库的 `parser.parse()` 方法可以更灵活地解析日期时间字符串，它能够自动识别多种常见的日期时间格式。首先需要安装 `dateutil` 库：

```bash
pip install python-dateutil
```

然后使用示例如下：

```python
from dateutil import parser

date_time_str = "Oct 15, 2023 2:30:00 PM"
date_time_obj = parser.parse(date_time_str)

print(date_time_obj)
print(type(date_time_obj))
```

`parser.parse()` 方法能够自动识别字符串中的日期时间信息并将其转换为 `datetime` 对象，无需显式指定格式。不过，在某些复杂或不常见的格式下，`strptime()` 方法可能更可靠，因为可以精确控制解析格式。

## 常见实践
### 从文件中读取并转换日期时间字符串
假设我们有一个 CSV 文件，其中某一列包含日期时间信息，我们需要读取并转换这些字符串。示例代码如下：

```python
import csv
import datetime

date_time_list = []
with open('data.csv', 'r', encoding='utf-8') as file:
    reader = csv.reader(file)
    next(reader)  # 跳过标题行
    for row in reader:
        date_time_str = row[2]  # 假设日期时间信息在第三列
        try:
            date_time_obj = datetime.datetime.strptime(date_time_str, "%Y-%m-%d %H:%M:%S")
            date_time_list.append(date_time_obj)
        except ValueError:
            print(f"无法解析日期时间字符串: {date_time_str}")

print(date_time_list)
```

### 处理用户输入的日期时间字符串
当处理用户输入的日期时间时，需要考虑用户可能输入的各种格式。可以使用 `dateutil.parser.parse()` 来提高灵活性：

```python
from dateutil import parser

try:
    user_input = input("请输入日期时间: ")
    date_time_obj = parser.parse(user_input)
    print(f"转换后的日期时间对象: {date_time_obj}")
except parser.ParserError:
    print("无法解析输入的日期时间字符串")
```

## 最佳实践
### 处理不同格式的日期时间字符串
在实际应用中，可能会遇到多种不同格式的日期时间字符串。一种解决方案是定义一个格式列表，然后依次尝试使用 `strptime()` 方法进行解析：

```python
import datetime

date_time_str = "2023/10/15 14:30:00"
formats = ["%Y-%m-%d %H:%M:%S", "%Y/%m/%d %H:%M:%S"]

date_time_obj = None
for fmt in formats:
    try:
        date_time_obj = datetime.datetime.strptime(date_time_str, fmt)
        break
    except ValueError:
        continue

if date_time_obj:
    print(date_time_obj)
else:
    print("无法解析日期时间字符串")
```

### 提高转换效率
如果需要处理大量的日期时间字符串转换，可以考虑使用 `numba` 库来加速。不过，`numba` 要求代码遵循一定的规则，例如使用 `strptime()` 方法时，格式字符串需要是常量。示例如下：

```python
import datetime
import numba


@numba.jit(nopython=True)
def convert_date_time(date_time_str):
    fmt = "%Y-%m-%d %H:%M:%S"
    year = int(date_time_str[0:4])
    month = int(date_time_str[5:7])
    day = int(date_time_str[8:10])
    hour = int(date_time_str[11:13])
    minute = int(date_time_str[14:16])
    second = int(date_time_str[17:19])
    return datetime.datetime(year, month, day, hour, minute, second)


date_time_str = "2023-10-15 14:30:00"
date_time_obj = convert_date_time(date_time_str)
print(date_time_obj)
```

## 小结
在 Python 中，将字符串转换为日期时间对象是一项常见且重要的操作。通过 `datetime.strptime()` 和 `dateutil.parser.parse()` 等方法，我们可以灵活地处理不同格式的日期时间字符串。在实际应用中，需要根据具体需求选择合适的方法，并注意处理可能出现的格式错误。同时，通过最佳实践可以提高转换效率和代码的健壮性。掌握这些技巧，能够帮助我们更好地处理日期时间相关的数据，为数据分析、数据处理等任务提供有力支持。

## 参考资料
---
title: "Python 中从字符串创建 datetime 对象"
description: "在 Python 的数据处理和开发中，经常会遇到需要将字符串格式的日期和时间信息转换为 `datetime` 对象的情况。`datetime` 模块为我们提供了强大的工具来处理日期和时间相关的操作。将字符串转换为 `datetime` 对象是进一步进行日期时间计算、比较以及格式化输出等操作的基础。本文将详细介绍如何在 Python 中从字符串创建 `datetime` 对象，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 的数据处理和开发中，经常会遇到需要将字符串格式的日期和时间信息转换为 `datetime` 对象的情况。`datetime` 模块为我们提供了强大的工具来处理日期和时间相关的操作。将字符串转换为 `datetime` 对象是进一步进行日期时间计算、比较以及格式化输出等操作的基础。本文将详细介绍如何在 Python 中从字符串创建 `datetime` 对象，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - `strptime` 方法
    - `fromisoformat` 方法
3. 常见实践
    - 处理不同格式的日期时间字符串
    - 错误处理
4. 最佳实践
    - 性能优化
    - 代码可读性提升
5. 小结
6. 参考资料

## 基础概念
`datetime` 模块是 Python 标准库的一部分，用于处理日期和时间。`datetime` 对象包含年、月、日、时、分、秒等信息。而从字符串创建 `datetime` 对象，就是将符合特定格式的文本数据转换为 `datetime` 类型的对象，以便在程序中进行各种日期时间相关的操作。

## 使用方法

### `strptime` 方法
`strptime` 方法用于将字符串按照指定的格式解析为 `datetime` 对象。它的语法如下：

```python
import datetime

datetime.datetime.strptime(date_string, format)
```

其中，`date_string` 是要解析的字符串，`format` 是指定字符串格式的格式字符串。格式字符串使用特定的占位符来表示日期和时间的各个部分。例如：

```python
import datetime

date_string = "2023-10-15 14:30:00"
date_format = "%Y-%m-%d %H:%M:%S"

date_obj = datetime.datetime.strptime(date_string, date_format)
print(date_obj)
```

在上述代码中，`%Y` 表示四位数的年份，`%m` 表示两位数的月份，`%d` 表示两位数的日期，`%H` 表示 24 小时制的小时数，`%M` 表示分钟数，`%S` 表示秒数。

### `fromisoformat` 方法
`fromisoformat` 方法用于从 ISO 8601 格式的字符串创建 `datetime` 对象。ISO 8601 是一种国际标准的日期和时间表示格式，具有固定的格式，如 `YYYY-MM-DD HH:MM:SS` 或 `YYYY-MM-DDTHH:MM:SS`。

```python
import datetime

date_string = "2023-10-15T14:30:00"
date_obj = datetime.datetime.fromisoformat(date_string)
print(date_obj)
```

这种方法使用起来更加简洁，不需要手动指定格式字符串，只要字符串是符合 ISO 8601 标准格式即可。

## 常见实践

### 处理不同格式的日期时间字符串
在实际应用中，我们可能会遇到各种不同格式的日期时间字符串。例如，日期可能用斜杠（`/`）分隔，时间可能使用 12 小时制等。下面是一个处理不同格式的示例：

```python
import datetime

date_string1 = "10/15/2023 2:30:00 PM"
date_format1 = "%m/%d/%Y %I:%M:%S %p"
date_obj1 = datetime.datetime.strptime(date_string1, date_format1)
print(date_obj1)

date_string2 = "20231015143000"
date_format2 = "%Y%m%d%H%M%S"
date_obj2 = datetime.datetime.strptime(date_string2, date_format2)
print(date_obj2)
```

在这个示例中，`date_string1` 使用了斜杠分隔日期，12 小时制时间并包含 AM/PM 标识，`date_string2` 则是一个紧凑的无分隔符格式。通过正确指定格式字符串，我们可以将它们都转换为 `datetime` 对象。

### 错误处理
在解析字符串为 `datetime` 对象时，可能会出现格式不匹配等错误。为了使程序更加健壮，我们需要进行适当的错误处理。

```python
import datetime

date_string = "2023-10-15 14:30:00"
date_format = "%Y-%m-%d %H:%M:%S"

try:
    date_obj = datetime.datetime.strptime(date_string, date_format)
    print(date_obj)
except ValueError as e:
    print(f"解析错误: {e}")
```

在上述代码中，我们使用 `try-except` 块来捕获 `ValueError` 异常，当字符串格式与指定格式不匹配时，会打印出错误信息。

## 最佳实践

### 性能优化
在处理大量字符串转换为 `datetime` 对象时，性能是一个需要考虑的因素。`strptime` 方法在每次调用时都需要解析格式字符串，这会带来一定的性能开销。如果要处理大量相同格式的字符串，可以考虑使用 `dateutil` 库中的 `parser` 模块，它会自动检测字符串格式，并且在性能上有一定优势。

```python
from dateutil import parser

date_string = "2023-10-15 14:30:00"
date_obj = parser.parse(date_string)
print(date_obj)
```

### 代码可读性提升
为了提高代码的可读性，可以将格式字符串定义为常量。这样在代码中使用时更加清晰，并且如果需要修改格式，只需要在一个地方进行修改。

```python
import datetime

DATE_FORMAT = "%Y-%m-%d %H:%M:%S"
date_string = "2023-10-15 14:30:00"

date_obj = datetime.datetime.strptime(date_string, DATE_FORMAT)
print(date_obj)
```

## 小结
本文详细介绍了在 Python 中从字符串创建 `datetime` 对象的方法，包括 `strptime` 和 `fromisoformat` 方法的使用。同时，还讨论了常见实践，如处理不同格式的字符串和错误处理，以及最佳实践，如性能优化和提升代码可读性。通过掌握这些知识，读者可以更加高效地处理日期时间字符串，并将其转换为 `datetime` 对象进行后续的操作。

## 参考资料
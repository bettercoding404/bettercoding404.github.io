---
title: "Python 中移除非 ASCII 字符和特殊字符"
description: "在处理文本数据时，经常会遇到需要清理数据的情况，尤其是移除其中的非 ASCII 字符和特殊字符。非 ASCII 字符通常来自不同语言的字符集，而特殊字符则包括标点符号、数学符号等。移除这些字符在许多场景下都非常有用，比如文本预处理以进行自然语言处理任务、数据清洗以确保数据的一致性等。本文将详细介绍在 Python 中移除非 ASCII 字符和特殊字符的方法。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在处理文本数据时，经常会遇到需要清理数据的情况，尤其是移除其中的非 ASCII 字符和特殊字符。非 ASCII 字符通常来自不同语言的字符集，而特殊字符则包括标点符号、数学符号等。移除这些字符在许多场景下都非常有用，比如文本预处理以进行自然语言处理任务、数据清洗以确保数据的一致性等。本文将详细介绍在 Python 中移除非 ASCII 字符和特殊字符的方法。

<!-- more -->
## 目录
1. 基础概念
    - 什么是非 ASCII 字符
    - 什么是特殊字符
2. 使用方法
    - 使用正则表达式移除字符
    - 使用字符串方法移除字符
3. 常见实践
    - 文本预处理
    - 数据清洗
4. 最佳实践
    - 性能优化
    - 处理不同编码
5. 小结
6. 参考资料

## 基础概念
### 什么是非 ASCII 字符
ASCII（美国信息交换标准代码）是基于拉丁字母的一套电脑编码系统，它定义了 128 个字符，包括英文字母（大写和小写）、数字和一些基本的标点符号。非 ASCII 字符就是不在这个集合中的字符，例如中文字符、日文字符、希腊字母等。

### 什么是特殊字符
特殊字符是指除了字母、数字之外的字符，例如标点符号（如 `,`, `.`, `!`）、数学符号（如 `+`, `-`, `*`）、特殊符号（如 `@`, `#`, `$`）等。

## 使用方法
### 使用正则表达式移除字符
正则表达式是一种强大的工具，用于在字符串中进行模式匹配。在 Python 中，可以使用 `re` 模块来处理正则表达式。

```python
import re


def remove_non_ascii_and_special_chars(text):
    # 移除非 ASCII 字符
    text = re.sub(r'[^\x00-\x7F]+', '', text)
    # 移除特殊字符，只保留字母和数字
    text = re.sub(r'[^a-zA-Z0-9]', '', text)
    return text


text = "Hello, 世界！123 @#$"
cleaned_text = remove_non_ascii_and_special_chars(text)
print(cleaned_text)
```

### 使用字符串方法移除字符
可以通过遍历字符串并检查每个字符是否是我们想要保留的字符来移除不需要的字符。

```python
def remove_non_ascii_and_special_chars2(text):
    result = ""
    for char in text:
        if char.isalnum() or char.isascii():
            result += char
    return result


text = "Hello, 世界！123 @#$"
cleaned_text2 = remove_non_ascii_and_special_chars2(text)
print(cleaned_text2)
```

## 常见实践
### 文本预处理
在自然语言处理任务中，如文本分类、情感分析等，通常需要对文本进行预处理。移除非 ASCII 字符和特殊字符可以减少噪声，提高模型的性能。

```python
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize

nltk.download('stopwords')
nltk.download('punkt')


def preprocess_text(text):
    text = remove_non_ascii_and_special_chars(text)
    tokens = word_tokenize(text.lower())
    stop_words = set(stopwords.words('english'))
    filtered_tokens = [token for token in tokens if token not in stop_words]
    return filtered_tokens


text = "Hello, World! This is a sample sentence with some non - ASCII characters 世界 and special chars @#$"
preprocessed_text = preprocess_text(text)
print(preprocessed_text)
```

### 数据清洗
在处理表格数据或其他类型的数据时，可能需要对文本字段进行清洗，以确保数据的一致性和准确性。

```python
import pandas as pd


def clean_dataframe(df):
    for col in df.columns:
        if df[col].dtype == 'object':
            df[col] = df[col].apply(remove_non_ascii_and_special_chars)
    return df


data = {
    'text': ["Hello, 世界！123 @#$", "Another sample with special chars &"]
}
df = pd.DataFrame(data)
cleaned_df = clean_dataframe(df)
print(cleaned_df)
```

## 最佳实践
### 性能优化
对于大规模数据，使用正则表达式可能会比较慢。可以考虑使用更高效的数据结构和算法。例如，使用 `bytearray` 来处理字节数据，在某些情况下可以提高性能。

```python
def remove_non_ascii_and_special_chars_fast(text):
    byte_text = bytearray(text, 'utf - 8')
    result = bytearray()
    for byte in byte_text:
        if 48 <= byte <= 57 or 65 <= byte <= 90 or 97 <= byte <= 122:
            result.append(byte)
    return result.decode('utf - 8')


text = "Hello, 世界！123 @#$"
cleaned_text_fast = remove_non_ascii_and_special_chars_fast(text)
print(cleaned_text_fast)
```

### 处理不同编码
在处理文本时，要注意文本的编码。确保在移除字符之前正确解码和编码文本，以避免出现乱码。

```python
def remove_non_ascii_and_special_chars_with_encoding(text, encoding='utf - 8'):
    decoded_text = text.decode(encoding)
    cleaned_text = remove_non_ascii_and_special_chars(decoded_text)
    return cleaned_text.encode(encoding)


byte_text = b"Hello, \xe4\xb8\x96\xe7\x95\x8c！123 @#$"
cleaned_byte_text = remove_non_ascii_and_special_chars_with_encoding(byte_text)
print(cleaned_byte_text.decode('utf - 8'))
```

## 小结
在 Python 中移除非 ASCII 字符和特殊字符有多种方法，每种方法都有其优缺点。正则表达式提供了强大的模式匹配功能，但在性能上可能有所不足；字符串方法相对简单，但对于复杂的模式匹配不够灵活。在实际应用中，需要根据具体需求选择合适的方法，并注意性能优化和编码问题。

## 参考资料
---
title: "Python 中移除非 ASCII 和特殊字符"
description: "在处理文本数据时，我们经常会遇到包含非 ASCII 字符和特殊字符的情况。非 ASCII 字符是指不在基本 ASCII 字符集（0 - 127 的字符编码）范围内的字符，而特殊字符则涵盖了诸如标点符号、数学符号等各种非字母数字的字符。移除这些字符在许多场景下都非常有用，比如数据清洗、文本标准化，以便后续进行更有效的文本分析、搜索或存储等操作。在 Python 中，有多种方法可以实现移除这些字符的功能，本文将详细介绍相关的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在处理文本数据时，我们经常会遇到包含非 ASCII 字符和特殊字符的情况。非 ASCII 字符是指不在基本 ASCII 字符集（0 - 127 的字符编码）范围内的字符，而特殊字符则涵盖了诸如标点符号、数学符号等各种非字母数字的字符。移除这些字符在许多场景下都非常有用，比如数据清洗、文本标准化，以便后续进行更有效的文本分析、搜索或存储等操作。在 Python 中，有多种方法可以实现移除这些字符的功能，本文将详细介绍相关的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
    - 非 ASCII 字符
    - 特殊字符
2. 使用方法
    - 使用正则表达式移除字符
    - 使用字符串方法和 ASCII 范围过滤
3. 常见实践
    - 数据清洗场景
    - 文本预处理用于机器学习
4. 最佳实践
    - 性能优化
    - 灵活性与可维护性
5. 小结
6. 参考资料

## 基础概念
### 非 ASCII 字符
ASCII（美国信息交换标准代码）是基于拉丁字母的一套电脑编码系统，它定义了 128 个字符，包括大小写英文字母、数字 0 - 9 和一些基本的标点符号等。非 ASCII 字符则是指那些不在这个范围内的字符，例如中文字符、日文字符、带重音的拉丁字母（如 é、ñ 等）。在 Python 中，字符串默认以 Unicode 编码存储，这使得处理非 ASCII 字符变得更加容易，但有时我们可能需要将其移除。

### 特殊字符
特殊字符是指除了字母和数字之外的字符，包括标点符号（如逗号、句号、感叹号等）、数学符号（如 +、-、* 等）、特殊符号（如 @、#、$ 等）。这些字符在文本数据中可能会干扰我们的分析或处理，因此在某些情况下需要将它们移除。

## 使用方法
### 使用正则表达式移除字符
正则表达式是处理文本模式匹配和替换的强大工具。在 Python 中，可以使用 `re` 模块来操作正则表达式。

```python
import re


def remove_nonascii_special(text):
    # 移除非 ASCII 字符
    text = re.sub(r'[^\x00-\x7F]+', '', text)
    # 移除特殊字符，只保留字母和数字
    text = re.sub(r'[^a-zA-Z0-9]', '', text)
    return text


text = "Hello, 世界！123@#$"
cleaned_text = remove_nonascii_special(text)
print(cleaned_text)
```

在上述代码中：
- `re.sub(r'[^\x00-\x7F]+', '', text)` 用于移除所有非 ASCII 字符。`[^\x00-\x7F]` 表示匹配不在 0x00 到 0x7F 这个 ASCII 范围内的任何字符，`+` 表示匹配一个或多个这样的字符，`re.sub` 则将匹配到的字符替换为空字符串。
- `re.sub(r'[^a-zA-Z0-9]', '', text)` 用于移除除了字母和数字之外的所有特殊字符。`[^a-zA-Z0-9]` 表示匹配不在字母和数字范围内的任何字符，同样将其替换为空字符串。

### 使用字符串方法和 ASCII 范围过滤
另一种方法是利用 Python 字符串的方法和 ASCII 码范围来过滤字符。

```python
def remove_nonascii_special_2(text):
    result = ""
    for char in text:
        if ord(char) < 128 and char.isalnum():
            result += char
    return result


text = "Hello, 世界！123@#$"
cleaned_text_2 = remove_nonascii_special_2(text)
print(cleaned_text_2)
```

在这段代码中：
- `ord(char)` 返回字符的 ASCII 码值。通过 `ord(char) < 128` 来判断字符是否为 ASCII 字符。
- `char.isalnum()` 用于判断字符是否为字母或数字。只有同时满足这两个条件的字符才会被保留到结果字符串中。

## 常见实践
### 数据清洗场景
在处理从网页抓取、文件读取等来源的数据时，经常会包含大量的非 ASCII 和特殊字符。例如，网页中的文本可能包含 HTML 实体、表情符号等。通过移除这些字符，可以将数据标准化，便于后续的分析和处理。

```python
import requests
from bs4 import BeautifulSoup


def clean_web_text(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    text = soup.get_text()
    # 使用前面定义的移除函数
    cleaned_text = remove_nonascii_special(text)
    return cleaned_text


url = "https://example.com"
cleaned_web_text = clean_web_text(url)
print(cleaned_web_text)
```

### 文本预处理用于机器学习
在自然语言处理（NLP）任务中，机器学习模型通常要求输入的文本数据具有一定的格式和标准化。移除非 ASCII 和特殊字符是文本预处理的重要步骤之一。例如，在文本分类任务中，我们可能需要将文本转换为统一的格式，以便模型能够更好地学习特征。

```python
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import Pipeline


data = ["Hello, 世界！123@#$ This is a test", "Another test with special characters &é"]
target = [0, 1]

pipeline = Pipeline([
    ('cleaning', FunctionTransformer(remove_nonascii_special)),
    ('vectorizer', TfidfVectorizer()),
    ('classifier', MultinomialNB())
])

pipeline.fit(data, target)
```

在上述代码中，`FunctionTransformer(remove_nonascii_special)` 用于在文本数据进入向量器之前移除非 ASCII 和特殊字符。

## 最佳实践
### 性能优化
如果处理的文本数据量非常大，性能是一个需要考虑的重要因素。正则表达式在某些情况下可能会比较慢，尤其是当模式复杂时。在这种情况下，可以优先考虑使用字符串方法和 ASCII 范围过滤的方式，因为它们的实现相对简单，执行速度更快。另外，对于重复使用的正则表达式，可以使用 `re.compile` 方法预先编译，以提高匹配效率。

```python
import re

# 预先编译正则表达式
nonascii_pattern = re.compile(r'[^\x00-\x7F]+')
special_pattern = re.compile(r'[^a-zA-Z0-9]')


def remove_nonascii_special_fast(text):
    text = nonascii_pattern.sub('', text)
    text = special_pattern.sub('', text)
    return text


```

### 灵活性与可维护性
在编写代码时，要考虑到代码的灵活性和可维护性。如果移除字符的规则可能会发生变化，最好将相关的逻辑封装在独立的函数中，这样便于修改和扩展。另外，可以添加注释来解释每一步的操作，提高代码的可读性。

```python
def remove_custom_chars(text, custom_pattern):
    """
    根据自定义的正则表达式模式移除字符
    :param text: 输入文本
    :param custom_pattern: 正则表达式模式
    :return: 移除特定字符后的文本
    """
    return re.sub(custom_pattern, '', text)


```

## 小结
在 Python 中移除非 ASCII 和特殊字符是文本处理中的常见需求。通过正则表达式和字符串方法，我们可以有效地实现这一目标。在实际应用中，需要根据具体的场景和需求选择合适的方法，并注意性能优化和代码的可维护性。掌握这些技巧将有助于我们更高效地处理文本数据，为后续的分析和应用打下良好的基础。

## 参考资料
- 《Python 数据分析实战》
- 《利用 Python 进行数据分析》 
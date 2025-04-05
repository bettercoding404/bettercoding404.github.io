---
title: "Python 处理 PDF：从入门到实践"
description: "在日常的文档处理任务中，PDF 文件是极为常见的格式。Python 作为一门功能强大的编程语言，提供了丰富的库和工具来处理 PDF 文件，涵盖读取、写入、编辑、提取文本等多种操作。本文将深入探讨 Python 处理 PDF 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握相关技术。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在日常的文档处理任务中，PDF 文件是极为常见的格式。Python 作为一门功能强大的编程语言，提供了丰富的库和工具来处理 PDF 文件，涵盖读取、写入、编辑、提取文本等多种操作。本文将深入探讨 Python 处理 PDF 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握相关技术。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **读取 PDF**
    - **写入 PDF**
    - **提取文本**
3. **常见实践**
    - **合并 PDF**
    - **拆分 PDF**
    - **添加水印**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
PDF（Portable Document Format）即便携式文档格式，由 Adobe 公司开发，旨在跨平台、跨设备地呈现一致的文档内容。Python 处理 PDF 主要借助第三方库，最常用的有 `PyPDF2` 和 `reportlab`。`PyPDF2` 侧重于 PDF 文件的读取、合并、拆分等操作；`reportlab` 则更擅长创建和编辑 PDF 文件。

## 使用方法

### 读取 PDF
使用 `PyPDF2` 库读取 PDF 文件。首先确保已安装该库：
```bash
pip install PyPDF2
```
读取 PDF 文件的示例代码如下：
```python
import PyPDF2

# 打开 PDF 文件
pdf_file = open('example.pdf', 'rb')
pdf_reader = PyPDF2.PdfReader(pdf_file)

# 获取页数
num_pages = len(pdf_reader.pages)
print(f"该 PDF 共有 {num_pages} 页")

# 读取第一页内容
page = pdf_reader.pages[0]
page_text = page.extract_text()
print(page_text)

# 关闭文件
pdf_file.close()
```

### 写入 PDF
使用 `reportlab` 库创建一个简单的 PDF 文件。安装 `reportlab`：
```bash
pip install reportlab
```
示例代码如下：
```python
from reportlab.pdfgen import canvas

def create_pdf():
    # 创建一个 PDF 文件
    c = canvas.Canvas('new_file.pdf')
    # 在 PDF 上绘制文本
    c.drawString(100, 750, "这是一个用 Python 创建的 PDF 文件")
    # 保存 PDF 文件
    c.save()

create_pdf()
```

### 提取文本
继续使用 `PyPDF2` 提取 PDF 中的所有文本：
```python
import PyPDF2

def extract_text_from_pdf(pdf_path):
    text = ""
    with open(pdf_path, 'rb') as pdf_file:
        pdf_reader = PyPDF2.PdfReader(pdf_file)
        for page_num in range(len(pdf_reader.pages)):
            page = pdf_reader.pages[page_num]
            text += page.extract_text()
    return text

pdf_path = 'example.pdf'
extracted_text = extract_text_from_pdf(pdf_path)
print(extracted_text)
```

## 常见实践

### 合并 PDF
将多个 PDF 文件合并为一个。示例代码如下：
```python
import PyPDF2

def merge_pdfs(pdf_files, output_file):
    pdf_merger = PyPDF2.PdfMerger()
    for pdf in pdf_files:
        with open(pdf, 'rb') as pdf_file:
            pdf_merger.append(pdf_file)
    with open(output_file, 'wb') as output:
        pdf_merger.write(output)

pdf_files = ['file1.pdf', 'file2.pdf']
output_file ='merged.pdf'
merge_pdfs(pdf_files, output_file)
```

### 拆分 PDF
按指定页数拆分 PDF。例如，将一个 PDF 拆分为每 10 页一个新文件：
```python
import PyPDF2

def split_pdf(pdf_path, pages_per_file):
    with open(pdf_path, 'rb') as pdf_file:
        pdf_reader = PyPDF2.PdfReader(pdf_file)
        num_pages = len(pdf_reader.pages)
        for i in range(0, num_pages, pages_per_file):
            pdf_writer = PyPDF2.PdfWriter()
            end_page = min(i + pages_per_file, num_pages)
            for page_num in range(i, end_page):
                page = pdf_reader.pages[page_num]
                pdf_writer.add_page(page)
            output_file = f'split_{i // pages_per_file + 1}.pdf'
            with open(output_file, 'wb') as output:
                pdf_writer.write(output)

pdf_path = 'example.pdf'
pages_per_file = 10
split_pdf(pdf_path, pages_per_file)
```

### 添加水印
给 PDF 添加水印。示例代码如下：
```python
import PyPDF2

def add_watermark(input_pdf, watermark_pdf, output_pdf):
    with open(input_pdf, 'rb') as input_file:
        input_reader = PyPDF2.PdfReader(input_file)
        with open(watermark_pdf, 'rb') as watermark_file:
            watermark_reader = PyPDF2.PdfReader(watermark_file)
            watermark_page = watermark_reader.pages[0]
            pdf_writer = PyPDF2.PdfWriter()
            for page_num in range(len(input_reader.pages)):
                page = input_reader.pages[page_num]
                page.merge_page(watermark_page)
                pdf_writer.add_page(page)
            with open(output_pdf, 'wb') as output_file:
                pdf_writer.write(output_file)

input_pdf = 'original.pdf'
watermark_pdf = 'watermark.pdf'
output_pdf = 'watermarked.pdf'
add_watermark(input_pdf, watermark_pdf, output_pdf)
```

## 最佳实践

### 性能优化
- **批量处理时使用多线程或多进程**：在处理大量 PDF 文件时，利用 Python 的 `concurrent.futures` 模块中的 `ThreadPoolExecutor` 或 `ProcessPoolExecutor` 可以显著提高处理速度。
```python
import concurrent.futures
import PyPDF2

def process_pdf(pdf_path):
    with open(pdf_path, 'rb') as pdf_file:
        pdf_reader = PyPDF2.PdfReader(pdf_file)
        # 这里进行具体处理，如提取文本
        text = ""
        for page_num in range(len(pdf_reader.pages)):
            page = pdf_reader.pages[page_num]
            text += page.extract_text()
        return text

pdf_paths = ['file1.pdf', 'file2.pdf', 'file3.pdf']
with concurrent.futures.ThreadPoolExecutor() as executor:
    results = list(executor.map(process_pdf, pdf_paths))
```

### 错误处理
在处理 PDF 文件时，可能会遇到文件损坏、权限不足等问题。务必添加适当的错误处理代码：
```python
import PyPDF2

def extract_text(pdf_path):
    try:
        with open(pdf_path, 'rb') as pdf_file:
            pdf_reader = PyPDF2.PdfReader(pdf_file)
            text = ""
            for page_num in range(len(pdf_reader.pages)):
                page = pdf_reader.pages[page_num]
                text += page.extract_text()
            return text
    except FileNotFoundError:
        print(f"文件 {pdf_path} 未找到")
    except PermissionError:
        print(f"没有权限访问文件 {pdf_path}")
    except PyPDF2.utils.PdfReadError:
        print(f"文件 {pdf_path} 可能损坏或格式不正确")

pdf_path = 'example.pdf'
text = extract_text(pdf_path)
```

## 小结
本文详细介绍了 Python 处理 PDF 的相关知识，包括基础概念、常用库的使用方法、常见实践场景以及最佳实践。通过这些内容，读者可以掌握在 Python 中读取、写入、编辑和处理 PDF 文件的基本技能，并了解如何优化性能和处理错误。在实际应用中，根据具体需求选择合适的库和方法，能够高效地完成各种 PDF 处理任务。

## 参考资料
- [PyPDF2 官方文档](https://pythonhosted.org/PyPDF2/){: rel="nofollow"}
- [reportlab 官方文档](https://www.reportlab.com/docs/){: rel="nofollow"}
- 《Python 数据分析实战》相关章节 
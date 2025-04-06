---
title: "Python 操作 PDF：从入门到实践"
description: "在日常的数据处理和文档管理任务中，PDF 格式的文件使用广泛。Python 作为一门功能强大且灵活的编程语言，提供了丰富的库来处理 PDF 文件。通过这些库，我们可以实现诸如读取、写入、合并、拆分、提取文本和图像等多种操作。本文将详细介绍 Python 处理 PDF 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握相关技能。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在日常的数据处理和文档管理任务中，PDF 格式的文件使用广泛。Python 作为一门功能强大且灵活的编程语言，提供了丰富的库来处理 PDF 文件。通过这些库，我们可以实现诸如读取、写入、合并、拆分、提取文本和图像等多种操作。本文将详细介绍 Python 处理 PDF 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握相关技能。

<!-- more -->
## 目录
1. **基础概念**
    - **PDF 格式概述**
    - **Python 处理 PDF 的常用库**
2. **使用方法**
    - **读取 PDF 文件**
    - **写入和创建 PDF 文件**
    - **合并和拆分 PDF 文件**
    - **提取文本和图像**
3. **常见实践**
    - **批量处理 PDF 文件**
    - **自动化 PDF 处理流程**
4. **最佳实践**
    - **性能优化**
    - **错误处理与异常捕获**
5. **小结**
6. **参考资料**

## 基础概念
### PDF 格式概述
PDF（Portable Document Format）是一种用于呈现文档的文件格式，由 Adobe Systems 开发。它旨在独立于软件、硬件和操作系统，确保文档在不同设备和平台上具有一致的外观。PDF 文件可以包含文本、图像、矢量图形、表单等多种元素，并且支持跨平台的打印和查看。

### Python 处理 PDF 的常用库
- **PyPDF2**：一个流行的 Python 库，用于读取、写入、合并和拆分 PDF 文件。它提供了简单易用的 API，适用于基本的 PDF 操作。
- **pdfminer.six**：专注于从 PDF 文件中提取文本和其他信息。它能够处理各种复杂的 PDF 布局，包括文本提取、图像提取等功能。
- **reportlab**：用于创建和生成 PDF 文件的库。它提供了丰富的绘图和排版功能，可用于生成高质量的 PDF 文档。

## 使用方法
### 读取 PDF 文件
使用 PyPDF2 库读取 PDF 文件的示例代码如下：
```python
import PyPDF2

def read_pdf(file_path):
    with open(file_path, 'rb') as file:
        reader = PyPDF2.PdfReader(file)
        num_pages = len(reader.pages)
        for page_num in range(num_pages):
            page = reader.pages[page_num]
            text = page.extract_text()
            print(f"Page {page_num + 1}:\n{text}")

file_path = 'example.pdf'
read_pdf(file_path)
```

### 写入和创建 PDF 文件
使用 reportlab 库创建一个简单的 PDF 文件：
```python
from reportlab.pdfgen import canvas

def create_pdf(file_path):
    c = canvas.Canvas(file_path)
    c.drawString(100, 750, "Hello, PDF!")
    c.save()

file_path = 'new_example.pdf'
create_pdf(file_path)
```

### 合并和拆分 PDF 文件
使用 PyPDF2 库合并两个 PDF 文件：
```python
import PyPDF2

def merge_pdfs(file_paths, output_path):
    merger = PyPDF2.PdfMerger()
    for file_path in file_paths:
        with open(file_path, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            merger.append(reader)
    with open(output_path, 'wb') as output_file:
        merger.write(output_file)

file_paths = ['file1.pdf', 'file2.pdf']
output_path ='merged.pdf'
merge_pdfs(file_paths, output_path)
```

拆分 PDF 文件，例如只保留第一页：
```python
import PyPDF2

def split_pdf(file_path, output_path):
    with open(file_path, 'rb') as file:
        reader = PyPDF2.PdfReader(file)
        page = reader.pages[0]
        writer = PyPDF2.PdfWriter()
        writer.add_page(page)
        with open(output_path, 'wb') as output_file:
            writer.write(output_file)

file_path = 'example.pdf'
output_path ='split_page1.pdf'
split_pdf(file_path, output_path)
```

### 提取文本和图像
使用 pdfminer.six 库提取 PDF 中的文本：
```python
import io
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage

def extract_text(file_path):
    resource_manager = PDFResourceManager()
    fake_file_handle = io.StringIO()
    converter = TextConverter(resource_manager, fake_file_handle, laparams=LAParams())
    page_interpreter = PDFPageInterpreter(resource_manager, converter)

    with open(file_path, 'rb') as file:
        for page in PDFPage.get_pages(file, caching=True, check_extractable=True):
            page_interpreter.process_page(page)

    text = fake_file_handle.getvalue()

    converter.close()
    fake_file_handle.close()

    return text

file_path = 'example.pdf'
text = extract_text(file_path)
print(text)
```

提取 PDF 中的图像较为复杂，需要结合 pdfminer.six 和 Pillow 库，以下是一个简单的示例框架：
```python
# 这里只是示例框架，实际代码需要更多处理和完善
from pdfminer.layout import LTImage
from pdfminer.pdfpage import PDFPage
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from PIL import Image
import io

def extract_images(file_path):
    resource_manager = PDFResourceManager()
    images = []

    with open(file_path, 'rb') as file:
        interpreter = PDFPageInterpreter(resource_manager)
        for page in PDFPage.get_pages(file):
            interpreter.process_page(page)
            layout = interpreter.device.layout
            for obj in layout:
                if isinstance(obj, LTImage):
                    image_stream = io.BytesIO(obj.stream.get_rawdata())
                    img = Image.open(image_stream)
                    images.append(img)

    return images

file_path = 'example.pdf'
extracted_images = extract_images(file_path)
for img in extracted_images:
    img.show()
```

## 常见实践
### 批量处理 PDF 文件
批量读取多个 PDF 文件并提取文本：
```python
import os
import PyPDF2

def batch_extract_text(folder_path):
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith('.pdf'):
                file_path = os.path.join(root, file)
                with open(file_path, 'rb') as pdf_file:
                    reader = PyPDF2.PdfReader(pdf_file)
                    num_pages = len(reader.pages)
                    for page_num in range(num_pages):
                        page = reader.pages[page_num]
                        text = page.extract_text()
                        print(f"File: {file}, Page {page_num + 1}:\n{text}")

folder_path = 'pdf_folder'
batch_extract_text(folder_path)
```

### 自动化 PDF 处理流程
结合定时任务库（如 schedule）实现自动化的 PDF 处理，例如每天凌晨合并特定文件夹中的 PDF 文件：
```python
import schedule
import time
import PyPDF2
import os

def auto_merge_pdfs():
    folder_path = 'pdf_folder'
    file_paths = [os.path.join(folder_path, file) for file in os.listdir(folder_path) if file.endswith('.pdf')]
    output_path ='merged_daily.pdf'
    merger = PyPDF2.PdfMerger()
    for file_path in file_paths:
        with open(file_path, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            merger.append(reader)
    with open(output_path, 'wb') as output_file:
        merger.write(output_file)

schedule.every().day.at("00:00").do(auto_merge_pdfs)

while True:
    schedule.run_pending()
    time.sleep(1)
```

## 最佳实践
### 性能优化
- **减少内存占用**：在处理大型 PDF 文件时，避免一次性加载整个文件到内存。例如，使用流处理方式，逐页读取和处理。
- **多线程处理**：对于批量处理任务，可以使用 Python 的多线程库（如 threading 或 concurrent.futures）来加速处理过程，提高效率。

### 错误处理与异常捕获
在进行 PDF 操作时，要注意捕获可能出现的异常，例如文件不存在、权限问题、PDF 格式错误等。使用 try - except 块来处理异常，确保程序的稳定性和健壮性。
```python
import PyPDF2

file_path = 'nonexistent_file.pdf'
try:
    with open(file_path, 'rb') as file:
        reader = PyPDF2.PdfReader(file)
        # 其他操作
except FileNotFoundError:
    print(f"The file {file_path} was not found.")
except PyPDF2.errors.PdfReadError as e:
    print(f"Error reading PDF: {e}")
```

## 小结
本文全面介绍了 Python 处理 PDF 的相关知识，从基础概念、常用库的使用方法，到常见实践和最佳实践。通过学习这些内容，读者可以利用 Python 的强大功能，灵活地处理各种 PDF 相关任务，提高工作效率和自动化程度。希望本文能帮助大家在实际项目中更好地运用 Python 处理 PDF 文件。

## 参考资料
- [PyPDF2 官方文档](https://pythonhosted.org/PyPDF2/){: rel="nofollow"}
- [pdfminer.six 官方文档](https://pdfminer.readthedocs.io/en/latest/){: rel="nofollow"}
- [reportlab 官方文档](https://www.reportlab.com/docs/){: rel="nofollow"}
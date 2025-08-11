---
title: "如何在 Python 中保存 JPEG 文件"
description: "在 Python 的图像处理和文件操作场景中，保存 JPEG 文件是一项常见任务。无论是处理图像数据、生成可视化结果，还是对图像进行编辑后存储，都需要掌握将图像保存为 JPEG 格式的方法。本文将详细介绍在 Python 中保存 JPEG 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松应对相关需求。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 的图像处理和文件操作场景中，保存 JPEG 文件是一项常见任务。无论是处理图像数据、生成可视化结果，还是对图像进行编辑后存储，都需要掌握将图像保存为 JPEG 格式的方法。本文将详细介绍在 Python 中保存 JPEG 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松应对相关需求。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - Pillow 库
    - OpenCV 库
3. 常见实践
    - 从网络下载图像并保存为 JPEG
    - 处理本地图像并保存为 JPEG
4. 最佳实践
    - 图像质量设置
    - 内存管理
5. 小结
6. 参考资料

## 基础概念
JPEG（Joint Photographic Experts Group）是一种广泛使用的有损图像压缩标准。它能够在显著减小文件大小的同时，保持较高的图像质量，因此非常适合存储照片、自然场景图像等。在 Python 中保存 JPEG 文件，本质上是将图像数据以 JPEG 格式的编码规则写入到文件系统中。这涉及到图像数据的处理、压缩算法的应用以及文件 I/O 操作。

## 使用方法
### Pillow 库
Pillow 是 Python 中最常用的图像处理库之一，提供了丰富的功能来处理各种图像格式。以下是使用 Pillow 保存 JPEG 文件的示例：

```python
from PIL import Image

# 打开一个图像文件
image = Image.open('input_image.png')

# 保存为 JPEG 文件
image.save('output_image.jpg', 'JPEG')
```

在上述代码中：
1. 首先导入 `Image` 模块，它是 Pillow 库中处理图像的核心类。
2. 使用 `Image.open` 方法打开一个现有的图像文件（这里以 `input_image.png` 为例）。
3. 调用 `image.save` 方法，将打开的图像保存为 `output_image.jpg`，并指定格式为 `JPEG`。

### OpenCV 库
OpenCV 是一个强大的计算机视觉库，也可以用于图像的读取、处理和保存。以下是使用 OpenCV 保存 JPEG 文件的示例：

```python
import cv2

# 读取图像
image = cv2.imread('input_image.jpg')

# 保存为 JPEG 文件
cv2.imwrite('output_image.jpg', image)
```

在这段代码中：
1. 导入 `cv2` 模块，即 OpenCV 的 Python 接口。
2. 使用 `cv2.imread` 方法读取一个图像文件（这里假设输入图像为 `input_image.jpg`）。
3. 调用 `cv2.imwrite` 方法，将读取的图像保存为 `output_image.jpg`。

## 常见实践
### 从网络下载图像并保存为 JPEG
在实际应用中，常常需要从网络上下载图像并保存为 JPEG 格式。可以结合 `requests` 库和 Pillow 库来实现：

```python
import requests
from PIL import Image
from io import BytesIO

# 发送 HTTP 请求获取图像数据
response = requests.get('https://example.com/image.jpg')

# 检查请求是否成功
if response.status_code == 200:
    # 使用 BytesIO 将响应内容转换为图像对象
    image = Image.open(BytesIO(response.content))
    # 保存为 JPEG 文件
    image.save('downloaded_image.jpg', 'JPEG')
else:
    print(f"请求失败，状态码: {response.status_code}")
```

在上述代码中：
1. 使用 `requests.get` 方法发送 HTTP GET 请求，从指定的 URL 下载图像数据。
2. 检查响应的状态码，如果状态码为 200，表示请求成功。
3. 使用 `BytesIO` 将响应的内容转换为可以被 Pillow 处理的图像对象。
4. 最后将图像保存为 `downloaded_image.jpg`。

### 处理本地图像并保存为 JPEG
假设需要对本地的图像进行一些处理（例如调整大小），然后保存为 JPEG 文件，可以使用 Pillow 库：

```python
from PIL import Image

# 打开图像
image = Image.open('input_image.jpg')

# 调整图像大小
new_image = image.resize((image.width // 2, image.height // 2))

# 保存为 JPEG 文件
new_image.save('resized_image.jpg', 'JPEG')
```

在这段代码中：
1. 打开本地的 `input_image.jpg` 图像。
2. 使用 `resize` 方法将图像的宽度和高度都减半。
3. 将处理后的图像保存为 `resized_image.jpg`。

## 最佳实践
### 图像质量设置
在保存 JPEG 文件时，可以通过设置图像质量参数来平衡文件大小和图像质量。在 Pillow 库中，可以在 `save` 方法中设置 `quality` 参数：

```python
from PIL import Image

image = Image.open('input_image.jpg')
# 设置图像质量为 80（0 - 100，100 为最高质量）
image.save('output_image.jpg', 'JPEG', quality=80)
```

在 OpenCV 中，`imwrite` 方法可以通过第三个参数来设置图像质量：

```python
import cv2

image = cv2.imread('input_image.jpg')
# 设置图像质量为 80（0 - 100，100 为最高质量）
cv2.imwrite('output_image.jpg', image, [cv2.IMWRITE_JPEG_QUALITY, 80])
```

### 内存管理
在处理大量图像或大尺寸图像时，内存管理非常重要。尽量避免在内存中长时间保留不必要的图像数据。例如，在使用 Pillow 处理完图像并保存后，及时关闭图像对象：

```python
from PIL import Image

image = Image.open('input_image.jpg')
image.save('output_image.jpg', 'JPEG')
image.close()  # 关闭图像对象，释放内存
```

## 小结
本文详细介绍了在 Python 中保存 JPEG 文件的相关知识，包括基础概念、使用 Pillow 和 OpenCV 库的方法、常见实践场景以及最佳实践。通过掌握这些内容，读者可以在自己的项目中灵活地处理图像数据，并将其保存为 JPEG 格式。无论是简单的图像存储，还是复杂的图像处理流程中的保存步骤，都能够轻松应对。

## 参考资料
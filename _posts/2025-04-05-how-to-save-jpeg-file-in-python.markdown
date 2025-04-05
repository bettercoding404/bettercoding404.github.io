---
title: "如何在 Python 中保存 JPEG 文件"
description: "在 Python 的图像处理和文件操作场景中，保存图像为 JPEG 格式是一项常见任务。无论是处理计算机视觉项目、数据分析中的图像预处理，还是简单的图像编辑应用，掌握如何保存 JPEG 文件都至关重要。本文将详细介绍在 Python 中保存 JPEG 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松应对相关需求。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 的图像处理和文件操作场景中，保存图像为 JPEG 格式是一项常见任务。无论是处理计算机视觉项目、数据分析中的图像预处理，还是简单的图像编辑应用，掌握如何保存 JPEG 文件都至关重要。本文将详细介绍在 Python 中保存 JPEG 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松应对相关需求。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - Pillow 库
    - OpenCV 库
3. 常见实践
    - 从网络获取图像并保存为 JPEG
    - 处理本地图像并保存为 JPEG
4. 最佳实践
    - 图像质量控制
    - 内存管理
5. 小结
6. 参考资料

## 基础概念
JPEG（Joint Photographic Experts Group）是一种广泛使用的有损图像压缩标准。它通过丢弃一些人类视觉系统不太敏感的图像数据来实现高压缩比，从而减小文件大小。在 Python 中保存 JPEG 文件，意味着将图像数据以 JPEG 格式的编码规则写入文件系统，以便后续存储和使用。

## 使用方法
### Pillow 库
Pillow 是 Python 中一个强大的图像处理库。以下是使用 Pillow 保存 JPEG 文件的示例：

```python
from PIL import Image

# 打开一张图像
image = Image.open('input_image.png')

# 保存为 JPEG 文件
image.save('output_image.jpg', 'JPEG')
```

### OpenCV 库
OpenCV 主要用于计算机视觉任务，也可以用来保存图像为 JPEG 格式。

```python
import cv2

# 读取图像
image = cv2.imread('input_image.png')

# 保存为 JPEG 文件
cv2.imwrite('output_image.jpg', image)
```

## 常见实践
### 从网络获取图像并保存为 JPEG
```python
import requests
from PIL import Image
from io import BytesIO

# 发送 HTTP 请求获取图像
response = requests.get('http://example.com/image.png')

# 从响应内容创建图像对象
image = Image.open(BytesIO(response.content))

# 保存为 JPEG 文件
image.save('downloaded_image.jpg', 'JPEG')
```

### 处理本地图像并保存为 JPEG
```python
import cv2

# 读取本地图像
image = cv2.imread('local_image.png')

# 进行一些图像处理操作，例如灰度转换
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# 保存处理后的图像为 JPEG
cv2.imwrite('processed_image.jpg', gray_image)
```

## 最佳实践
### 图像质量控制
在 Pillow 中，可以通过设置 `quality` 参数来控制 JPEG 图像的质量。值越高，图像质量越好，但文件大小也越大。

```python
from PIL import Image

image = Image.open('input_image.png')
image.save('output_image.jpg', 'JPEG', quality=95)
```

在 OpenCV 中，`imwrite` 函数的第三个参数可以用于设置 JPEG 质量。

```python
import cv2

image = cv2.imread('input_image.png')
cv2.imwrite('output_image.jpg', image, [cv2.IMWRITE_JPEG_QUALITY, 95])
```

### 内存管理
在处理大型图像时，合理的内存管理很重要。例如，在 Pillow 中可以使用 `Image.fromarray` 从 NumPy 数组创建图像对象，避免不必要的内存复制。

```python
import numpy as np
from PIL import Image

# 创建一个随机的 NumPy 数组表示图像
image_array = np.random.randint(0, 256, size=(100, 100, 3), dtype=np.uint8)

# 从数组创建图像对象
image = Image.fromarray(image_array)

# 保存为 JPEG 文件
image.save('generated_image.jpg', 'JPEG')
```

## 小结
本文介绍了在 Python 中保存 JPEG 文件的多种方法，包括使用 Pillow 和 OpenCV 库。我们探讨了基础概念、不同库的使用方法、常见实践场景以及最佳实践，例如图像质量控制和内存管理。通过这些知识，读者可以在各种项目中灵活、高效地保存 JPEG 文件。

## 参考资料
- [Pillow 官方文档](https://pillow.readthedocs.io/en/stable/){: rel="nofollow"}
- [OpenCV 官方文档](https://docs.opencv.org/){: rel="nofollow"}
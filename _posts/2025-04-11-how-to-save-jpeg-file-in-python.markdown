---
title: "如何在 Python 中保存 JPEG 文件"
description: "在图像处理和数据处理任务中，常常需要将图像以 JPEG 格式保存。Python 提供了多个库来实现这一功能，这些库各有特点且适用于不同的场景。本文将深入探讨如何使用 Python 保存 JPEG 文件，包括基础概念、具体使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在图像处理和数据处理任务中，常常需要将图像以 JPEG 格式保存。Python 提供了多个库来实现这一功能，这些库各有特点且适用于不同的场景。本文将深入探讨如何使用 Python 保存 JPEG 文件，包括基础概念、具体使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用 Pillow 库保存 JPEG 文件**
    - **安装 Pillow 库**
    - **保存 JPEG 文件的代码示例**
3. **使用 OpenCV 库保存 JPEG 文件**
    - **安装 OpenCV 库**
    - **保存 JPEG 文件的代码示例**
4. **常见实践**
    - **从网络获取图像并保存为 JPEG**
    - **批量处理图像并保存为 JPEG**
5. **最佳实践**
    - **优化图像质量**
    - **处理不同色彩模式**
6. **小结**
7. **参考资料**

## 基础概念
JPEG（Joint Photographic Experts Group）是一种有损图像压缩格式，广泛应用于存储照片和其他复杂图像。它通过去除人眼难以察觉的图像细节来减小文件大小，同时保持图像的视觉质量。在 Python 中保存 JPEG 文件，就是将图像数据按照 JPEG 格式的规范写入文件系统。

## 使用 Pillow 库保存 JPEG 文件
### 安装 Pillow 库
Pillow 是 Python 中常用的图像处理库。可以使用 `pip` 进行安装：
```bash
pip install Pillow
```

### 保存 JPEG 文件的代码示例
```python
from PIL import Image

# 打开一张图像
image = Image.open('input_image.png')

# 保存为 JPEG 格式
image.save('output_image.jpg', 'JPEG')
```
在上述代码中，首先使用 `Image.open` 方法打开一张图像，然后使用 `image.save` 方法将图像保存为 JPEG 格式。第二个参数指定了保存的格式为 `JPEG`。

## 使用 OpenCV 库保存 JPEG 文件
### 安装 OpenCV 库
OpenCV 是一个强大的计算机视觉库。可以使用 `pip` 安装：
```bash
pip install opencv-python
```

### 保存 JPEG 文件的代码示例
```python
import cv2

# 读取一张图像
image = cv2.imread('input_image.png')

# 保存为 JPEG 格式
cv2.imwrite('output_image.jpg', image)
```
这段代码中，`cv2.imread` 用于读取图像，`cv2.imwrite` 用于将图像保存为 JPEG 格式。

## 常见实践
### 从网络获取图像并保存为 JPEG
```python
import requests
from PIL import Image
from io import BytesIO

# 从网络获取图像
response = requests.get('http://example.com/image.png')
image = Image.open(BytesIO(response.content))

# 保存为 JPEG 格式
image.save('downloaded_image.jpg', 'JPEG')
```
此代码通过 `requests` 库从网络获取图像数据，然后使用 Pillow 库将其保存为 JPEG 文件。

### 批量处理图像并保存为 JPEG
```python
import os
from PIL import Image

# 图像文件夹路径
image_folder = 'images'
output_folder = 'output_images'

# 创建输出文件夹（如果不存在）
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# 遍历文件夹中的所有图像文件
for filename in os.listdir(image_folder):
    if filename.endswith(('.png', '.jpg', '.jpeg')):
        image_path = os.path.join(image_folder, filename)
        image = Image.open(image_path)
        output_path = os.path.join(output_folder, os.path.splitext(filename)[0] + '.jpg')
        image.save(output_path, 'JPEG')
```
这段代码遍历指定文件夹中的所有图像文件，将它们转换为 JPEG 格式并保存到另一个文件夹中。

## 最佳实践
### 优化图像质量
在 Pillow 中，可以通过设置 `quality` 参数来调整 JPEG 图像的质量：
```python
from PIL import Image

image = Image.open('input_image.png')
image.save('output_image.jpg', 'JPEG', quality=80)  # 质量设置为 80
```
`quality` 参数取值范围为 0 到 100，值越高图像质量越好，但文件大小也越大。

### 处理不同色彩模式
有些图像可能具有不同的色彩模式（如 RGBA），保存为 JPEG 时需要转换为合适的模式（如 RGB）：
```python
from PIL import Image

image = Image.open('input_image.png')
if image.mode == 'RGBA':
    image = image.convert('RGB')
image.save('output_image.jpg', 'JPEG')
```
这段代码检查图像的色彩模式，如果是 `RGBA` 则转换为 `RGB` 再保存为 JPEG。

## 小结
本文介绍了在 Python 中保存 JPEG 文件的方法，涵盖了使用 Pillow 和 OpenCV 两个常用库。通过基础概念的讲解、代码示例的展示以及常见实践和最佳实践的分享，希望读者能够熟练掌握在 Python 中保存 JPEG 文件的技巧，并应用到实际项目中。

## 参考资料
- [Pillow 官方文档](https://pillow.readthedocs.io/en/stable/){: rel="nofollow"}
- [OpenCV 官方文档](https://docs.opencv.org/master/){: rel="nofollow"}
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
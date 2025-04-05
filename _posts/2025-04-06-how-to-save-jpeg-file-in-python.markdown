---
title: "如何在 Python 中保存 JPEG 文件"
description: "在 Python 的图像处理和文件操作领域，保存 JPEG 文件是一项常见任务。无论是处理摄影图像、计算机视觉项目中的图像数据，还是简单地将处理后的图像保存为 JPEG 格式，掌握相关技术都是非常重要的。本文将深入探讨如何在 Python 中保存 JPEG 文件，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 的图像处理和文件操作领域，保存 JPEG 文件是一项常见任务。无论是处理摄影图像、计算机视觉项目中的图像数据，还是简单地将处理后的图像保存为 JPEG 格式，掌握相关技术都是非常重要的。本文将深入探讨如何在 Python 中保存 JPEG 文件，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 Pillow 库**
    - **使用 OpenCV 库**
3. **常见实践**
    - **处理图像后保存**
    - **批量保存图像**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
JPEG（Joint Photographic Experts Group）是一种用于有损压缩的图像文件格式。它广泛应用于存储照片、数字图像等，通过牺牲一定的图像质量来换取较小的文件大小，从而便于存储和传输。

在 Python 中保存 JPEG 文件，通常需要借助第三方库来处理图像数据并将其保存为所需格式。两个常用的库是 Pillow 和 OpenCV，它们都提供了丰富的功能来实现这一目的。

## 使用方法
### 使用 Pillow 库
Pillow 是 Python 中一个强大的图像处理库，提供了简单易用的接口来处理各种图像操作，包括保存图像为 JPEG 格式。

首先，确保已经安装了 Pillow 库：
```bash
pip install Pillow
```

以下是保存 JPEG 文件的示例代码：
```python
from PIL import Image

# 打开一个图像
image = Image.open('input_image.jpg')

# 保存为 JPEG 文件
image.save('output_image.jpg', 'JPEG')
```
在上述代码中，我们首先使用 `Image.open` 方法打开一个已有的图像文件。然后，使用 `image.save` 方法将图像保存为 JPEG 格式，第一个参数是输出文件名，第二个参数指定文件格式为 'JPEG'。

### 使用 OpenCV 库
OpenCV（Open Source Computer Vision Library）是一个用于计算机视觉和图像处理的跨平台库。虽然它主要侧重于图像处理算法，但也可以很方便地保存图像为 JPEG 格式。

首先，安装 OpenCV 库：
```bash
pip install opencv-python
```

以下是使用 OpenCV 保存 JPEG 文件的示例代码：
```python
import cv2

# 读取图像
image = cv2.imread('input_image.jpg')

# 保存为 JPEG 文件
cv2.imwrite('output_image.jpg', image)
```
在这段代码中，我们使用 `cv2.imread` 方法读取图像文件，然后使用 `cv2.imwrite` 方法将图像保存为 JPEG 格式。`cv2.imwrite` 的第一个参数是输出文件名，第二个参数是要保存的图像数据。

## 常见实践
### 处理图像后保存
在实际应用中，我们通常需要对图像进行一些处理，然后再保存为 JPEG 文件。以下是一个使用 Pillow 库对图像进行灰度转换后保存的示例：
```python
from PIL import Image, ImageOps

# 打开图像
image = Image.open('input_image.jpg')

# 转换为灰度图像
gray_image = ImageOps.grayscale(image)

# 保存为 JPEG 文件
gray_image.save('gray_output_image.jpg', 'JPEG')
```
使用 OpenCV 进行类似的灰度转换并保存的示例：
```python
import cv2

# 读取图像
image = cv2.imread('input_image.jpg')

# 转换为灰度图像
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# 保存为 JPEG 文件
cv2.imwrite('gray_output_image.jpg', gray_image)
```

### 批量保存图像
在处理大量图像数据时，批量保存图像是很常见的需求。以下是使用 Pillow 批量读取并保存图像为 JPEG 格式的示例：
```python
import os
from PIL import Image

# 输入图像文件夹路径
input_folder = 'input_images'
# 输出图像文件夹路径
output_folder = 'output_images'

# 如果输出文件夹不存在，则创建它
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# 遍历输入文件夹中的所有文件
for filename in os.listdir(input_folder):
    if filename.endswith('.jpg') or filename.endswith('.jpeg'):
        image_path = os.path.join(input_folder, filename)
        image = Image.open(image_path)
        output_path = os.path.join(output_folder, filename)
        image.save(output_path, 'JPEG')
```
使用 OpenCV 进行批量保存的示例：
```python
import os
import cv2

# 输入图像文件夹路径
input_folder = 'input_images'
# 输出图像文件夹路径
output_folder = 'output_images'

# 如果输出文件夹不存在，则创建它
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# 遍历输入文件夹中的所有文件
for filename in os.listdir(input_folder):
    if filename.endswith('.jpg') or filename.endswith('.jpeg'):
        image_path = os.path.join(input_folder, filename)
        image = cv2.imread(image_path)
        output_path = os.path.join(output_folder, filename)
        cv2.imwrite(output_path, image)
```

## 最佳实践
- **选择合适的库**：根据项目需求选择 Pillow 或 OpenCV。如果只是简单的图像处理和文件保存，Pillow 可能更易于使用；而如果涉及复杂的计算机视觉算法和高性能处理，OpenCV 会是更好的选择。
- **注意图像质量设置**：在保存 JPEG 文件时，可以通过设置参数来控制图像质量。例如，在 Pillow 中可以使用 `image.save('output_image.jpg', 'JPEG', quality=85)` 来调整质量，`quality` 参数范围是 0 到 100，数值越高质量越好，但文件大小也越大。
- **错误处理**：在文件读取和保存操作中，添加适当的错误处理代码，以确保程序在遇到文件不存在、权限问题等错误时能够优雅地处理。

## 小结
在 Python 中保存 JPEG 文件是一个相对简单的任务，通过 Pillow 和 OpenCV 等库可以轻松实现。掌握这两个库的基本使用方法，以及在常见实践场景中的应用，能够满足大多数图像处理项目中保存 JPEG 文件的需求。同时，遵循最佳实践原则可以提高代码的稳定性和性能。

## 参考资料
- [Pillow 官方文档](https://pillow.readthedocs.io/en/stable/){: rel="nofollow"}
- [OpenCV 官方文档](https://docs.opencv.org/){: rel="nofollow"}
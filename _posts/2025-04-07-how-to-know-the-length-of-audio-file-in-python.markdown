---
title: "如何在 Python 中获取音频文件时长"
description: "在处理音频文件时，了解音频文件的时长是一项常见需求。无论是进行音频编辑、分析，还是构建音频相关的应用程序，获取音频时长都是一个基础且重要的操作。Python 作为一种功能强大的编程语言，提供了多种方法来实现这一目的。本文将详细介绍在 Python 中获取音频文件时长的相关概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在处理音频文件时，了解音频文件的时长是一项常见需求。无论是进行音频编辑、分析，还是构建音频相关的应用程序，获取音频时长都是一个基础且重要的操作。Python 作为一种功能强大的编程语言，提供了多种方法来实现这一目的。本文将详细介绍在 Python 中获取音频文件时长的相关概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `pydub` 库
    - 使用 `moviepy` 库
    - 使用 `mutagen` 库
3. 常见实践
    - 批量获取音频文件时长
    - 在音频处理流程中获取时长
4. 最佳实践
    - 选择合适的库
    - 错误处理
5. 小结
6. 参考资料

## 基础概念
音频文件的时长，简单来说，就是音频从开始播放到结束播放所持续的时间。在数字音频领域，音频文件被编码成一系列的数据样本，时长的计算与音频的采样率、声道数以及样本数量等因素相关。采样率指的是每秒采集的音频样本数，声道数决定了音频的声道数量（如单声道、立体声等）。通过这些参数，可以精确计算出音频文件的时长。不过，在实际编程中，我们通常借助一些成熟的库来简化这一计算过程。

## 使用方法

### 使用 `pydub` 库
`pydub` 是一个用于处理音频文件的 Python 库，它提供了简单易用的接口来读取、编辑和导出音频文件。安装 `pydub` 库可以使用以下命令：
```bash
pip install pydub
```
获取音频文件时长的代码示例如下：
```python
from pydub import AudioSegment

def get_audio_length_pydub(file_path):
    audio = AudioSegment.from_file(file_path)
    duration_in_ms = len(audio)
    duration_in_seconds = duration_in_ms / 1000
    return duration_in_seconds

file_path = "your_audio_file.mp3"
length = get_audio_length_pydub(file_path)
print(f"音频文件时长（秒）：{length}")
```
### 使用 `moviepy` 库
`moviepy` 是一个用于视频编辑的库，但它也可以处理音频文件。安装 `moviepy` 库：
```bash
pip install moviepy
```
代码示例：
```python
from moviepy.editor import AudioFileClip

def get_audio_length_moviepy(file_path):
    audio_clip = AudioFileClip(file_path)
    duration = audio_clip.duration
    audio_clip.close()
    return duration

file_path = "your_audio_file.mp3"
length = get_audio_length_moviepy(file_path)
print(f"音频文件时长（秒）：{length}")
```
### 使用 `mutagen` 库
`mutagen` 是一个用于处理音频元数据的库，也能获取音频时长。安装 `mutagen` 库：
```bash
pip install mutagen
```
代码示例：
```python
from mutagen.mp3 import MP3

def get_audio_length_mutagen(file_path):
    audio = MP3(file_path)
    duration = audio.info.length
    return duration

file_path = "your_audio_file.mp3"
length = get_audio_length_mutagen(file_path)
print(f"音频文件时长（秒）：{length}")
```

## 常见实践

### 批量获取音频文件时长
在实际项目中，可能需要获取多个音频文件的时长。可以结合文件遍历操作来实现：
```python
import os
from pydub import AudioSegment

def get_batch_audio_lengths(folder_path):
    audio_lengths = {}
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith(('.mp3', '.wav')):
                file_path = os.path.join(root, file)
                audio = AudioSegment.from_file(file_path)
                duration_in_ms = len(audio)
                duration_in_seconds = duration_in_ms / 1000
                audio_lengths[file] = duration_in_seconds
    return audio_lengths

folder_path = "your_audio_folder"
lengths = get_batch_audio_lengths(folder_path)
for audio_file, length in lengths.items():
    print(f"{audio_file} 时长（秒）：{length}")
```

### 在音频处理流程中获取时长
在音频处理过程中，获取时长可以帮助进行一些时间相关的操作，比如裁剪音频：
```python
from pydub import AudioSegment

def crop_audio(file_path, start_time, end_time):
    audio = AudioSegment.from_file(file_path)
    cropped_audio = audio[start_time * 1000:end_time * 1000]
    return cropped_audio

file_path = "your_audio_file.mp3"
original_length = get_audio_length_pydub(file_path)
cropped_audio = crop_audio(file_path, 10, 20)  # 裁剪 10 到 20 秒的音频
cropped_length = get_audio_length_pydub(cropped_audio)
print(f"裁剪后的音频时长（秒）：{cropped_length}")
```

## 最佳实践

### 选择合适的库
不同的库有不同的特点和适用场景。如果只是单纯获取音频时长，`mutagen` 库相对轻量级，性能较好。如果需要对音频进行更多的编辑操作，`pydub` 库提供了更丰富的功能。而 `moviepy` 库在处理视频和音频结合的场景下有优势。根据项目的具体需求选择合适的库可以提高开发效率。

### 错误处理
在读取音频文件时，可能会遇到文件格式不支持、文件损坏等问题。因此，在代码中添加适当的错误处理是很重要的。例如：
```python
from pydub import AudioSegment

def get_audio_length_with_error_handling(file_path):
    try:
        audio = AudioSegment.from_file(file_path)
        duration_in_ms = len(audio)
        duration_in_seconds = duration_in_ms / 1000
        return duration_in_seconds
    except Exception as e:
        print(f"获取音频时长时出错：{e}")
        return None

file_path = "your_audio_file.mp3"
length = get_audio_length_with_error_handling(file_path)
if length is not None:
    print(f"音频文件时长（秒）：{length}")
```

## 小结
本文详细介绍了在 Python 中获取音频文件时长的方法，包括基础概念、使用不同库的方法、常见实践以及最佳实践。通过使用 `pydub`、`moviepy` 和 `mutagen` 等库，我们可以轻松地获取音频文件的时长。在实际项目中，根据需求选择合适的库，并注意错误处理等最佳实践，可以提高程序的稳定性和效率。希望本文能帮助读者在处理音频文件时更好地掌握获取时长这一重要操作。

## 参考资料
- [pydub 官方文档](https://github.com/jiaaro/pydub){: rel="nofollow"}
- [moviepy 官方文档](https://zulko.github.io/moviepy/){: rel="nofollow"}
- [mutagen 官方文档](https://mutagen.readthedocs.io/en/latest/){: rel="nofollow"}
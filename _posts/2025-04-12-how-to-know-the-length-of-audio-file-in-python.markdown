---
title: "如何在 Python 中获取音频文件时长"
description: "在处理音频数据时，了解音频文件的时长是一项常见需求。无论是音频编辑、音频分析还是多媒体项目开发，获取音频时长都是一个基础且重要的操作。Python 作为一种功能强大且广泛应用于数据处理和编程的语言，提供了多种方法来实现这一目标。本文将详细介绍在 Python 中获取音频文件时长的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在处理音频数据时，了解音频文件的时长是一项常见需求。无论是音频编辑、音频分析还是多媒体项目开发，获取音频时长都是一个基础且重要的操作。Python 作为一种功能强大且广泛应用于数据处理和编程的语言，提供了多种方法来实现这一目标。本文将详细介绍在 Python 中获取音频文件时长的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `pydub` 库**
    - **使用 `moviepy` 库**
    - **使用 `eyed3` 库**
3. **常见实践**
    - **批量获取音频文件时长**
    - **结合文件遍历获取时长**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
音频文件时长指的是音频从开始播放到结束播放所持续的时间。在计算机中，音频数据以数字形式存储，音频文件格式多种多样，如 MP3、WAV、FLAC 等。每种音频文件格式都有其特定的结构和编码方式，但都包含了音频数据以及相关的元数据。元数据中通常会包含音频时长等信息，我们可以通过编程的方式解析这些元数据来获取音频文件的时长。

## 使用方法

### 使用 `pydub` 库
`pydub` 是一个用于处理音频的 Python 库，它提供了简单易用的 API 来读取、编辑和写入音频文件。

**安装 `pydub` 库**：
```bash
pip install pydub
```

**获取音频文件时长示例代码**：
```python
from pydub import AudioSegment

def get_audio_length_pydub(file_path):
    audio = AudioSegment.from_file(file_path)
    duration_ms = len(audio)
    duration_s = duration_ms / 1000
    return duration_s

file_path = "your_audio_file.mp3"
length = get_audio_length_pydub(file_path)
print(f"音频文件时长: {length} 秒")
```

### 使用 `moviepy` 库
`moviepy` 是一个用于视频编辑的 Python 库，也可以用于处理音频文件。

**安装 `moviepy` 库**：
```bash
pip install moviepy
```

**获取音频文件时长示例代码**：
```python
from moviepy.editor import AudioFileClip

def get_audio_length_moviepy(file_path):
    audio_clip = AudioFileClip(file_path)
    duration_s = audio_clip.duration
    audio_clip.close()
    return duration_s

file_path = "your_audio_file.mp3"
length = get_audio_length_moviepy(file_path)
print(f"音频文件时长: {length} 秒")
```

### 使用 `eyed3` 库
`eyed3` 主要用于处理 MP3 文件的元数据，但也可以获取音频时长。

**安装 `eyed3` 库**：
```bash
pip install eyed3
```

**获取音频文件时长示例代码**：
```python
import eyed3

def get_audio_length_eyed3(file_path):
    audiofile = eyed3.load(file_path)
    duration_s = audiofile.info.time_secs
    return duration_s

file_path = "your_audio_file.mp3"
length = get_audio_length_eyed3(file_path)
print(f"音频文件时长: {length} 秒")
```

## 常见实践

### 批量获取音频文件时长
在实际应用中，可能需要获取多个音频文件的时长。以下是使用 `pydub` 库批量获取音频文件时长的示例：

```python
import os
from pydub import AudioSegment

def get_audio_lengths_in_folder(folder_path):
    audio_lengths = {}
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith(('.mp3', '.wav', '.flac')):
                file_path = os.path.join(root, file)
                audio = AudioSegment.from_file(file_path)
                duration_ms = len(audio)
                duration_s = duration_ms / 1000
                audio_lengths[file] = duration_s
    return audio_lengths

folder_path = "your_audio_folder"
lengths = get_audio_lengths_in_folder(folder_path)
for file, length in lengths.items():
    print(f"{file} 时长: {length} 秒")
```

### 结合文件遍历获取时长
结合文件遍历和上述获取音频时长的方法，可以方便地处理大量音频文件。例如，我们可以将获取到的音频时长信息写入一个 CSV 文件中，以便后续分析。

```python
import os
import csv
from pydub import AudioSegment

def save_audio_lengths_to_csv(folder_path, csv_file_path):
    with open(csv_file_path, mode='w', newline='', encoding='utf-8') as csv_file:
        fieldnames = ['文件名', '时长（秒）']
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

        writer.writeheader()

        for root, dirs, files in os.walk(folder_path):
            for file in files:
                if file.endswith(('.mp3', '.wav', '.flac')):
                    file_path = os.path.join(root, file)
                    audio = AudioSegment.from_file(file_path)
                    duration_ms = len(audio)
                    duration_s = duration_ms / 1000
                    writer.writerow({'文件名': file, '时长（秒）': duration_s})

folder_path = "your_audio_folder"
csv_file_path = "audio_lengths.csv"
save_audio_lengths_to_csv(folder_path, csv_file_path)
```

## 最佳实践

### 性能优化
- **缓存结果**：如果需要多次获取同一个音频文件的时长，可以考虑缓存结果，避免重复读取和计算。
- **选择合适的库**：不同的库在处理不同音频文件格式和性能方面可能存在差异。根据实际需求选择最适合的库。例如，`pydub` 库在处理常见音频格式时较为通用，而 `eyed3` 库在处理 MP3 文件时更有针对性。

### 错误处理
在读取音频文件时，可能会遇到各种错误，如文件不存在、文件格式不支持等。因此，在代码中添加适当的错误处理机制非常重要。

```python
from pydub import AudioSegment

def get_audio_length_with_error_handling(file_path):
    try:
        audio = AudioSegment.from_file(file_path)
        duration_ms = len(audio)
        duration_s = duration_ms / 1000
        return duration_s
    except FileNotFoundError:
        print(f"文件 {file_path} 不存在")
    except Exception as e:
        print(f"读取文件 {file_path} 时发生错误: {e}")

file_path = "your_audio_file.mp3"
length = get_audio_length_with_error_handling(file_path)
```

## 小结
本文介绍了在 Python 中获取音频文件时长的多种方法，包括使用 `pydub`、`moviepy` 和 `eyed3` 等库。同时，还探讨了常见实践和最佳实践，如批量获取音频时长、结合文件遍历以及性能优化和错误处理等方面。通过掌握这些知识和技巧，读者可以更加高效地处理音频文件时长相关的任务，无论是在音频处理、多媒体项目开发还是数据分析等领域。

## 参考资料
- [pydub 官方文档](https://github.com/jiaaro/pydub){: rel="nofollow"}
- [moviepy 官方文档](https://zulko.github.io/moviepy/){: rel="nofollow"}
- [eyed3 官方文档](https://eyed3.readthedocs.io/en/latest/){: rel="nofollow"}
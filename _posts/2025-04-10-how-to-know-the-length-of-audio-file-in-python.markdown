---
title: "如何在 Python 中获取音频文件时长"
description: "在处理音频数据时，了解音频文件的时长是一个常见需求。无论是进行音频编辑、分析还是创建多媒体应用程序，知道音频的长度都有助于更好地管理和操作音频内容。Python 作为一种功能强大且灵活的编程语言，提供了多种方法来获取音频文件的时长。本文将深入探讨这些方法，帮助你轻松掌握在 Python 中获取音频文件时长的技巧。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在处理音频数据时，了解音频文件的时长是一个常见需求。无论是进行音频编辑、分析还是创建多媒体应用程序，知道音频的长度都有助于更好地管理和操作音频内容。Python 作为一种功能强大且灵活的编程语言，提供了多种方法来获取音频文件的时长。本文将深入探讨这些方法，帮助你轻松掌握在 Python 中获取音频文件时长的技巧。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `pydub` 库**
    - **使用 `moviepy` 库**
    - **使用 `wave` 模块（针对 WAV 文件）**
3. **常见实践**
    - **批量获取音频文件时长**
    - **结合文件遍历获取时长**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
音频文件时长的计算依赖于音频文件的格式以及其中存储的音频数据信息。不同的音频格式（如 MP3、WAV、FLAC 等）有不同的结构和编码方式，但本质上，音频时长是由音频的采样率、采样位数以及音频数据的总样本数决定的。例如，对于一个采样率为 44100Hz 的音频，这意味着每秒有 44100 个音频样本。如果我们知道了音频文件的总样本数，就可以通过总样本数除以采样率来得到音频的时长（单位为秒）。

## 使用方法

### 使用 `pydub` 库
`pydub` 是一个用于处理音频文件的强大库，它支持多种音频格式。首先，确保你已经安装了 `pydub` 库：
```bash
pip install pydub
```
以下是使用 `pydub` 获取音频文件时长的示例代码：
```python
from pydub import AudioSegment

def get_audio_length_pydub(file_path):
    audio = AudioSegment.from_file(file_path)
    duration = len(audio) / 1000  # 音频时长单位为毫秒，转换为秒
    return duration

file_path = 'your_audio_file.mp3'
length = get_audio_length_pydub(file_path)
print(f"音频文件时长: {length} 秒")
```

### 使用 `moviepy` 库
`moviepy` 库不仅可以处理视频文件，也能用于获取音频文件时长。安装 `moviepy` 库：
```bash
pip install moviepy
```
示例代码如下：
```python
from moviepy.editor import AudioFileClip

def get_audio_length_moviepy(file_path):
    audio_clip = AudioFileClip(file_path)
    duration = audio_clip.duration
    audio_clip.close()  # 关闭音频剪辑对象，释放资源
    return duration

file_path = 'your_audio_file.mp3'
length = get_audio_length_moviepy(file_path)
print(f"音频文件时长: {length} 秒")
```

### 使用 `wave` 模块（针对 WAV 文件）
`wave` 模块是 Python 标准库的一部分，专门用于处理 WAV 格式的音频文件。以下是使用 `wave` 模块获取 WAV 文件时长的代码：
```python
import wave

def get_audio_length_wave(file_path):
    with wave.open(file_path, 'rb') as wf:
        frames = wf.getnframes()
        rate = wf.getframerate()
        duration = frames / float(rate)
    return duration

file_path = 'your_wav_file.wav'
length = get_audio_length_wave(file_path)
print(f"音频文件时长: {length} 秒")
```

## 常见实践

### 批量获取音频文件时长
在实际应用中，我们可能需要获取文件夹中多个音频文件的时长。以下是使用 `pydub` 库实现批量获取音频文件时长的示例：
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
                duration = len(audio) / 1000
                audio_lengths[file] = duration
    return audio_lengths

folder_path = 'your_audio_folder'
lengths = get_audio_lengths_in_folder(folder_path)
for file, length in lengths.items():
    print(f"{file} 时长: {length} 秒")
```

### 结合文件遍历获取时长
可以结合文件遍历操作，更灵活地获取音频文件时长。例如，只获取特定文件夹下特定格式的音频文件时长：
```python
import os
from moviepy.editor import AudioFileClip

def get_specific_audio_lengths(folder_path, extensions):
    audio_lengths = {}
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if any(file.endswith(ext) for ext in extensions):
                file_path = os.path.join(root, file)
                audio_clip = AudioFileClip(file_path)
                duration = audio_clip.duration
                audio_clip.close()
                audio_lengths[file] = duration
    return audio_lengths

folder_path = 'your_audio_folder'
extensions = ('.mp3', '.wav')
lengths = get_specific_audio_lengths(folder_path, extensions)
for file, length in lengths.items():
    print(f"{file} 时长: {length} 秒")
```

## 最佳实践

### 性能优化
- **选择合适的库**：根据具体需求选择性能最佳的库。例如，如果只处理 WAV 文件，`wave` 模块作为标准库的一部分，性能会比较高。对于多种格式的音频文件，`pydub` 和 `moviepy` 库提供了更广泛的支持，但可能在某些情况下性能稍逊一筹。
- **缓存结果**：如果需要多次获取同一个音频文件的时长，可以考虑缓存结果，避免重复读取文件和计算时长，提高程序效率。

### 错误处理
在读取音频文件时，可能会遇到各种错误，如文件不存在、格式不支持等。因此，在代码中添加适当的错误处理是很重要的。例如：
```python
from pydub import AudioSegment

def get_audio_length_pydub(file_path):
    try:
        audio = AudioSegment.from_file(file_path)
        duration = len(audio) / 1000
        return duration
    except FileNotFoundError:
        print(f"文件 {file_path} 不存在")
    except Exception as e:
        print(f"获取音频时长时发生错误: {e}")
    return None

file_path = 'your_audio_file.mp3'
length = get_audio_length_pydub(file_path)
if length is not None:
    print(f"音频文件时长: {length} 秒")
```

## 小结
本文介绍了在 Python 中获取音频文件时长的多种方法，包括使用 `pydub` 库、`moviepy` 库以及 `wave` 模块（针对 WAV 文件）。同时，通过常见实践和最佳实践的示例，展示了如何在实际应用中灵活运用这些方法，并提高代码的性能和稳定性。希望这些内容能帮助你在处理音频文件时长相关的任务中更加得心应手。

## 参考资料
- [pydub 官方文档](https://pydub.readthedocs.io/en/latest/){: rel="nofollow"}
- [moviepy 官方文档](https://zulko.github.io/moviepy/){: rel="nofollow"}
- [Python wave 模块文档](https://docs.python.org/3/library/wave.html){: rel="nofollow"}
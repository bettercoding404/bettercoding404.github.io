---
title: "如何在 Python 中获取音频文件的时长"
description: "在处理音频数据时，了解音频文件的时长是一项常见需求。无论是音频编辑、音频分析还是多媒体应用开发，获取音频时长都能为进一步的数据处理和操作提供重要信息。Python 作为一种功能强大且广泛应用的编程语言，提供了多种方法来实现这一目标。本文将详细介绍在 Python 中获取音频文件时长的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在处理音频数据时，了解音频文件的时长是一项常见需求。无论是音频编辑、音频分析还是多媒体应用开发，获取音频时长都能为进一步的数据处理和操作提供重要信息。Python 作为一种功能强大且广泛应用的编程语言，提供了多种方法来实现这一目标。本文将详细介绍在 Python 中获取音频文件时长的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `pydub` 库**
    - **使用 `moviepy` 库**
    - **使用 `eyed3` 库**
3. **常见实践**
    - **批量获取音频时长**
    - **结合其他音频处理操作**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
音频文件的时长，简单来说，就是音频从开始播放到结束所持续的时间。在数字音频领域，音频文件通常由一系列的样本组成，每个样本表示在特定时刻的音频信号值。音频时长取决于采样率（每秒采集的样本数）、样本位数（每个样本所使用的比特数）以及音频文件的总样本数。通过这些参数，我们可以计算出音频文件的时长。

## 使用方法

### 使用 `pydub` 库
`pydub` 是一个用于处理音频文件的强大库，它提供了简单易用的 API 来读取、写入和操作音频数据。

首先，确保你已经安装了 `pydub` 库：
```bash
pip install pydub
```

以下是获取音频文件时长的代码示例：
```python
from pydub import AudioSegment

def get_audio_length_pydub(file_path):
    audio = AudioSegment.from_file(file_path)
    length_in_ms = len(audio)
    length_in_seconds = length_in_ms / 1000
    return length_in_seconds

file_path = 'your_audio_file.mp3'
length = get_audio_length_pydub(file_path)
print(f"音频文件时长为: {length} 秒")
```

### 使用 `moviepy` 库
`moviepy` 主要用于视频编辑，但它也可以处理音频文件并获取其时长。

安装 `moviepy` 库：
```bash
pip install moviepy
```

代码示例：
```python
from moviepy.editor import AudioFileClip

def get_audio_length_moviepy(file_path):
    audio_clip = AudioFileClip(file_path)
    length_in_seconds = audio_clip.duration
    audio_clip.close()
    return length_in_seconds

file_path = 'your_audio_file.mp4'  # 也可以是其他音频格式
length = get_audio_length_moviepy(file_path)
print(f"音频文件时长为: {length} 秒")
```

### 使用 `eyed3` 库
`eyed3` 是一个用于处理音频文件元数据的库，同时也能获取音频时长。

安装 `eyed3` 库：
```bash
pip install eyed3
```

代码示例：
```python
import eyed3

def get_audio_length_eyed3(file_path):
    audiofile = eyed3.load(file_path)
    length_in_seconds = audiofile.info.time_secs
    return length_in_seconds

file_path = 'your_audio_file.mp3'
length = get_audio_length_eyed3(file_path)
print(f"音频文件时长为: {length} 秒")
```

## 常见实践

### 批量获取音频时长
在实际应用中，可能需要批量处理多个音频文件并获取它们的时长。以下是使用 `pydub` 库实现批量获取音频时长的示例：
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
                length_in_ms = len(audio)
                length_in_seconds = length_in_ms / 1000
                audio_lengths[file] = length_in_seconds
    return audio_lengths

folder_path = 'your_audio_folder'
lengths = get_audio_lengths_in_folder(folder_path)
for audio_file, length in lengths.items():
    print(f"{audio_file} 的时长为: {length} 秒")
```

### 结合其他音频处理操作
获取音频时长通常是音频处理流程中的一部分。例如，在音频剪辑操作中，我们可能需要先获取音频时长，然后根据时长进行剪辑。以下是使用 `moviepy` 库结合音频剪辑和时长获取的示例：
```python
from moviepy.editor import AudioFileClip

def clip_audio_and_get_length(file_path, start_time, end_time):
    audio_clip = AudioFileClip(file_path)
    clipped_audio = audio_clip.subclip(start_time, end_time)
    length_in_seconds = clipped_audio.duration
    clipped_audio.write_audiofile('clipped_audio.mp3')
    clipped_audio.close()
    audio_clip.close()
    return length_in_seconds

file_path = 'your_audio_file.mp3'
start_time = 5  # 开始时间（秒）
end_time = 15   # 结束时间（秒）
clipped_length = clip_audio_and_get_length(file_path, start_time, end_time)
print(f"剪辑后的音频时长为: {clipped_length} 秒")
```

## 最佳实践

### 性能优化
在处理大量音频文件时，性能优化至关重要。可以考虑以下几点：
- **缓存结果**：如果多次获取同一个音频文件的时长，可以将结果缓存起来，避免重复计算。
- **并行处理**：对于批量处理音频文件，可以使用多线程或多进程来并行获取时长，提高处理速度。例如，使用 `concurrent.futures` 模块：
```python
import os
import concurrent.futures
from pydub import AudioSegment

def get_audio_length(file_path):
    audio = AudioSegment.from_file(file_path)
    length_in_ms = len(audio)
    length_in_seconds = length_in_ms / 1000
    return length_in_seconds

def get_audio_lengths_in_folder_parallel(folder_path):
    audio_lengths = {}
    file_paths = []
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith(('.mp3', '.wav', '.flac')):
                file_path = os.path.join(root, file)
                file_paths.append(file_path)

    with concurrent.futures.ThreadPoolExecutor() as executor:
        lengths = list(executor.map(get_audio_length, file_paths))

    for file, length in zip(file_paths, lengths):
        audio_lengths[file] = length

    return audio_lengths

folder_path = 'your_audio_folder'
lengths = get_audio_lengths_in_folder_parallel(folder_path)
for audio_file, length in lengths.items():
    print(f"{audio_file} 的时长为: {length} 秒")
```

### 错误处理
在获取音频时长时，可能会遇到各种错误，如文件不存在、文件格式不支持等。因此，需要进行适当的错误处理。以下是使用 `try - except` 块进行错误处理的示例：
```python
from pydub import AudioSegment

def get_audio_length_with_error_handling(file_path):
    try:
        audio = AudioSegment.from_file(file_path)
        length_in_ms = len(audio)
        length_in_seconds = length_in_ms / 1000
        return length_in_seconds
    except FileNotFoundError:
        print(f"文件 {file_path} 未找到")
    except Exception as e:
        print(f"获取音频时长时发生错误: {e}")

file_path = 'non_existent_audio_file.mp3'
length = get_audio_length_with_error_handling(file_path)
```

## 小结
在 Python 中获取音频文件的时长有多种方法，每种方法都有其优缺点和适用场景。`pydub` 库适用于简单的音频处理和时长获取；`moviepy` 库在处理视频和音频结合的场景中表现出色；`eyed3` 库则专注于音频元数据处理。在实际应用中，我们可以根据具体需求选择合适的库，并结合性能优化和错误处理等最佳实践，高效地获取音频文件的时长。

## 参考资料
- [pydub 官方文档](https://github.com/jiaaro/pydub){: rel="nofollow"}
- [moviepy 官方文档](https://zulko.github.io/moviepy/){: rel="nofollow"}
- [eyed3 官方文档](https://eyed3.readthedocs.io/en/latest/){: rel="nofollow"}
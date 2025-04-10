---
title: "如何在Python中获取音频文件的时长"
description: "在处理音频文件时，了解音频文件的时长是一个常见需求。例如，在音频编辑、音频分析、音频索引等场景下，知道音频的时长有助于进行后续的处理。Python提供了多个库可以用来获取音频文件的时长，本文将详细介绍这些方法。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在处理音频文件时，了解音频文件的时长是一个常见需求。例如，在音频编辑、音频分析、音频索引等场景下，知道音频的时长有助于进行后续的处理。Python提供了多个库可以用来获取音频文件的时长，本文将详细介绍这些方法。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用`pydub`库
    - 使用`moviepy`库
    - 使用`audioread`库
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
音频文件的时长就是音频播放的持续时间，通常以秒为单位。不同的音频格式（如MP3、WAV、FLAC等）存储音频数据的方式不同，但都可以通过相应的库解析音频文件头信息或音频流数据来获取时长。

## 使用方法

### 使用`pydub`库
`pydub`是一个用于处理音频的高级Python库，它支持多种音频格式的读取和操作。

1. **安装`pydub`库**：
    ```bash
    pip install pydub
    ```

2. **获取音频时长代码示例**：
    ```python
    from pydub import AudioSegment

    def get_audio_length_pydub(file_path):
        audio = AudioSegment.from_file(file_path)
        duration_seconds = len(audio) / 1000  # pydub以毫秒为单位返回音频长度，转换为秒
        return duration_seconds

    file_path = "your_audio_file.mp3"
    length = get_audio_length_pydub(file_path)
    print(f"音频时长（秒）: {length}")
    ```

### 使用`moviepy`库
`moviepy`库不仅可以处理视频，也可以处理音频文件。

1. **安装`moviepy`库**：
    ```bash
    pip install moviepy
    ```

2. **获取音频时长代码示例**：
    ```python
    from moviepy.editor import AudioFileClip

    def get_audio_length_moviepy(file_path):
        audio_clip = AudioFileClip(file_path)
        duration_seconds = audio_clip.duration
        audio_clip.close()  # 关闭音频剪辑对象，释放资源
        return duration_seconds

    file_path = "your_audio_file.mp3"
    length = get_audio_length_moviepy(file_path)
    print(f"音频时长（秒）: {length}")
    ```

### 使用`audioread`库
`audioread`库是一个简单的音频文件读取库，支持多种音频格式。

1. **安装`audioread`库**：
    ```bash
    pip install audioread
    ```

2. **获取音频时长代码示例**：
    ```python
    import audioread

    def get_audio_length_audioread(file_path):
        with audioread.audio_open(file_path) as f:
            duration_seconds = f.duration
        return duration_seconds

    file_path = "your_audio_file.mp3"
    length = get_audio_length_audioread(file_path)
    print(f"音频时长（秒）: {length}")
    ```

## 常见实践
在实际项目中，获取音频时长通常是音频处理流程的一部分。例如，在一个音频分类项目中，可能需要对不同时长的音频进行统计分析，以便更好地了解数据分布。以下是一个简单的示例，统计一组音频文件的平均时长：

```python
import os
from pydub import AudioSegment


def get_average_audio_length(folder_path):
    total_length = 0
    file_count = 0

    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.endswith(('.mp3', '.wav', '.flac')):
                file_path = os.path.join(root, file)
                audio = AudioSegment.from_file(file_path)
                duration_seconds = len(audio) / 1000
                total_length += duration_seconds
                file_count += 1

    if file_count == 0:
        return 0

    average_length = total_length / file_count
    return average_length


folder_path = "your_audio_folder"
average_length = get_average_audio_length(folder_path)
print(f"平均音频时长（秒）: {average_length}")

```

## 最佳实践
1. **性能考量**：
    - 如果需要处理大量音频文件，建议使用`audioread`库，因为它相对轻量级，读取速度较快。
    - `pydub`库在处理音频格式转换和其他音频操作方面功能强大，但在单纯获取时长时性能可能不如`audioread`。
    - `moviepy`库虽然也能获取音频时长，但由于它功能较为复杂，加载时间可能较长，适合在同时需要进行视频和音频处理的场景下使用。

2. **错误处理**：
    - 在实际应用中，音频文件可能存在损坏或格式不支持的情况。因此，在使用上述库时，需要进行适当的错误处理。例如：
    ```python
    from pydub import AudioSegment

    def get_audio_length_pydub(file_path):
        try:
            audio = AudioSegment.from_file(file_path)
            duration_seconds = len(audio) / 1000
            return duration_seconds
        except Exception as e:
            print(f"获取音频时长时出错: {e}")
            return None


    file_path = "your_audio_file.mp3"
    length = get_audio_length_pydub(file_path)
    if length is not None:
        print(f"音频时长（秒）: {length}")

    ```

## 小结
本文介绍了在Python中获取音频文件时长的多种方法，包括使用`pydub`、`moviepy`和`audioread`库。每种方法都有其特点和适用场景。在实际项目中，应根据具体需求选择合适的库，并注意性能优化和错误处理。希望这些内容能帮助读者更好地处理音频文件时长相关的问题。

## 参考资料
- [pydub官方文档](https://github.com/jiaaro/pydub){: rel="nofollow"}
- [moviepy官方文档](https://zulko.github.io/moviepy/){: rel="nofollow"}
- [audioread官方文档](https://audioread.readthedocs.io/en/latest/){: rel="nofollow"}
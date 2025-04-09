---
title: "Python Subprocess：使用 curl 并输出到文件"
description: "在 Python 编程中，我们常常需要与外部命令进行交互。`subprocess` 模块提供了一个强大的接口来创建新进程、连接到它们的输入/输出/错误管道，并获取它们的返回码。而 `curl` 是一个广泛使用的命令行工具，用于传输数据。将 `subprocess` 与 `curl` 结合使用，并将 `curl` 的输出重定向到文件，在很多场景下都非常有用，比如下载文件、获取网页内容并保存等。本文将深入探讨这一技术的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在 Python 编程中，我们常常需要与外部命令进行交互。`subprocess` 模块提供了一个强大的接口来创建新进程、连接到它们的输入/输出/错误管道，并获取它们的返回码。而 `curl` 是一个广泛使用的命令行工具，用于传输数据。将 `subprocess` 与 `curl` 结合使用，并将 `curl` 的输出重定向到文件，在很多场景下都非常有用，比如下载文件、获取网页内容并保存等。本文将深入探讨这一技术的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
    - `subprocess` 模块
    - `curl` 工具
2. 使用方法
    - 基本的 `subprocess` 调用 `curl`
    - 将 `curl` 输出重定向到文件
3. 常见实践
    - 下载文件
    - 获取网页内容并保存
4. 最佳实践
    - 错误处理
    - 提高性能
5. 小结
6. 参考资料

## 基础概念
### `subprocess` 模块
`subprocess` 模块旨在替换一些旧的模块，如 `os.system`、`os.spawn*` 等。它提供了 `Popen` 类来创建新进程，并允许你管理它们的输入、输出和错误流。通过 `Popen`，你可以控制外部进程的执行，并获取其执行结果。

### `curl` 工具
`curl` 是一个功能强大的命令行工具，支持多种协议（如 HTTP、FTP 等）。它可以用于发送请求、下载文件、上传数据等。在命令行中，你可以使用 `curl` 命令并添加不同的参数来实现各种功能。例如，`curl example.com` 可以获取 `example.com` 的网页内容。

## 使用方法
### 基本的 `subprocess` 调用 `curl`
下面是一个简单的示例，展示如何使用 `subprocess` 模块调用 `curl` 命令：

```python
import subprocess

# 调用 curl 命令获取网页内容
result = subprocess.run(['curl', 'example.com'], capture_output=True, text=True)

# 输出网页内容
print(result.stdout)
```

在这个示例中：
- `subprocess.run` 是 `subprocess` 模块中的一个函数，用于运行外部命令。
- `['curl', 'example.com']` 是传递给 `subprocess.run` 的参数列表，第一个元素是命令（`curl`），后面的元素是命令的参数（`example.com`）。
- `capture_output=True` 表示捕获命令的标准输出和标准错误输出。
- `text=True` 表示以文本形式返回输出，而不是字节形式。

### 将 `curl` 输出重定向到文件
要将 `curl` 的输出重定向到文件，可以使用以下方法：

```python
import subprocess

# 打开文件以写入模式
with open('output.txt', 'w') as f:
    # 调用 curl 命令并将输出重定向到文件
    subprocess.run(['curl', 'example.com'], stdout=f)
```

在这个示例中：
- `open('output.txt', 'w')` 打开一个名为 `output.txt` 的文件，以写入模式。
- `subprocess.run` 的 `stdout` 参数被设置为文件对象 `f`，这样 `curl` 的输出就会被写入到 `output.txt` 文件中。

## 常见实践
### 下载文件
假设你要从一个 URL 下载文件，可以使用以下代码：

```python
import subprocess

url = 'http://example.com/somefile.txt'
output_file ='saved_file.txt'

with open(output_file, 'wb') as f:
    subprocess.run(['curl', url], stdout=f)
```

在这个示例中，`curl` 从指定的 `url` 下载文件，并将其内容写入到 `saved_file.txt` 文件中。`wb` 模式表示以二进制写入模式打开文件，这对于下载非文本文件（如图片、二进制文件等）非常重要。

### 获取网页内容并保存
如果你想获取网页内容并保存为 HTML 文件，可以这样做：

```python
import subprocess

url = 'http://example.com'
output_file = 'page.html'

with open(output_file, 'w', encoding='utf-8') as f:
    subprocess.run(['curl', url], stdout=f, text=True)
```

这里使用 `encoding='utf-8'` 来确保网页内容以正确的编码保存。

## 最佳实践
### 错误处理
在使用 `subprocess` 和 `curl` 时，错误处理非常重要。例如，如果 `curl` 命令执行失败，我们需要捕获并处理错误。

```python
import subprocess

url = 'http://nonexistent.example.com'
output_file = 'output.txt'

try:
    with open(output_file, 'w') as f:
        result = subprocess.run(['curl', url], stdout=f, stderr=subprocess.PIPE, text=True)
    if result.returncode!= 0:
        print(f"Error occurred: {result.stderr}")
except Exception as e:
    print(f"An unexpected error occurred: {e}")
```

在这个示例中：
- `stderr=subprocess.PIPE` 表示捕获标准错误输出。
- 检查 `result.returncode` 是否为 0，如果不为 0，则表示命令执行失败，输出错误信息。

### 提高性能
如果需要下载多个文件或获取多个网页内容，可以考虑使用多线程或异步编程来提高性能。例如，使用 `concurrent.futures` 模块进行多线程下载：

```python
import concurrent.futures
import subprocess
import requests


def download_file(url, output_file):
    try:
        with open(output_file, 'wb') as f:
            subprocess.run(['curl', url], stdout=f)
        print(f"{url} downloaded successfully to {output_file}")
    except Exception as e:
        print(f"Error downloading {url}: {e}")


urls = [
    'http://example.com/file1.txt',
    'http://example.com/file2.txt',
    'http://example.com/file3.txt'
]

output_files = [f'saved_{i}.txt' for i in range(len(urls))]

with concurrent.futures.ThreadPoolExecutor() as executor:
    executor.map(download_file, urls, output_files)
```

在这个示例中，`concurrent.futures.ThreadPoolExecutor` 创建了一个线程池，`executor.map` 方法并行地调用 `download_file` 函数来下载多个文件，从而提高了下载效率。

## 小结
通过本文，我们深入了解了如何在 Python 中使用 `subprocess` 模块调用 `curl` 命令，并将其输出重定向到文件。我们学习了基础概念、使用方法、常见实践以及最佳实践，包括错误处理和性能优化。掌握这些知识将有助于你在 Python 编程中更高效地与外部命令交互，完成诸如文件下载、网页内容获取等任务。

## 参考资料
- [Python官方文档 - subprocess模块](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}
- [curl官方文档](https://curl.se/docs/){: rel="nofollow"}
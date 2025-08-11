---
title: "深入探索 psutil：Python 系统监控的得力助手"
description: "在 Python 的世界里，`psutil`（process and system utilities）库是一个强大的工具，用于跨平台地获取有关正在运行的进程和系统利用率（如 CPU、内存、磁盘、网络等）的信息。无论是系统管理员进行日常监控，还是开发人员调试应用程序，`psutil` 都能提供非常有价值的数据。本文将全面介绍 `psutil` 的基础概念、使用方法、常见实践以及最佳实践，帮助你充分利用这个库。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 的世界里，`psutil`（process and system utilities）库是一个强大的工具，用于跨平台地获取有关正在运行的进程和系统利用率（如 CPU、内存、磁盘、网络等）的信息。无论是系统管理员进行日常监控，还是开发人员调试应用程序，`psutil` 都能提供非常有价值的数据。本文将全面介绍 `psutil` 的基础概念、使用方法、常见实践以及最佳实践，帮助你充分利用这个库。

<!-- more -->
## 目录
1. **基础概念**
    - `psutil` 是什么
    - 支持的操作系统
2. **使用方法**
    - 安装 `psutil`
    - 基本系统信息获取
    - 进程信息获取与操作
3. **常见实践**
    - 监控 CPU 使用率
    - 内存使用情况分析
    - 磁盘 I/O 监控
    - 网络连接监控
4. **最佳实践**
    - 性能优化
    - 错误处理
    - 与其他工具结合使用
5. **小结**
6. **参考资料**

## 基础概念
### `psutil` 是什么
`psutil` 是一个用 Python 编写的第三方库，它提供了一个跨平台的接口，用于检索有关正在运行的进程和系统利用率的信息。它可以获取诸如 CPU 使用率、内存占用、磁盘 I/O、网络连接等信息，甚至可以对进程进行管理，如终止进程、获取进程详细信息等。

### 支持的操作系统
`psutil` 支持多种操作系统，包括 Linux、Windows、macOS 以及 BSD 家族的系统。这使得它成为一个非常通用的系统监控工具，无论你使用的是哪种主流操作系统，都可以利用 `psutil` 来获取系统和进程信息。

## 使用方法
### 安装 `psutil`
在开始使用 `psutil` 之前，需要先安装它。如果你使用的是 `pip` 包管理器，可以在命令行中运行以下命令：
```bash
pip install psutil
```
如果你使用的是 `conda`，则可以运行：
```bash
conda install -c conda-forge psutil
```

### 基本系统信息获取
获取 CPU 使用率：
```python
import psutil

# 获取 CPU 在 1 秒内的使用率
cpu_percent = psutil.cpu_percent(interval=1)
print(f"CPU使用率: {cpu_percent}%")
```

获取内存信息：
```python
import psutil

# 获取虚拟内存信息
mem = psutil.virtual_memory()
print(f"总内存: {mem.total / (1024.0 ** 3):.2f} GB")
print(f"已使用内存: {mem.used / (1024.0 ** 3):.2f} GB")
print(f"内存使用率: {mem.percent}%")
```

### 进程信息获取与操作
获取所有正在运行的进程：
```python
import psutil

for proc in psutil.process_iter(['name', 'pid']):
    print(f"进程名: {proc.info['name']}, PID: {proc.info['pid']}")
```

获取特定进程的详细信息：
```python
import psutil

try:
    proc = psutil.Process(1234)  # 替换 1234 为实际的 PID
    print(f"进程名: {proc.name()}")
    print(f"进程状态: {proc.status()}")
    print(f"内存使用: {proc.memory_info().rss / (1024.0 ** 2):.2f} MB")
except psutil.NoSuchProcess:
    print("指定的进程不存在")
```

终止进程：
```python
import psutil

try:
    proc = psutil.Process(1234)  # 替换 1234 为实际的 PID
    proc.terminate()
    print("进程已终止")
except psutil.NoSuchProcess:
    print("指定的进程不存在")
```

## 常见实践
### 监控 CPU 使用率
```python
import psutil
import time

while True:
    cpu_percent = psutil.cpu_percent(interval=1)
    print(f"当前 CPU 使用率: {cpu_percent}%")
    time.sleep(1)
```
这段代码会每秒打印一次当前的 CPU 使用率，通过 `while True` 循环可以持续监控。

### 内存使用情况分析
```python
import psutil
import matplotlib.pyplot as plt
import numpy as np

mem_usage = []
times = []

for _ in range(60):
    mem = psutil.virtual_memory()
    mem_usage.append(mem.percent)
    times.append(_)
    time.sleep(1)

plt.plot(times, mem_usage)
plt.xlabel('时间 (秒)')
plt.ylabel('内存使用率 (%)')
plt.title('内存使用情况随时间变化')
plt.show()
```
这段代码会收集 60 秒内的内存使用率数据，并使用 `matplotlib` 绘制出内存使用率随时间变化的图表。

### 磁盘 I/O 监控
```python
import psutil
import time

while True:
    disk_io = psutil.disk_io_counters()
    print(f"读取字节数: {disk_io.read_bytes}")
    print(f"写入字节数: {disk_io.write_bytes}")
    time.sleep(1)
```
这段代码每秒打印一次磁盘的读取和写入字节数，以监控磁盘 I/O 活动。

### 网络连接监控
```python
import psutil
import time

while True:
    net_io = psutil.net_io_counters()
    print(f"发送字节数: {net_io.bytes_sent}")
    print(f"接收字节数: {net_io.bytes_recv}")
    time.sleep(1)
```
这段代码每秒打印一次网络发送和接收的字节数，用于监控网络连接的流量。

## 最佳实践
### 性能优化
在获取大量进程信息或频繁调用 `psutil` 函数时，性能可能会成为问题。为了优化性能，可以：
 - 批量获取信息：尽量一次性获取多个进程的信息，而不是逐个获取。例如，使用 `psutil.process_iter` 并指定需要的信息字段。
 - 缓存数据：如果某些信息不需要实时更新，可以缓存这些数据，减少频繁调用系统 API 的开销。

### 错误处理
在使用 `psutil` 时，可能会遇到各种错误，如进程不存在、权限不足等。应该进行适当的错误处理，以确保程序的稳定性。例如，在获取特定进程信息时，使用 `try - except` 块捕获 `psutil.NoSuchProcess` 异常。

### 与其他工具结合使用
`psutil` 可以与其他工具和库结合使用，以实现更强大的功能。例如：
 - 与日志库（如 `logging`）结合，将系统和进程信息记录到日志文件中，方便后续分析。
 - 与数据可视化库（如 `matplotlib`、`seaborn`）结合，将监控数据以直观的图表形式展示出来。

## 小结
`psutil` 是一个功能强大且实用的 Python 库，它为我们提供了丰富的系统和进程信息获取及操作方法。通过掌握 `psutil` 的基础概念、使用方法、常见实践以及最佳实践，我们可以更好地监控系统状态、调试应用程序以及进行性能优化。无论是小型脚本还是大型项目，`psutil` 都能成为我们的得力助手。

## 参考资料
- [psutil 官方文档](https://psutil.readthedocs.io/en/latest/)
- [Python 官方文档](https://docs.python.org/3/)
- [psutil GitHub 仓库](https://github.com/giampaolo/psutil)
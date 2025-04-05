---
title: "Python 中的休眠时间（Sleeping Time）"
description: "在 Python 编程中，有时我们需要让程序暂停执行一段时间，这就是“休眠时间”的概念。休眠时间可以用于多种场景，比如控制程序的执行节奏、在特定时间间隔内进行数据采样，或者在进行网络请求时避免过于频繁的访问导致服务器过载等。通过合理使用休眠时间，我们可以优化程序的性能和稳定性。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，有时我们需要让程序暂停执行一段时间，这就是“休眠时间”的概念。休眠时间可以用于多种场景，比如控制程序的执行节奏、在特定时间间隔内进行数据采样，或者在进行网络请求时避免过于频繁的访问导致服务器过载等。通过合理使用休眠时间，我们可以优化程序的性能和稳定性。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `time.sleep()`
    - 使用 `datetime.timedelta` 与循环实现定时休眠
3. 常见实践
    - 网络请求中的休眠
    - 定时任务中的休眠
4. 最佳实践
    - 精确控制休眠时间
    - 处理异常情况
5. 小结
6. 参考资料

## 基础概念
“休眠时间”在 Python 中是指让程序在某段时间内暂停执行的操作。通过引入休眠，我们可以调整程序的执行流程，使其按照我们期望的时间节奏运行。这在多任务处理、模拟真实场景以及控制资源使用等方面非常有用。

## 使用方法

### 使用 `time.sleep()`
`time.sleep()` 是 Python 标准库 `time` 模块中用于暂停程序执行的函数。它接受一个参数，表示要暂停的秒数。

```python
import time

print("程序开始")
time.sleep(5)  # 程序将暂停 5 秒
print("程序继续执行")
```

### 使用 `datetime.timedelta` 与循环实现定时休眠
`datetime.timedelta` 用于表示时间间隔，结合循环可以实现按特定时间间隔进行多次休眠。

```python
import datetime
import time

start_time = datetime.datetime.now()
end_time = start_time + datetime.timedelta(minutes=2)  # 设定结束时间为 2 分钟后

while datetime.datetime.now() < end_time:
    print("当前时间: ", datetime.datetime.now())
    time.sleep(30)  # 每 30 秒打印一次当前时间
```

## 常见实践

### 网络请求中的休眠
在进行网络请求时，为了避免过于频繁的请求导致服务器拒绝访问或被封禁，我们需要设置适当的休眠时间。

```python
import requests
import time

urls = ["https://example.com", "https://example.org", "https://example.net"]

for url in urls:
    try:
        response = requests.get(url)
        print(f"请求 {url} 成功，状态码: {response.status_code}")
    except requests.RequestException as e:
        print(f"请求 {url} 失败: {e}")
    time.sleep(2)  # 每次请求后暂停 2 秒
```

### 定时任务中的休眠
在编写定时执行的任务时，休眠时间可以用来控制任务执行的频率。

```python
import time

def scheduled_task():
    while True:
        print("执行定时任务")
        # 执行任务的代码
        time.sleep(3600)  # 每小时执行一次任务
```

## 最佳实践

### 精确控制休眠时间
在一些对时间精度要求较高的场景中，我们可以使用 `time.perf_counter()` 来精确测量和控制休眠时间。

```python
import time

start_time = time.perf_counter()
# 执行一些操作
time.sleep(2)  # 假设这里需要休眠 2 秒
elapsed_time = time.perf_counter() - start_time
print(f"实际休眠时间: {elapsed_time} 秒")
```

### 处理异常情况
在使用休眠时，可能会遇到各种异常，比如用户中断程序等。我们应该适当处理这些异常，确保程序的稳定性。

```python
import time

try:
    print("开始休眠")
    time.sleep(10)
    print("休眠结束")
except KeyboardInterrupt:
    print("休眠被用户中断")
```

## 小结
Python 中的休眠时间是一个强大的工具，它可以帮助我们更好地控制程序的执行流程，提高程序的性能和稳定性。通过合理使用 `time.sleep()` 以及结合其他时间相关的模块和方法，我们能够在网络请求、定时任务等多种场景中灵活应用休眠功能。同时，在实际应用中，我们要注意精确控制休眠时间并处理可能出现的异常情况，以确保程序的健壮性。

## 参考资料
- 《Python 核心编程》
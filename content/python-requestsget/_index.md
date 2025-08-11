---
title: "深入探索 Python requests.get：从基础到最佳实践"
description: "在Python的网络请求世界里，`requests`库是一个强大且常用的工具。其中的`requests.get`方法，用于向服务器发送HTTP GET请求，是获取网络资源的重要手段。无论是从网页获取数据、调用API，还是与各种网络服务交互，`requests.get`都发挥着关键作用。本文将全面介绍`requests.get`的基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一强大功能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python的网络请求世界里，`requests`库是一个强大且常用的工具。其中的`requests.get`方法，用于向服务器发送HTTP GET请求，是获取网络资源的重要手段。无论是从网页获取数据、调用API，还是与各种网络服务交互，`requests.get`都发挥着关键作用。本文将全面介绍`requests.get`的基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一强大功能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **基本请求**
    - **传递参数**
    - **设置请求头**
3. **常见实践**
    - **获取网页内容**
    - **调用API**
4. **最佳实践**
    - **错误处理**
    - **优化性能**
    - **处理响应数据**
5. **小结**
6. **参考资料**

## 基础概念
HTTP GET请求是一种向服务器请求资源的方法。它将请求参数附加在URL后面，服务器接收到请求后，返回所请求的资源。`requests.get`方法就是在Python中发起这种请求的接口。它会返回一个`Response`对象，包含了服务器的响应信息，如状态码、响应头和响应体等。

## 使用方法

### 基本请求
使用`requests.get`发起一个简单的HTTP GET请求非常容易。以下是一个示例，请求百度首页：

```python
import requests

response = requests.get('https://www.baidu.com')
print(response.status_code)  # 打印响应状态码
print(response.text)  # 打印响应内容（网页源代码）
```

### 传递参数
有时我们需要向服务器传递一些参数。可以通过`params`参数来实现。例如，向百度搜索引擎发送搜索请求：

```python
import requests

params = {'wd': 'Python requests.get'}
response = requests.get('https://www.baidu.com/s', params=params)
print(response.url)  # 打印实际请求的URL
print(response.status_code)
print(response.text)
```

### 设置请求头
为了模拟浏览器请求或者提供额外的信息，我们可以设置请求头。以下是一个设置自定义请求头的示例：

```python
import requests

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}
response = requests.get('https://www.example.com', headers=headers)
print(response.status_code)
```

## 常见实践

### 获取网页内容
获取网页内容是`requests.get`最常见的用途之一。我们可以通过解析响应内容来提取所需的信息。以下是一个获取网页标题的示例：

```python
import requests
from bs4 import BeautifulSoup

response = requests.get('https://www.zhihu.com')
if response.status_code == 200:
    soup = BeautifulSoup(response.text, 'html.parser')
    title = soup.title.string
    print(title)
else:
    print(f'请求失败，状态码: {response.status_code}')
```

### 调用API
许多网站和服务提供了API，我们可以使用`requests.get`来调用这些API获取数据。例如，调用豆瓣电影API获取电影信息：

```python
import requests

url = 'https://api.douban.com/v2/movie/top250'
params = {'start': 0, 'count': 10}
response = requests.get(url, params=params)
if response.status_code == 200:
    data = response.json()
    for movie in data['subjects']:
        print(movie['title'])
else:
    print(f'请求失败，状态码: {response.status_code}')
```

## 最佳实践

### 错误处理
在使用`requests.get`时，可能会遇到各种错误，如网络问题、服务器故障等。因此，进行适当的错误处理非常重要。可以使用`try...except`语句来捕获异常：

```python
import requests

try:
    response = requests.get('https://nonexistentwebsite.com')
    response.raise_for_status()  # 检查响应状态码，如果不是200则抛出异常
    print(response.text)
except requests.RequestException as e:
    print(f'请求发生错误: {e}')
```

### 优化性能
为了提高请求的性能，可以设置合理的超时时间，避免长时间等待。还可以使用连接池来复用连接：

```python
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

session = requests.Session()
retry = Retry(connect=3, backoff_factor=0.5)
adapter = HTTPAdapter(max_retries=retry)
session.mount('http://', adapter)
session.mount('https://', adapter)

response = session.get('https://www.example.com', timeout=5)
print(response.status_code)
```

### 处理响应数据
根据不同的需求，对响应数据进行合适的处理。如果响应数据是JSON格式，可以使用`response.json()`方法解析；如果是二进制数据，如图片，可以使用`response.content`来获取并保存。

```python
import requests

# 下载图片
response = requests.get('https://example.com/image.jpg')
if response.status_code == 200:
    with open('image.jpg', 'wb') as f:
        f.write(response.content)
```

## 小结
`requests.get`是Python中发起HTTP GET请求的强大工具。通过本文，我们学习了它的基础概念、使用方法、常见实践以及最佳实践。在实际应用中，我们需要根据具体需求合理使用`requests.get`，并注意错误处理、性能优化和数据处理等方面，以确保程序的稳定和高效运行。

## 参考资料
- [requests官方文档](https://requests.readthedocs.io/en/latest/)
- [Python官方文档](https://docs.python.org/zh-cn/3/)
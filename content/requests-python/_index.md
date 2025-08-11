---
title: "深入探索 Python 的 Requests 库：从基础到最佳实践"
description: "在当今的数据驱动时代，与各种网络资源进行交互是许多编程任务的关键部分。Python 的 `requests` 库提供了一种简单而强大的方式来与 HTTP 服务器进行通信，无论是获取网页内容、发送数据到 API 还是执行其他网络相关操作。本博客将深入探讨 `requests` 库的基础概念、使用方法、常见实践以及最佳实践，帮助你在 Python 项目中更高效地使用这一工具。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在当今的数据驱动时代，与各种网络资源进行交互是许多编程任务的关键部分。Python 的 `requests` 库提供了一种简单而强大的方式来与 HTTP 服务器进行通信，无论是获取网页内容、发送数据到 API 还是执行其他网络相关操作。本博客将深入探讨 `requests` 库的基础概念、使用方法、常见实践以及最佳实践，帮助你在 Python 项目中更高效地使用这一工具。

<!-- more -->
## 目录
1. **基础概念**
    - HTTP 方法
    - 响应码
2. **使用方法**
    - 发送 GET 请求
    - 发送 POST 请求
    - 处理响应
3. **常见实践**
    - 与 RESTful API 交互
    - 网页抓取
4. **最佳实践**
    - 错误处理
    - 会话管理
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
### HTTP 方法
HTTP 定义了多种方法来操作服务器上的资源。`requests` 库支持所有主要的 HTTP 方法，最常用的有：
- **GET**：用于从服务器获取资源。例如，访问网页或从 API 获取数据。
- **POST**：用于向服务器提交数据，通常用于创建新资源或更新现有资源。

### 响应码
服务器在接收到请求后，会返回一个响应码来表示请求的结果。常见的响应码有：
- **200**：表示请求成功，资源已成功获取或操作已成功完成。
- **404**：表示请求的资源不存在。
- **500**：表示服务器内部错误。

## 使用方法
### 发送 GET 请求
要发送一个 GET 请求，只需使用 `requests.get` 方法。以下是一个简单的示例，获取百度首页的内容：
```python
import requests

response = requests.get('https://www.baidu.com')
print(response.text)
```
在这个示例中，`requests.get` 方法发送了一个 GET 请求到指定的 URL，并返回一个 `Response` 对象。`response.text` 属性包含了服务器返回的网页内容。

### 发送 POST 请求
发送 POST 请求可以使用 `requests.post` 方法。假设我们有一个简单的 API 端点，用于接收用户提交的数据：
```python
import requests

data = {'key1': 'value1', 'key2': 'value2'}
response = requests.post('https://example.com/api', data=data)
print(response.json())
```
在这个示例中，`data` 是要发送到服务器的数据，以字典形式表示。`requests.post` 方法将数据发送到指定的 URL，并返回服务器的响应。`response.json()` 方法将响应内容解析为 JSON 格式。

### 处理响应
`Response` 对象提供了多个属性和方法来处理服务器的响应：
- **status_code**：返回响应的状态码。
- **headers**：返回响应的头部信息。
- **text**：返回响应的文本内容。
- **json()**：如果响应内容是 JSON 格式，将其解析为 Python 字典。

```python
import requests

response = requests.get('https://api.github.com/users/octocat')
print("Status Code:", response.status_code)
print("Headers:", response.headers)
print("JSON Data:", response.json())
```

## 常见实践
### 与 RESTful API 交互
许多现代的 Web 服务都提供 RESTful API，`requests` 库可以方便地与之交互。例如，与 GitHub API 交互获取用户信息：
```python
import requests

username = 'octocat'
url = f'https://api.github.com/users/{username}'
response = requests.get(url)

if response.status_code == 200:
    user_data = response.json()
    print(f"User Name: {user_data['name']}")
    print(f"Followers: {user_data['followers']}")
else:
    print(f"Error: {response.status_code}")
```

### 网页抓取
虽然网页抓取需要遵守网站的使用条款，但 `requests` 库可以作为抓取网页内容的第一步。例如，抓取豆瓣电影 Top250 的信息：
```python
import requests
from bs4 import BeautifulSoup

url = 'https://movie.douban.com/top250'
response = requests.get(url)

if response.status_code == 200:
    soup = BeautifulSoup(response.text, 'html.parser')
    movie_list = soup.find_all('div', class_='item')
    for movie in movie_list:
        title = movie.find('span', class_='title').text
        print(title)
else:
    print(f"Error: {response.status_code}")
```

## 最佳实践
### 错误处理
在使用 `requests` 库时，始终要进行错误处理。可以使用 `try-except` 块来捕获可能的异常：
```python
import requests

try:
    response = requests.get('https://nonexistent-url.com')
    response.raise_for_status()  # 检查响应状态码，如果不是 200 系列则抛出异常
    print(response.text)
except requests.RequestException as e:
    print(f"An error occurred: {e}")
```

### 会话管理
如果需要在多个请求之间保持某些状态（如 cookies），可以使用 `requests.Session` 对象：
```python
import requests

session = requests.Session()
session.get('https://example.com/login')  # 登录操作，可能会设置 cookies
response = session.get('https://example.com/dashboard')  # 使用相同的会话访问其他页面
print(response.text)
```

### 性能优化
对于大量请求，可以使用并发请求来提高性能。`requests` 库本身不支持并发，但可以结合 `concurrent.futures` 模块：
```python
import requests
import concurrent.futures

urls = ['https://example.com', 'https://example.org', 'https://example.net']

def fetch_url(url):
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.text
    except requests.RequestException as e:
        return f"Error: {e}"

with concurrent.futures.ThreadPoolExecutor() as executor:
    results = list(executor.map(fetch_url, urls))
    for result in results:
        print(result)
```

## 小结
`requests` 库是 Python 中进行网络请求的强大工具，通过简单的方法调用，可以轻松地与 HTTP 服务器进行交互。了解基础概念、掌握使用方法、熟悉常见实践以及遵循最佳实践，将帮助你在各种项目中更高效地使用 `requests` 库，无论是与 API 交互还是进行网页抓取等任务。

## 参考资料
- [Requests 官方文档](https://requests.readthedocs.io/en/latest/)
- [Python 官方文档](https://docs.python.org/3/)
- [HTTP 协议文档](https://developer.mozilla.org/zh-CN/docs/Web/HTTP)
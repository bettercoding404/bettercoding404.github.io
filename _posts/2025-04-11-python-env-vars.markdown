---
title: "深入理解Python环境变量（Env Vars）"
description: "在Python开发中，环境变量（Environment Variables，简称Env Vars）是一项强大且实用的功能。它们允许我们在不同的运行环境中轻松配置和管理应用程序的设置，而无需修改代码本身。通过使用环境变量，我们可以将敏感信息（如API密钥、数据库密码）与代码分离，提高代码的安全性和可移植性。本文将详细介绍Python环境变量的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python开发中，环境变量（Environment Variables，简称Env Vars）是一项强大且实用的功能。它们允许我们在不同的运行环境中轻松配置和管理应用程序的设置，而无需修改代码本身。通过使用环境变量，我们可以将敏感信息（如API密钥、数据库密码）与代码分离，提高代码的安全性和可移植性。本文将详细介绍Python环境变量的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 在Python脚本中访问环境变量
    - 设置环境变量
        - 临时设置
        - 永久设置（不同操作系统）
3. 常见实践
    - 配置数据库连接
    - 管理API密钥
4. 最佳实践
    - 安全性
    - 可维护性
    - 跨环境兼容性
5. 小结
6. 参考资料

## 基础概念
环境变量是存储在操作系统中的键值对。它们提供了一种在操作系统和运行于其上的应用程序之间传递信息的方式。在Python中，我们可以读取和修改这些环境变量，以适应不同的运行环境。例如，我们可以在开发环境中使用一组测试数据库的连接信息，而在生产环境中使用真实的数据库连接信息，通过环境变量的设置来轻松切换。

## 使用方法

### 在Python脚本中访问环境变量
在Python中，我们可以使用`os`模块来访问环境变量。以下是一个简单的示例：

```python
import os

# 获取环境变量的值
value = os.getenv('MY_VARIABLE')
print(value)
```

在上述代码中，`os.getenv('MY_VARIABLE')`用于获取名为`MY_VARIABLE`的环境变量的值。如果该环境变量不存在，`getenv`方法将返回`None`。

### 设置环境变量

#### 临时设置
在Linux和MacOS系统中，可以在终端中使用以下命令临时设置环境变量：

```bash
export MY_VARIABLE="some_value"
```

在Windows系统中，可以使用以下命令：

```batch
set MY_VARIABLE=some_value
```

这种设置方法只在当前终端会话中有效，关闭终端后环境变量将被清除。

#### 永久设置（不同操作系统）

**Linux和MacOS**：
可以将环境变量的设置添加到`.bashrc`或`.zshrc`文件中（根据使用的Shell）。例如，打开`.bashrc`文件并添加以下行：

```bash
export MY_VARIABLE="some_value"
```

保存文件后，在终端中执行以下命令使设置生效：

```bash
source ~/.bashrc
```

**Windows**：
1. 右键点击“此电脑”，选择“属性”。
2. 点击“高级系统设置”。
3. 在“系统属性”窗口中，点击“环境变量”按钮。
4. 在“用户变量”或“系统变量”区域（根据需要）中，点击“新建”按钮。
5. 输入变量名和变量值，然后点击“确定”保存设置。

## 常见实践

### 配置数据库连接
在开发Web应用程序时，我们通常需要连接到数据库。通过使用环境变量，我们可以轻松配置不同环境下的数据库连接信息。以下是一个使用`Flask`框架和`SQLAlchemy`库连接数据库的示例：

```python
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# 从环境变量中获取数据库连接字符串
db_uri = os.getenv('DATABASE_URI')
app.config['SQLALCHEMY_DATABASE_URI'] = db_uri

db = SQLAlchemy(app)

# 其他应用逻辑代码
```

在不同的环境中，我们只需要设置`DATABASE_URI`环境变量为相应的数据库连接字符串，就可以轻松切换数据库。

### 管理API密钥
许多API服务要求我们提供API密钥来进行身份验证。为了安全起见，我们不应该将API密钥硬编码在代码中，而是使用环境变量来管理它们。例如，使用`Google Maps API`的示例：

```python
import googlemaps
import os

# 从环境变量中获取Google Maps API密钥
gmaps_api_key = os.getenv('GOOGLE_MAPS_API_KEY')
gmaps = googlemaps.Client(key=gmaps_api_key)

# 使用Google Maps API进行地理编码
geocode_result = gmaps.geocode('1600 Amphitheatre Parkway, Mountain View, CA')
print(geocode_result)
```

## 最佳实践

### 安全性
- **敏感信息保护**：永远不要将敏感信息（如API密钥、数据库密码）硬编码在代码中。始终使用环境变量来存储这些信息，并确保环境变量的设置在服务器上是安全的。
- **避免泄露**：在部署应用程序时，要注意避免在日志或错误信息中意外泄露环境变量的值。

### 可维护性
- **命名规范**：为环境变量使用有意义且一致的命名规范。例如，使用全大写字母和下划线分隔单词，如`DATABASE_URI`、`API_KEY`。
- **集中管理**：在大型项目中，可以考虑使用配置文件（如`.env`文件）来集中管理环境变量。可以使用`python-dotenv`库来加载`.env`文件中的环境变量。

### 跨环境兼容性
- **测试环境**：确保在开发、测试和生产环境中都能正确设置和使用环境变量。可以编写测试脚本来验证环境变量的正确性。
- **文档记录**：在项目文档中明确记录需要设置的环境变量及其作用，以便其他开发人员和运维人员能够轻松理解和配置。

## 小结
Python环境变量为我们提供了一种灵活、安全且可维护的方式来管理应用程序的配置信息。通过掌握环境变量的基础概念、使用方法、常见实践和最佳实践，我们可以提高代码的质量和可移植性，确保应用程序在不同环境中稳定运行。希望本文能够帮助读者更好地理解和使用Python环境变量，在开发过程中更加高效地管理应用程序的配置。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [python-dotenv库文档](https://pypi.org/project/python-dotenv/){: rel="nofollow"}
- [Flask官方文档](https://flask.palletsprojects.com/){: rel="nofollow"}
- [SQLAlchemy官方文档](https://www.sqlalchemy.org/){: rel="nofollow"}
- [Google Maps API文档](https://developers.google.com/maps/documentation){: rel="nofollow"}
---
title: "用 Python 脚本保存 Windows 系统 Chrome 浏览器书签"
description: "在日常使用浏览器的过程中，书签是我们快速访问常用网站的重要工具。然而，随着时间推移，书签数量增多，可能会面临丢失或损坏的风险。编写 Python 脚本来保存 Chrome 浏览器书签，能帮助我们定期备份书签数据，确保重要链接的安全性和可访问性。本文将详细介绍如何编写这样的 Python 脚本，涵盖基础概念、使用方法、常见实践以及最佳实践等方面。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在日常使用浏览器的过程中，书签是我们快速访问常用网站的重要工具。然而，随着时间推移，书签数量增多，可能会面临丢失或损坏的风险。编写 Python 脚本来保存 Chrome 浏览器书签，能帮助我们定期备份书签数据，确保重要链接的安全性和可访问性。本文将详细介绍如何编写这样的 Python 脚本，涵盖基础概念、使用方法、常见实践以及最佳实践等方面。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **安装必要库**
    - **编写 Python 脚本**
3. **常见实践**
    - **定期备份**
    - **与云存储结合**
4. **最佳实践**
    - **错误处理**
    - **数据加密**
5. **小结**
6. **参考资料**

## 基础概念
Chrome 浏览器将书签数据存储在一个 SQLite 数据库文件中，该文件位于用户的本地配置文件夹下。Python 作为一种强大的编程语言，拥有丰富的库来处理文件读取、数据库操作等任务。我们可以利用这些库读取 Chrome 书签数据库文件，提取其中的书签信息，并将其保存为更易管理的格式，比如 JSON 文件。

## 使用方法
### 安装必要库
在编写脚本之前，需要安装一些必要的库。对于处理 SQLite 数据库，我们使用 `sqlite3` 库，它是 Python 标准库的一部分，无需额外安装。另外，为了方便处理 JSON 格式的数据，我们使用 `json` 库，同样也是标准库的一部分。

### 编写 Python 脚本
以下是一个简单的 Python 脚本示例，用于读取 Chrome 书签数据库并将书签信息保存为 JSON 文件：

```python
import sqlite3
import json
import os
from datetime import datetime


def get_chrome_bookmarks():
    # Chrome 书签数据库文件路径
    chrome_path = os.path.expanduser('~') + r'\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'

    # 连接到 SQLite 数据库
    conn = sqlite3.connect(chrome_path)
    cursor = conn.cursor()

    # 查询书签数据
    cursor.execute("SELECT * FROM bookmarks")
    bookmarks = cursor.fetchall()

    conn.close()

    # 处理书签数据，转换为 JSON 格式
    bookmarks_list = []
    for bookmark in bookmarks:
        bookmark_dict = {
            'id': bookmark[0],
            'name': bookmark[1],
            'url': bookmark[2],
            'parent_id': bookmark[3],
            'position': bookmark[4],
            'date_added': datetime.fromtimestamp(bookmark[5] / 1000000).strftime('%Y-%m-%d %H:%M:%S'),
            'date_modified': datetime.fromtimestamp(bookmark[6] / 1000000).strftime('%Y-%m-%d %H:%M:%S')
        }
        bookmarks_list.append(bookmark_dict)

    return bookmarks_list


def save_bookmarks_to_json(bookmarks, file_path):
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(bookmarks, f, ensure_ascii=False, indent=4)


if __name__ == "__main__":
    bookmarks = get_chrome_bookmarks()
    save_bookmarks_to_json(bookmarks, 'chrome_bookmarks.json')
```

### 代码解释
1. **`get_chrome_bookmarks` 函数**：
    - 首先定义 Chrome 书签数据库文件的路径。
    - 使用 `sqlite3.connect` 连接到数据库。
    - 执行 SQL 查询获取所有书签数据。
    - 关闭数据库连接后，将获取到的数据处理成字典形式，并将所有书签字典添加到列表中返回。

2. **`save_bookmarks_to_json` 函数**：
    - 接受书签列表和保存的文件路径作为参数。
    - 使用 `json.dump` 将书签列表写入指定的 JSON 文件，设置 `ensure_ascii=False` 以正确处理非 ASCII 字符，`indent=4` 使 JSON 文件格式更易读。

3. **主程序部分**：
    - 调用 `get_chrome_bookmarks` 函数获取书签数据。
    - 调用 `save_bookmarks_to_json` 函数将书签数据保存为 `chrome_bookmarks.json` 文件。

## 常见实践
### 定期备份
为了确保书签数据的安全性，我们可以使用 Python 的 `schedule` 库来实现定期备份。以下是修改后的代码示例：

```python
import sqlite3
import json
import os
from datetime import datetime
import schedule
import time


def get_chrome_bookmarks():
    # Chrome 书签数据库文件路径
    chrome_path = os.path.expanduser('~') + r'\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'

    # 连接到 SQLite 数据库
    conn = sqlite3.connect(chrome_path)
    cursor = conn.cursor()

    # 查询书签数据
    cursor.execute("SELECT * FROM bookmarks")
    bookmarks = cursor.fetchall()

    conn.close()

    # 处理书签数据，转换为 JSON 格式
    bookmarks_list = []
    for bookmark in bookmarks:
        bookmark_dict = {
            'id': bookmark[0],
            'name': bookmark[1],
            'url': bookmark[2],
            'parent_id': bookmark[3],
            'position': bookmark[4],
            'date_added': datetime.fromtimestamp(bookmark[5] / 1000000).strftime('%Y-%m-%d %H:%M:%S'),
            'date_modified': datetime.fromtimestamp(bookmark[6] / 1000000).strftime('%Y-%m-%d %H:%M:%S')
        }
        bookmarks_list.append(bookmark_dict)

    return bookmarks_list


def save_bookmarks_to_json(bookmarks, file_path):
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(bookmarks, f, ensure_ascii=False, indent=4)


def backup_chrome_bookmarks():
    bookmarks = get_chrome_bookmarks()
    save_bookmarks_to_json(bookmarks, f'chrome_bookmarks_{datetime.now().strftime("%Y%m%d_%H%M%S")}.json')


if __name__ == "__main__":
    # 每天凌晨 2 点执行备份任务
    schedule.every().day.at("02:00").do(backup_chrome_bookmarks)

    while True:
        schedule.run_pending()
        time.sleep(1)
```

### 与云存储结合
可以将备份的 JSON 文件上传到云存储服务，如 Google Drive 或 Dropbox。以 Google Drive 为例，使用 `pydrive` 库来实现文件上传：

```python
from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive
import sqlite3
import json
import os
from datetime import datetime


def get_chrome_bookmarks():
    # Chrome 书签数据库文件路径
    chrome_path = os.path.expanduser('~') + r'\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'

    # 连接到 SQLite 数据库
    conn = sqlite3.connect(chrome_path)
    cursor = conn.cursor()

    # 查询书签数据
    cursor.execute("SELECT * FROM bookmarks")
    bookmarks = cursor.fetchall()

    conn.close()

    # 处理书签数据，转换为 JSON 格式
    bookmarks_list = []
    for bookmark in bookmarks:
        bookmark_dict = {
            'id': bookmark[0],
            'name': bookmark[1],
            'url': bookmark[2],
            'parent_id': bookmark[3],
            'position': bookmark[4],
            'date_added': datetime.fromtimestamp(bookmark[5] / 1000000).strftime('%Y-%m-%d %H:%M:%S'),
            'date_modified': datetime.fromtimestamp(bookmark[6] / 1000000).strftime('%Y-%m-%d %H:%M:%S')
        }
        bookmarks_list.append(bookmark_dict)

    return bookmarks_list


def save_bookmarks_to_json(bookmarks, file_path):
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(bookmarks, f, ensure_ascii=False, indent=4)


def backup_chrome_bookmarks_to_gdrive():
    bookmarks = get_chrome_bookmarks()
    file_name = f'chrome_bookmarks_{datetime.now().strftime("%Y%m%d_%H%M%S")}.json'
    save_bookmarks_to_json(bookmarks, file_name)

    gauth = GoogleAuth()
    gauth.LocalWebserverAuth()
    drive = GoogleDrive(gauth)

    file_drive = drive.CreateFile({'title': file_name})
    file_drive.SetContentFile(file_name)
    file_drive.Upload()


if __name__ == "__main__":
    backup_chrome_bookmarks_to_gdrive()
```

## 最佳实践
### 错误处理
在读取数据库和保存文件的过程中，可能会出现各种错误。因此，需要添加适当的错误处理代码，以提高脚本的稳定性。以下是添加错误处理后的代码示例：

```python
import sqlite3
import json
import os
from datetime import datetime


def get_chrome_bookmarks():
    # Chrome 书签数据库文件路径
    chrome_path = os.path.expanduser('~') + r'\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'

    try:
        # 连接到 SQLite 数据库
        conn = sqlite3.connect(chrome_path)
        cursor = conn.cursor()

        # 查询书签数据
        cursor.execute("SELECT * FROM bookmarks")
        bookmarks = cursor.fetchall()

        conn.close()

        # 处理书签数据，转换为 JSON 格式
        bookmarks_list = []
        for bookmark in bookmarks:
            bookmark_dict = {
                'id': bookmark[0],
                'name': bookmark[1],
                'url': bookmark[2],
                'parent_id': bookmark[3],
                'position': bookmark[4],
                'date_added': datetime.fromtimestamp(bookmark[5] / 1000000).strftime('%Y-%m-%d %H:%M:%S'),
                'date_modified': datetime.fromtimestamp(bookmark[6] / 1000000).strftime('%Y-%m-%d %H:%M:%S')
            }
            bookmarks_list.append(bookmark_dict)

        return bookmarks_list
    except sqlite3.Error as e:
        print(f"SQLite 错误: {e}")
        return []


def save_bookmarks_to_json(bookmarks, file_path):
    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(bookmarks, f, ensure_ascii=False, indent=4)
    except IOError as e:
        print(f"文件操作错误: {e}")


if __name__ == "__main__":
    bookmarks = get_chrome_bookmarks()
    save_bookmarks_to_json(bookmarks, 'chrome_bookmarks.json')
```

### 数据加密
书签数据可能包含一些敏感信息，为了保护数据安全，可以对保存的 JSON 文件进行加密。使用 `cryptography` 库来实现简单的加密功能：

```python
from cryptography.fernet import Fernet
import sqlite3
import json
import os
from datetime import datetime


def get_chrome_bookmarks():
    # Chrome 书签数据库文件路径
    chrome_path = os.path.expanduser('~') + r'\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'

    try:
        # 连接到 SQLite 数据库
        conn = sqlite3.connect(chrome_path)
        cursor = conn.cursor()

        # 查询书签数据
        cursor.execute("SELECT * FROM bookmarks")
        bookmarks = cursor.fetchall()

        conn.close()

        # 处理书签数据，转换为 JSON 格式
        bookmarks_list = []
        for bookmark in bookmarks:
            bookmark_dict = {
                'id': bookmark[0],
                'name': bookmark[1],
                'url': bookmark[2],
                'parent_id': bookmark[3],
                'position': bookmark[4],
                'date_added': datetime.fromtimestamp(bookmark[5] / 1000000).strftime('%Y-%m-%d %H:%M:%S'),
                'date_modified': datetime.fromtimestamp(bookmark[6] / 1000000).strftime('%Y-%m-%d %H:%M:%S')
            }
            bookmarks_list.append(bookmark_dict)

        return bookmarks_list
    except sqlite3.Error as e:
        print(f"SQLite 错误: {e}")
        return []


def save_bookmarks_to_json(bookmarks, file_path):
    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(bookmarks, f, ensure_ascii=False, indent=4)
    except IOError as e:
        print(f"文件操作错误: {e}")


def encrypt_file(file_path, key):
    f = Fernet(key)
    with open(file_path, 'rb') as original_file:
        original = original_file.read()

    encrypted = f.encrypt(original)

    with open(file_path, 'wb') as encrypted_file:
        encrypted_file.write(encrypted)


if __name__ == "__main__":
    bookmarks = get_chrome_bookmarks()
    save_bookmarks_to_json(bookmarks, 'chrome_bookmarks.json')

    key = Fernet.generate_key()
    encrypt_file('chrome_bookmarks.json', key)
```

## 小结
通过编写 Python 脚本来保存 Windows 系统 Chrome 浏览器书签，我们可以实现书签数据的备份、管理和保护。本文介绍了从基础概念到实际应用的各个方面，包括使用方法、常见实践以及最佳实践。通过定期备份和数据加密等措施，可以确保书签数据的安全性和可靠性。希望这些内容能帮助读者更好地管理自己的浏览器书签数据。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- [sqlite3 模块文档](https://docs.python.org/3/library/sqlite3.html){: rel="nofollow"}
- [json 模块文档](https://docs.python.org/3/library/json.html){: rel="nofollow"}
- [pydrive 文档](https://pythonhosted.org/PyDrive/){: rel="nofollow"}
- [cryptography 文档](https://cryptography.io/en/latest/){: rel="nofollow"}
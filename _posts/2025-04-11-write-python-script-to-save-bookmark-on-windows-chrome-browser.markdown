---
title: "用Python脚本保存Windows Chrome浏览器书签"
description: "在日常使用电脑的过程中，Chrome浏览器的书签是我们快速访问常用网站的重要工具。然而，书签数据可能因为各种原因丢失，例如浏览器更新、系统故障等。编写Python脚本来保存Chrome浏览器书签，能够让我们定期备份书签数据，避免丢失带来的不便。本文将详细介绍如何编写这样的Python脚本，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在日常使用电脑的过程中，Chrome浏览器的书签是我们快速访问常用网站的重要工具。然而，书签数据可能因为各种原因丢失，例如浏览器更新、系统故障等。编写Python脚本来保存Chrome浏览器书签，能够让我们定期备份书签数据，避免丢失带来的不便。本文将详细介绍如何编写这样的Python脚本，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **安装必要的库**
    - **编写Python脚本**
3. **常见实践**
    - **定期备份书签**
    - **将书签保存为不同格式**
4. **最佳实践**
    - **错误处理**
    - **代码优化**
5. **小结**
6. **参考资料**

## 基础概念
Chrome浏览器将书签数据存储在一个名为`Bookmarks`的JSON格式文件中。这个文件位于用户的Chrome配置文件夹内。在Windows系统中，路径通常类似于`C:\Users\[用户名]\AppData\Local\Google\Chrome\User Data\Default\Bookmarks`。JSON（JavaScript Object Notation）是一种轻量级的数据交换格式，易于阅读和编写，也便于机器解析和生成。Python有内置的`json`库，可以方便地处理JSON数据。我们的目标就是读取这个`Bookmarks`文件中的数据，并进行必要的处理和保存。

## 使用方法

### 安装必要的库
在编写脚本之前，我们需要安装`json`库。在Python中，`json`库是内置库，无需额外安装。如果我们想对书签数据进行更复杂的处理，例如将书签转换为HTML格式，可能需要安装`html`库（同样是内置库）。

### 编写Python脚本
以下是一个简单的Python脚本，用于读取Chrome浏览器的书签并保存为一个新的JSON文件：

```python
import json


def save_chrome_bookmarks():
    # Chrome书签文件路径
    bookmarks_path = r'C:\Users\[用户名]\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'

    try:
        with open(bookmarks_path, 'r', encoding='utf-8') as f:
            bookmarks_data = json.load(f)

        # 保存书签数据到新文件
        new_bookmarks_file = 'backup_bookmarks.json'
        with open(new_bookmarks_file, 'w', encoding='utf-8') as f:
            json.dump(bookmarks_data, f, ensure_ascii=False, indent=4)

        print(f'书签已成功保存到 {new_bookmarks_file}')
    except FileNotFoundError:
        print('未找到Chrome书签文件')
    except json.JSONDecodeError:
        print('无法解析书签文件中的JSON数据')


if __name__ == "__main__":
    save_chrome_bookmarks()
```

### 代码解释
1. **导入必要的库**：`import json`导入了处理JSON数据的库。
2. **定义函数**：`save_chrome_bookmarks`函数负责读取和保存书签数据。
3. **设置书签文件路径**：`bookmarks_path`变量设置为Chrome书签文件的实际路径，需要将`[用户名]`替换为你自己的Windows用户名。
4. **读取书签数据**：使用`open`函数以读取模式打开书签文件，并使用`json.load`将JSON数据加载到`bookmarks_data`变量中。
5. **保存书签数据**：使用`open`函数以写入模式打开一个新文件`backup_bookmarks.json`，并使用`json.dump`将书签数据保存到新文件中。`ensure_ascii=False`确保非ASCII字符正确显示，`indent=4`使保存的JSON文件格式更美观。
6. **错误处理**：使用`try - except`块捕获可能的错误，如文件未找到或JSON解析错误，并打印相应的错误信息。

## 常见实践

### 定期备份书签
为了确保书签数据的安全性，我们可以使用Python的`schedule`库来定期运行保存书签的脚本。首先，安装`schedule`库：
```bash
pip install schedule
```

以下是修改后的脚本，实现每天凌晨2点自动备份书签：

```python
import json
import schedule
import time


def save_chrome_bookmarks():
    bookmarks_path = r'C:\Users\[用户名]\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'
    try:
        with open(bookmarks_path, 'r', encoding='utf-8') as f:
            bookmarks_data = json.load(f)

        new_bookmarks_file = 'backup_bookmarks.json'
        with open(new_bookmarks_file, 'w', encoding='utf-8') as f:
            json.dump(bookmarks_data, f, ensure_ascii=False, indent=4)

        print(f'书签已成功保存到 {new_bookmarks_file}')
    except FileNotFoundError:
        print('未找到Chrome书签文件')
    except json.JSONDecodeError:
        print('无法解析书签文件中的JSON数据')


# 每天凌晨2点执行备份任务
schedule.every().day.at("02:00").do(save_chrome_bookmarks)

while True:
    schedule.run_pending()
    time.sleep(1)
```

### 将书签保存为不同格式
除了JSON格式，我们还可以将书签转换为HTML格式，以便在浏览器中直接查看。以下是一个示例脚本，将书签转换为HTML格式并保存：

```python
import json


def save_bookmarks_as_html():
    bookmarks_path = r'C:\Users\[用户名]\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'
    try:
        with open(bookmarks_path, 'r', encoding='utf-8') as f:
            bookmarks_data = json.load(f)

        html_content = '<html><head><title>Chrome Bookmarks</title></head><body>'

        def process_bookmark_folder(folder):
            nonlocal html_content
            if 'children' in folder:
                html_content += f'<h2>{folder["name"]}</h2>'
                html_content += '<ul>'
                for child in folder['children']:
                    if 'url' in child:
                        html_content += f'<li><a href="{child["url"]}">{child["name"]}</a></li>'
                    elif 'children' in child:
                        process_bookmark_folder(child)
                html_content += '</ul>'

        process_bookmark_folder(bookmarks_data['roots']['bookmark_bar'])
        html_content += '</body></html>'

        with open('bookmarks.html', 'w', encoding='utf-8') as f:
            f.write(html_content)

        print('书签已成功保存为bookmarks.html')
    except FileNotFoundError:
        print('未找到Chrome书签文件')
    except json.JSONDecodeError:
        print('无法解析书签文件中的JSON数据')


if __name__ == "__main__":
    save_bookmarks_as_html()
```

## 最佳实践

### 错误处理
在实际应用中，除了处理文件未找到和JSON解析错误，还可以处理其他可能的异常情况，例如权限不足导致无法读取或写入文件。可以在`try - except`块中添加更多的异常处理：

```python
import json


def save_chrome_bookmarks():
    bookmarks_path = r'C:\Users\[用户名]\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'
    try:
        with open(bookmarks_path, 'r', encoding='utf-8') as f:
            bookmarks_data = json.load(f)

        new_bookmarks_file = 'backup_bookmarks.json'
        with open(new_bookmarks_file, 'w', encoding='utf-8') as f:
            json.dump(bookmarks_data, f, ensure_ascii=False, indent=4)

        print(f'书签已成功保存到 {new_bookmarks_file}')
    except FileNotFoundError:
        print('未找到Chrome书签文件')
    except json.JSONDecodeError:
        print('无法解析书签文件中的JSON数据')
    except PermissionError:
        print('权限不足，无法读取或写入文件')


if __name__ == "__main__":
    save_chrome_bookmarks()
```

### 代码优化
为了提高代码的可读性和可维护性，可以将一些功能封装成独立的函数。例如，读取书签文件和保存书签数据可以分别封装成两个函数：

```python
import json


def read_chrome_bookmarks():
    bookmarks_path = r'C:\Users\[用户名]\AppData\Local\Google\Chrome\User Data\Default\Bookmarks'
    try:
        with open(bookmarks_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except FileNotFoundError:
        print('未找到Chrome书签文件')
    except json.JSONDecodeError:
        print('无法解析书签文件中的JSON数据')
    except PermissionError:
        print('权限不足，无法读取文件')
    return None


def save_bookmarks(bookmarks_data, output_file):
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(bookmarks_data, f, ensure_ascii=False, indent=4)
        print(f'书签已成功保存到 {output_file}')
    except PermissionError:
        print('权限不足，无法写入文件')


def save_chrome_bookmarks():
    bookmarks_data = read_chrome_bookmarks()
    if bookmarks_data:
        new_bookmarks_file = 'backup_bookmarks.json'
        save_bookmarks(bookmarks_data, new_bookmarks_file)


if __name__ == "__main__":
    save_chrome_bookmarks()
```

## 小结
通过编写Python脚本来保存Chrome浏览器书签，我们能够更好地管理和保护书签数据。本文介绍了相关的基础概念，详细说明了使用方法，包括安装必要的库和编写脚本。同时，列举了常见实践，如定期备份和转换为不同格式，以及最佳实践，如错误处理和代码优化。希望这些内容能帮助读者更好地理解和应用这一技术，确保自己的书签数据安全。

## 参考资料
- [Python官方文档 - json库](https://docs.python.org/3/library/json.html){: rel="nofollow"}
- [schedule库官方文档](https://schedule.readthedocs.io/en/stable/){: rel="nofollow"}
- [Chrome浏览器书签文件结构](https://www.chromium.org/user-experience/bookmarks){: rel="nofollow"}
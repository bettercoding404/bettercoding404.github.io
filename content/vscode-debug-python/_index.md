---
title: "VSCode Debug Python：从入门到精通"
description: "在Python开发过程中，调试是必不可少的环节。Visual Studio Code（简称VSCode）作为一款流行的代码编辑器，提供了强大的调试功能，能帮助开发者快速定位和解决代码中的问题。本文将深入介绍VSCode中调试Python代码的相关知识，帮助你提升开发效率。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python开发过程中，调试是必不可少的环节。Visual Studio Code（简称VSCode）作为一款流行的代码编辑器，提供了强大的调试功能，能帮助开发者快速定位和解决代码中的问题。本文将深入介绍VSCode中调试Python代码的相关知识，帮助你提升开发效率。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 安装Python扩展
    - 配置调试环境
    - 启动调试
3. **常见实践**
    - 断点调试
    - 查看变量值
    - 单步调试
4. **最佳实践**
    - 条件断点
    - 调试多文件项目
    - 远程调试
5. **小结**
6. **参考资料**

## 基础概念
调试是指在程序运行过程中，通过各种手段检查程序的执行状态和变量的值，以发现并修复程序中的错误。VSCode的调试功能通过调试器实现，调试器可以暂停程序的执行，让开发者查看当前的变量值、调用栈等信息。

## 使用方法
### 安装Python扩展
打开VSCode，点击左侧的扩展图标（或使用快捷键Ctrl+Shift+X），在搜索框中输入“Python”，选择“Python”扩展并点击安装。安装完成后，重启VSCode。

### 配置调试环境
1. 创建一个Python项目目录，例如`my_project`。
2. 在该目录下创建一个Python文件，例如`main.py`，内容如下：
```python
def add_numbers(a, b):
    result = a + b
    return result


num1 = 5
num2 = 3
result = add_numbers(num1, num2)
print(f"The result of adding {num1} and {num2} is {result}")
```
3. 点击VSCode界面左侧的调试图标（或使用快捷键Ctrl+Shift+D），如果是第一次调试，会提示“创建launch.json文件”。选择“Python文件”作为调试配置模板。VSCode会在项目目录下生成一个`.vscode`文件夹，并在其中创建`launch.json`文件。

### 启动调试
1. 在`main.py`文件中，点击代码行号旁边的空白处，设置一个断点（会出现一个红点）。例如，在`result = a + b`这一行设置断点。
2. 点击调试界面中的绿色三角形“开始调试”按钮（或使用快捷键F5），程序会运行到设置的断点处暂停。

## 常见实践
### 断点调试
断点是调试过程中最常用的工具。在代码中设置断点后，程序运行到该断点时会暂停执行，此时可以查看变量的值、调用栈等信息。例如，在上述`main.py`中设置断点后，程序暂停时，将鼠标悬停在变量`a`、`b`、`result`上，即可查看它们当前的值。

### 查看变量值
除了在断点处悬停鼠标查看变量值外，还可以在调试界面的“变量”面板中查看所有变量及其值。该面板会实时更新变量的值，方便开发者观察变量在程序执行过程中的变化。

### 单步调试
单步调试可以让程序逐行执行，方便开发者观察每一行代码的执行效果。在调试暂停时，可以使用调试工具栏中的“单步跳过”（F10）、“单步进入”（F11）和“单步跳出”（Shift+F11）按钮进行单步调试。
 - “单步跳过”：执行当前行代码，并停在下一行。
 - “单步进入”：如果当前行调用了函数，会进入函数内部继续执行。
 - “单步跳出”：从当前函数中跳出，返回调用该函数的地方。

## 最佳实践
### 条件断点
有时候，我们只想在特定条件下暂停程序。例如，在循环中，只想在某个变量满足特定值时暂停。可以在断点红点上右键点击，选择“编辑断点”，在弹出的对话框中设置条件。例如，在一个循环中，我们只想在`i`等于10时暂停：
```python
for i in range(20):
    # 设置条件断点，条件为 i == 10
    result = i * 2
    print(result)
```
### 调试多文件项目
对于多文件的Python项目，调试过程类似，但需要注意调试配置。在`launch.json`文件中，可以通过修改`program`字段来指定要调试的主文件路径。例如，项目结构如下：
```
my_project/
    ├── main.py
    └── utils.py
```
如果`main.py`中调用了`utils.py`中的函数，在`launch.json`中确保`program`字段指向`main.py`的路径：
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: 当前文件",
            "type": "python",
            "request": "launch",
            "program": "${workspaceFolder}/main.py",
            "console": "integratedTerminal"
        }
    ]
}
```
### 远程调试
如果需要在远程服务器上调试Python代码，可以使用VSCode的远程调试功能。首先，在远程服务器上安装`ptvsd`库：
```bash
pip install ptvsd
```
然后，在Python代码中添加以下代码，启动远程调试服务器：
```python
import ptvsd

ptvsd.enable_attach(address=('0.0.0.0', 5678))
ptvsd.wait_for_attach()
```
在VSCode中，安装“Remote - SSH”扩展，连接到远程服务器。接着，配置调试环境，在`launch.json`中添加如下配置：
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: 远程调试",
            "type": "python",
            "request": "attach",
            "port": 5678,
            "host": "localhost",
            "pathMappings": [
                {
                    "localRoot": "${workspaceFolder}",
                    "remoteRoot": "/path/to/your/project/on/remote/server"
                }
            ]
        }
    ]
}
```
这样就可以在VSCode中远程调试服务器上的Python代码了。

## 小结
通过本文，我们全面了解了在VSCode中调试Python代码的方法，从基础概念到常见实践，再到最佳实践。掌握这些调试技巧，可以大大提高我们的开发效率，快速定位和解决代码中的问题。希望读者能够通过不断实践，熟练运用VSCode的调试功能，提升Python开发水平。

## 参考资料
- [Visual Studio Code官方文档](https://code.visualstudio.com/docs)
- [Python官方文档](https://docs.python.org/3/)
- [VSCode Python扩展文档](https://code.visualstudio.com/docs/languages/python)
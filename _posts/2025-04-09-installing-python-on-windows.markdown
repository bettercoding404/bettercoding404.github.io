---
title: "在 Windows 上安装 Python"
description: "Python 是一种广泛使用的高级编程语言，在数据科学、Web 开发、自动化脚本等众多领域都有出色表现。在 Windows 操作系统上安装 Python 是开启 Python 编程之旅的第一步。本文将详细介绍在 Windows 上安装 Python 的基础概念、具体使用方法、常见实践场景以及最佳实践，帮助读者顺利搭建起 Python 开发环境。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
Python 是一种广泛使用的高级编程语言，在数据科学、Web 开发、自动化脚本等众多领域都有出色表现。在 Windows 操作系统上安装 Python 是开启 Python 编程之旅的第一步。本文将详细介绍在 Windows 上安装 Python 的基础概念、具体使用方法、常见实践场景以及最佳实践，帮助读者顺利搭建起 Python 开发环境。

<!-- more -->
## 目录
1. **基础概念**
2. **安装步骤**
    - 下载 Python 安装包
    - 运行安装程序
    - 配置环境变量
3. **常见实践**
    - 使用命令行运行 Python 脚本
    - 安装第三方库
4. **最佳实践**
    - 虚拟环境的使用
    - 选择合适的 Python 版本
5. **小结**
6. **参考资料**

## 基础概念
Python 是一种开源、跨平台的编程语言，具有简洁易读的语法和丰富的库。在 Windows 上安装 Python 意味着将 Python 解释器以及相关的工具和库部署到 Windows 系统中，使得用户能够编写、运行 Python 代码。Python 解释器负责将人类编写的 Python 代码转换为计算机能够理解的机器语言并执行。

## 安装步骤

### 下载 Python 安装包
1. 打开浏览器，访问 Python 官方网站：[https://www.python.org/downloads/windows/](https://www.python.org/downloads/windows/)。
2. 在下载页面中，选择适合你 Windows 系统版本（32 位或 64 位）的 Python 安装包。通常建议下载最新稳定版本。

### 运行安装程序
1. 找到下载好的安装包文件，双击运行它。
2. 在安装向导中，勾选“Add Python to PATH”选项，这一步非常重要，它可以让系统自动将 Python 的安装路径添加到环境变量中，方便后续在命令行中直接使用 Python 命令。
3. 选择安装类型，一般推荐选择“Customize installation”（自定义安装），这样可以根据自己的需求选择安装的组件。
4. 在接下来的页面中，根据需要勾选相应的组件，然后点击“Install”按钮开始安装。

### 配置环境变量（若未勾选 Add Python to PATH）
1. 如果在安装过程中没有勾选“Add Python to PATH”，则需要手动配置环境变量。
2. 右键点击“此电脑”，选择“属性”。
3. 在弹出的窗口中，点击“高级系统设置”。
4. 在“系统属性”窗口中，点击“环境变量”按钮。
5. 在“系统变量”中找到“Path”变量，点击“编辑”。
6. 在“编辑环境变量”窗口中，点击“新建”，然后输入 Python 的安装路径（例如：C:\Python39），如果 Python 安装目录下的 Scripts 文件夹也需要添加到路径中，同样新建一行输入 C:\Python39\Scripts。
7. 点击“确定”保存设置。

## 常见实践

### 使用命令行运行 Python 脚本
1. 打开命令提示符（可以通过在开始菜单中搜索“命令提示符”打开）。
2. 输入“python”命令，进入 Python 交互环境。在交互环境中可以直接输入 Python 代码并执行，例如：
```python
print("Hello, World!")
```
3. 如果要运行一个 Python 脚本文件，先确保命令提示符的当前路径是脚本文件所在的目录。例如，你的脚本文件名为“test.py”，可以使用以下命令运行：
```bash
python test.py
```

### 安装第三方库
Python 的强大之处在于其丰富的第三方库。可以使用“pip”工具来安装第三方库。例如，要安装“numpy”库：
1. 打开命令提示符。
2. 输入以下命令：
```bash
pip install numpy
```
安装完成后，就可以在 Python 代码中导入并使用该库了，例如：
```python
import numpy as np
arr = np.array([1, 2, 3, 4])
print(arr)
```

## 最佳实践

### 虚拟环境的使用
虚拟环境可以为每个项目创建独立的 Python 环境，避免不同项目之间的依赖冲突。
1. 安装“venv”模块（Python 3.3 及以上版本自带）。
2. 创建虚拟环境。在命令提示符中，进入项目目录，然后输入以下命令创建名为“myenv”的虚拟环境：
```bash
python -m venv myenv
```
3. 激活虚拟环境：
    - 在 Windows 上，进入虚拟环境的 Scripts 目录，然后运行“activate”脚本：
```bash
myenv\Scripts\activate
```
4. 此时命令提示符的前缀会显示当前激活的虚拟环境名称。在虚拟环境中安装的第三方库只会在该环境中可用。当项目完成后，可以使用“deactivate”命令退出虚拟环境。

### 选择合适的 Python 版本
Python 有 2.x 和 3.x 两个大版本，目前 Python 2 已经停止维护，建议使用 Python 3。在选择具体的 Python 3 版本时，尽量选择最新稳定版本，以获取最新的功能和性能优化。同时，要注意某些第三方库可能对特定版本的 Python 有兼容性要求，在开发项目时需要根据实际情况进行选择。

## 小结
在 Windows 上安装 Python 并不复杂，通过正确下载安装包、合理配置环境变量，并掌握常见的使用方法和最佳实践，读者可以轻松搭建起高效的 Python 开发环境。虚拟环境的使用和合适 Python 版本的选择将有助于更好地管理项目依赖和确保代码的兼容性。希望本文能够帮助读者顺利开启 Python 编程之路。

## 参考资料
- Python 官方文档：[https://docs.python.org/3/](https://docs.python.org/3/){: rel="nofollow"}
- Python 官方 Windows 下载页面：[https://www.python.org/downloads/windows/](https://www.python.org/downloads/windows/){: rel="nofollow"}
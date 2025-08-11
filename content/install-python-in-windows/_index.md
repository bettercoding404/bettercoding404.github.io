---
title: "在 Windows 系统中安装 Python"
description: "Python 是一种广泛应用于各种领域的高级编程语言，如 Web 开发、数据分析、人工智能等。在 Windows 操作系统上安装 Python 是踏上 Python 编程之旅的第一步。本文将详细介绍在 Windows 系统中安装 Python 的基础概念、具体使用方法、常见实践以及最佳实践，帮助读者顺利完成安装并开启 Python 编程学习。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
Python 是一种广泛应用于各种领域的高级编程语言，如 Web 开发、数据分析、人工智能等。在 Windows 操作系统上安装 Python 是踏上 Python 编程之旅的第一步。本文将详细介绍在 Windows 系统中安装 Python 的基础概念、具体使用方法、常见实践以及最佳实践，帮助读者顺利完成安装并开启 Python 编程学习。

<!-- more -->
## 目录
1. **基础概念**
2. **安装步骤**
3. **常见实践**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
Python 有不同的版本，如 Python 2 和 Python 3，目前推荐使用 Python 3，因为 Python 2 已经停止更新维护。安装 Python 意味着将 Python 解释器以及相关的标准库安装到 Windows 系统中，以便系统能够识别和运行 Python 代码。

## 安装步骤

### 从官网下载安装包
1. 打开浏览器，访问 Python 官方网站 [https://www.python.org/downloads/windows/](https://www.python.org/downloads/windows/)。
2. 在下载页面中，选择适合你 Windows 系统版本（32 位或 64 位）的 Python 安装包进行下载。例如，如果你使用的是 64 位 Windows 系统，就下载 64 位的 Python 安装包。

### 运行安装程序
1. 找到下载好的安装包，双击运行它。
2. 在安装向导界面，确保勾选“Add Python to PATH”选项，这一步非常重要，它会将 Python 的安装路径添加到系统的环境变量中，这样在命令行中就可以直接访问 Python 命令。
3. 点击“Install Now”进行默认安装，或者点击“Customize installation”进行自定义安装，可根据个人需求选择安装组件等。

### 验证安装是否成功
1. 打开命令提示符（可以通过在开始菜单中搜索“命令提示符”找到）。
2. 在命令提示符中输入 `python --version`，如果安装成功，会显示你安装的 Python 版本号，例如 `Python 3.9.6`。

### 设置环境变量（可选，若未勾选 Add Python to PATH）
1. 右键点击“此电脑”，选择“属性”。
2. 在弹出的窗口中点击“高级系统设置”。
3. 在“系统属性”窗口中，点击“环境变量”按钮。
4. 在“系统变量”中找到“Path”变量，点击“编辑”。
5. 点击“新建”，将 Python 的安装路径（例如 `C:\Python39`）添加进去，然后点击“确定”保存设置。

## 常见实践

### 使用命令行运行 Python 代码
1. 打开命令提示符。
2. 输入 `python` 进入 Python 交互式环境，在这个环境中可以直接输入 Python 代码并执行。例如：
```python
print("Hello, World!")
```
输入上述代码后，会在命令行中输出 `Hello, World!`。
3. 若要运行一个 Python 脚本文件，先将命令提示符切换到脚本文件所在的目录。例如，你的 Python 脚本 `test.py` 存放在 `C:\Users\YourName\Documents` 目录下，在命令提示符中输入 `cd C:\Users\YourName\Documents`，然后输入 `python test.py` 即可运行该脚本。

### 使用 Python 包管理工具 pip
pip 是 Python 的标准包管理工具，用于安装、升级和卸载 Python 包。
1. 安装包：在命令提示符中输入 `pip install package_name`，例如 `pip install numpy` 可以安装 numpy 这个常用的数值计算库。
2. 升级包：使用 `pip install --upgrade package_name` 命令，如 `pip install --upgrade requests` 可升级 requests 库。
3. 卸载包：输入 `pip uninstall package_name` 即可，比如 `pip uninstall pandas` 可卸载 pandas 库。

## 最佳实践

### 安装虚拟环境工具 venv
虚拟环境可以让你在不同的项目中独立管理 Python 包的版本，避免包版本冲突。
1. 打开命令提示符，切换到你想要创建虚拟环境的目录，例如 `cd C:\Projects\my_project`。
2. 输入 `python -m venv myenv`，这会在当前目录下创建一个名为 `myenv` 的虚拟环境。
3. 激活虚拟环境：在 Windows 系统中，进入 `myenv\Scripts` 目录，然后运行 `activate` 命令。激活后，命令提示符的开头会显示虚拟环境的名称，例如 `(myenv) C:\Projects\my_project>`。
4. 在虚拟环境中安装包就不会影响系统全局的 Python 包环境。当项目结束后，在命令提示符中输入 `deactivate` 即可退出虚拟环境。

### 选择合适的 Python IDE
安装好 Python 后，选择一个适合的集成开发环境（IDE）可以提高开发效率。常见的 Python IDE 有 PyCharm、Visual Studio Code 等。
1. **PyCharm**：功能强大，适合专业的 Python 开发人员。在 JetBrains 官网下载安装包进行安装，安装过程中可以选择关联已安装的 Python 解释器。
2. **Visual Studio Code**：轻量级且高度可定制，通过安装 Python 扩展来支持 Python 开发。在官网下载安装 Visual Studio Code，然后在扩展商店中搜索并安装“Python”扩展。

## 小结
在 Windows 系统中安装 Python 是一个相对简单的过程，但需要注意一些关键步骤，如添加 Python 到系统路径、选择合适的版本和安装方式等。通过掌握常见实践和最佳实践，如使用命令行运行代码、管理 Python 包以及创建虚拟环境等，能够为后续的 Python 编程学习和项目开发打下坚实的基础。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/)
- [Python Windows 安装指南](https://www.python.org/downloads/windows/)
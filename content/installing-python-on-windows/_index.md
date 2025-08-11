---
title: "在 Windows 上安装 Python"
description: "Python 是一种广泛使用的高级编程语言，在数据科学、Web 开发、自动化脚本等众多领域都有出色表现。在 Windows 操作系统上安装 Python 是开启 Python 编程之旅的第一步。本博客将详细介绍在 Windows 上安装 Python 的相关知识，帮助读者顺利搭建开发环境。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
Python 是一种广泛使用的高级编程语言，在数据科学、Web 开发、自动化脚本等众多领域都有出色表现。在 Windows 操作系统上安装 Python 是开启 Python 编程之旅的第一步。本博客将详细介绍在 Windows 上安装 Python 的相关知识，帮助读者顺利搭建开发环境。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 通过官网安装
    - 使用包管理器安装
3. 常见实践
    - 配置环境变量
    - 验证安装
4. 最佳实践
    - 选择合适的 Python 版本
    - 管理虚拟环境
5. 小结
6. 参考资料

## 基础概念
Python 有不同的版本，如 Python 2 和 Python 3。Python 2 逐渐不再维护，目前推荐使用 Python 3。安装 Python 意味着将 Python 解释器以及相关的标准库和工具安装到 Windows 系统中，以便能够运行 Python 代码。

## 使用方法

### 通过官网安装
1. **下载安装包**
   - 打开浏览器，访问 Python 官方网站（https://www.python.org/downloads/windows/）。
   - 根据你的 Windows 系统版本（32 位或 64 位）选择合适的 Python 安装包。例如，对于 64 位 Windows 系统，选择带有 “x86-64” 的安装文件。
2. **运行安装程序**
   - 双击下载的安装包，在安装向导中，确保勾选 “Add Python to PATH” 选项（这一步很重要，它会自动将 Python 添加到系统环境变量中，方便后续在命令行中使用 Python）。
   - 点击 “Install Now” 进行默认安装，或者点击 “Customize installation” 进行自定义安装，可选择安装路径等。

### 使用包管理器安装
**使用 Chocolatey（一种 Windows 包管理器）**
1. **安装 Chocolatey**
   - 以管理员身份打开 PowerShell。
   - 运行以下命令安装 Chocolatey：
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
2. **使用 Chocolatey 安装 Python**
   - 在 PowerShell 中运行以下命令安装 Python：
```powershell
chocolatey install python
```

## 常见实践

### 配置环境变量
如果在安装过程中没有勾选 “Add Python to PATH”，则需要手动配置环境变量。
1. **打开系统属性**：右键点击 “此电脑”，选择 “属性”，然后点击 “高级系统设置”。
2. **配置环境变量**：在 “系统属性” 窗口中，点击 “环境变量”。在 “系统变量” 中找到 “Path” 变量，点击 “编辑”。
3. **添加 Python 路径**：点击 “新建”，添加 Python 的安装路径（例如 “C:\Python39”，具体路径根据你的安装位置而定）以及 “C:\Python39\Scripts”（这个路径包含了一些常用的脚本）。

### 验证安装
1. **打开命令提示符**：按下 Win + R 键，输入 “cmd” 并回车。
2. **检查 Python 版本**：在命令提示符中输入 “python --version”，如果安装成功，会显示安装的 Python 版本号，例如 “Python 3.9.12”。
3. **进入 Python 交互环境**：在命令提示符中输入 “python”，进入 Python 交互环境，此时可以输入简单的 Python 代码进行测试，例如：
```python
print("Hello, Python!")
```

## 最佳实践

### 选择合适的 Python 版本
根据项目需求选择合适的 Python 版本。如果是新的项目，优先选择最新的稳定 Python 3 版本。一些旧项目可能仍依赖 Python 2，但不建议在新项目中使用 Python 2。

### 管理虚拟环境
虚拟环境可以让你在同一台机器上为不同项目创建独立的 Python 环境，避免包版本冲突。
1. **安装 virtualenv**：在命令提示符中运行以下命令安装 virtualenv（前提是已经安装了 Python 和 pip）：
```powershell
pip install virtualenv
```
2. **创建虚拟环境**：在项目目录下，运行以下命令创建一个名为 “myenv” 的虚拟环境：
```powershell
virtualenv myenv
```
3. **激活虚拟环境**：在 Windows 上，进入虚拟环境的 Scripts 目录，运行以下命令激活虚拟环境：
```powershell
myenv\Scripts\activate
```
   激活后，命令提示符前会显示虚拟环境的名称。
4. **退出虚拟环境**：在虚拟环境中，运行以下命令退出虚拟环境：
```powershell
deactivate
```

## 小结
在 Windows 上安装 Python 有多种方法，通过官网安装和使用包管理器安装都较为方便。安装后正确配置环境变量并验证安装是确保 Python 能正常使用的关键。同时，遵循最佳实践，如选择合适的版本和管理虚拟环境，能提高开发效率并避免潜在问题。希望通过本博客的介绍，读者能顺利在 Windows 上安装并使用 Python 进行开发。

## 参考资料
---
title: "在 Windows 上安装 Python"
description: "Python 是一种广泛应用于各种领域的高级编程语言，如 Web 开发、数据科学、人工智能等。在 Windows 操作系统上安装 Python 是踏上 Python 编程之旅的第一步。本文将详细介绍在 Windows 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者顺利安装并开始使用 Python。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
Python 是一种广泛应用于各种领域的高级编程语言，如 Web 开发、数据科学、人工智能等。在 Windows 操作系统上安装 Python 是踏上 Python 编程之旅的第一步。本文将详细介绍在 Windows 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者顺利安装并开始使用 Python。

<!-- more -->
## 目录
1. **基础概念**
2. **安装 Python 的不同方式**
    - **使用官方安装程序**
    - **使用包管理器（Chocolatey）**
3. **常见实践**
    - **配置环境变量**
    - **验证安装**
4. **最佳实践**
    - **选择合适的 Python 版本**
    - **创建虚拟环境**
5. **小结**
6. **参考资料**

## 基础概念
Python 有不同的版本，如 Python 2 和 Python 3。Python 2 已经停止更新，目前推荐使用 Python 3。在安装 Python 时，我们需要考虑操作系统的位数（32 位或 64 位），确保下载与系统匹配的安装包。此外，Python 安装包通常包含 Python 解释器、标准库以及一些常用的工具。

## 安装 Python 的不同方式

### 使用官方安装程序
1. **下载安装包**
    访问 Python 官方网站（https://www.python.org/downloads/windows/），根据你的 Windows 系统位数选择合适的 Python 3 安装包。例如，如果你使用的是 64 位 Windows 系统，下载 Windows x86-64 executable installer。
2. **运行安装程序**
    双击下载的安装包，在安装向导中，确保勾选“Add Python to PATH”选项，这将自动将 Python 安装路径添加到系统环境变量中，方便在命令行中直接使用 Python 命令。然后按照提示完成安装。

### 使用包管理器（Chocolatey）
1. **安装 Chocolatey**
    以管理员身份打开命令提示符（CMD），运行以下命令：
    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    ```
2. **使用 Chocolatey 安装 Python**
    安装完 Chocolatey 后，在命令提示符中运行以下命令安装 Python：
    ```powershell
    choco install python3
    ```
    Chocolatey 会自动下载并安装最新版本的 Python 3，并配置好环境变量。

## 常见实践

### 配置环境变量
如果在安装过程中没有勾选“Add Python to PATH”选项，或者需要手动配置环境变量，可以按照以下步骤操作：
1. 右键点击“此电脑”，选择“属性”。
2. 在弹出的窗口中点击“高级系统设置”。
3. 在“系统属性”窗口中，点击“环境变量”按钮。
4. 在“系统变量”中找到“Path”变量，点击“编辑”。
5. 点击“新建”，将 Python 的安装路径（例如 `C:\Python39`）以及 `C:\Python39\Scripts` 添加到路径中，然后点击“确定”保存设置。

### 验证安装
安装完成后，可以通过以下方法验证 Python 是否安装成功：
1. 打开命令提示符，输入 `python --version`，如果安装成功，将显示 Python 的版本号，例如 `Python 3.9.12`。
2. 输入 `python` 进入 Python 交互环境，在交互环境中输入 `print("Hello, World!")`，如果能正确输出 `Hello, World!`，说明 Python 安装并配置成功。

## 最佳实践

### 选择合适的 Python 版本
在选择 Python 版本时，要考虑项目的需求。如果是新项目，建议使用最新的稳定版 Python 3。但有些旧项目可能仍然依赖 Python 2，这种情况下需要谨慎处理，确保项目的兼容性。

### 创建虚拟环境
虚拟环境可以隔离不同项目的 Python 依赖，避免依赖冲突。可以使用 `venv` 模块创建虚拟环境：
1. 打开命令提示符，进入你想要创建虚拟环境的目录。
2. 运行命令 `python -m venv myenv`，其中 `myenv` 是虚拟环境的名称，可以自定义。
3. 激活虚拟环境：
    - 在 Windows 上，进入虚拟环境的 `Scripts` 目录，运行 `activate` 命令。激活后，命令提示符会显示虚拟环境的名称，例如 `(myenv) C:\>`。
    - 当你完成项目开发后，在虚拟环境中运行 `deactivate` 命令可以退出虚拟环境。

## 小结
在 Windows 上安装 Python 可以通过官方安装程序或包管理器（如 Chocolatey）进行。安装过程中要注意选择合适的版本和系统位数，并正确配置环境变量。验证安装成功后，通过创建虚拟环境等最佳实践，可以更好地管理项目的 Python 依赖。希望本文能帮助你顺利安装并使用 Python，开启编程之旅。

## 参考资料
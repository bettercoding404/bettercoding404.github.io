---
title: "在 Windows 上安装 Python"
description: "Python 是一种广泛应用于各种领域的高级编程语言，从数据分析、人工智能到网络开发等。在 Windows 系统上安装 Python 是使用 Python 进行开发的第一步。本博客将详细介绍在 Windows 上安装 Python 的相关知识，帮助你快速、顺利地开启 Python 之旅。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
Python 是一种广泛应用于各种领域的高级编程语言，从数据分析、人工智能到网络开发等。在 Windows 系统上安装 Python 是使用 Python 进行开发的第一步。本博客将详细介绍在 Windows 上安装 Python 的相关知识，帮助你快速、顺利地开启 Python 之旅。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 官方安装包安装
    - 使用微软商店安装
3. 常见实践
    - 配置环境变量
    - 验证安装
4. 最佳实践
    - 安装虚拟环境
    - 选择合适的 Python 版本
5. 小结
6. 参考资料

## 基础概念
Python 有不同的版本，如 Python 2 和 Python 3。Python 2 已经逐渐停止维护，目前推荐使用 Python 3。在安装 Python 时，你需要了解一些基本概念：
- **安装路径**：Python 安装的目录位置，默认路径可能因安装方式而异。
- **环境变量**：用于指定系统查找 Python 可执行文件的路径，配置环境变量后可以在任意目录通过命令行访问 Python。

## 使用方法
### 官方安装包安装
1. **下载安装包**：
    - 访问 Python 官方网站（https://www.python.org/downloads/windows/）。
    - 根据你的 Windows 系统版本（32 位或 64 位）选择合适的 Python 3 安装包进行下载。
2. **运行安装程序**：
    - 双击下载的安装包，在安装向导中，建议勾选“Add Python to PATH”（将 Python 添加到系统路径）选项，这将自动配置环境变量。
    - 选择安装路径，如果你不熟悉，可使用默认路径，然后点击“Install Now”（立即安装）进行快速安装，或者点击“Customize installation”（自定义安装）进行更多设置。

### 使用微软商店安装
1. 打开微软商店：在 Windows 搜索栏中输入“Microsoft Store”，然后打开应用商店。
2. 搜索 Python：在微软商店的搜索框中输入“Python”。
3. 选择并安装：从搜索结果中选择你需要的 Python 版本，点击“获取”或“安装”按钮进行安装。

## 常见实践
### 配置环境变量
如果在安装过程中没有勾选“Add Python to PATH”，则需要手动配置环境变量：
1. 右键点击“此电脑”，选择“属性”。
2. 在弹出窗口中点击“高级系统设置”。
3. 在“系统属性”窗口中，点击“环境变量”按钮。
4. 在“系统变量”中找到“Path”变量，点击“编辑”。
5. 点击“新建”，将 Python 的安装路径（例如 C:\Python39）以及安装路径下的“Scripts”文件夹路径（例如 C:\Python39\Scripts）添加进去。

### 验证安装
安装完成后，验证 Python 是否安装成功：
1. 打开命令提示符：在 Windows 搜索栏中输入“cmd”，然后打开命令提示符窗口。
2. 输入命令：在命令提示符中输入“python --version”，如果安装成功，将显示安装的 Python 版本号。
    ```bash
    python --version
    ```
3. 进入 Python 交互环境：在命令提示符中输入“python”，进入 Python 交互环境，此时你可以输入简单的 Python 语句进行测试，例如“print('Hello, World!')”。
    ```bash
    python
    print('Hello, World!')
    ```

## 最佳实践
### 安装虚拟环境
虚拟环境可以让你在不同项目中使用不同版本的 Python 及其依赖包，避免版本冲突：
1. 安装 `virtualenv`：在命令提示符中输入以下命令安装 `virtualenv`。
    ```bash
    pip install virtualenv
    ```
2. 创建虚拟环境：在你希望创建虚拟环境的目录下，打开命令提示符，输入以下命令创建名为 `myenv` 的虚拟环境。
    ```bash
    virtualenv myenv
    ```
3. 激活虚拟环境：在 Windows 系统中，进入虚拟环境的 `Scripts` 文件夹，然后运行 `activate` 脚本。
    ```bash
    cd myenv\Scripts
    activate
    ```
    激活后，命令提示符的开头会显示虚拟环境的名称。

### 选择合适的 Python 版本
根据项目需求选择合适的 Python 版本：
- 如果项目使用的库或框架对 Python 版本有特定要求，务必安装相应版本的 Python。
- 对于新的项目，建议使用最新的稳定版本 Python 3，以获得最新的功能和性能优化。

## 小结
在 Windows 上安装 Python 有多种方式，每种方式都有其特点。通过官方安装包安装可以进行更多自定义设置，而使用微软商店安装则更为便捷。安装完成后，正确配置环境变量并验证安装是必不可少的步骤。同时，采用虚拟环境管理和选择合适的 Python 版本等最佳实践，可以让你的 Python 开发工作更加顺利和高效。

## 参考资料
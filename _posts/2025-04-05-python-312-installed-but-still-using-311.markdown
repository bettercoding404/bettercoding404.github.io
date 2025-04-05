---
title: "Python 3.12 已安装但仍使用 3.11：深入解析与实践"
description: "在 Python 的使用过程中，有时会遇到这样的情况：明明已经成功安装了 Python 3.12，但系统却仍然默认使用 Python 3.11。这种现象可能会给开发者带来一些困惑，尤其是在需要使用 Python 3.12 新特性或进行特定版本相关开发工作时。本文将深入探讨这个问题，介绍相关概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和解决这一情况。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 的使用过程中，有时会遇到这样的情况：明明已经成功安装了 Python 3.12，但系统却仍然默认使用 Python 3.11。这种现象可能会给开发者带来一些困惑，尤其是在需要使用 Python 3.12 新特性或进行特定版本相关开发工作时。本文将深入探讨这个问题，介绍相关概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和解决这一情况。

<!-- more -->
## 目录
1. **基础概念**
    - **Python 版本管理机制**
    - **环境变量的作用**
2. **使用方法**
    - **查看当前 Python 版本**
    - **切换到 Python 3.12**
3. **常见实践**
    - **虚拟环境中的版本选择**
    - **在 IDE 中配置 Python 3.12**
4. **最佳实践**
    - **全局版本管理工具**
    - **项目级版本控制策略**
5. **小结**
6. **参考资料**

## 基础概念
### Python 版本管理机制
Python 本身并没有内置非常完善的版本管理系统，不同操作系统下安装和管理 Python 版本的方式有所不同。在 Windows 上，通常通过官方安装包进行安装；在 Linux 和 macOS 上，既可以使用系统包管理器（如 apt 在 Ubuntu 上，brew 在 macOS 上），也可以从源代码编译安装。

当安装多个 Python 版本时，系统需要一种方式来决定使用哪个版本作为默认版本。这就涉及到环境变量的设置。

### 环境变量的作用
环境变量是操作系统中用于存储系统配置信息的变量。在 Python 的语境下，`PATH` 环境变量尤为重要。`PATH` 变量包含了一系列目录路径，当在命令行中输入一个可执行文件名（如 `python`）时，操作系统会在 `PATH` 变量指定的目录中查找对应的可执行文件。

如果安装了多个 Python 版本，不同版本的 `python` 可执行文件可能位于不同的目录。如果 `PATH` 变量中指向 Python 3.11 的目录排在指向 Python 3.12 的目录之前，系统就会优先找到 Python 3.11 的可执行文件，从而导致即使安装了 Python 3.12，仍然默认使用 Python 3.11。

## 使用方法
### 查看当前 Python 版本
在命令行中，可以使用以下命令查看当前默认的 Python 版本：
```bash
python --version
```
在 Windows 上，打开命令提示符（CMD）或 PowerShell，输入上述命令；在 Linux 和 macOS 上，打开终端输入该命令。如果安装了 Python 3.12，但输出显示为 `Python 3.11.x`，则说明当前系统仍然默认使用 Python 3.11。

### 切换到 Python 3.12
- **方法一：修改 `PATH` 环境变量**
    - **Windows**：
        1. 右键点击“此电脑”，选择“属性”。
        2. 在弹出窗口中点击“高级系统设置”。
        3. 在“系统属性”窗口中，点击“环境变量”按钮。
        4. 在“系统变量”中找到“Path”变量，点击“编辑”。
        5. 将 Python 3.12 的安装目录（通常类似 `C:\Python312`）添加到“Path”变量的开头（确保目录路径正确，且目录中包含 `python.exe` 文件）。
        6. 点击“确定”保存设置。
    - **Linux 和 macOS**：
        1. 打开终端，编辑 `.bashrc` 文件（对于 Zsh 可以编辑 `.zshrc`）。在终端中输入：
        ```bash
        nano ~/.bashrc
        ```
        2. 在文件末尾添加以下内容，将 `/path/to/python312` 替换为 Python 3.12 的实际安装目录：
        ```bash
        export PATH=/path/to/python312:$PATH
        ```
        3. 保存并退出编辑器（在 nano 中按 `Ctrl + X`，然后按 `Y` 确认保存，再按 `Enter` 退出）。
        4. 使修改生效，在终端中输入：
        ```bash
        source ~/.bashrc
        ```
- **方法二：使用别名（适用于 Linux 和 macOS）**
在 `.bashrc` 或 `.zshrc` 文件中添加以下内容，将 `/path/to/python312` 替换为 Python 3.12 的实际安装目录：
```bash
alias python312=/path/to/python312/bin/python3.12
```
保存并使修改生效（同上述修改 `PATH` 变量的第四步）。之后在终端中输入 `python312` 就可以使用 Python 3.12 了。

## 常见实践
### 虚拟环境中的版本选择
虚拟环境是 Python 开发中常用的工具，它允许在一个项目中使用特定版本的 Python 及其依赖包，而不影响系统全局的 Python 环境。

1. **创建虚拟环境**
    - 首先确保已经安装了 `venv` 模块（Python 自带）。使用以下命令创建一个基于 Python 3.12 的虚拟环境：
    ```bash
    python3.12 -m venv myenv312
    ```
    这将在当前目录下创建一个名为 `myenv312` 的虚拟环境，其中使用的是 Python 3.12。
2. **激活虚拟环境**
    - **Windows**：
    ```bash
    myenv312\Scripts\activate
    ```
    - **Linux 和 macOS**：
    ```bash
    source myenv312/bin/activate
    ```
激活虚拟环境后，命令行提示符会发生变化，显示当前处于虚拟环境中。此时在该虚拟环境中执行 `python --version`，应该显示 Python 3.12 的版本号。

### 在 IDE 中配置 Python 3.12
许多 IDE（如 PyCharm、Visual Studio Code 等）支持配置不同的 Python 解释器。以 PyCharm 为例：
1. 打开项目，点击菜单栏中的 `File` -> `Settings`（在 macOS 上是 `PyCharm` -> `Preferences`）。
2. 在弹出的窗口中，找到 `Project: [项目名称]` -> `Python Interpreter`。
3. 在 `Python Interpreter` 页面，点击右上角的齿轮图标，选择 `Add...`。
4. 在弹出的窗口中，选择 `Conda Environment`（如果使用 Conda 管理环境）或 `Virtualenv Environment`（如果使用 `venv` 创建虚拟环境）。
5. 然后选择 Python 3.12 的可执行文件路径（例如 `/path/to/python312/bin/python3.12`），点击 `OK` 完成配置。

## 最佳实践
### 全局版本管理工具
使用专门的版本管理工具可以更方便地管理多个 Python 版本，如 `pyenv`。
1. **安装 `pyenv`**
    - **Linux 和 macOS**：
    ```bash
    curl https://pyenv.run | bash
    ```
    按照提示完成安装，安装完成后需要将 `pyenv` 的相关路径添加到 `PATH` 环境变量中，按照安装提示操作即可。
    - **Windows**：可以使用 `scoop` 安装 `pyenv-win`。首先安装 `scoop`：
    ```bash
    irm get.scoop.sh | iex
    ```
    然后安装 `pyenv-win`：
    ```bash
    scoop install pyenv-win
    ```
2. **使用 `pyenv` 管理 Python 版本**
    - 安装 Python 3.12：
    ```bash
    pyenv install 3.12.0
    ```
    - 设置全局默认版本为 Python 3.12：
    ```bash
    pyenv global 3.12.0
    ```
    - 查看当前使用的 Python 版本：
    ```bash
    pyenv version
    ```

### 项目级版本控制策略
对于每个项目，建议使用 `pyproject.toml` 和 `poetry` 来管理项目的依赖和 Python 版本。
1. **安装 `poetry`**
    - **Windows、Linux 和 macOS**：
    ```bash
    curl -sSL https://install.python-poetry.org | python3 -
    ```
2. **初始化项目**
在项目目录下，运行以下命令初始化 `poetry` 项目：
```bash
poetry init
```
按照提示填写项目信息。
3. **指定 Python 版本**
编辑 `pyproject.toml` 文件，在 `[tool.poetry.dependencies]` 部分添加对 Python 版本的要求：
```toml
[tool.poetry.dependencies]
python = "^3.12"
```
4. **安装依赖**
使用以下命令安装项目所需的依赖包：
```bash
poetry install
```
`poetry` 会根据 `pyproject.toml` 中的配置，创建一个虚拟环境并安装指定版本的 Python 和依赖包。

## 小结
本文围绕“Python 3.12 已安装但仍使用 3.11”这一问题，介绍了相关的基础概念，包括 Python 版本管理机制和环境变量的作用。详细阐述了查看和切换 Python 版本的方法，以及在虚拟环境和 IDE 中使用 Python 3.12 的常见实践。同时，推荐了使用全局版本管理工具 `pyenv` 和项目级版本控制策略 `poetry` 的最佳实践。通过这些内容，希望读者能够更好地理解和处理 Python 版本管理问题，在开发中更加高效地使用不同版本的 Python。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- [pyenv 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}
- [poetry 官方文档](https://python-poetry.org/docs/){: rel="nofollow"}
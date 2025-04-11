---
title: "Python 3.12 已安装但仍在使用 3.11：深入解析与实践"
description: "在 Python 的使用过程中，有时会遇到这样的情况：明明已经安装了 Python 3.12，但系统或某些程序仍然使用 Python 3.11。这种现象背后涉及到 Python 的版本管理、环境变量设置等多个技术点。深入理解并解决这个问题，对于开发人员高效使用不同版本的 Python 至关重要。本文将围绕“Python 3.12 已安装但仍在使用 3.11”这一主题，详细介绍相关的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌控 Python 版本。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 的使用过程中，有时会遇到这样的情况：明明已经安装了 Python 3.12，但系统或某些程序仍然使用 Python 3.11。这种现象背后涉及到 Python 的版本管理、环境变量设置等多个技术点。深入理解并解决这个问题，对于开发人员高效使用不同版本的 Python 至关重要。本文将围绕“Python 3.12 已安装但仍在使用 3.11”这一主题，详细介绍相关的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌控 Python 版本。

<!-- more -->
## 目录
1. **基础概念**
    - **Python 版本管理**
    - **环境变量的作用**
2. **使用方法**
    - **查看已安装的 Python 版本**
    - **切换默认 Python 版本**
3. **常见实践**
    - **在虚拟环境中使用不同版本**
    - **解决 IDE 中版本冲突**
4. **最佳实践**
    - **使用版本管理工具**
    - **配置项目特定的 Python 版本**
5. **小结**
6. **参考资料**

## 基础概念
### Python 版本管理
Python 是一个不断发展的编程语言，不同版本会带来新的特性、性能优化和 bug 修复。在同一系统中安装多个版本的 Python 是很常见的需求。然而，系统需要知道在执行 `python` 命令时应该使用哪个版本，这就涉及到版本管理。Python 有多种版本管理方式，例如系统自带的环境变量配置、第三方版本管理工具（如 `pyenv`、`virtualenv` 等）。

### 环境变量的作用
环境变量是操作系统中用于存储特定信息的动态对象。在 Python 中，环境变量 `PATH` 起着关键作用。`PATH` 变量包含了一系列目录路径，当在命令行中输入 `python` 命令时，操作系统会按照 `PATH` 变量中的路径顺序查找 `python` 可执行文件。如果 `PATH` 变量中靠前的路径指向的是 Python 3.11 的安装目录，那么即使安装了 Python 3.12，系统默认执行的还是 Python 3.11。

## 使用方法
### 查看已安装的 Python 版本
在命令行中，可以使用以下命令查看已安装的 Python 版本：
- **Windows**：
    ```batch
    python --version
    ```
    如果系统同时安装了多个版本，可以通过查看 Python 安装目录来确认具体版本。例如，Python 3.11 可能安装在 `C:\Python311`，Python 3.12 可能安装在 `C:\Python312`。
- **Linux 和 macOS**：
    ```bash
    python3 --version
    python3.11 --version
    python3.12 --version
    ```
    这样可以分别查看系统默认的 Python 3 版本以及特定的 Python 3.11 和 3.12 版本。

### 切换默认 Python 版本
- **Windows**：
    1. 打开“系统属性” -> “高级” -> “环境变量”。
    2. 在“系统变量”中找到“PATH”变量，点击“编辑”。
    3. 将 Python 3.12 的安装目录（例如 `C:\Python312`）移动到 PATH 变量列表的较前位置，确保它排在 Python 3.11 的安装目录之前。
    4. 保存设置后，重新打开命令提示符，输入 `python --version`，应该会显示 Python 3.12 的版本号。
- **Linux 和 macOS**：
    1. 编辑 `~/.bashrc` 或 `~/.zshrc` 文件（根据使用的 shell）。
    2. 在文件中添加或修改以下内容，将 Python 3.12 的路径放在前面：
    ```bash
    export PATH="/usr/local/bin/python3.12:$PATH"
    ```
    3. 保存文件后，执行 `source ~/.bashrc` 或 `source ~/.zshrc` 使设置生效。
    4. 在命令行输入 `python --version`，验证是否切换到了 Python 3.12。

## 常见实践
### 在虚拟环境中使用不同版本
虚拟环境是一个独立的 Python 运行环境，它允许在同一系统中为不同项目使用不同版本的 Python。
1. **安装 `virtualenv`**：
    - **Windows**：
    ```batch
    pip install virtualenv
    ```
    - **Linux 和 macOS**：
    ```bash
    pip3 install virtualenv
    ```
2. **创建虚拟环境并指定 Python 版本**：
    - **使用 Python 3.12 创建虚拟环境**：
    ```bash
    virtualenv -p python3.12 myenv312
    ```
    - **使用 Python 3.11 创建虚拟环境**：
    ```bash
    virtualenv -p python3.11 myenv311
    ```
3. **激活虚拟环境**：
    - **Windows**：
    ```batch
    myenv312\Scripts\activate
    ```
    - **Linux 和 macOS**：
    ```bash
    source myenv312/bin/activate
    ```
    激活后，命令行提示符会显示当前使用的虚拟环境名称，此时安装的 Python 包和执行的 Python 命令都基于该虚拟环境指定的 Python 版本。

### 解决 IDE 中版本冲突
在集成开发环境（IDE）中，如 PyCharm，也可能遇到版本冲突问题。
1. **打开项目设置**：
    - 在 PyCharm 中，选择“File” -> “Settings”（Windows/Linux）或“PyCharm” -> “Preferences”（macOS）。
2. **配置项目解释器**：
    - 在设置中找到“Project: [项目名称]” -> “Python Interpreter”。
    - 点击右上角的齿轮图标，选择“Add...”。
    - 在弹出的窗口中，选择“Conda Environment”或“Virtualenv Environment”，然后在“Interpreter”下拉框中选择 Python 3.12 的解释器路径（例如 `/usr/local/bin/python3.12`）。
    - 点击“OK”保存设置，此时项目将使用 Python 3.12 作为解释器。

## 最佳实践
### 使用版本管理工具
`pyenv` 是一个强大的 Python 版本管理工具，它可以方便地在不同 Python 版本之间切换，并且支持全局、局部和 shell 级别的版本设置。
1. **安装 `pyenv`**：
    - **Linux 和 macOS**：
    ```bash
    curl https://pyenv.run | bash
    ```
    - **Windows**：可以通过 `scoop` 安装：
    ```batch
    scoop install pyenv
    ```
2. **安装 Python 版本**：
    ```bash
    pyenv install 3.12.0
    pyenv install 3.11.0
    ```
3. **设置全局 Python 版本**：
    ```bash
    pyenv global 3.12.0
    ```
4. **设置局部项目版本**：
    在项目目录下执行：
    ```bash
    pyenv local 3.11.0
    ```
    这样，该项目将使用 Python 3.11，而其他项目可以继续使用全局设置的 Python 3.12。

### 配置项目特定的 Python 版本
在项目的 `requirements.txt` 文件中，可以指定项目所需的 Python 版本范围。例如：
```
python_version >= '3.12'
```
在部署项目时，部署工具（如 `pipenv` 或 `poetry`）可以根据这个要求安装合适的 Python 版本和依赖包，确保项目在目标环境中使用正确的 Python 版本运行。

## 小结
本文围绕“Python 3.12 已安装但仍在使用 3.11”这一问题，深入探讨了 Python 版本管理的基础概念、不同系统下查看和切换默认 Python 版本的方法、在虚拟环境和 IDE 中使用不同版本的常见实践，以及使用版本管理工具和配置项目特定版本的最佳实践。通过掌握这些知识和技巧，开发人员能够更加灵活地管理 Python 版本，避免版本冲突带来的问题，提高开发效率。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- [pyenv 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}
- [virtualenv 官方文档](https://virtualenv.pypa.io/en/latest/){: rel="nofollow"}
---
title: "深入理解与高效使用 Python 虚拟环境（create python venv）"
description: "在 Python 开发中，虚拟环境（Virtual Environment）是一项极为重要的技术。它允许开发者在同一系统上为不同的项目创建相互隔离的 Python 环境，每个环境可以有独立的 Python 版本以及各自的包依赖，避免了不同项目之间的依赖冲突。本文将详细介绍如何创建 Python 虚拟环境（create python venv），包括基础概念、使用方法、常见实践和最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 开发中，虚拟环境（Virtual Environment）是一项极为重要的技术。它允许开发者在同一系统上为不同的项目创建相互隔离的 Python 环境，每个环境可以有独立的 Python 版本以及各自的包依赖，避免了不同项目之间的依赖冲突。本文将详细介绍如何创建 Python 虚拟环境（create python venv），包括基础概念、使用方法、常见实践和最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 在不同操作系统下创建虚拟环境
    - 激活与停用虚拟环境
3. 常见实践
    - 安装项目依赖
    - 管理依赖文件
4. 最佳实践
    - 项目结构与虚拟环境
    - 持续集成与虚拟环境
5. 小结
6. 参考资料

## 基础概念
虚拟环境是一个独立的 Python 运行环境，它包含了特定版本的 Python 解释器以及一系列安装的包。每个虚拟环境都像是一个沙盒，与系统级的 Python 环境和其他虚拟环境相互隔离。这意味着在一个虚拟环境中安装的包不会影响到其他环境，为不同项目的开发提供了极大的便利。

## 使用方法

### 在不同操作系统下创建虚拟环境

#### Windows
1. **确保 Python 安装并配置好环境变量**
首先要确认 Python 已经正确安装，并且 `python` 命令可以在命令行中正常使用。可以在命令提示符中输入 `python --version` 来检查。
2. **创建虚拟环境**
打开命令提示符，进入你想要创建虚拟环境的目录，例如 `cd C:\projects\my_project`。然后使用以下命令创建虚拟环境：
```bash
python -m venv my_venv
```
这里 `my_venv` 是虚拟环境的名称，你可以根据实际情况自定义。

#### macOS 和 Linux
1. **确认 Python 安装**
同样先确认 Python 已经安装，可以在终端输入 `python3 --version` 检查。
2. **创建虚拟环境**
打开终端，进入目标目录，例如 `cd /home/user/projects/my_project`。然后使用以下命令创建虚拟环境：
```bash
python3 -m venv my_venv
```

### 激活与停用虚拟环境

#### Windows
1. **激活虚拟环境**
在命令提示符中进入虚拟环境的 `Scripts` 目录，例如 `cd C:\projects\my_project\my_venv\Scripts`。然后运行激活脚本：
```bash
activate
```
激活后，命令提示符的前缀会显示虚拟环境的名称，例如 `(my_venv) C:\projects\my_project\my_venv\Scripts>`。
2. **停用虚拟环境**
在激活的虚拟环境中，运行以下命令停用虚拟环境：
```bash
deactivate
```

#### macOS 和 Linux
1. **激活虚拟环境**
进入虚拟环境的 `bin` 目录，例如 `cd /home/user/projects/my_project/my_venv/bin`。然后运行激活脚本：
```bash
source activate
```
激活后，终端提示符会显示虚拟环境名称，例如 `(my_venv) /home/user/projects/my_project/my_venv/bin$`。
2. **停用虚拟环境**
在激活的虚拟环境中，运行以下命令停用：
```bash
deactivate
```

## 常见实践

### 安装项目依赖
激活虚拟环境后，可以使用 `pip` 安装项目所需的包。例如，安装 `numpy` 和 `pandas`：
```bash
pip install numpy pandas
```
这样，`numpy` 和 `pandas` 就会被安装到当前虚拟环境中，而不会影响系统级的 Python 环境或其他虚拟环境。

### 管理依赖文件
为了方便在不同环境中部署项目，通常会生成一个依赖文件，记录项目所需的所有包及其版本。可以使用以下命令生成依赖文件 `requirements.txt`：
```bash
pip freeze > requirements.txt
```
在新的环境中安装项目依赖时，可以使用：
```bash
pip install -r requirements.txt
```

## 最佳实践

### 项目结构与虚拟环境
建议将虚拟环境与项目代码放在同一目录层次结构中，保持项目的整体性。例如：
```
my_project/
    my_venv/
    my_project_code/
        __init__.py
        main.py
    requirements.txt
```
这样的结构使得项目的依赖管理和部署更加清晰和方便。

### 持续集成与虚拟环境
在持续集成（CI）过程中，为每个构建任务创建虚拟环境是一个好的实践。例如在使用 GitHub Actions 时，可以在 `.github/workflows` 目录下创建一个 YAML 文件，如下所示：
```yaml
name: Python CI

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: 3.9

      - name: Create virtual environment
        run: |
          python -m venv my_venv
          source my_venv/bin/activate

      - name: Install dependencies
        run: |
          pip install -r requirements.txt

      - name: Run tests
        run: |
          pytest
```
这样可以确保每次构建时都在一个全新的、隔离的虚拟环境中进行，避免了因环境不一致导致的问题。

## 小结
创建和使用 Python 虚拟环境（create python venv）是 Python 开发中的关键技能。通过创建独立的虚拟环境，我们可以有效管理项目依赖，避免依赖冲突，提高项目的可维护性和可部署性。掌握虚拟环境的创建、激活、停用以及依赖管理等操作，能够极大地提升开发效率。

## 参考资料
- [Python官方文档 - 虚拟环境](https://docs.python.org/3/library/venv.html)
- [Real Python - Working with Python Virtual Environments](https://realpython.com/python-virtual-environments-a-primer/)
---
title: "深入探索：创建新的 Python 虚拟环境"
description: "在 Python 开发过程中，虚拟环境是一个强大且必不可少的工具。它允许我们在一个隔离的环境中安装项目所需的特定版本的包，避免不同项目之间的依赖冲突。本文将全面深入地介绍如何创建新的 Python 虚拟环境，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者熟练掌握并运用这一技术。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 开发过程中，虚拟环境是一个强大且必不可少的工具。它允许我们在一个隔离的环境中安装项目所需的特定版本的包，避免不同项目之间的依赖冲突。本文将全面深入地介绍如何创建新的 Python 虚拟环境，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者熟练掌握并运用这一技术。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `venv` 模块创建虚拟环境
    - 使用 `virtualenv` 创建虚拟环境
3. 常见实践
    - 激活和停用虚拟环境
    - 在虚拟环境中安装和管理包
4. 最佳实践
    - 项目结构与虚拟环境
    - 版本控制与虚拟环境
5. 小结
6. 参考资料

## 基础概念
虚拟环境本质上是一个独立的 Python 环境，它有自己独立的 Python 解释器、库和脚本。每个虚拟环境都像是一个“沙盒”，在其中安装的包和进行的配置不会影响到系统全局的 Python 环境，也不会影响其他虚拟环境。这使得不同项目可以依赖不同版本的库，而不会产生版本冲突的问题。

例如，项目 A 需要 `Django 2.2`，项目 B 需要 `Django 3.0`，通过使用虚拟环境，我们可以在不同的虚拟环境中分别安装这两个不同版本的 `Django`，满足两个项目的不同需求。

## 使用方法

### 使用 `venv` 模块创建虚拟环境
`venv` 是 Python 3.3 及以上版本内置的创建虚拟环境的模块。以下是创建虚拟环境的步骤：

1. **打开终端**：在 Windows 上，可以通过命令提示符或 PowerShell；在 macOS 和 Linux 上，使用终端应用。

2. **选择创建虚拟环境的目录**：例如，我们在桌面上创建一个名为 `my_project` 的项目目录，并在其中创建虚拟环境。

```bash
cd Desktop/my_project
```

3. **创建虚拟环境**：假设我们将虚拟环境命名为 `myenv`。

```bash
python -m venv myenv
```

### 使用 `virtualenv` 创建虚拟环境
`virtualenv` 是一个第三方库，在 Python 2 和 Python 3 中都广泛使用。在使用之前，需要确保已经安装了 `virtualenv`。可以使用以下命令安装：

```bash
pip install virtualenv
```

安装完成后，创建虚拟环境的步骤如下：

1. **打开终端并进入项目目录**：同 `venv` 模块的步骤 1 和 2。

2. **创建虚拟环境**：同样将虚拟环境命名为 `myenv`。

```bash
virtualenv myenv
```

如果想指定使用 Python 3 来创建虚拟环境，可以使用以下命令：

```bash
virtualenv -p python3 myenv
```

## 常见实践

### 激活和停用虚拟环境

1. **在 Windows 上激活虚拟环境**：
    - 如果使用 `venv` 创建的虚拟环境：
```bash
myenv\Scripts\activate
```
    - 如果使用 `virtualenv` 创建的虚拟环境：
```bash
myenv\Scripts\activate
```

2. **在 macOS 和 Linux 上激活虚拟环境**：
```bash
source myenv/bin/activate
```

激活虚拟环境后，命令行提示符会显示虚拟环境的名称，例如 `(myenv) user@computer:~/Desktop/my_project$`。

3. **停用虚拟环境**：
在激活虚拟环境的终端中，运行以下命令：
```bash
deactivate
```

### 在虚拟环境中安装和管理包
激活虚拟环境后，可以使用 `pip` 命令安装、升级和卸载包。

1. **安装包**：例如安装 `numpy` 包：
```bash
pip install numpy
```

2. **升级包**：升级 `numpy` 到最新版本：
```bash
pip install --upgrade numpy
```

3. **卸载包**：卸载 `numpy` 包：
```bash
pip uninstall numpy
```

还可以使用 `pip freeze` 命令列出当前虚拟环境中安装的所有包及其版本信息，并将其输出到一个文件中，方便记录和共享项目的依赖：
```bash
pip freeze > requirements.txt
```

在新的环境中安装相同的依赖时，可以使用以下命令：
```bash
pip install -r requirements.txt
```

## 最佳实践

### 项目结构与虚拟环境
将虚拟环境放在项目根目录下是一个不错的实践。这样可以使项目的结构更加清晰，便于管理。例如：
```
my_project/
    myenv/
    my_project_code/
        __init__.py
        main.py
    requirements.txt
```

### 版本控制与虚拟环境
在使用版本控制系统（如 Git）时，不要将虚拟环境的内容提交到仓库中。因为虚拟环境中的内容可以通过 `requirements.txt` 文件重新创建。可以在 `.gitignore` 文件中添加虚拟环境的目录名（例如 `myenv`），以确保虚拟环境不会被意外提交。

## 小结
创建和使用 Python 虚拟环境是 Python 开发中的重要环节，它为解决依赖冲突、项目隔离提供了有效的解决方案。通过本文介绍的基础概念、使用方法、常见实践以及最佳实践，读者应该能够熟练地创建、管理和使用虚拟环境，提升 Python 开发的效率和质量。

## 参考资料
- [Python官方文档 - venv](https://docs.python.org/3/library/venv.html)
- [virtualenv官方文档](https://virtualenv.pypa.io/en/latest/)
---
title: "Python 3.12 已安装但仍在使用 3.11：深入解析与实践"
description: "在 Python 的世界里，版本的更新带来了性能提升、新特性以及更好的兼容性。有时，我们可能会遇到这样的情况：明明已经安装了 Python 3.12，但系统却仍然使用 Python 3.11。这篇博客将深入探讨这个现象背后的原因，以及如何正确地处理它，确保我们能够在需要时顺利地使用 Python 3.12。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在 Python 的世界里，版本的更新带来了性能提升、新特性以及更好的兼容性。有时，我们可能会遇到这样的情况：明明已经安装了 Python 3.12，但系统却仍然使用 Python 3.11。这篇博客将深入探讨这个现象背后的原因，以及如何正确地处理它，确保我们能够在需要时顺利地使用 Python 3.12。

<!-- more -->
## 目录
1. **基础概念**
    - 理解 Python 版本管理
    - 为什么会出现已安装 3.12 却使用 3.11 的情况
2. **使用方法**
    - 检查 Python 版本
    - 切换 Python 版本
3. **常见实践**
    - 在不同项目中使用不同 Python 版本
    - 解决版本冲突
4. **最佳实践**
    - 使用虚拟环境
    - 配置项目的 Python 版本
5. **小结**
6. **参考资料**

## 基础概念
### 理解 Python 版本管理
Python 的版本管理是一个关键部分。不同的操作系统和 Python 发行版有不同的方式来安装和管理 Python 版本。例如，在 Linux 系统中，我们可能会使用包管理器（如 apt、yum 等）来安装 Python，而在 Windows 上，通常从 Python 官方网站下载安装包进行安装。

每个 Python 版本都有其独立的运行环境和库集合。这意味着，当我们安装多个版本时，系统需要一种方式来确定在执行 `python` 命令时应该使用哪个版本。

### 为什么会出现已安装 3.12 却使用 3.11 的情况
1. **路径问题**：系统的 `PATH` 环境变量决定了在命令行中执行命令时系统查找可执行文件的顺序。如果 Python 3.11 的安装路径在 `PATH` 中排在 Python 3.12 之前，那么当我们执行 `python` 命令时，系统会优先找到并使用 Python 3.11。
2. **默认设置**：某些系统或工具可能会默认使用特定版本的 Python。例如，一些 IDE（集成开发环境）可能会在安装时自动配置为使用系统默认的 Python 版本，而这个默认版本可能是 3.11。

## 使用方法
### 检查 Python 版本
在命令行中，我们可以使用以下命令检查当前使用的 Python 版本：
```bash
python --version
```
如果安装了多个 Python 版本，我们还可以通过指定完整路径来检查特定版本的 Python：
```bash
/path/to/python3.12 --version
```
例如，在 Linux 系统中，如果 Python 3.12 安装在 `/usr/local/bin` 目录下，我们可以使用：
```bash
/usr/local/bin/python3.12 --version
```

### 切换 Python 版本
1. **临时切换**：在命令行中，我们可以直接使用完整路径来调用特定版本的 Python。例如：
```bash
/usr/local/bin/python3.12 your_script.py
```
这样就可以临时使用 Python 3.12 来运行脚本 `your_script.py`。

2. **永久切换（修改 PATH 环境变量）**：
    - 在 Linux 或 macOS 系统中，我们可以编辑 `~/.bashrc`（对于 bash shell）或 `~/.zshrc`（对于 zsh shell）文件，将 Python 3.12 的路径添加到 `PATH` 变量的开头。例如：
```bash
export PATH="/usr/local/bin:$PATH"
```
保存文件后，执行 `source ~/.bashrc` 或 `source ~/.zshrc` 使更改生效。

    - 在 Windows 系统中，我们可以通过“系统属性” -> “高级” -> “环境变量”来编辑 `PATH` 变量。将 Python 3.12 的安装路径添加到 `PATH` 变量的开头。

## 常见实践
### 在不同项目中使用不同 Python 版本
在开发多个项目时，不同项目可能依赖于不同版本的 Python 和相关库。我们可以使用工具如 `pyenv` 或 `virtualenv` 来为每个项目创建独立的 Python 环境。

例如，使用 `pyenv`：
1. 安装 `pyenv`：
```bash
curl https://pyenv.run | bash
```
2. 安装 Python 版本：
```bash
pyenv install 3.12
```
3. 为项目创建虚拟环境：
```bash
pyenv virtualenv 3.12 my_project_env
```
4. 进入项目目录并激活虚拟环境：
```bash
cd my_project
pyenv local my_project_env
```

### 解决版本冲突
当不同的库依赖于不同版本的 Python 时，可能会出现版本冲突。解决这个问题的一种方法是使用 `pip` 的 `--no-deps` 选项来安装库，这样可以避免安装依赖项，然后手动安装所需版本的依赖库。

例如：
```bash
pip install --no-deps some_library
pip install required_version_of_dependency
```

## 最佳实践
### 使用虚拟环境
虚拟环境是 Python 开发中的最佳实践之一。它允许我们在一个隔离的环境中安装项目所需的库和 Python 版本，而不会影响系统全局的 Python 环境。

使用 `venv` 模块创建虚拟环境：
```bash
python3.12 -m venv my_venv
```
激活虚拟环境：
- 在 Linux 或 macOS 中：
```bash
source my_venv/bin/activate
```
- 在 Windows 中：
```bash
my_venv\Scripts\activate
```

### 配置项目的 Python 版本
在项目中，我们可以使用 `pyproject.toml` 文件来指定项目所需的 Python 版本。例如：
```toml
[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "my_project"
version = "0.1.0"
requires-python = ">=3.12"
```

## 小结
在本文中，我们深入探讨了“Python 3.12 已安装但仍在使用 3.11”这一现象背后的原因，并介绍了多种检查、切换 Python 版本的方法。同时，我们还讨论了在不同项目中使用不同 Python 版本、解决版本冲突以及一些最佳实践，如使用虚拟环境和配置项目的 Python 版本。通过掌握这些知识和技巧，我们能够更好地管理 Python 版本，提高开发效率。

## 参考资料
- [Python 官方文档](https://docs.python.org/){: rel="nofollow"}
- [pyenv 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}
- [virtualenv 官方文档](https://virtualenv.pypa.io/en/latest/){: rel="nofollow"}
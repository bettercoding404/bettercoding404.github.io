---
title: "如何在 Mac 上切换到 Python 3.12 版本"
description: "在 Mac 系统中，默认安装的 Python 版本可能不是 3.12 。随着 Python 3.12 的发布，它带来了许多新特性和性能改进。将 Python 环境切换到 3.12 版本，能够让开发者使用这些新功能，优化项目开发。本文将详细介绍在 Mac 上切换到 Python 3.12 版本的相关知识和操作方法。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Mac 系统中，默认安装的 Python 版本可能不是 3.12 。随着 Python 3.12 的发布，它带来了许多新特性和性能改进。将 Python 环境切换到 3.12 版本，能够让开发者使用这些新功能，优化项目开发。本文将详细介绍在 Mac 上切换到 Python 3.12 版本的相关知识和操作方法。

<!-- more -->
## 目录
1. **基础概念**
2. **安装 Python 3.12**
3. **切换 Python 版本的方法**
4. **常见实践**
5. **最佳实践**
6. **小结**
7. **参考资料**

## 基础概念
Python 是一种广泛使用的高级编程语言，不同版本在语法、功能和性能上可能存在差异。Python 3.12 相比之前的版本有了诸多改进，如增强的类型检查、新的标准库模块、性能优化等。在 Mac 上，系统自带了 Python 2 和 Python 3 的某些版本，但可能并非最新的 3.12 版本。为了使用 Python 3.12 的新特性，需要手动安装并切换到该版本。

## 安装 Python 3.12
### 使用 Homebrew 安装
1. **确保 Homebrew 已安装**：如果尚未安装 Homebrew，可以在终端中运行以下命令进行安装：
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. **安装 Python 3.12**：安装好 Homebrew 后，在终端中运行以下命令来安装 Python 3.12 ：
   ```bash
   brew install python@3.12
   ```
### 使用 Python 官方安装包
1. 访问 [Python 官方网站](https://www.python.org/downloads/mac-osx/)，下载适用于 Mac 的 Python 3.12 安装包（通常是 `.pkg` 格式）。
2. 双击下载的安装包，按照安装向导的提示完成安装。

## 切换 Python 版本的方法
### 使用 `python3` 命令别名
1. **查看当前 Python 版本**：在终端中运行 `python3 --version` 命令，查看当前默认的 Python 3 版本。
2. **创建别名**：编辑 `~/.bash_profile` 或 `~/.zshrc` 文件（根据你使用的 shell 环境）。如果使用的是 `bash` ，可以在终端中运行 `nano ~/.bash_profile` ；如果是 `zsh` ，运行 `nano ~/.zshrc` 。
   在打开的文件中添加以下内容（假设使用 Homebrew 安装的 Python 3.12 ）：
   ```bash
   alias python3='/opt/homebrew/bin/python3.12'
   ```
3. **使配置生效**：保存文件后，在终端中运行 `source ~/.bash_profile` （对于 `bash` ）或 `source ~/.zshrc` （对于 `zsh` ）。
4. **验证版本**：再次运行 `python3 --version` ，应该显示 Python 3.12 版本号。

### 使用 `pyenv` 管理 Python 版本
1. **安装 `pyenv`**：可以使用 Homebrew 安装 `pyenv` ，在终端中运行：
   ```bash
   brew install pyenv
   ```
2. **安装 Python 3.12**：安装好 `pyenv` 后，运行以下命令安装 Python 3.12 ：
   ```bash
   pyenv install 3.12
   ```
3. **设置全局 Python 版本**：运行以下命令将 Python 3.12 设置为全局版本：
   ```bash
   pyenv global 3.12
   ```
4. **验证版本**：运行 `python --version` ，应该显示 Python 3.12 版本号。

## 常见实践
### 创建虚拟环境
在使用 Python 3.12 进行项目开发时，建议创建虚拟环境，以隔离项目依赖。
1. **安装 `venv`**：如果使用 Homebrew 安装的 Python 3.12 ，`venv` 已经包含在安装包中。如果使用官方安装包，可能需要手动安装 `venv` 。
2. **创建虚拟环境**：在项目目录下，运行以下命令创建虚拟环境：
   ```bash
   python3 -m venv myenv
   ```
   其中 `myenv` 是虚拟环境的名称，可以自行修改。
3. **激活虚拟环境**：对于 `bash` 或 `zsh` ，在终端中运行：
   ```bash
   source myenv/bin/activate
   ```
4. **验证 Python 版本**：激活虚拟环境后，运行 `python --version` ，应该显示 Python 3.12 版本号。

### 安装项目依赖
在虚拟环境中，可以使用 `pip` 安装项目所需的依赖包。例如，安装 `numpy` ：
```bash
pip install numpy
```

## 最佳实践
### 版本控制与项目管理
使用 `pipenv` 或 `poetry` 等工具进行项目依赖管理和版本控制。
1. **安装 `pipenv`**：在终端中运行：
   ```bash
   pip install pipenv
   ```
2. **创建项目环境**：进入项目目录，运行：
   ```bash
   pipenv --python 3.12
   ```
   这将创建一个基于 Python 3.12 的虚拟环境，并生成 `Pipfile` 和 `Pipfile.lock` 文件用于管理依赖。
3. **安装依赖**：在 `pipenv` 环境中安装依赖包，例如：
   ```bash
   pipenv install numpy
   ```

### 与 IDE 集成
将 Python 3.12 集成到常用的 IDE 中，如 PyCharm 。
1. **打开 PyCharm**：打开 PyCharm ，创建或打开一个项目。
2. **设置 Python 解释器**：在菜单栏中选择 `File` -> `Settings` （Windows/Linux ）或 `PyCharm` -> `Preferences` （Mac ）。在弹出的窗口中，选择 `Project: [项目名称]` -> `Python Interpreter` 。
3. **添加 Python 3.12 解释器**：点击右上角的齿轮图标，选择 `Add...` 。在弹出的窗口中，选择 `Conda Environment` 或 `Virtualenv Environment` ，然后选择 Python 3.12 解释器路径（例如 `/opt/homebrew/bin/python3.12` ）。

## 小结
通过本文介绍的方法，在 Mac 上切换到 Python 3.12 版本并不复杂。首先要选择合适的安装方式，如使用 Homebrew 或官方安装包。然后通过命令别名或 `pyenv` 等工具切换 Python 版本。在实际开发中，创建虚拟环境、合理管理依赖以及与 IDE 集成都是提高开发效率和项目质量的重要实践。希望读者通过本文能够顺利在 Mac 上使用 Python 3.12 进行开发。

## 参考资料
- [Python 官方网站](https://www.python.org/)
- [Homebrew 官方网站](https://brew.sh/)
- [pyenv 官方文档](https://github.com/pyenv/pyenv)
- [pipenv 官方文档](https://pipenv.pypa.io/en/latest/)
- [poetry 官方文档](https://python-poetry.org/docs/)
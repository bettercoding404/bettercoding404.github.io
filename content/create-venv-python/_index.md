---
title: "深入理解 Python 中的虚拟环境（create venv python）"
description: "在 Python 开发过程中，不同的项目可能会依赖不同版本的 Python 库。为了避免项目之间的依赖冲突，虚拟环境成为了 Python 开发者的重要工具。`create venv python` 即创建 Python 虚拟环境，它允许我们在系统的全局 Python 环境之外，创建独立的、隔离的 Python 环境，每个虚拟环境都可以有自己独立的包安装和管理。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 开发过程中，不同的项目可能会依赖不同版本的 Python 库。为了避免项目之间的依赖冲突，虚拟环境成为了 Python 开发者的重要工具。`create venv python` 即创建 Python 虚拟环境，它允许我们在系统的全局 Python 环境之外，创建独立的、隔离的 Python 环境，每个虚拟环境都可以有自己独立的包安装和管理。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 在命令行创建虚拟环境
    - 激活虚拟环境
    - 安装包到虚拟环境
    - 退出虚拟环境
3. 常见实践
    - 项目初始化时创建虚拟环境
    - 共享虚拟环境配置
4. 最佳实践
    - 版本控制虚拟环境相关文件
    - 使用 `.gitignore` 忽略不必要的文件
    - 定期更新虚拟环境中的包
5. 小结
6. 参考资料

## 基础概念
虚拟环境是一个独立的 Python 运行环境，它有自己独立的 Python 解释器、标准库和第三方包。当你在虚拟环境中安装一个包时，该包只会安装在这个虚拟环境中，不会影响系统全局的 Python 环境。这就好比在你的电脑上为每个项目都准备了一个独立的“小房间”，每个“小房间”里可以摆放不同版本的工具（库），而不会互相干扰。

## 使用方法
### 在命令行创建虚拟环境
在大多数操作系统上，Python 3 自带了 `venv` 模块来创建虚拟环境。假设我们要为一个名为 `my_project` 的项目创建虚拟环境，以下是具体步骤：

1. 打开命令行终端。
2. 切换到项目目录。例如，如果项目在 `C:\projects\my_project` 目录下：
    - 在 Windows 系统上：
```batch
cd C:\projects\my_project
```
    - 在 Linux 或 macOS 系统上：
```bash
cd /home/user/projects/my_project
```
3. 创建虚拟环境。通常命名虚拟环境目录为 `.venv`（这是一个约定俗成的命名，当然你也可以使用其他名字）：
```bash
python -m venv.venv
```

### 激活虚拟环境
- **Windows 系统**：
```batch
.venv\Scripts\activate
```
激活后，命令行提示符前面会显示虚拟环境的名称，例如 `(.venv) C:\projects\my_project>`。

- **Linux 或 macOS 系统**：
```bash
source.venv/bin/activate
```
激活后，命令行提示符类似 `(.venv) user@host:~/projects/my_project$`。

### 安装包到虚拟环境
激活虚拟环境后，就可以使用 `pip` 安装项目所需的包了。例如，安装 `numpy` 包：
```bash
pip install numpy
```
`pip` 会将 `numpy` 及其依赖项安装到当前的虚拟环境中。

### 退出虚拟环境
当你完成项目开发，不再需要使用虚拟环境时，可以使用以下命令退出：
```bash
deactivate
```
命令行提示符会恢复到激活虚拟环境之前的样子。

## 常见实践
### 项目初始化时创建虚拟环境
在开始一个新的 Python 项目时，首先创建虚拟环境是一个良好的习惯。这样可以确保项目从一开始就有一个独立的依赖环境，避免后续开发过程中出现依赖冲突。例如，在创建一个 Flask 项目时：
1. 创建项目目录：
```bash
mkdir my_flask_project
cd my_flask_project
```
2. 创建虚拟环境：
```bash
python -m venv.venv
```
3. 激活虚拟环境：
```bash
source.venv/bin/activate  # 在 Linux 或 macOS 上
#.venv\Scripts\activate  # 在 Windows 上
```
4. 安装 Flask：
```bash
pip install flask
```

### 共享虚拟环境配置
为了方便团队成员或者在不同开发环境中使用相同的虚拟环境配置，可以使用 `requirements.txt` 文件。在激活虚拟环境后，使用以下命令生成 `requirements.txt` 文件：
```bash
pip freeze > requirements.txt
```
这个文件会列出当前虚拟环境中安装的所有包及其版本号。团队成员在克隆项目后，可以使用以下命令安装相同的包：
```bash
pip install -r requirements.txt
```

## 最佳实践
### 版本控制虚拟环境相关文件
虽然虚拟环境本身不应该直接纳入版本控制（因为它包含大量二进制文件和特定于本地环境的内容），但 `requirements.txt` 文件应该纳入版本控制（例如使用 Git）。这样团队成员可以轻松获取项目所需的依赖项。

### 使用 `.gitignore` 忽略不必要的文件
在项目根目录创建一个 `.gitignore` 文件，并添加以下内容来忽略虚拟环境目录：
```
.venv
```
这样，在使用 Git 进行版本控制时，虚拟环境目录就不会被意外提交。

### 定期更新虚拟环境中的包
为了保持项目的安全性和兼容性，定期更新虚拟环境中的包是一个好习惯。可以使用以下命令更新所有包：
```bash
pip freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
```
不过，在更新包之前，建议先进行测试，以确保不会引入兼容性问题。

## 小结
`create venv python` 创建的虚拟环境是 Python 开发中非常重要的工具，它可以有效地隔离项目的依赖，避免不同项目之间的依赖冲突。通过掌握虚拟环境的创建、激活、安装包和退出等基本操作，以及在项目初始化、共享配置和版本控制等方面的实践和最佳实践，开发者能够更加高效、稳定地进行 Python 项目开发。

## 参考资料
- [Python官方文档 - venv模块](https://docs.python.org/3/library/venv.html)
- [Real Python - Working with Python Virtual Environments](https://realpython.com/python-virtual-environments-a-primer/)
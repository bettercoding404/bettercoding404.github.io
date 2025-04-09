---
title: "Python 3.12 已安装但仍使用 3.11：深入解析与实践"
description: "在 Python 的使用过程中，有时会遇到这样的情况：明明已经成功安装了 Python 3.12，但系统在运行时却仍然使用 Python 3.11。这一现象可能会给开发者带来一些困惑，尤其是在需要特定版本特性或修复的场景下。本文将详细探讨这一问题，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和解决该问题。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在 Python 的使用过程中，有时会遇到这样的情况：明明已经成功安装了 Python 3.12，但系统在运行时却仍然使用 Python 3.11。这一现象可能会给开发者带来一些困惑，尤其是在需要特定版本特性或修复的场景下。本文将详细探讨这一问题，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和解决该问题。

<!-- more -->
## 目录
1. **基础概念**
    - 理解 Python 版本管理
    - 为何出现已安装 3.12 却使用 3.11 的情况
2. **使用方法**
    - 确认 Python 版本安装情况
    - 切换默认 Python 版本
3. **常见实践**
    - 在不同项目中使用不同 Python 版本
    - 解决版本冲突问题
4. **最佳实践**
    - 使用虚拟环境管理版本
    - 自动化版本切换
5. **小结**
6. **参考资料**

## 基础概念
### 理解 Python 版本管理
Python 允许在同一系统上安装多个版本。这是因为不同的项目可能依赖于不同版本的 Python 及其标准库和第三方库。版本管理工具（如 `pyenv`、`virtualenv` 等）可以帮助用户轻松管理多个 Python 版本，并在不同项目之间切换。

### 为何出现已安装 3.12 却使用 3.11 的情况
- **环境变量设置**：系统的环境变量决定了在命令行中输入 `python` 时调用的版本。如果环境变量配置指向 Python 3.11，即使安装了 3.12，系统仍会默认使用 3.11。
- **系统默认版本**：某些操作系统在安装 Python 时会设置一个默认版本，这个默认版本可能是 3.11，而不会自动切换到新安装的 3.12。

## 使用方法
### 确认 Python 版本安装情况
在命令行中输入以下命令可以查看已安装的 Python 版本：
```bash
python --version
```
如果安装了多个版本，还可以使用 `pyenv versions`（假设安装了 `pyenv`）来查看所有版本列表：
```bash
pyenv versions
```

### 切换默认 Python 版本
#### 在 Windows 系统中
1. **通过环境变量设置**：
    - 右键点击“此电脑”，选择“属性”。
    - 点击“高级系统设置”，然后在弹出的窗口中点击“环境变量”。
    - 在“系统变量”中找到“Path”变量，点击“编辑”。
    - 将 Python 3.12 的安装路径（例如 `C:\Python312`）添加到路径的开头，确保它在 Python 3.11 的路径之前。
2. **使用 `pyenv`**：
    - 安装 `pyenv-win`。
    - 安装完成后，在命令行中使用以下命令设置全局默认版本：
    ```bash
    pyenv global 3.12.0
    ```

#### 在 Linux 和 macOS 系统中
1. **通过环境变量设置**：
    - 打开终端，编辑 `.bashrc` 或 `.zshrc` 文件（根据使用的 shell）：
    ```bash
    nano ~/.bashrc
    ```
    - 在文件末尾添加以下内容（假设 Python 3.12 的安装路径为 `/usr/local/bin/python3.12`）：
    ```bash
    export PATH=/usr/local/bin/python3.12:$PATH
    ```
    - 保存并退出文件，然后执行以下命令使更改生效：
    ```bash
    source ~/.bashrc
    ```
2. **使用 `pyenv`**：
    - 安装 `pyenv`。
    - 使用以下命令设置全局默认版本：
    ```bash
    pyenv global 3.12.0
    ```

## 常见实践
### 在不同项目中使用不同 Python 版本
使用 `virtualenv` 可以为每个项目创建独立的虚拟环境，每个环境可以指定使用特定的 Python 版本。
1. 安装 `virtualenv`：
```bash
pip install virtualenv
```
2. 为项目创建虚拟环境并指定 Python 版本（假设项目名为 `my_project`，使用 Python 3.12）：
```bash
virtualenv -p python3.12 my_project_env
```
3. 激活虚拟环境：
    - 在 Windows 中：
    ```bash
    my_project_env\Scripts\activate
    ```
    - 在 Linux 和 macOS 中：
    ```bash
    source my_project_env/bin/activate
    ```

### 解决版本冲突问题
当不同项目依赖不同版本的同一库时，可能会出现版本冲突。可以通过在每个虚拟环境中分别安装所需版本的库来解决。
例如，项目 A 需要 `numpy` 1.19，项目 B 需要 `numpy` 1.21：
1. 为项目 A 创建虚拟环境并安装 `numpy` 1.19：
```bash
virtualenv -p python3.12 project_a_env
source project_a_env/bin/activate
pip install numpy==1.19
```
2. 为项目 B 创建虚拟环境并安装 `numpy` 1.21：
```bash
virtualenv -p python3.12 project_b_env
source project_b_env/bin/activate
pip install numpy==1.21
```

## 最佳实践
### 使用虚拟环境管理版本
除了 `virtualenv`，还可以使用 `venv`（Python 3.3 及以上自带的虚拟环境创建工具）。
创建虚拟环境：
```bash
python3.12 -m venv my_venv
```
激活虚拟环境：
    - 在 Windows 中：
    ```bash
    my_venv\Scripts\activate
    ```
    - 在 Linux 和 macOS 中：
    ```bash
    source my_venv/bin/activate
    ```

### 自动化版本切换
可以编写脚本或使用工具来自动化版本切换过程。例如，使用 `direnv` 可以在进入项目目录时自动切换到该项目所需的 Python 版本和虚拟环境。
1. 安装 `direnv`：
    - 在 Linux 和 macOS 中：
    ```bash
    brew install direnv
    ```
    - 在 Windows 中，可以通过 Scoop 安装：
    ```bash
    scoop install direnv
    ```
2. 在项目目录中创建 `.envrc` 文件，内容如下：
```bash
layout python3.12
```
3. 允许 `direnv` 加载环境变量：
```bash
direnv allow
```

## 小结
通过深入了解 Python 版本管理的基础概念，掌握切换默认版本的方法，以及在不同项目中使用不同版本的常见实践和最佳实践，读者可以更好地应对“Python 3.12 已安装但仍使用 3.11”的问题。合理使用版本管理工具和虚拟环境，能够提高开发效率，减少版本冲突带来的问题。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- [pyenv 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}
- [virtualenv 官方文档](https://virtualenv.pypa.io/en/latest/){: rel="nofollow"}
- [direnv 官方文档](https://direnv.net/){: rel="nofollow"}
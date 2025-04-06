---
title: "Python 在 Ubuntu 上的安装：从基础到最佳实践"
description: "Python 作为一种广泛应用于软件开发、数据分析、人工智能等多个领域的高级编程语言，在 Ubuntu 系统上的安装是许多开发者和数据科学家的首要任务。本文将详细介绍在 Ubuntu 系统上安装 Python 的相关知识，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松掌握并高效运用 Python。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
Python 作为一种广泛应用于软件开发、数据分析、人工智能等多个领域的高级编程语言，在 Ubuntu 系统上的安装是许多开发者和数据科学家的首要任务。本文将详细介绍在 Ubuntu 系统上安装 Python 的相关知识，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松掌握并高效运用 Python。

<!-- more -->
## 目录
1. **基础概念**
    - Python 版本
    - Ubuntu 软件包管理
2. **使用方法**
    - 使用 Ubuntu 官方软件源安装 Python
    - 使用 Pyenv 安装多版本 Python
3. **常见实践**
    - 安装 Python 相关库
    - 创建虚拟环境
4. **最佳实践**
    - 配置环境变量
    - 管理 Python 项目依赖
5. **小结**
6. **参考资料**

## 基础概念
### Python 版本
Python 有两个主要版本：Python 2 和 Python 3。Python 2 于 2000 年发布，在很长一段时间内被广泛使用，但从 2020 年 1 月 1 日起，Python 2 不再获得官方支持。Python 3 于 2008 年发布，在语法、功能和安全性上进行了许多改进，是目前推荐使用的版本。

### Ubuntu 软件包管理
Ubuntu 使用 `apt`（Advanced Package Tool）进行软件包的管理。`apt` 可以自动处理软件包的依赖关系，方便用户安装、升级和卸载软件。通过 `apt` 安装的软件包通常来自 Ubuntu 官方软件源，这些软件包经过测试和验证，具有较高的稳定性。

## 使用方法
### 使用 Ubuntu 官方软件源安装 Python
Ubuntu 官方软件源提供了 Python 的安装包，安装过程非常简单。以下是在 Ubuntu 上安装 Python 3 的步骤：

1. 更新软件源列表：
    ```bash
    sudo apt update
    ```

2. 安装 Python 3：
    ```bash
    sudo apt install python3
    ```

3. 安装 Python 3 的包管理工具 `pip`：
    ```bash
    sudo apt install python3-pip
    ```

安装完成后，可以通过以下命令检查 Python 版本：
```bash
python3 --version
```

### 使用 Pyenv 安装多版本 Python
Pyenv 是一个用于管理多个 Python 版本的工具，它允许用户在同一系统上轻松切换不同版本的 Python。以下是安装 Pyenv 并使用它安装 Python 的步骤：

1. 安装依赖：
    ```bash
    sudo apt-get update
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    ```

2. 安装 Pyenv：
    ```bash
    curl https://pyenv.run | bash
    ```

3. 将 Pyenv 添加到环境变量中。编辑 `~/.bashrc` 文件，添加以下内容：
    ```bash
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    ```

4. 重新加载 `~/.bashrc`：
    ```bash
   . ~/.bashrc
    ```

5. 使用 Pyenv 安装 Python 版本。例如，安装 Python 3.9.12：
    ```bash
    pyenv install 3.9.12
    ```

6. 设置全局 Python 版本：
    ```bash
    pyenv global 3.9.12
    ```

## 常见实践
### 安装 Python 相关库
安装好 Python 后，通常需要安装一些第三方库来实现特定的功能。可以使用 `pip` 来安装库。例如，安装 `numpy` 库：
```bash
pip3 install numpy
```

如果要安装特定版本的库，可以指定版本号：
```bash
pip3 install numpy==1.21.0
```

### 创建虚拟环境
虚拟环境可以为每个项目创建独立的 Python 环境，避免不同项目之间的依赖冲突。以下是使用 `venv` 模块创建虚拟环境的步骤：

1. 创建虚拟环境：
    ```bash
    python3 -m venv myenv
    ```

2. 激活虚拟环境：
    ```bash
   . myenv/bin/activate
    ```

激活虚拟环境后，命令行提示符会显示当前虚拟环境的名称。在虚拟环境中安装的库只在该环境中有效。当完成项目开发后，可以使用以下命令退出虚拟环境：
```bash
deactivate
```

## 最佳实践
### 配置环境变量
为了更方便地使用 Python 和相关工具，可以配置环境变量。例如，将 `pip` 安装的库的路径添加到 `PATH` 环境变量中，这样在任何目录下都可以直接运行库的可执行文件。

编辑 `~/.bashrc` 文件，添加以下内容：
```bash
export PATH="$PATH:/home/yourusername/.local/bin"
```

重新加载 `~/.bashrc` 使设置生效：
```bash
. ~/.bashrc
```

### 管理 Python 项目依赖
对于大型项目，管理项目的依赖是非常重要的。可以使用 `requirements.txt` 文件来记录项目所依赖的库及其版本号。

生成 `requirements.txt` 文件：
```bash
pip3 freeze > requirements.txt
```

在新的环境中安装项目依赖：
```bash
pip3 install -r requirements.txt
```

## 小结
本文详细介绍了在 Ubuntu 系统上安装 Python 的方法，包括使用官方软件源和 Pyenv 安装不同版本的 Python。同时，讲解了常见的实践操作，如安装库和创建虚拟环境。最佳实践部分提供了配置环境变量和管理项目依赖的方法，帮助读者更好地使用 Python 进行项目开发。希望通过本文的介绍，读者能够深入理解并高效使用 Python 在 Ubuntu 上的安装和相关操作。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- [Ubuntu 官方文档](https://ubuntu.com/docs){: rel="nofollow"}
- [Pyenv 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}
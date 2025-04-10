---
title: "深入理解 Python requirements.txt"
description: "在 Python 项目开发过程中，管理项目所依赖的包及其版本是一项重要的任务。`requirements.txt` 文件就是 Python 生态系统中用于记录和管理项目依赖的标准方式。它能够确保项目在不同环境（开发、测试、生产）中都能以相同的依赖配置运行，极大地提高了项目的可重复性和可维护性。本文将详细介绍 `requirements.txt` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要工具。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 项目开发过程中，管理项目所依赖的包及其版本是一项重要的任务。`requirements.txt` 文件就是 Python 生态系统中用于记录和管理项目依赖的标准方式。它能够确保项目在不同环境（开发、测试、生产）中都能以相同的依赖配置运行，极大地提高了项目的可重复性和可维护性。本文将详细介绍 `requirements.txt` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要工具。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 生成 `requirements.txt`
    - 安装依赖
3. 常见实践
    - 版本控制
    - 环境隔离
4. 最佳实践
    - 分层管理
    - 定期更新
    - 明确注释
5. 小结
6. 参考资料

## 基础概念
`requirements.txt` 是一个纯文本文件，其中每行指定一个 Python 包及其版本号（可选）。例如：

```txt
Flask==1.1.2
requests>=2.25.1
```

上述示例中，`Flask` 包被指定为精确版本 `1.1.2`，而 `requests` 包要求版本大于等于 `2.25.1`。这种指定方式能够确保项目在不同环境中使用相同或兼容的包版本，避免因包版本差异导致的兼容性问题。

## 使用方法

### 生成 `requirements.txt`
在项目开发过程中，随着功能的增加，会引入各种依赖包。为了记录这些依赖，可以使用 `pip freeze` 命令生成 `requirements.txt` 文件。假设你在一个虚拟环境中安装了多个包，在命令行中执行以下命令：

```bash
pip freeze > requirements.txt
```

这将把当前虚拟环境中安装的所有包及其版本信息输出到 `requirements.txt` 文件中。例如，执行该命令后，`requirements.txt` 文件内容可能如下：

```txt
click==7.1.2
Flask==1.1.2
itsdangerous==1.1.0
Jinja2==2.11.3
MarkupSafe==1.1.1
Werkzeug==1.0.1
```

### 安装依赖
当你在新环境中部署项目时，需要安装项目所依赖的包。可以使用 `pip install -r` 命令从 `requirements.txt` 文件中读取依赖并进行安装。例如：

```bash
pip install -r requirements.txt
```

上述命令会根据 `requirements.txt` 文件中的记录，下载并安装相应的包及其依赖项。

## 常见实践

### 版本控制
在 `requirements.txt` 文件中精确指定包的版本号是一个良好的实践。这样可以确保项目在不同环境中使用相同版本的包，避免因包版本更新导致的兼容性问题。例如：

```txt
Django==3.2.7
numpy==1.19.5
```

### 环境隔离
使用虚拟环境（如 `venv` 或 `virtualenv`）与 `requirements.txt` 配合是常见的做法。虚拟环境可以创建一个独立的 Python 环境，避免不同项目之间的依赖冲突。在虚拟环境中生成和安装 `requirements.txt` 中的依赖，能够确保项目的依赖环境是干净且可重复的。

例如，使用 `venv` 创建虚拟环境并安装依赖的步骤如下：

1. 创建虚拟环境：

```bash
python3 -m venv myenv
```

2. 激活虚拟环境：
    - 在 Windows 上：

```bash
myenv\Scripts\activate
```

    - 在 Linux 或 Mac 上：

```bash
source myenv/bin/activate
```

3. 安装依赖：

```bash
pip install -r requirements.txt
```

## 最佳实践

### 分层管理
对于大型项目，可以采用分层管理 `requirements.txt` 的方式。例如，创建一个基础的 `base.txt` 文件，包含项目通用的核心依赖；然后根据不同的环境（开发、测试、生产）创建相应的 `dev.txt`、`test.txt` 和 `prod.txt` 文件，这些文件可以继承 `base.txt` 并添加特定环境的依赖。

例如，`base.txt` 文件内容：

```txt
Flask==1.1.2
requests>=2.25.1
```

`dev.txt` 文件内容：

```txt
-r base.txt
Flask-DebugToolbar==0.11.0
```

这样在开发环境中，除了安装基础依赖，还会安装 `Flask-DebugToolbar` 用于调试。

### 定期更新
定期检查并更新 `requirements.txt` 中的依赖版本，以获取最新的功能、修复和安全更新。可以使用工具如 `pip-review` 来帮助检查哪些包有可用的更新。

安装 `pip-review`：

```bash
pip install pip-review
```

检查更新：

```bash
pip-review --local --interactive
```

该命令会列出当前环境中可更新的包，并询问是否要更新。

### 明确注释
在 `requirements.txt` 文件中添加注释，解释某些依赖的用途或特殊要求。这样可以提高文件的可读性和可维护性。例如：

```txt
# 核心 Web 框架
Flask==1.1.2
# 用于发送 HTTP 请求
requests>=2.25.1
```

## 小结
`requirements.txt` 是 Python 项目中管理依赖的重要工具，通过记录项目所需的包及其版本信息，确保项目在不同环境中的可重复性和稳定性。掌握其基础概念、使用方法、常见实践和最佳实践，能够帮助开发人员更高效地管理项目依赖，提高开发效率和项目质量。

## 参考资料
- [pip官方文档](https://pip.pypa.io/en/stable/){: rel="nofollow"}
- [Python官方文档 - 虚拟环境](https://docs.python.org/zh-cn/3/library/venv.html){: rel="nofollow"}
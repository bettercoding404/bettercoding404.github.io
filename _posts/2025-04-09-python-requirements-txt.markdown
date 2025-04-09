---
title: "深入理解 Python requirements.txt"
description: "在 Python 项目开发过程中，依赖管理是一个至关重要的环节。不同的项目可能会使用各种各样的第三方库，而且这些库还会不断更新版本。`requirements.txt` 文件就是 Python 生态系统中用于管理项目依赖的一个强大工具，它能够记录项目运行所需的所有依赖库及其版本号，方便项目在不同环境中进行部署和迁移。本文将详细介绍 `requirements.txt` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握项目依赖管理。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在 Python 项目开发过程中，依赖管理是一个至关重要的环节。不同的项目可能会使用各种各样的第三方库，而且这些库还会不断更新版本。`requirements.txt` 文件就是 Python 生态系统中用于管理项目依赖的一个强大工具，它能够记录项目运行所需的所有依赖库及其版本号，方便项目在不同环境中进行部署和迁移。本文将详细介绍 `requirements.txt` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握项目依赖管理。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 生成 `requirements.txt` 文件
    - 安装依赖
3. 常见实践
    - 版本控制
    - 环境隔离
4. 最佳实践
    - 分层管理依赖
    - 定期更新依赖
5. 小结
6. 参考资料

## 基础概念
`requirements.txt` 是一个纯文本文件，它按照特定的格式列出了项目所依赖的 Python 包及其版本号。每一行通常包含一个包名及其对应的版本约束，例如：

```txt
Flask==1.1.2
requests==2.25.1
```

这里 `Flask` 和 `requests` 是包名，`==1.1.2` 和 `==2.25.1` 分别是对应的版本号。通过这种方式，我们可以精确地指定项目运行所需要的库版本，确保在不同环境中项目的依赖是一致的。

## 使用方法
### 生成 `requirements.txt` 文件
在项目开发过程中，我们可以使用 `pip freeze` 命令来生成 `requirements.txt` 文件。`pip freeze` 会列出当前 Python 环境中已经安装的所有包及其版本号。

假设我们在一个虚拟环境中安装了 `Flask` 和 `requests` 两个库，在命令行中执行以下命令：

```bash
pip freeze > requirements.txt
```

上述命令会将当前环境中所有已安装包的信息输出到 `requirements.txt` 文件中。生成的文件内容可能如下：

```txt
Click==7.1.2
Flask==1.1.2
itsdangerous==1.1.0
Jinja2==2.11.3
MarkupSafe==1.1.1
requests==2.25.1
Werkzeug==1.0.1
```

### 安装依赖
当我们在新的环境中部署项目时，可以使用 `pip install -r requirements.txt` 命令来安装 `requirements.txt` 文件中列出的所有依赖包。例如：

```bash
pip install -r requirements.txt
```

这条命令会读取 `requirements.txt` 文件中的每一行，根据包名和版本号从 PyPI（Python Package Index）下载并安装相应的包。

## 常见实践
### 版本控制
在 `requirements.txt` 中精确指定包的版本号是一种常见的做法，这样可以确保项目在不同环境中的依赖一致性。但是，过于严格的版本控制可能会导致在升级依赖时需要进行大量的修改。因此，可以使用一些灵活的版本约束语法，例如：

```txt
Flask>=1.1.2,<1.2.0
requests~=2.25.1
```

`>=1.1.2,<1.2.0` 表示版本大于等于 `1.1.2` 且小于 `1.2.0`，`~=2.25.1` 表示版本大于等于 `2.25.1` 且小于 `2.26.0`（即允许小版本号的升级）。

### 环境隔离
为了避免不同项目之间的依赖冲突，建议使用虚拟环境。例如，使用 `venv` 模块创建虚拟环境：

```bash
python3 -m venv myenv
source myenv/bin/activate  # 在 Windows 上使用 myenv\Scripts\activate
```

在虚拟环境中安装和管理依赖，然后生成 `requirements.txt` 文件。这样，每个项目都有自己独立的依赖环境，不会相互干扰。

## 最佳实践
### 分层管理依赖
对于大型项目，可以将依赖进行分层管理。例如，将基础依赖（如数据库连接库、日志库等）和项目特定的业务依赖分开记录在不同的文件中，然后在 `requirements.txt` 中通过 `-r` 指令引入这些文件。

```txt
# requirements.txt
-r base.txt
-r business.txt
```

```txt
# base.txt
psycopg2==2.8.6
logging==0.5.1.2
```

```txt
# business.txt
Flask==1.1.2
requests==2.25.1
```

### 定期更新依赖
定期检查和更新 `requirements.txt` 中的依赖版本，以获取新功能、修复的漏洞和性能提升。可以使用工具如 `pip-review` 来帮助检测哪些依赖有可用的更新：

```bash
pip install pip-review
pip-review --local --interactive
```

上述命令会列出当前环境中可更新的包，并提示是否要更新。

## 小结
`requirements.txt` 是 Python 项目依赖管理的重要工具，通过精确记录项目所依赖的包及其版本号，可以确保项目在不同环境中的一致性和可重复性。掌握其生成、安装以及常见和最佳实践，能够帮助我们更高效地开发和部署 Python 项目，减少因依赖问题带来的困扰。

## 参考资料
- [pip官方文档](https://pip.pypa.io/en/stable/){: rel="nofollow"}
- [Python官方文档 - 虚拟环境](https://docs.python.org/zh-cn/3/library/venv.html){: rel="nofollow"}
- [pip-review文档](https://pypi.org/project/pip-review/){: rel="nofollow"}
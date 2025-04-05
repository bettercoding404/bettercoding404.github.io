---
title: "深入理解 Python requirements.txt"
description: "在 Python 项目开发过程中，管理项目依赖是至关重要的一环。`requirements.txt` 文件就是解决这一问题的得力工具。它能够清晰地记录项目所依赖的 Python 包及其版本信息，方便在不同环境中快速、准确地安装项目所需的全部依赖，确保项目的可重复性和稳定性。本文将深入探讨 `requirements.txt` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要工具。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 项目开发过程中，管理项目依赖是至关重要的一环。`requirements.txt` 文件就是解决这一问题的得力工具。它能够清晰地记录项目所依赖的 Python 包及其版本信息，方便在不同环境中快速、准确地安装项目所需的全部依赖，确保项目的可重复性和稳定性。本文将深入探讨 `requirements.txt` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要工具。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 生成 `requirements.txt` 文件
    - 安装依赖
3. 常见实践
    - 版本控制
    - 区分开发和生产依赖
4. 最佳实践
    - 保持简洁
    - 定期更新
    - 使用虚拟环境
5. 小结
6. 参考资料

## 基础概念
`requirements.txt` 是一个纯文本文件，用于指定 Python 项目所依赖的包及其版本号。每一行通常包含一个包名及其对应的版本约束，格式如下：
```
package_name==version_number
```
例如：
```
Flask==1.1.2
numpy==1.19.5
```
这种格式清晰明了，使得其他开发者或者部署环境能够准确地知道项目运行所需要的依赖情况。

## 使用方法

### 生成 `requirements.txt` 文件
在项目开发过程中，我们通常使用 `pip freeze` 命令来生成 `requirements.txt` 文件。`pip freeze` 会列出当前环境中已安装的所有 Python 包及其版本信息。

首先，确保你在项目的虚拟环境中（如果没有使用虚拟环境，这一步也可以在全局 Python 环境中进行，但不推荐）。然后在命令行中执行以下命令：
```bash
pip freeze > requirements.txt
```
这将把当前环境中所有已安装的包及其版本信息输出到 `requirements.txt` 文件中。

### 安装依赖
当你拿到一个包含 `requirements.txt` 文件的项目时，要在本地环境安装项目所需的所有依赖，只需要执行以下命令：
```bash
pip install -r requirements.txt
```
`-r` 参数表示从指定的文件（这里就是 `requirements.txt`）中读取依赖列表并进行安装。

## 常见实践

### 版本控制
在 `requirements.txt` 文件中明确指定包的版本号非常重要。这样可以确保在不同的开发、测试和生产环境中，项目使用的是相同版本的依赖，避免因依赖版本不一致导致的兼容性问题。例如：
```
Django==3.2.7
requests==2.26.0
```
通过指定版本号，无论在谁的开发环境或者服务器上部署，只要按照 `requirements.txt` 安装依赖，都能保证使用的是相同版本的包。

### 区分开发和生产依赖
在实际项目中，开发环境可能需要一些额外的工具和包，而生产环境并不需要。比如开发过程中用于调试的 `pdbpp`，用于代码检查的 `flake8` 等。为了区分这些依赖，可以创建两个文件：`requirements.txt` 用于生产依赖，`requirements-dev.txt` 用于开发依赖。

生成这两个文件的方式如下：
```bash
# 生成生产依赖文件
pip freeze | grep -vE "pdbpp|flake8" > requirements.txt

# 生成开发依赖文件
pip freeze | grep -E "pdbpp|flake8" > requirements-dev.txt
```
安装时分别使用：
```bash
# 安装生产依赖
pip install -r requirements.txt

# 安装开发依赖
pip install -r requirements-dev.txt
```

## 最佳实践

### 保持简洁
`requirements.txt` 文件应该只包含项目运行所必需的依赖。避免将一些临时安装的包或者与项目核心功能无关的包添加进去。这样可以使依赖列表清晰明了，易于维护和管理。

### 定期更新
随着项目的发展，依赖的包也可能需要更新以获取新功能、修复漏洞等。定期检查和更新 `requirements.txt` 中的依赖版本是个好习惯。但在更新时，一定要进行充分的测试，确保新版本的包不会对项目造成兼容性问题。

### 使用虚拟环境
虚拟环境是 Python 项目开发中不可或缺的一部分。它可以为每个项目创建独立的 Python 环境，避免不同项目之间的依赖冲突。在生成 `requirements.txt` 文件和安装依赖时，务必在相应项目的虚拟环境中进行操作。例如使用 `venv` 创建虚拟环境：
```bash
python -m venv myenv
source myenv/bin/activate  # 在 Windows 上使用 myenv\Scripts\activate
```
然后在激活的虚拟环境中进行依赖的管理和操作。

## 小结
`requirements.txt` 文件在 Python 项目开发中扮演着重要角色，它帮助我们有效地管理项目依赖，确保项目在不同环境中的可重复性和稳定性。通过掌握其基础概念、使用方法、常见实践以及最佳实践，我们能够更加高效地开发和部署 Python 项目，减少因依赖问题带来的困扰。

## 参考资料
- [官方 Python 文档](https://docs.python.org/3/){: rel="nofollow"}
- [pip 官方文档](https://pip.pypa.io/en/stable/){: rel="nofollow"}
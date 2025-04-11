---
title: "Python Requirements.txt：项目依赖管理的得力助手"
description: "在 Python 项目开发过程中，管理项目所依赖的包及其版本是一项至关重要的任务。不同的项目可能依赖于不同版本的同一个库，并且随着项目的发展，依赖项也会不断变化。`requirements.txt` 文件就是解决这一问题的有效工具，它能清晰地记录项目所需要的所有包及其版本信息，方便在不同环境中快速搭建相同的运行环境。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 项目开发过程中，管理项目所依赖的包及其版本是一项至关重要的任务。不同的项目可能依赖于不同版本的同一个库，并且随着项目的发展，依赖项也会不断变化。`requirements.txt` 文件就是解决这一问题的有效工具，它能清晰地记录项目所需要的所有包及其版本信息，方便在不同环境中快速搭建相同的运行环境。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 创建 `requirements.txt` 文件
    - 安装依赖
3. 常见实践
    - 开发环境与生产环境的依赖管理
    - 版本控制
4. 最佳实践
    - 定期更新依赖
    - 处理间接依赖
    - 多环境依赖管理
5. 小结
6. 参考资料

## 基础概念
`requirements.txt` 是一个纯文本文件，用于指定 Python 项目所需的所有包及其版本号。每一行代表一个依赖项，格式通常为 `package_name==version`。例如：
```
numpy==1.19.5
pandas==1.2.4
matplotlib==3.4.3
```
这种格式明确地定义了项目运行所需的包及其具体版本，确保在不同环境中安装的依赖是一致的。

## 使用方法
### 创建 `requirements.txt` 文件
有多种方式可以创建 `requirements.txt` 文件。最常用的方法是使用 `pip freeze` 命令。假设你已经在当前环境中安装了项目所需的所有包，在命令行中运行以下命令：
```bash
pip freeze > requirements.txt
```
这会将当前环境中安装的所有包及其版本信息输出到 `requirements.txt` 文件中。

如果你想只记录项目中实际使用的包，可以使用 `pipreqs` 工具。首先安装 `pipreqs`：
```bash
pip install pipreqs
```
然后在项目根目录下运行：
```bash
pipreqs./
```
`pipreqs` 会自动分析项目中的 Python 文件，检测导入的包，并生成 `requirements.txt` 文件。

### 安装依赖
当你拿到一个包含 `requirements.txt` 文件的项目时，要在新环境中安装所有依赖，可以使用以下命令：
```bash
pip install -r requirements.txt
```
这会读取 `requirements.txt` 文件中的每一行，按照指定的版本安装相应的包。

## 常见实践
### 开发环境与生产环境的依赖管理
在开发过程中，我们可能会安装一些仅用于开发的工具，如代码检查工具（`flake8`）、测试框架（`pytest`）等。这些工具在生产环境中并不需要。因此，可以创建两个 `requirements.txt` 文件，一个用于开发环境（例如 `requirements-dev.txt`），一个用于生产环境（`requirements.txt`）。

开发环境的 `requirements-dev.txt` 可以包含开发工具：
```
flake8==3.9.2
pytest==6.2.5
numpy==1.19.5
pandas==1.2.4
```
生产环境的 `requirements.txt` 只包含项目运行必需的包：
```
numpy==1.19.5
pandas==1.2.4
```

### 版本控制
将 `requirements.txt` 文件纳入版本控制系统（如 Git）是一个好习惯。这样，团队成员可以方便地获取最新的依赖信息，并且在出现问题时可以追溯到特定版本的依赖配置。

## 最佳实践
### 定期更新依赖
定期检查并更新 `requirements.txt` 中的依赖版本是很重要的。可以使用 `pip-review` 工具来查看哪些包有可用的更新：
```bash
pip install pip-review
pip-review --local --interactive
```
该命令会列出可更新的包，并询问你是否要更新。更新后，记得重新生成 `requirements.txt` 文件。

### 处理间接依赖
有时候，项目直接依赖的包可能会依赖其他包（间接依赖）。在更新依赖时，要注意间接依赖可能会带来的兼容性问题。可以使用 `pipdeptree` 工具来查看依赖树：
```bash
pip install pipdeptree
pipdeptree
```
这有助于了解项目的依赖结构，避免因更新某个包而破坏其他依赖关系。

### 多环境依赖管理
对于有多个运行环境（如开发、测试、生产）的项目，可以使用 `pipenv` 或 `poetry` 等工具。这些工具可以更方便地管理不同环境的依赖，并且支持创建虚拟环境。

例如，使用 `poetry`：
1. 初始化项目：
```bash
poetry init
```
2. 添加依赖：
```bash
poetry add numpy pandas
```
3. 生成 `requirements.txt` 文件：
```bash
poetry export -f requirements.txt --output requirements.txt
```

## 小结
`requirements.txt` 文件是 Python 项目依赖管理的重要组成部分。通过清晰地记录项目所需的包及其版本，它使得项目在不同环境中的部署变得更加可靠和高效。合理运用创建、安装依赖的方法，以及遵循常见实践和最佳实践，能够帮助开发者更好地管理项目依赖，减少因依赖问题导致的错误和调试成本。

## 参考资料
- [Python官方文档 - pip](https://pip.pypa.io/en/stable/){: rel="nofollow"}
- [pipreqs 官方文档](https://github.com/bndr/pipreqs){: rel="nofollow"}
- [pip-review 官方文档](https://github.com/jgonggrijp/pip-review){: rel="nofollow"}
- [pipdeptree 官方文档](https://github.com/naiquevin/pipdeptree){: rel="nofollow"}
- [Poetry 官方文档](https://python-poetry.org/docs/){: rel="nofollow"}
- [Pipenv 官方文档](https://pipenv.pypa.io/en/latest/){: rel="nofollow"}
---
title: "深入理解 Python requirements.txt"
description: "在 Python 项目开发过程中，管理项目依赖是一项至关重要的任务。不同的项目可能依赖于各种不同版本的 Python 库，如何确保项目在不同环境（开发、测试、生产）中使用相同的依赖版本呢？`requirements.txt` 文件就是解决这一问题的关键工具。它以一种标准化的方式记录项目所依赖的 Python 库及其版本号，使得项目的部署和迁移变得更加容易。本文将详细介绍 `requirements.txt` 的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 项目开发过程中，管理项目依赖是一项至关重要的任务。不同的项目可能依赖于各种不同版本的 Python 库，如何确保项目在不同环境（开发、测试、生产）中使用相同的依赖版本呢？`requirements.txt` 文件就是解决这一问题的关键工具。它以一种标准化的方式记录项目所依赖的 Python 库及其版本号，使得项目的部署和迁移变得更加容易。本文将详细介绍 `requirements.txt` 的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 生成 `requirements.txt`
    - 安装依赖
3. 常见实践
    - 版本控制
    - 不同环境的依赖管理
4. 最佳实践
    - 保持简洁
    - 定期更新
    - 分块管理
5. 小结
6. 参考资料

## 基础概念
`requirements.txt` 是一个纯文本文件，用于指定 Python 项目所需的所有依赖包及其版本号。文件中的每一行都包含一个包名和可选的版本说明符。例如：

```txt
Flask==1.1.2
numpy>=1.19.5
```

第一行指定项目需要 `Flask` 库的版本为 `1.1.2`，第二行表示需要 `numpy` 库，版本大于等于 `1.19.5`。通过这种方式，开发人员可以精确控制项目所依赖的库版本，避免因库版本不一致导致的兼容性问题。

## 使用方法

### 生成 `requirements.txt`
在开发过程中，当项目依赖的库逐渐增多时，手动编写 `requirements.txt` 会变得繁琐且容易出错。幸运的是，有多种方法可以自动生成这个文件。

- **使用 `pip freeze` 命令**：`pip freeze` 命令会列出当前环境中安装的所有 Python 包及其版本号。我们可以将这个输出重定向到 `requirements.txt` 文件中。在命令行中进入项目的虚拟环境（推荐），然后运行以下命令：

```bash
pip freeze > requirements.txt
```

这个命令会将当前环境中所有已安装的包及其版本信息写入 `requirements.txt` 文件。

- **使用 `pipreqs` 工具**：`pipreqs` 是一个更智能的工具，它可以分析项目中的 Python 代码，自动检测项目实际使用的包，并生成 `requirements.txt` 文件。首先需要安装 `pipreqs`：

```bash
pip install pipreqs
```

然后在项目根目录下运行：

```bash
pipreqs.
```

这个命令会在当前目录下生成 `requirements.txt` 文件，并且只会列出项目实际依赖的包。

### 安装依赖
当我们拿到一个包含 `requirements.txt` 文件的项目时，如何安装项目所需的所有依赖呢？使用 `pip install` 命令结合 `requirements.txt` 文件即可。在命令行中进入项目的虚拟环境，运行以下命令：

```bash
pip install -r requirements.txt
```

`-r` 参数表示从指定的文件（这里是 `requirements.txt`）中读取依赖列表并安装相应的包。

## 常见实践

### 版本控制
在 `requirements.txt` 文件中指定精确的版本号是一种良好的实践。这样可以确保在不同环境中安装的包版本完全一致，避免因版本差异导致的问题。例如：

```txt
Django==3.2.7
requests==2.26.0
```

然而，过于严格的版本控制也可能带来一些问题，比如当依赖的库发布了重要的安全更新时，需要手动更新 `requirements.txt` 文件中的版本号。在这种情况下，可以使用一些宽松的版本说明符，如 `~=`（兼容指定版本的主版本和次版本）或 `>=`（大于等于指定版本）。

### 不同环境的依赖管理
在实际项目中，开发、测试和生产环境可能需要不同的依赖配置。例如，开发环境可能需要一些调试工具和测试框架，而生产环境则只需要项目运行所需的核心依赖。

可以通过创建多个 `requirements.txt` 文件来解决这个问题，例如 `requirements-dev.txt`、`requirements-test.txt` 和 `requirements-prod.txt`。

```bash
# 开发环境依赖
pip freeze > requirements-dev.txt

# 测试环境依赖（可以在开发环境依赖基础上添加测试相关的包）
pip freeze | grep -vE 'package1|package2' > requirements-test.txt

# 生产环境依赖（只包含核心运行时依赖）
pip freeze | grep -E 'core_package1|core_package2' > requirements-prod.txt
```

在不同环境中安装依赖时，只需要指定相应的 `requirements.txt` 文件即可：

```bash
# 开发环境安装依赖
pip install -r requirements-dev.txt

# 测试环境安装依赖
pip install -r requirements-test.txt

# 生产环境安装依赖
pip install -r requirements-prod.txt
```

## 最佳实践

### 保持简洁
`requirements.txt` 文件应该只包含项目真正依赖的包。避免包含一些临时安装的包或者与项目核心功能无关的包。定期清理 `requirements.txt` 文件，删除不再使用的依赖。

### 定期更新
定期检查依赖包的更新情况，并在 `requirements.txt` 文件中更新版本号。可以使用一些工具，如 `pip-review` 来帮助检查哪些依赖包有可用更新。

```bash
pip install pip-review
pip-review --local --interactive
```

这个命令会列出当前环境中可更新的包，并询问是否要更新它们。更新后，重新生成 `requirements.txt` 文件。

### 分块管理
对于大型项目，依赖可能非常多。可以将 `requirements.txt` 文件按功能或模块进行分块管理。例如，创建 `requirements-api.txt`、`requirements-db.txt` 等文件，分别管理 API 相关的依赖和数据库相关的依赖。然后在主 `requirements.txt` 文件中通过 ` -r` 参数引入这些子文件：

```txt
-r requirements-api.txt
-r requirements-db.txt
```

这样可以使依赖管理更加清晰和易于维护。

## 小结
`requirements.txt` 是 Python 项目依赖管理的重要工具，它能够确保项目在不同环境中的一致性和可重复性。通过正确使用和管理 `requirements.txt` 文件，开发人员可以更高效地开发、测试和部署 Python 项目。掌握生成、安装依赖以及常见和最佳实践，将有助于提升项目的质量和可维护性。

## 参考资料
- [pip官方文档](https://pip.pypa.io/en/stable/){: rel="nofollow"}
- [pipreqs官方文档](https://github.com/bndr/pipreqs){: rel="nofollow"}
- [Python官方文档 - 虚拟环境和包](https://docs.python.org/zh-cn/3/tutorial/venv.html){: rel="nofollow"}
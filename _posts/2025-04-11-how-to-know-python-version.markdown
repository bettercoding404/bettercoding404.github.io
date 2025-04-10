---
title: "如何查看 Python 版本"
description: "在 Python 开发过程中，了解当前使用的 Python 版本至关重要。不同的 Python 版本在语法、功能以及标准库等方面存在差异。知晓 Python 版本可以帮助开发者确保代码的兼容性，合理选择开发工具和依赖库等。本文将详细介绍查看 Python 版本的基础概念、多种使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 开发过程中，了解当前使用的 Python 版本至关重要。不同的 Python 版本在语法、功能以及标准库等方面存在差异。知晓 Python 版本可以帮助开发者确保代码的兼容性，合理选择开发工具和依赖库等。本文将详细介绍查看 Python 版本的基础概念、多种使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **在命令行中查看**
    - **在 Python 脚本中查看**
3. **常见实践**
    - **在不同操作系统下查看版本**
    - **与开发环境结合查看版本**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
Python 有多个主要版本，如 Python 2 和 Python 3，每个主要版本又包含多个次要版本和补丁版本。版本号通常遵循语义化版本号规则，格式为 `主版本号.次版本号.补丁版本号`。例如，`3.8.10` 中，`3` 是主版本号，`8` 是次版本号，`10` 是补丁版本号。主版本号的变化通常意味着较大的功能更新和不兼容的语法改变；次版本号的更新会引入新功能但保持向后兼容性；补丁版本号则主要用于修复漏洞。

## 使用方法

### 在命令行中查看
- **Windows 系统**
打开命令提示符（CMD），输入以下命令：
    ```bash
    python --version
    ```
    例如，如果安装的是 Python 3.9.6，命令行将输出 `Python 3.9.6`。

    另外，也可以进入 Python 交互式环境，然后输入以下内容：
    ```bash
    python
    ```
    在 Python 交互式环境中，输入：
    ```python
    import sys
    print(sys.version)
    ```
    输出结果会包含更详细的版本信息，例如 `3.9.6 (tags/v3.9.6:db3ff76, Jun 28 2021, 15:26:21) [MSC v.1929 64 bit (AMD64)]`

- **Linux 系统**
在终端中输入：
    ```bash
    python3 --version
    ```
    如果系统同时安装了 Python 2 和 Python 3，`python --version` 可能指向 Python 2，使用 `python3 --version` 确保查看的是 Python 3 版本。同样，也可以进入 Python 交互式环境查看详细版本信息：
    ```bash
    python3
    ```
    在交互式环境中：
    ```python
    import sys
    print(sys.version)
    ```

- **macOS 系统**
与 Linux 系统类似，在终端中输入：
    ```bash
    python3 --version
    ```
    进入 Python 交互式环境查看详细版本信息的方法也相同：
    ```bash
    python3
    ```
    在交互式环境中：
    ```python
    import sys
    print(sys.version)
    ```

### 在 Python 脚本中查看
在 Python 脚本中，可以使用 `sys` 模块来获取版本信息。创建一个 Python 脚本，例如 `version_check.py`，内容如下：
```python
import sys

print("Python 版本:", sys.version)
```
保存脚本后，在命令行中运行：
```bash
python version_check.py
```
输出结果将显示当前 Python 的版本信息。

## 常见实践

### 在不同操作系统下查看版本
在进行跨平台开发时，需要确保在不同操作系统上使用的 Python 版本一致或兼容。例如，在开发一个 Web 应用时，开发环境是 Windows 系统，而生产环境是 Linux 服务器。在 Windows 系统上，按照上述方法查看 Python 版本后，在 Linux 服务器上也进行相同的操作，对比两个环境中的 Python 版本是否符合预期。如果不一致，可能需要进行版本升级或降级，以确保代码的兼容性。

### 与开发环境结合查看版本
在使用集成开发环境（IDE）如 PyCharm、Visual Studio Code 等进行开发时，也需要关注当前项目所使用的 Python 版本。在 PyCharm 中，可以通过以下步骤查看：
1. 打开项目。
2. 点击菜单栏中的 `File` -> `Settings`（Windows/Linux）或 `PyCharm` -> `Preferences`（macOS）。
3. 在弹出的窗口中，选择 `Project: [项目名称]` -> `Python Interpreter`。
4. 在 `Python Interpreter` 页面，可以看到当前项目所使用的 Python 解释器版本。

在 Visual Studio Code 中，通过左下角的状态栏切换 Python 解释器，点击解释器名称可以查看已安装的 Python 版本列表，并选择合适的版本。这样可以确保在开发过程中使用正确的 Python 版本，避免因版本不兼容导致的问题。

## 最佳实践
- **自动化版本检查**：在项目的构建脚本或启动脚本中添加版本检查功能。例如，在 `setup.py` 中添加代码检查 Python 版本是否满足项目要求：
```python
import sys

if sys.version_info < (3, 8):
    raise SystemExit("项目需要 Python 3.8 及以上版本")
```
这样，当运行项目时，如果 Python 版本不满足要求，会自动报错提示。

- **记录版本信息**：在项目的文档中记录所使用的 Python 版本以及相关依赖库的版本信息。这有助于其他开发者在克隆项目或进行维护时，能够快速搭建出与原开发环境相似的环境，减少因版本不一致导致的问题。

- **定期更新版本**：关注 Python 官方发布的新版本信息，及时将项目中的 Python 版本进行更新。但在更新前，需要进行充分的测试，确保项目的兼容性。可以使用虚拟环境来隔离不同版本的 Python 和依赖库，方便进行版本升级测试。

## 小结
本文详细介绍了查看 Python 版本的多种方法，包括在命令行中使用 `--version` 选项和在 Python 脚本中通过 `sys` 模块获取版本信息。同时，阐述了在不同操作系统和开发环境下查看版本的常见实践，以及确保项目版本兼容性的最佳实践。掌握如何查看和管理 Python 版本是 Python 开发者的重要技能，有助于提高开发效率和代码质量。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- 各操作系统官方文档中关于命令行操作的部分。
- 各 IDE 的官方文档中关于查看 Python 版本的相关内容。
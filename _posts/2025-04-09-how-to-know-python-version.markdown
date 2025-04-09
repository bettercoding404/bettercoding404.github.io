---
title: "如何查看 Python 版本"
description: "在 Python 开发过程中，了解当前使用的 Python 版本是非常重要的。不同版本的 Python 在语法、库的支持以及性能等方面都可能存在差异。知晓 Python 版本有助于我们确保代码的兼容性，合理选择适合的库和工具，以及排查可能出现的版本相关问题。本文将详细介绍查看 Python 版本的基础概念、多种使用方法、常见实践场景以及最佳实践。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在 Python 开发过程中，了解当前使用的 Python 版本是非常重要的。不同版本的 Python 在语法、库的支持以及性能等方面都可能存在差异。知晓 Python 版本有助于我们确保代码的兼容性，合理选择适合的库和工具，以及排查可能出现的版本相关问题。本文将详细介绍查看 Python 版本的基础概念、多种使用方法、常见实践场景以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 在命令行中查看
    - 在 Python 脚本中查看
3. 常见实践
    - 新环境搭建时确认版本
    - 解决兼容性问题时查看版本
4. 最佳实践
    - 自动化版本检查
    - 记录版本信息
5. 小结
6. 参考资料

## 基础概念
Python 版本号由三个部分组成，主版本号.次版本号.修订号，例如 3.8.5。主版本号的变化通常意味着较大的语法和功能改动，可能导致代码兼容性问题；次版本号的更新一般会引入新功能或对现有功能进行改进；修订号主要是针对一些小的 bug 修复和性能优化。了解版本号的构成有助于我们评估不同版本之间的差异以及对代码的潜在影响。

## 使用方法

### 在命令行中查看
- **Windows 系统**：
    - 打开命令提示符（CMD）。在开始菜单中搜索“命令提示符”并打开。
    - 输入 `python --version` 命令，按下回车键，即可看到当前 Python 的版本号。例如，输出结果可能为 `Python 3.9.7`。
    - 如果你安装了多个 Python 版本，并且设置了不同的环境变量，也可以使用 `py --version` 命令，它会根据系统默认设置显示相应的 Python 版本。

- **Linux 和 macOS 系统**：
    - 打开终端。在 Linux 系统中，可以通过快捷键（如 Ctrl + Alt + T）打开终端；在 macOS 系统中，打开“应用程序”文件夹中的“终端”应用。
    - 输入 `python3 --version` 命令，按下回车键，即可看到 Python 3 的版本号。例如，输出可能为 `Python 3.8.10`。如果系统同时安装了 Python 2 和 Python 3，使用 `python --version` 命令可能会显示 Python 2 的版本，需要注意区分。

### 在 Python 脚本中查看
在 Python 脚本中，可以使用 `sys` 模块来获取当前 Python 的版本信息。以下是一个简单的示例代码：

```python
import sys

print(sys.version)
```

上述代码中，首先导入了 `sys` 模块，然后使用 `sys.version` 来获取 Python 的版本信息，并通过 `print` 函数将其输出。运行该脚本后，控制台会输出详细的版本信息，例如：`3.9.7 (tags/v3.9.7:1016ef3, Aug 30 2021, 20:19:38) [MSC v.1929 64 bit (AMD64)]`，不仅包含了版本号，还包含了一些其他的构建信息。

如果你只想获取版本号的主要部分（主版本号、次版本号和修订号），可以使用以下代码：

```python
import sys

version_info = sys.version_info
print(f"{version_info.major}.{version_info.minor}.{version_info.micro}")
```

在这段代码中，`sys.version_info` 返回一个包含版本号各个部分的对象，通过访问 `major`、`minor` 和 `micro` 属性，我们可以分别获取主版本号、次版本号和修订号，并将它们格式化输出。

## 常见实践

### 新环境搭建时确认版本
当我们在新的开发环境中安装 Python 后，首先要做的就是确认安装的 Python 版本是否符合项目要求。例如，某些项目可能要求 Python 3.8 及以上版本，我们可以通过上述命令行或脚本的方法查看版本，确保环境配置正确。如果版本不符合要求，我们可能需要重新安装合适版本的 Python 或者调整项目的依赖。

### 解决兼容性问题时查看版本
在开发过程中，遇到代码兼容性问题时，查看 Python 版本是非常关键的一步。比如，某些库在特定的 Python 版本上可能存在兼容性问题。当我们发现代码运行出现异常或者某些功能无法正常使用时，首先要查看当前 Python 版本，对比库的官方文档中列出的兼容版本范围，从而判断是否是版本不兼容导致的问题。如果是版本问题，可以尝试升级或降级 Python 版本，或者寻找其他兼容的库来解决问题。

## 最佳实践

### 自动化版本检查
在大型项目中，为了确保所有开发人员使用的 Python 版本一致，可以编写自动化脚本进行版本检查。例如，在项目的 `setup.py` 或 `Makefile` 中添加版本检查的逻辑。以下是一个简单的示例，使用 `make` 命令结合 `python` 脚本来检查版本：

```python
# check_version.py
import sys

required_version = (3, 8)
current_version = sys.version_info

if current_version < required_version:
    print(f"Python {required_version[0]}.{required_version[1]} or higher is required.")
    sys.exit(1)
else:
    print("Python version meets requirements.")
```

然后在 `Makefile` 中添加如下规则：

```makefile
check-python-version:
    python check_version.py
```

这样，开发人员在项目根目录下执行 `make check-python-version` 命令，就可以自动检查 Python 版本是否符合要求。

### 记录版本信息
在项目文档中记录项目所使用的 Python 版本信息是一个很好的实践。这样，新加入的开发人员或者在不同环境中部署项目的人员可以快速了解项目对 Python 版本的要求。可以在项目的 `README.md` 文件或者专门的项目文档中添加如下内容：

```
### Python 版本要求
本项目使用 Python 3.8 开发，建议使用相同版本的 Python 环境以确保兼容性。
```

同时，在项目的依赖管理文件（如 `requirements.txt`）中，也可以添加关于 Python 版本的注释，以便更好地记录项目的依赖环境。

## 小结
通过本文，我们详细了解了如何查看 Python 版本，包括在命令行和 Python 脚本中的方法。同时，探讨了在新环境搭建和解决兼容性问题等常见实践场景中查看版本的重要性。此外，还介绍了自动化版本检查和记录版本信息等最佳实践，帮助我们更好地管理项目的 Python 版本环境。希望这些内容能够帮助读者在 Python 开发过程中更加高效地处理版本相关的问题，确保项目的顺利进行。

## 参考资料
- [Python 官方文档](https://docs.python.org/zh-cn/3/){: rel="nofollow"}
- [Python 版本管理工具介绍](https://www.tecmint.com/manage-python-versions-with-virtualenv/){: rel="nofollow"}
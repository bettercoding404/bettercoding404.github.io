---
title: "查看 PyCharm 运行的 Python 版本"
description: "在使用 PyCharm 进行 Python 开发时，了解当前项目所运行的 Python 版本至关重要。不同的 Python 版本在语法、库的兼容性等方面存在差异。知晓正在运行的 Python 版本，有助于开发者更好地调试代码、选择合适的库，以及确保项目在目标环境中能正常运行。本文将详细介绍如何查看 PyCharm 运行的 Python 版本，包括基础概念、使用方法、常见实践和最佳实践。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在使用 PyCharm 进行 Python 开发时，了解当前项目所运行的 Python 版本至关重要。不同的 Python 版本在语法、库的兼容性等方面存在差异。知晓正在运行的 Python 版本，有助于开发者更好地调试代码、选择合适的库，以及确保项目在目标环境中能正常运行。本文将详细介绍如何查看 PyCharm 运行的 Python 版本，包括基础概念、使用方法、常见实践和最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 在 PyCharm 界面中查看
    - 通过代码查看
3. 常见实践
    - 新环境搭建时确认版本
    - 排查兼容性问题
4. 最佳实践
    - 项目初始化时记录版本
    - 持续集成与版本管理
5. 小结
6. 参考资料

## 基础概念
Python 有多个主要版本，如 Python 2 和 Python 3，每个主要版本又有不同的小版本。不同版本在功能、语法和标准库等方面存在变化。例如，Python 3 在字符串处理、异常处理等方面有较大改进，并且不再兼容 Python 2 的部分语法。PyCharm 是一款强大的 Python IDE，它可以配置使用不同的 Python 解释器，因此明确当前项目使用的 Python 版本对于开发过程的顺利进行至关重要。

## 使用方法
### 在 PyCharm 界面中查看
1. **打开项目设置**：在 PyCharm 中，点击菜单栏中的 `File` -> `Settings`（Windows/Linux）或 `PyCharm` -> `Preferences`（Mac）。
2. **进入项目解释器设置**：在弹出的设置窗口中，找到并点击 `Project: [项目名称]` -> `Python Interpreter`。
3. **查看 Python 版本**：在 `Python Interpreter` 页面的右上角，会显示当前项目所使用的 Python 解释器路径，路径旁边的数字即为当前 Python 的版本号。

### 通过代码查看
在 Python 脚本中添加以下代码：
```python
import sys
print(sys.version)
```
运行该脚本，在控制台输出的信息中，会显示完整的 Python 版本号以及其他相关信息，例如：
```
3.8.10 (default, Mar 15 2023, 12:22:08) 
[GCC 9.4.0]
```

## 常见实践
### 新环境搭建时确认版本
在创建新的 Python 项目或搭建新的开发环境时，首先要确认 PyCharm 所使用的 Python 版本是否符合项目需求。例如，如果项目依赖于 Python 3.8 及以上版本的某些新特性，那么在创建项目时就要确保选择正确的 Python 解释器版本。通过上述界面查看或代码查看的方法，确认版本无误后再进行后续开发。

### 排查兼容性问题
当代码出现兼容性问题，如某些库无法导入或运行时出现语法错误，首先要检查当前 PyCharm 运行的 Python 版本。因为一些库可能只支持特定的 Python 版本范围。通过查看版本，可以快速定位问题是否是由于版本不兼容导致的。例如，如果在使用某个新库时遇到问题，发现当前 Python 版本过低，可能需要升级 Python 版本或寻找兼容当前版本的替代库。

## 最佳实践
### 项目初始化时记录版本
在项目初始化阶段，将所使用的 Python 版本记录在项目的文档中，如 `README.md` 文件。这样团队成员在克隆项目或搭建开发环境时，能够清楚知道项目所依赖的 Python 版本。例如，在 `README.md` 中添加以下内容：
```
### 项目依赖
- **Python 版本**：3.9.6
```
### 持续集成与版本管理
在持续集成（CI）环境中，确保 CI 脚本使用与本地开发环境相同的 Python 版本。可以通过在 CI 配置文件（如 `.gitlab-ci.yml` 或 `.travis.yml`）中指定 Python 版本来实现。例如，在 `.gitlab-ci.yml` 中：
```yaml
image: python:3.9

stages:
  - test

test:
  stage: test
  script:
    - python -m unittest discover
```
这样可以保证项目在不同环境下（本地开发、测试服务器、生产环境等）都能使用相同版本的 Python 运行，减少因版本差异导致的问题。

## 小结
了解 PyCharm 运行的 Python 版本是 Python 开发过程中的重要环节。通过在界面中查看或编写代码查看的方法，开发者可以快速获取版本信息。在新环境搭建、排查兼容性问题等常见实践场景中，及时确认版本有助于提高开发效率。而遵循项目初始化记录版本、持续集成中统一版本等最佳实践原则，可以进一步确保项目的稳定性和可维护性。

## 参考资料
- [PyCharm 官方文档](https://www.jetbrains.com/pycharm/docs/){: rel="nofollow"}
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
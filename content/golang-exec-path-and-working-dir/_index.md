---
layout: post
title:  "Golang 获取当前工作目录和执行目录"
description: "本文介绍了如何使用 Golang 获取当前工作目录和执行目录，并提供了完整的示例代码和参考资料。"
date:   2024-11-02 01:00:00 +0000
last_modified_at: 2024-11-22 01:00:00 +0000
categories: [Golang]
cascade:
  - type: docs
---
在 Golang 中获取程序的“当前工作目录”（Current Working Directory, CWD）和“执行目录”（Executable Directory, ED）是开发中常见的需求。特别是在需要加载配置文件、资源文件或进行文件路径操作时，明确路径是至关重要的。本篇博客将深入探讨如何使用 Go 标准库来获取这些目录信息，并讲解两者的区别和使用场景。


## 当前工作目录（Current Working Directory）

当前工作目录指的是程序启动时的所在目录。这意味着无论程序的二进制文件实际位置在哪里，Go 都会根据启动它的环境所在路径来决定它的工作目录。我们可以通过 os 包中的 Getwd 函数获取当前工作目录。

获取当前工作目录的方法
获取当前工作目录非常简单，直接调用 os.Getwd() 即可：

```go
package main

import (
    "fmt"
    "os"
)

func main() {
    cwd, err := os.Getwd()
    if err != nil {
        fmt.Println("获取当前工作目录失败:", err)
        return
    }
    fmt.Println("当前工作目录:", cwd)
}

```

### 使用场景
Getwd() 返回程序的运行时工作目录，这对于需要基于相对路径操作文件的程序非常有用。例如，当我们在本地开发中使用 go run 命令启动程序时，工作目录会是当前文件夹。然而，在生产环境中，如果以不同的方式部署，例如通过容器运行程序，工作目录可能会有所不同。

在许多情况下，我们可以根据相对路径轻松地访问资源文件，但需要记住，工作目录并不等同于二进制文件所在的路径。比如，当我们从项目根目录运行 Go 文件时，工作目录即为项目根目录。

## 执行目录（Executable Directory）
执行目录指的是程序二进制文件所在的目录，和当前工作目录不同。无论程序从何处启动，执行目录都保持不变。因此，当我们想要根据程序文件的位置来查找资源时，执行目录非常有用。

在 Go 中获取执行目录可以通过 os.Executable 函数。该函数返回程序的绝对路径，我们可以进一步获取目录部分。

### 获取执行目录的方法
要获取执行目录，我们可以结合 path/filepath 包中的 Dir 函数，如下所示：

```go
package main

import (
    "fmt"
    "os"
    "path/filepath"
)

func main() {
    execPath, err := os.Executable()
    if err != nil {
        fmt.Println("获取执行目录失败:", err)
        return
    }

    execDir := filepath.Dir(execPath)
    fmt.Println("执行目录:", execDir)
}

```

os.Executable 返回的是二进制文件的绝对路径，而通过 filepath.Dir 可以获取文件路径的目录部分。

### 使用场景
执行目录在以下情况下尤为有用：

读取和加载资源文件：在项目打包或部署后，程序的启动位置和二进制文件所在位置可能不一致。为了确保加载的资源和二进制文件处于同一目录，我们可以使用执行目录路径。
便于部署和打包：在容器化应用、微服务或分布式环境中，二进制文件及相关资源通常放在固定目录下，通过执行目录可以确保我们在任意环境中都能找到所需的文件。

## 两者的区别与选择
工作目录：是程序启动时的当前路径，可能会发生改变。如果用户在不同目录下启动程序，那么当前工作目录将不同。这适合需要动态响应不同启动环境的场景。
执行目录：与程序二进制文件的位置一致，不随启动环境变化，适用于查找和加载与程序打包在一起的资源文件。
一个通俗的类比是：

当前工作目录好比我们进入的“工作区域”。
执行目录是“我们的基地”，即使我们在外地出差，基地还是不变的。

## 示例：同时获取并使用当前工作目录和执行目录
假设我们有一个配置文件需要读取，可以尝试先从当前工作目录读取，如果找不到再从执行目录中读取：

```go

package main

import (
    "fmt"
    "os"
    "path/filepath"
)

func main() {
    // 获取当前工作目录
    cwd, err := os.Getwd()
    if err != nil {
        fmt.Println("获取当前工作目录失败:", err)
        return
    }
    fmt.Println("当前工作目录:", cwd)

    // 获取执行目录
    execPath, err := os.Executable()
    if err != nil {
        fmt.Println("获取执行目录失败:", err)
        return
    }
    execDir := filepath.Dir(execPath)
    fmt.Println("执行目录:", execDir)

    // 假设我们要读取一个名为 config.json 的配置文件
    configFile := "config.json"
    cwdConfigPath := filepath.Join(cwd, configFile)
    execDirConfigPath := filepath.Join(execDir, configFile)

    // 尝试读取当前工作目录下的 config.json
    if _, err := os.Stat(cwdConfigPath); err == nil {
        fmt.Println("配置文件在当前工作目录:", cwdConfigPath)
    } else if _, err := os.Stat(execDirConfigPath); err == nil {
        fmt.Println("配置文件在执行目录:", execDirConfigPath)
    } else {
        fmt.Println("配置文件未找到")
    }
}

```
在这个示例中，我们首先尝试从当前工作目录加载配置文件，如果失败则在执行目录中查找。这种方法可以让程序具备更高的灵活性，同时确保无论在本地开发还是生产环境中都能找到正确的文件路径。

## 总结
* 当前工作目录和执行目录是两个重要且不同的概念，分别对应程序运行时的动态位置和程序二进制文件的固定位置。
* os.Getwd 用于获取当前工作目录，而 os.Executable 结合 filepath.Dir 可以获取执行目录。
* 选择适合的路径获取方式，可以让文件和资源管理更加高效，并减少部署和环境带来的路径问题。


## 参考资料
* [Go 官方文档 - os.Getwd](https://pkg.go.dev/os#Getwd)
* [Go 官方文档 - os.Executable](https://pkg.go.dev/os#Executable)
* [Go 官方文档 - path/filepath](https://pkg.go.dev/path/filepath)
  


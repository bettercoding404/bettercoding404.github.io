---
layout: post
title:  "使用Golang读取和写入 Json：详解与示例"
description: "本文介绍了如何使用 Golang 读取和写入 Json 数据，包括结构体到 Json 字符串、Json 字符串到结构体、Json 文件到结构体、结构体到 Json 文件等操作。并提供了完整的示例代码和参考资料。"
date:   2024-11-02 03:00:00 +0000
last_modified_at: 2024-11-22 03:00:00 +0000
categories: [Golang, Json]
cascade:
  - type: docs
---
在现代应用开发中，JSON（JavaScript Object Notation）已经成为一种主流的数据交换格式。它结构清晰，易于读取和解析，广泛用于 Web 开发、API 设计、配置文件等场景。Go 语言在处理 JSON 数据方面提供了强大的内置支持，让我们能够快速、便捷地进行 JSON 数据的读写操作。本篇博客将详细介绍如何在 Go 中读取和写入 JSON 数据，并配合代码示例帮助您深入理解。

## 基本的 JSON 读写概念
在 Go 中，标准库的 encoding/json 包提供了对 JSON 数据进行编码和解码的基本功能：

编码（Encoding）：将 Go 的数据结构转化为 JSON 格式。
解码（Decoding）：将 JSON 数据解析为 Go 的数据结构。
示例 JSON 数据
假设我们有以下 JSON 数据表示一名用户：

```json
{
  "id": 1,
  "name": "Alice",
  "email": "alice@example.com",
  "age": 25,
  "is_active": true
}

```
这篇文章讲介绍如何将此 JSON 数据读入 Go 的结构体，以及如何将 Go 的结构体输出为JSON文件。

## 定义数据结构
在 Go 中，我们通常使用结构体来表示 JSON 对象的结构。以上面的 JSON 为例，我们可以定义一个 User 结构体：

```go
type User struct {
    ID       int    `json:"id"`
    Name     string `json:"name"`
    Email    string `json:"email"`
    Age      int    `json:"age"`
    IsActive bool   `json:"is_active"`
}

```
注意这里的标签（例如 json:"id"），它们用于指定结构体字段与 JSON 字段的映射关系。这有助于 Go 在进行 JSON 编码和解码时，能够正确匹配字段。

## 读取 JSON 数据

在读取 JSON 时，通常分两种情况：

* 从字符串或文件读取 JSON 数据
* 从网络请求中解析 JSON 数据
我们先从最常见的 JSON 字符串和文件读取讲起。

### 从 JSON 字符串读取数据
假设我们有一段 JSON 字符串，下面是将 JSON 字符串解析为 User 结构体的示例代码：

```go

package main

import (
    "encoding/json"
    "fmt"
)

func main() {
    // JSON 字符串
    data := `{"id":1,"name":"Alice","email":"alice@example.com","age":25,"is_active":true}`

    // 定义一个 User 结构体变量
    var user User

    // 将 JSON 字符串解码到 User 结构体
    err := json.Unmarshal([]byte(data), &user)
    if err != nil {
        fmt.Println("Error decoding JSON:", err)
        return
    }

    // 打印解析结果
    fmt.Printf("User: %+v\n", user)
}

```

在这段代码中，我们使用 json.Unmarshal 将 JSON 字符串解析到 user 变量中。如果解析成功，user 将包含 JSON 数据中对应的值。

### 从文件读取 JSON 数据
假设我们有一个包含用户信息的 JSON 文件 user.json：

```json

{
  "id": 1,
  "name": "Alice",
  "email": "alice@example.com",
  "age": 25,
  "is_active": true
}

```

可以使用 os.ReadFile 读取文件内容，然后解析 JSON：

```go
package main

import (
   "encoding/json"
   "fmt"
   "os"
)

func main() {
   // 读取文件内容
   data, err := os.ReadFile("user.json")
   if err != nil {
      fmt.Println("Error reading file:", err)
      return
   }

   // 定义一个 User 结构体变量
   var user User

   // 将文件内容解码到 User 结构体
   err = json.Unmarshal(data, &user)
   if err != nil {
      fmt.Println("Error decoding JSON:", err)
      return
   }

   // 打印解析结果
   fmt.Printf("User: %+v\n", user)
}


```

注意事项
json.Unmarshal 仅支持解析 JSON 对象和数组，确保数据格式正确。
错误处理很重要，尤其是在处理文件 I/O 和 JSON 解析时，应始终检查是否有错误。
## 写入 JSON 数据
写入 JSON 数据同样很简单，主要通过 json.Marshal 或 json.MarshalIndent 将结构体转化为 JSON 字符串。

### 将结构体编码为 JSON 字符串
下面是将 User 结构体编码为 JSON 字符串的示例：

```go

package main

import (
    "encoding/json"
    "fmt"
)

func main() {
    // 定义一个 User 结构体实例
    user := User{
        ID:       1,
        Name:     "Alice",
        Email:    "alice@example.com",
        Age:      25,
        IsActive: true,
    }

    // 将结构体编码为 JSON 字符串
    data, err := json.Marshal(user)
    if err != nil {
        fmt.Println("Error encoding JSON:", err)
        return
    }

    // 打印 JSON 字符串
    fmt.Println("JSON:", string(data))
}

```

### 将 JSON 写入文件
可以使用 json.MarshalIndent 生成美化过的 JSON，然后写入文件。

```go

package main

import (
	"encoding/json"
	"fmt"
	"os"
)

func main() {
	// 定义一个 User 结构体实例
	user := User{
		ID:       1,
		Name:     "Alice",
		Email:    "alice@example.com",
		Age:      25,
		IsActive: true,
	}

	// 美化 JSON 输出
	data, err := json.MarshalIndent(user, "", "  ")
	if err != nil {
		fmt.Println("Error encoding JSON:", err)
		return
	}

	// 将 JSON 数据写入文件
	err = os.WriteFile("output.json", data, 0644)
	if err != nil {
		fmt.Println("Error writing JSON to file:", err)
		return
	}

	fmt.Println("JSON data written to output.json")
}

```
在这个示例中，我们使用 json.MarshalIndent 美化 JSON 数据，便于阅读，并使用 os.WriteFile 将 JSON 数据写入文件。

## json.Marshal 与 json.MarshalIndent 的区别
在 Go 中，json.Marshal 和 json.MarshalIndent 都可以将结构体编码为 JSON 格式的字符串，但它们的输出格式有所不同：

json.Marshal：直接将结构体转换为紧凑的 JSON 字符串。输出的 JSON 数据没有任何额外的空格或换行，通常适用于数据传输和存储，这样可以最大程度地减少数据大小。

json.MarshalIndent：相比 json.Marshal，json.MarshalIndent 可以生成格式化、易于阅读的 JSON 字符串。它需要两个额外的参数：一个是前缀字符串（通常传空字符串 ""），另一个是缩进字符串（例如 " " 表示两个空格缩进）。这使得输出的 JSON 数据结构清晰，便于调试和查看，适合日志记录或配置文件的生成。

### 示例比较

```go

package main

import (
    "encoding/json"
    "fmt"
)

type User struct {
    ID       int    `json:"id"`
    Name     string `json:"name"`
    Email    string `json:"email"`
    Age      int    `json:"age"`
    IsActive bool   `json:"is_active"`
}

func main() {
    user := User{
        ID:       1,
        Name:     "Alice",
        Email:    "alice@example.com",
        Age:      25,
        IsActive: true,
    }

    // 使用 json.Marshal 编码
    compactJSON, _ := json.Marshal(user)
    fmt.Println("Compact JSON:", string(compactJSON))

    // 使用 json.MarshalIndent 编码
    prettyJSON, _ := json.MarshalIndent(user, "", "  ")
    fmt.Println("Pretty JSON:\n", string(prettyJSON))
}

```
输出示例：
```text

Compact JSON: {"id":1,"name":"Alice","email":"alice@example.com","age":25,"is_active":true}
Pretty JSON:
 {
   "id": 1,
   "name": "Alice",
   "email": "alice@example.com",
   "age": 25,
   "is_active": true
 }

```

## 结语
Go 语言的 encoding/json 包为 JSON 数据的读写提供了非常便捷的方法。在本篇博客中，详细绍了如何将 JSON 数据解析为 Go 的结构体，
以及如何将 Go 结构体编码为 JSON 数据并写入文件，并介绍了 json.Marshal 和 json.MarshalIndent 的区别。希望对您有所帮助。

## 参考资料
* [Go 官方文档 - encoding/json](https://pkg.go.dev/encoding/json)
* [JSON and Go](https://go.dev/blog/json)

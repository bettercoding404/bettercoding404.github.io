---
layout: post
title:  "使用 Golang 实现有向图的最短路径算法(Dijkstra)"
description: "本文介绍了如何使用 Golang 实现 Dijkstra 算法，用于计算有向图中的最短路径。并提供了完整的示例代码和参考资料。"
date:   2024-11-02 00:00:00 +0000
last_modified_at: 2024-11-22 00:00:00 +0000
categories: [Golang, Algorithm]
cascade:
  - type: docs
---
## 基础知识概述
   在开始编码之前，我们需要理解一些基础的概念：

有向图：有向图中的每条边都是单向的，即从一个节点指向另一个节点，不能反向行驶。
权重：图中的边可以附带权重，表示从一个节点到另一个节点的代价（如距离或时间）。
最短路径：在一个有向图中，从起点到终点的路径中，边权重之和最小的路径称为最短路径。
在解决有向图中的最短路径问题时，最常用的算法是 Dijkstra 算法。

## Dijkstra 算法简介
   Dijkstra 算法是一种贪心算法，用于计算加权图中从一个源节点到其他所有节点的最短路径。它的工作原理如下：

初始化源节点的距离为 0，其他节点的距离为无穷大。
每次从未访问的节点中选择距离最小的节点，将其标记为“已访问”。
更新邻居节点的距离，如果通过当前节点的路径比之前记录的路径更短，则更新距离。
重复上述步骤，直到访问了所有节点或找到目标节点。

## Golang 中的 Dijkstra 实现
   接下来，我们将使用 Golang 编写一个 Dijkstra 算法，处理有向图的最短路径问题。

### 数据结构定义
首先，定义节点和图的结构：
```go
package main

import (
    "container/heap"
    "fmt"
    "math"
)

// Edge 代表一个有向边，包含目标节点和边的权重
type Edge struct {
    target int
    weight int
}

// Graph 表示一个有向图
type Graph struct {
    adjList map[int][]Edge
}

// NewGraph 创建一个新的空图
func NewGraph() *Graph {
    return &Graph{adjList: make(map[int][]Edge)}
}

// AddEdge 添加一条有向边
func (g *Graph) AddEdge(source, target, weight int) {
    g.adjList[source] = append(g.adjList[source], Edge{target, weight})
}

```

### 实现优先队列
Dijkstra 算法需要不断选择当前距离最小的节点，因此我们使用优先队列来优化选择过程。Golang 的 container/heap 包可以帮助我们实现最小堆。

```go

type Item struct {
    node     int
    priority int
}

// PriorityQueue 实现了一个优先队列
type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].priority < pq[j].priority
}
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(*Item))
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    *pq = old[0 : n-1]
    return item
}
    
```
### Dijkstra 算法实现
有了上述数据结构，我们可以实现 Dijkstra 算法来寻找最短路径。

```go

func (g *Graph) Dijkstra(start int) map[int]int {
    distances := make(map[int]int)
    for node := range g.adjList {
        distances[node] = math.MaxInt64
    }
    distances[start] = 0

    pq := &PriorityQueue{}
    heap.Init(pq)
    heap.Push(pq, &Item{node: start, priority: 0})

    for pq.Len() > 0 {
        current := heap.Pop(pq).(*Item)
        currentNode := current.node

        for _, edge := range g.adjList[currentNode] {
            newDist := distances[currentNode] + edge.weight
            if newDist < distances[edge.target] {
                distances[edge.target] = newDist
                heap.Push(pq, &Item{node: edge.target, priority: newDist})
            }
        }
    }

    return distances
}

```


### 示例代码：寻找最短路径
假设我们有以下有向图：

节点 1 到节点 2，权重 4
节点 1 到节点 3，权重 2
节点 2 到节点 3，权重 5
节点 2 到节点 4，权重 10
节点 3 到节点 4，权重 3
我们可以使用以下代码测试 Dijkstra 算法的效果。
```go
func main() {
    g := NewGraph()
    g.AddEdge(1, 2, 4)
    g.AddEdge(1, 3, 2)
    g.AddEdge(2, 3, 5)
    g.AddEdge(2, 4, 10)
    g.AddEdge(3, 4, 3)

    startNode := 1
    distances := g.Dijkstra(startNode)

    fmt.Printf("从节点 %d 到其他节点的最短路径:\n", startNode)
    for node, distance := range distances {
        fmt.Printf("到节点 %d 的距离: %d\n", node, distance)
    }
}

```

运行该代码，输出应为：
```text

从节点 1 到其他节点的最短路径:
到节点 1 的距离: 0
到节点 2 的距离: 4
到节点 3 的距离: 2
到节点 4 的距离: 5

```

## 完整代码
下面是完整的 Golang 代码，包含了上述所有部分：
```go
package main

import (
    "container/heap"
    "fmt"
    "math"
)

// Edge 代表一个有向边，包含目标节点和边的权重
type Edge struct {
    target int
    weight int
}

// Graph 表示一个有向图
type Graph struct {
    adjList map[int][]Edge
}

// NewGraph 创建一个新的空图
func NewGraph() *Graph {
    return &Graph{adjList: make(map[int][]Edge)}
}

// AddEdge 添加一条有向边
func (g *Graph) AddEdge(source, target, weight int) {
    g.adjList[source] = append(g.adjList[source], Edge{target, weight})
}

// Item 代表优先队列中的一个项
type Item struct {
    node     int // 当前节点
    priority int // 节点到起点的距离（优先级）
}

// PriorityQueue 实现了一个优先队列
type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].priority < pq[j].priority // 小顶堆：优先级越小越靠前
}
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(*Item))
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    *pq = old[0 : n-1]
    return item
}

// Dijkstra 算法实现
func (g *Graph) Dijkstra(start int) map[int]int {
    // 初始化距离表，将所有节点的距离初始化为无穷大
    distances := make(map[int]int)
    for node := range g.adjList {
        distances[node] = math.MaxInt64
    }
    distances[start] = 0

    // 初始化优先队列，并将起点入队
    pq := &PriorityQueue{}
    heap.Init(pq)
    heap.Push(pq, &Item{node: start, priority: 0})

    for pq.Len() > 0 {
        current := heap.Pop(pq).(*Item)
        currentNode := current.node

        // 遍历当前节点的邻接节点，更新其距离
        for _, edge := range g.adjList[currentNode] {
            newDist := distances[currentNode] + edge.weight
            if newDist < distances[edge.target] {
                distances[edge.target] = newDist
                heap.Push(pq, &Item{node: edge.target, priority: newDist})
            }
        }
    }

    return distances
}

func main() {
    // 构建图
    g := NewGraph()
    g.AddEdge(1, 2, 4)
    g.AddEdge(1, 3, 2)
    g.AddEdge(2, 3, 5)
    g.AddEdge(2, 4, 10)
    g.AddEdge(3, 4, 3)

    // 使用 Dijkstra 算法寻找从起点 1 到其他节点的最短路径
    startNode := 1
    distances := g.Dijkstra(startNode)

    // 输出结果
    fmt.Printf("从节点 %d 到其他节点的最短路径:\n", startNode)
    for node, distance := range distances {
        fmt.Printf("到节点 %d 的距离: %d\n", node, distance)
    }
}

```

### 总结
   通过 Golang 实现 Dijkstra 算法，我们可以高效地计算有向图中的最短路径。此算法在实际应用中有着重要的意义，例如在地图导航、网络路由优化等场景中都可以使用它来处理复杂的路径规划问题。


### 参考资料
算法导论 (Introduction to Algorithms) - Thomas H. Cormen 等著  
[Golang 官方文档](https://go.dev/doc/)

---
title:  C语言实现Dijkstra算法：从基础到最佳实践
description:  简介Dijkstra算法是由荷兰计算机科学家艾兹格·迪科斯彻（Edsger W. Dijkstra）在1956年发现的，是一种用于在带权有向图中寻找从一个给定源点到其他所有顶点的最短路径的经典算法。在C语言中实现Dijkstra算法，不仅能加深对算法本身的理解，还能提升在图论相关问题上的编程能力。本文将详细介绍如何使用C语言实现Dijkstra算法，包括基础概念、使用方法、常见实践和最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
Dijkstra算法是由荷兰计算机科学家艾兹格·迪科斯彻（Edsger W. Dijkstra）在1956年发现的，是一种用于在带权有向图中寻找从一个给定源点到其他所有顶点的最短路径的经典算法。在C语言中实现Dijkstra算法，不仅能加深对算法本身的理解，还能提升在图论相关问题上的编程能力。本文将详细介绍如何使用C语言实现Dijkstra算法，包括基础概念、使用方法、常见实践和最佳实践。

## 目录
1. **基础概念**
    - 图的表示
    - 最短路径问题
    - Dijkstra算法原理
2. **C语言实现Dijkstra算法的使用方法**
    - 初始化图
    - 实现Dijkstra算法
    - 输出最短路径
3. **常见实践**
    - 处理稀疏图和稠密图
    - 与其他算法的结合
4. **最佳实践**
    - 优化算法性能
    - 错误处理和代码健壮性
5. **小结**

## 基础概念
### 图的表示
在C语言中，图可以用多种方式表示，常见的有邻接矩阵和邻接表。
- **邻接矩阵**：用一个二维数组`graph[i][j]`表示图，其中`graph[i][j]`表示顶点`i`到顶点`j`的边的权重。如果没有边，则`graph[i][j]`为一个极大值（例如`INT_MAX`）。
- **邻接表**：用一个数组的链表表示图，每个数组元素对应一个顶点，链表中存储与该顶点相邻的顶点及其边的权重。

### 最短路径问题
最短路径问题是在一个图中找到从一个源点到其他各个顶点的路径中，路径权重之和最小的路径。Dijkstra算法解决的是带权有向图中，所有边权重非负的最短路径问题。

### Dijkstra算法原理
Dijkstra算法使用贪心策略。它维护一个集合`S`，集合中的顶点已经确定了从源点到它们的最短路径。算法初始时，`S`只包含源点。然后，不断从集合`S`之外的顶点中选择距离源点最近的顶点`u`，将其加入集合`S`，并更新与`u`相邻的顶点到源点的距离。重复这个过程，直到所有顶点都在集合`S`中。

## C语言实现Dijkstra算法的使用方法
### 初始化图
下面是使用邻接矩阵表示图并初始化的代码示例：
```c
#include <stdio.h>
#include <limits.h>

#define V 9 // 顶点数

// 初始化邻接矩阵
void initGraph(int graph[V][V]) {
    for (int i = 0; i < V; i++) {
        for (int j = 0; j < V; j++) {
            graph[i][j] = INT_MAX;
        }
    }
    // 添加边和权重
    graph[0][1] = 4; graph[0][7] = 8;
    graph[1][0] = 4; graph[1][2] = 8; graph[1][7] = 11;
    graph[2][1] = 8; graph[2][3] = 7; graph[2][5] = 4; graph[2][8] = 2;
    graph[3][2] = 7; graph[3][4] = 9; graph[3][5] = 14;
    graph[4][3] = 9; graph[4][5] = 10;
    graph[5][2] = 4; graph[5][3] = 14; graph[5][4] = 10; graph[5][6] = 2;
    graph[6][5] = 2; graph[6][7] = 1; graph[6][8] = 6;
    graph[7][0] = 8; graph[7][1] = 11; graph[7][6] = 1; graph[7][8] = 7;
    graph[8][2] = 2; graph[8][6] = 6; graph[8][7] = 7;
}
```

### 实现Dijkstra算法
```c
// 找到距离源点最近且未访问的顶点
int minDistance(int dist[], int sptSet[]) {
    int min = INT_MAX, minIndex;

    for (int v = 0; v < V; v++)
        if (sptSet[v] == 0 && dist[v] <= min)
            min = dist[v], minIndex = v;

    return minIndex;
}

// 打印从源点到各个顶点的最短路径
void printPath(int parent[], int j) {
    if (parent[j] == -1)
        return;

    printPath(parent, parent[j]);

    printf("%d ", j);
}

// 打印结果
void printSolution(int dist[], int parent[], int src) {
    printf("Vertex\t Distance\tPath\n");
    for (int i = 0; i < V; i++) {
        printf("%d -> %d \t\t %d\t\t%d ", src, i, dist[i], src);
        printPath(parent, i);
        printf("\n");
    }
}

// Dijkstra算法实现
void dijkstra(int graph[V][V], int src) {
    int dist[V];
    int sptSet[V];
    int parent[V];

    for (int i = 0; i < V; i++) {
        dist[i] = INT_MAX;
        sptSet[i] = 0;
        parent[i] = -1;
    }

    dist[src] = 0;

    for (int count = 0; count < V - 1; count++) {
        int u = minDistance(dist, sptSet);
        sptSet[u] = 1;

        for (int v = 0; v < V; v++)
            if (!sptSet[v] && graph[u][v]!= INT_MAX && dist[u]!= INT_MAX && dist[u] + graph[u][v] < dist[v]) {
                dist[v] = dist[u] + graph[u][v];
                parent[v] = u;
            }
    }

    printSolution(dist, parent, src);
}
```

### 输出最短路径
在主函数中调用上述函数，即可输出从源点到各个顶点的最短路径：
```c
int main() {
    int graph[V][V];
    initGraph(graph);

    int src = 0;
    dijkstra(graph, src);

    return 0;
}
```

## 常见实践
### 处理稀疏图和稠密图
- **稀疏图**：对于稀疏图，使用邻接表表示可以节省内存，因为邻接表只存储存在的边。在实现Dijkstra算法时，可以将邻接矩阵改为邻接表结构，并相应修改算法中的边遍历部分。
- **稠密图**：对于稠密图，邻接矩阵虽然占用较多内存，但由于其简单的访问方式，在某些情况下可以提高算法的运行效率。

### 与其他算法的结合
Dijkstra算法可以与其他图算法结合使用。例如，在计算所有顶点对之间的最短路径时，可以多次调用Dijkstra算法，也可以使用Floyd-Warshall算法。另外，在处理带负权边的图时，可以先使用Bellman-Ford算法预处理，再使用Dijkstra算法。

## 最佳实践
### 优化算法性能
- **使用优先队列**：可以使用优先队列（例如堆）来优化`minDistance`函数的查找过程，将时间复杂度从$O(V)$降低到$O(\log V)$。在C语言中，可以自己实现一个堆结构，或者使用一些开源库（如`libpq`）中的优先队列实现。
- **减少冗余计算**：在更新距离时，可以使用松弛操作的优化策略，减少不必要的计算。

### 错误处理和代码健壮性
- **输入验证**：在初始化图和接收输入时，要进行严格的输入验证，确保输入的图是合法的。
- **边界情况处理**：处理图中不存在路径、顶点编号越界等边界情况，使代码更加健壮。

## 小结
通过本文，我们详细介绍了C语言实现Dijkstra算法的各个方面，从基础概念到具体的代码实现，再到常见实践和最佳实践。掌握Dijkstra算法及其在C语言中的实现，对于解决各种图论相关的实际问题具有重要意义。希望读者通过阅读本文，能够深入理解并灵活运用Dijkstra算法，在算法设计和编程实践中取得更好的成果。

---

以上博客详细介绍了C语言实现Dijkstra算法的相关内容，希望能满足你的需求。如果有任何进一步的修改建议或补充信息，请随时告诉我。
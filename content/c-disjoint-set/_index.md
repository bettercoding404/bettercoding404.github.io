---
title:  C语言实现并查集：原理、实践与最佳实践
description:  简介并查集（Union-Find Set）是一种非常实用的数据结构，它主要用于处理不相交集合的合并与查询问题。在许多算法问题中，比如图的连通性判断、最小生成树算法等，都有着广泛的应用。本文将深入探讨如何使用C语言实现并查集，从基础概念开始，逐步介绍使用方法、常见实践以及最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
并查集（Union-Find Set）是一种非常实用的数据结构，它主要用于处理不相交集合的合并与查询问题。在许多算法问题中，比如图的连通性判断、最小生成树算法等，都有着广泛的应用。本文将深入探讨如何使用C语言实现并查集，从基础概念开始，逐步介绍使用方法、常见实践以及最佳实践。

## 目录
1. 基础概念
2. 使用方法
    - 初始化
    - 查找
    - 合并
3. 常见实践
    - 图的连通性判断
    - 检测无向图中的环
4. 最佳实践
    - 路径压缩优化
    - 按秩合并优化
5. 代码示例
6. 小结

## 基础概念
并查集是一种树形的数据结构，每个集合用一棵有根树来表示。树中的每个节点代表集合中的一个元素，树根作为集合的代表。

### 集合表示
并查集通常用数组来实现，数组的下标表示元素，数组的值表示该元素的父节点。如果一个元素的值等于它自己的下标，那么这个元素就是所在集合的根节点。

### 操作
并查集主要有两个基本操作：
- **查找（Find）**：查找元素所在集合的代表（根节点）。
- **合并（Union）**：将两个不同的集合合并成一个集合。

## 使用方法

### 初始化
初始化并查集时，每个元素都是一个独立的集合，其根节点就是它自身。

```c
#define MAXN 1000

int parent[MAXN];

void init(int n) {
    for (int i = 0; i < n; i++) {
        parent[i] = i;
    }
}
```

### 查找
查找操作通过不断向上追溯节点的父节点，直到找到根节点。

```c
int find(int x) {
    while (x!= parent[x]) {
        x = parent[x];
    }
    return x;
}
```

### 合并
合并操作首先找到两个元素所在集合的根节点，然后将其中一个根节点的父节点设为另一个根节点。

```c
void unionSet(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX!= rootY) {
        parent[rootX] = rootY;
    }
}
```

## 常见实践

### 图的连通性判断
判断图中两个顶点是否连通，可以使用并查集。在图的边集中依次合并每条边的两个顶点所在的集合，最后判断两个顶点是否在同一个集合中。

```c
// 假设图用边集数组表示
struct Edge {
    int u, v;
} edges[MAXN];

// 判断两个顶点是否连通
int isConnected(int u, int v) {
    return find(u) == find(v);
}

// 构建图的并查集
void buildUnionFind(int m) {
    for (int i = 0; i < m; i++) {
        unionSet(edges[i].u, edges[i].v);
    }
}
```

### 检测无向图中的环
在无向图中，如果在合并两个顶点时，它们已经在同一个集合中，那么就形成了一个环。

```c
int detectCycle(int m) {
    for (int i = 0; i < m; i++) {
        int rootU = find(edges[i].u);
        int rootV = find(edges[i].v);
        if (rootU == rootV) {
            return 1; // 存在环
        }
        unionSet(edges[i].u, edges[i].v);
    }
    return 0; // 不存在环
}
```

## 最佳实践

### 路径压缩优化
在查找操作中，路径压缩可以将查找路径上的所有节点直接连接到根节点，从而提高后续查找操作的效率。

```c
int find(int x) {
    if (x!= parent[x]) {
        parent[x] = find(parent[x]); // 路径压缩
    }
    return parent[x];
}
```

### 按秩合并优化
秩（rank）可以理解为树的高度。按秩合并是将秩较小的树合并到秩较大的树下面，这样可以保证树的高度增长较慢，从而提高查找和合并的效率。

```c
int rank[MAXN];

void init(int n) {
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }
}

void unionSet(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX!= rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootX] = rootY;
            rank[rootY]++;
        }
    }
}
```

## 代码示例
完整的C语言实现并查集代码示例，包含初始化、查找、合并、路径压缩和按秩合并优化。

```c
#include <stdio.h>

#define MAXN 1000

int parent[MAXN];
int rank[MAXN];

void init(int n) {
    for (int i = 0; i < n; i++) {
        parent[i] = i;
        rank[i] = 0;
    }
}

int find(int x) {
    if (x!= parent[x]) {
        parent[x] = find(parent[x]); // 路径压缩
    }
    return parent[x];
}

void unionSet(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX!= rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootX] = rootY;
            rank[rootY]++;
        }
    }
}

// 假设图用边集数组表示
struct Edge {
    int u, v;
} edges[MAXN];

// 判断两个顶点是否连通
int isConnected(int u, int v) {
    return find(u) == find(v);
}

// 构建图的并查集
void buildUnionFind(int m) {
    for (int i = 0; i < m; i++) {
        unionSet(edges[i].u, edges[i].v);
    }
}

// 检测无向图中的环
int detectCycle(int m) {
    for (int i = 0; i < m; i++) {
        int rootU = find(edges[i].u);
        int rootV = find(edges[i].v);
        if (rootU == rootV) {
            return 1; // 存在环
        }
        unionSet(edges[i].u, edges[i].v);
    }
    return 0; // 不存在环
}

int main() {
    int n = 5; // 顶点数
    int m = 4; // 边数
    edges[0].u = 0; edges[0].v = 1;
    edges[1].u = 1; edges[1].v = 2;
    edges[2].u = 2; edges[2].v = 3;
    edges[3].u = 3; edges[3].v = 4;

    init(n);
    buildUnionFind(m);

    if (isConnected(0, 4)) {
        printf("顶点0和顶点4连通\n");
    } else {
        printf("顶点0和顶点4不连通\n");
    }

    if (detectCycle(m)) {
        printf("图中存在环\n");
    } else {
        printf("图中不存在环\n");
    }

    return 0;
}
```

## 小结
并查集是一种强大的数据结构，在处理集合相关问题时非常高效。通过本文，我们学习了并查集的基础概念、使用方法、常见实践以及最佳实践。在实际应用中，合理运用路径压缩和按秩合并等优化策略，可以显著提高并查集的性能。希望读者通过理解和实践这些内容，能够在算法设计和编程中灵活运用并查集解决各种问题。
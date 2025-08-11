---
title:  用C语言实现图：从基础到最佳实践
description:  简介在计算机科学中，图是一种用于表示对象之间关系的数据结构。图由节点（也称为顶点）和连接这些节点的边组成。在许多领域，如社交网络分析、路径规划、电路设计等，图结构都发挥着重要作用。本文将深入探讨如何使用C语言实现图，包括基础概念、使用方法、常见实践以及最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在计算机科学中，图是一种用于表示对象之间关系的数据结构。图由节点（也称为顶点）和连接这些节点的边组成。在许多领域，如社交网络分析、路径规划、电路设计等，图结构都发挥着重要作用。本文将深入探讨如何使用C语言实现图，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 图的基础概念
2. C语言实现图的方法
    - 邻接矩阵
    - 邻接表
3. 常见实践
    - 添加节点和边
    - 遍历图
        - 深度优先搜索（DFS）
        - 广度优先搜索（BFS）
    - 最短路径算法
        - Dijkstra算法
4. 最佳实践
    - 内存管理
    - 代码优化
    - 错误处理
5. 小结

## 图的基础概念
图G由两个集合V和E组成，记为G = (V, E)，其中V是顶点的有穷非空集合，E是V中顶点偶对（称为边）的有穷集合。根据边是否有方向，图可以分为无向图和有向图。
- **无向图**：边没有方向，(u, v) 和 (v, u) 表示同一条边。
- **有向图**：边有方向，<u, v> 表示从顶点u到顶点v的一条有向边。

图还可以有权重，即每条边可以有一个与之关联的数值，用于表示某种度量，如距离、成本等。

## C语言实现图的方法

### 邻接矩阵
邻接矩阵是表示图的一种简单方法。对于一个有n个顶点的图，我们可以使用一个n x n的二维数组来表示。如果图中存在从顶点i到顶点j的边，则 `adj[i][j]` 为1（对于有权图，则为边的权重），否则为0。

```c
#include <stdio.h>
#include <stdlib.h>

#define MAX_VERTICES 100

typedef struct {
    int adjMatrix[MAX_VERTICES][MAX_VERTICES];
    int numVertices;
} Graph;

// 初始化图
void initGraph(Graph *g, int numVertices) {
    g->numVertices = numVertices;
    for (int i = 0; i < numVertices; i++) {
        for (int j = 0; j < numVertices; j++) {
            g->adjMatrix[i][j] = 0;
        }
    }
}

// 添加边
void addEdge(Graph *g, int src, int dest) {
    g->adjMatrix[src][dest] = 1;
    // 如果是无向图，还需要添加反向边
    // g->adjMatrix[dest][src] = 1;
}

// 打印邻接矩阵
void printGraph(Graph *g) {
    for (int i = 0; i < g->numVertices; i++) {
        for (int j = 0; j < g->numVertices; j++) {
            printf("%d ", g->adjMatrix[i][j]);
        }
        printf("\n");
    }
}

int main() {
    Graph g;
    initGraph(&g, 5);
    addEdge(&g, 0, 1);
    addEdge(&g, 0, 2);
    addEdge(&g, 1, 2);
    addEdge(&g, 2, 3);
    addEdge(&g, 3, 4);

    printGraph(&g);

    return 0;
}
```

### 邻接表
邻接表是另一种常用的表示图的数据结构。对于每个顶点，我们使用一个链表来存储与其相邻的顶点。这种方法在存储稀疏图时更加节省空间。

```c
#include <stdio.h>
#include <stdlib.h>

#define MAX_VERTICES 100

typedef struct Node {
    int dest;
    struct Node *next;
} Node;

typedef struct {
    Node *adjList[MAX_VERTICES];
    int numVertices;
} Graph;

// 创建新节点
Node* createNode(int dest) {
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->dest = dest;
    newNode->next = NULL;
    return newNode;
}

// 初始化图
void initGraph(Graph *g, int numVertices) {
    g->numVertices = numVertices;
    for (int i = 0; i < numVertices; i++) {
        g->adjList[i] = NULL;
    }
}

// 添加边
void addEdge(Graph *g, int src, int dest) {
    Node *newNode = createNode(dest);
    newNode->next = g->adjList[src];
    g->adjList[src] = newNode;

    // 如果是无向图，还需要添加反向边
    // newNode = createNode(src);
    // newNode->next = g->adjList[dest];
    // g->adjList[dest] = newNode;
}

// 打印邻接表
void printGraph(Graph *g) {
    for (int i = 0; i < g->numVertices; i++) {
        printf("Adjacency list of vertex %d: ", i);
        Node *temp = g->adjList[i];
        while (temp) {
            printf("%d -> ", temp->dest);
            temp = temp->next;
        }
        printf("NULL\n");
    }
}

int main() {
    Graph g;
    initGraph(&g, 5);
    addEdge(&g, 0, 1);
    addEdge(&g, 0, 2);
    addEdge(&g, 1, 2);
    addEdge(&g, 2, 3);
    addEdge(&g, 3, 4);

    printGraph(&g);

    return 0;
}
```

## 常见实践

### 添加节点和边
在上述代码示例中，我们已经展示了如何添加边。添加节点则需要根据使用的表示方法进行相应的调整。对于邻接矩阵，我们需要增加矩阵的大小；对于邻接表，我们需要在邻接表数组中添加一个新的链表头。

### 遍历图
遍历图是图算法中的常见操作，主要有深度优先搜索（DFS）和广度优先搜索（BFS）两种方法。

#### 深度优先搜索（DFS）
DFS 从起始顶点开始，沿着一条路径尽可能深地探索，直到无法继续，然后回溯到上一个顶点，继续探索其他路径。

```c
#include <stdio.h>
#include <stdlib.h>

#define MAX_VERTICES 100

typedef struct Node {
    int dest;
    struct Node *next;
} Node;

typedef struct {
    Node *adjList[MAX_VERTICES];
    int numVertices;
} Graph;

// 创建新节点
Node* createNode(int dest) {
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->dest = dest;
    newNode->next = NULL;
    return newNode;
}

// 初始化图
void initGraph(Graph *g, int numVertices) {
    g->numVertices = numVertices;
    for (int i = 0; i < numVertices; i++) {
        g->adjList[i] = NULL;
    }
}

// 添加边
void addEdge(Graph *g, int src, int dest) {
    Node *newNode = createNode(dest);
    newNode->next = g->adjList[src];
    g->adjList[src] = newNode;
}

// DFS 辅助函数
void DFSUtil(Graph *g, int vertex, int visited[]) {
    visited[vertex] = 1;
    printf("%d ", vertex);

    Node *temp = g->adjList[vertex];
    while (temp) {
        int adjVertex = temp->dest;
        if (!visited[adjVertex]) {
            DFSUtil(g, adjVertex, visited);
        }
        temp = temp->next;
    }
}

// DFS 遍历
void DFS(Graph *g, int startVertex) {
    int visited[MAX_VERTICES] = {0};
    DFSUtil(g, startVertex, visited);
}

int main() {
    Graph g;
    initGraph(&g, 5);
    addEdge(&g, 0, 1);
    addEdge(&g, 0, 2);
    addEdge(&g, 1, 2);
    addEdge(&g, 2, 3);
    addEdge(&g, 3, 4);

    printf("DFS starting from vertex 0: ");
    DFS(&g, 0);

    return 0;
}
```

#### 广度优先搜索（BFS）
BFS 从起始顶点开始，先访问其所有相邻顶点，然后再逐层向外扩展。

```c
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_VERTICES 100

typedef struct Node {
    int dest;
    struct Node *next;
} Node;

typedef struct {
    Node *adjList[MAX_VERTICES];
    int numVertices;
} Graph;

// 创建新节点
Node* createNode(int dest) {
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->dest = dest;
    newNode->next = NULL;
    return newNode;
}

// 初始化图
void initGraph(Graph *g, int numVertices) {
    g->numVertices = numVertices;
    for (int i = 0; i < numVertices; i++) {
        g->adjList[i] = NULL;
    }
}

// 添加边
void addEdge(Graph *g, int src, int dest) {
    Node *newNode = createNode(dest);
    newNode->next = g->adjList[src];
    g->adjList[src] = newNode;
}

// BFS 遍历
void BFS(Graph *g, int startVertex) {
    bool visited[MAX_VERTICES] = {false};
    int queue[MAX_VERTICES];
    int front = 0, rear = 0;

    visited[startVertex] = true;
    queue[rear++] = startVertex;

    while (front < rear) {
        int currentVertex = queue[front++];
        printf("%d ", currentVertex);

        Node *temp = g->adjList[currentVertex];
        while (temp) {
            int adjVertex = temp->dest;
            if (!visited[adjVertex]) {
                visited[adjVertex] = true;
                queue[rear++] = adjVertex;
            }
            temp = temp->next;
        }
    }
}

int main() {
    Graph g;
    initGraph(&g, 5);
    addEdge(&g, 0, 1);
    addEdge(&g, 0, 2);
    addEdge(&g, 1, 2);
    addEdge(&g, 2, 3);
    addEdge(&g, 3, 4);

    printf("BFS starting from vertex 0: ");
    BFS(&g, 0);

    return 0;
}
```

### 最短路径算法
#### Dijkstra算法
Dijkstra算法用于在加权有向图中找到从一个给定顶点到其他所有顶点的最短路径。

```c
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAX_VERTICES 100

typedef struct {
    int adjMatrix[MAX_VERTICES][MAX_VERTICES];
    int numVertices;
} Graph;

// 初始化图
void initGraph(Graph *g, int numVertices) {
    g->numVertices = numVertices;
    for (int i = 0; i < numVertices; i++) {
        for (int j = 0; j < numVertices; j++) {
            g->adjMatrix[i][j] = 0;
        }
    }
}

// 添加边
void addEdge(Graph *g, int src, int dest, int weight) {
    g->adjMatrix[src][dest] = weight;
}

// 找到距离最小的顶点
int minDistance(int dist[], bool sptSet[], int numVertices) {
    int min = INT_MAX, minIndex;

    for (int v = 0; v < numVertices; v++) {
        if (!sptSet[v] && dist[v] <= min) {
            min = dist[v];
            minIndex = v;
        }
    }

    return minIndex;
}

// 打印路径
void printPath(int parent[], int j) {
    if (parent[j] == -1) {
        printf("%d ", j);
        return;
    }

    printPath(parent, parent[j]);
    printf("%d ", j);
}

// 打印结果
void printSolution(int dist[], int parent[], int numVertices, int src) {
    printf("Vertex\t Distance\tPath\n");
    for (int i = 0; i < numVertices; i++) {
        printf("%d -> %d\t\t %d\t\t", src, i, dist[i]);
        printPath(parent, i);
        printf("\n");
    }
}

// Dijkstra算法
void dijkstra(Graph *g, int src) {
    int dist[MAX_VERTICES];
    int parent[MAX_VERTICES];
    bool sptSet[MAX_VERTICES];

    for (int i = 0; i < g->numVertices; i++) {
        dist[i] = INT_MAX;
        parent[i] = -1;
        sptSet[i] = false;
    }

    dist[src] = 0;

    for (int count = 0; count < g->numVertices - 1; count++) {
        int u = minDistance(dist, sptSet, g->numVertices);
        sptSet[u] = true;

        for (int v = 0; v < g->numVertices; v++) {
            if (!sptSet[v] && g->adjMatrix[u][v] && dist[u]!= INT_MAX && dist[u] + g->adjMatrix[u][v] < dist[v]) {
                dist[v] = dist[u] + g->adjMatrix[u][v];
                parent[v] = u;
            }
        }
    }

    printSolution(dist, parent, g->numVertices, src);
}

int main() {
    Graph g;
    initGraph(&g, 5);
    addEdge(&g, 0, 1, 10);
    addEdge(&g, 0, 2, 3);
    addEdge(&g, 1, 2, 1);
    addEdge(&g, 1, 3, 2);
    addEdge(&g, 2, 1, 4);
    addEdge(&g, 2, 3, 8);
    addEdge(&g, 2, 4, 2);
    addEdge(&g, 3, 4, 7);
    addEdge(&g, 4, 3, 9);

    dijkstra(&g, 0);

    return 0;
}
```

## 最佳实践

### 内存管理
在使用邻接表时，动态分配内存需要谨慎处理。确保在程序结束时释放所有分配的内存，以避免内存泄漏。可以编写专门的函数来释放邻接表中的所有节点。

### 代码优化
对于大规模图，算法的性能至关重要。例如，在Dijkstra算法中，可以使用优先队列来优化寻找最小距离顶点的操作，从而提高算法效率。

### 错误处理
在添加边、节点或执行其他操作时，应进行充分的错误检查。例如，检查顶点索引是否在有效范围内，确保内存分配成功等。

## 小结
本文全面介绍了使用C语言实现图的相关知识，包括图的基础概念、两种常见的表示方法（邻接矩阵和邻接表）、常见实践操作（添加节点和边、遍历图、最短路径算法）以及最佳实践。通过深入理解这些内容，读者可以在实际应用中灵活运用图结构解决各种问题。希望本文能为你在C语言实现图的道路上提供有益的指导。
---
title:  C语言实现BFS算法：从基础到最佳实践
description:  简介广度优先搜索（Breadth-First Search，简称BFS）是一种用于图和树的遍历算法。它从起始顶点开始，一层一层地向外扩展，依次访问距离起始顶点最近的所有顶点，然后再访问距离更远一层的顶点，以此类推，直到遍历完所有可达顶点或找到目标顶点。BFS在许多领域都有广泛应用，如路径规划、迷宫求解、社交网络分析等。在本文中，我们将详细介绍如何使用C语言实现BFS算法。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
广度优先搜索（Breadth-First Search，简称BFS）是一种用于图和树的遍历算法。它从起始顶点开始，一层一层地向外扩展，依次访问距离起始顶点最近的所有顶点，然后再访问距离更远一层的顶点，以此类推，直到遍历完所有可达顶点或找到目标顶点。BFS在许多领域都有广泛应用，如路径规划、迷宫求解、社交网络分析等。在本文中，我们将详细介绍如何使用C语言实现BFS算法。

## 目录
1. **BFS算法基础概念**
    - 什么是BFS算法
    - BFS算法的应用场景
2. **C语言实现BFS算法的使用方法**
    - 图的表示
    - 队列的实现
    - BFS算法的代码实现
3. **常见实践**
    - 迷宫求解
    - 最短路径问题
4. **最佳实践**
    - 优化BFS算法
    - 内存管理
5. **小结**

## BFS算法基础概念
### 什么是BFS算法
BFS算法使用队列（Queue）来辅助实现遍历。它从起始顶点开始，将其标记为已访问并放入队列中。然后，不断从队列中取出顶点，访问该顶点的所有未访问邻接顶点，将这些邻接顶点标记为已访问并放入队列。重复这个过程，直到队列为空，此时所有可达顶点都已被访问。

### BFS算法的应用场景
- **路径规划**：在地图上寻找两点之间的最短路径。
- **迷宫求解**：找到从起点到终点的最短路线。
- **网络分析**：在社交网络中查找用户之间的最短关系路径。

## C语言实现BFS算法的使用方法
### 图的表示
在C语言中，图通常有两种表示方法：邻接矩阵（Adjacency Matrix）和邻接表（Adjacency List）。

**邻接矩阵**：用一个二维数组来表示图中顶点之间的连接关系。如果顶点i和顶点j之间有边，则`adjMatrix[i][j]`为1，否则为0。

```c
#define MAX_VERTICES 100

typedef struct {
    int adjMatrix[MAX_VERTICES][MAX_VERTICES];
    int numVertices;
} Graph;

void createGraph(Graph *g, int numVertices) {
    g->numVertices = numVertices;
    for (int i = 0; i < numVertices; i++) {
        for (int j = 0; j < numVertices; j++) {
            g->adjMatrix[i][j] = 0;
        }
    }
}

void addEdge(Graph *g, int src, int dest) {
    g->adjMatrix[src][dest] = 1;
    g->adjMatrix[dest][src] = 1; // 对于无向图
}
```

**邻接表**：用数组和链表相结合的方式来表示图。数组的每个元素指向一个链表，链表中的节点表示与该顶点相邻的顶点。

```c
#include <stdio.h>
#include <stdlib.h>

#define MAX_VERTICES 100

typedef struct Node {
    int vertex;
    struct Node *next;
} Node;

typedef struct {
    Node *adjList[MAX_VERTICES];
    int numVertices;
} Graph;

Node* createNode(int vertex) {
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->vertex = vertex;
    newNode->next = NULL;
    return newNode;
}

void createGraph(Graph *g, int numVertices) {
    g->numVertices = numVertices;
    for (int i = 0; i < numVertices; i++) {
        g->adjList[i] = NULL;
    }
}

void addEdge(Graph *g, int src, int dest) {
    Node *newNode = createNode(dest);
    newNode->next = g->adjList[src];
    g->adjList[src] = newNode;

    newNode = createNode(src);
    newNode->next = g->adjList[dest];
    g->adjList[dest] = newNode; // 对于无向图
}
```

### 队列的实现
BFS算法需要使用队列来存储待访问的顶点。以下是一个简单的队列实现：

```c
typedef struct {
    int items[MAX_VERTICES];
    int front;
    int rear;
} Queue;

void createQueue(Queue *q) {
    q->front = -1;
    q->rear = -1;
}

int isQueueEmpty(Queue *q) {
    return q->front == -1;
}

int isQueueFull(Queue *q) {
    return (q->rear + 1) % MAX_VERTICES == q->front;
}

void enqueue(Queue *q, int item) {
    if (isQueueFull(q)) {
        return;
    }
    if (q->front == -1) {
        q->front = 0;
    }
    q->rear = (q->rear + 1) % MAX_VERTICES;
    q->items[q->rear] = item;
}

int dequeue(Queue *q) {
    if (isQueueEmpty(q)) {
        return -1;
    }
    int item = q->items[q->front];
    if (q->front == q->rear) {
        q->front = -1;
        q->rear = -1;
    } else {
        q->front = (q->front + 1) % MAX_VERTICES;
    }
    return item;
}
```

### BFS算法的代码实现
以下是使用邻接表实现BFS算法的代码：

```c
void bfs(Graph *g, int startVertex) {
    int visited[MAX_VERTICES] = {0};
    Queue q;
    createQueue(&q);

    visited[startVertex] = 1;
    enqueue(&q, startVertex);

    while (!isQueueEmpty(&q)) {
        int currentVertex = dequeue(&q);
        printf("Visited vertex: %d\n", currentVertex);

        Node *temp = g->adjList[currentVertex];
        while (temp!= NULL) {
            int adjVertex = temp->vertex;
            if (!visited[adjVertex]) {
                visited[adjVertex] = 1;
                enqueue(&q, adjVertex);
            }
            temp = temp->next;
        }
    }
}
```

## 常见实践
### 迷宫求解
在迷宫求解问题中，可以将迷宫中的每个格子看作图的顶点，相邻的格子之间有边。使用BFS算法可以找到从起点到终点的最短路径。

```c
#define ROWS 5
#define COLS 5

int maze[ROWS][COLS] = {
    {0, 1, 0, 0, 0},
    {0, 1, 0, 1, 0},
    {0, 0, 0, 0, 0},
    {0, 1, 1, 1, 0},
    {0, 0, 0, 1, 0}
};

typedef struct {
    int row;
    int col;
} Point;

void printPath(Point path[], int len) {
    for (int i = 0; i < len; i++) {
        printf("(%d, %d) ", path[i].row, path[i].col);
    }
    printf("\n");
}

int isValid(int row, int col) {
    return row >= 0 && row < ROWS && col >= 0 && col < COLS && maze[row][col] == 0;
}

void mazeBFS(int startRow, int startCol, int endRow, int endCol) {
    int visited[ROWS][COLS] = {0};
    Queue q;
    createQueue(&q);

    Point start = {startRow, startCol};
    enqueue(&q, start);
    visited[startRow][startCol] = 1;

    Point parent[ROWS][COLS];
    parent[startRow][startCol] = start;

    int found = 0;

    while (!isQueueEmpty(&q)) {
        Point current = dequeue(&q);
        int row = current.row;
        int col = current.col;

        if (row == endRow && col == endCol) {
            found = 1;
            break;
        }

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        for (int i = 0; i < 4; i++) {
            int newRow = row + dr[i];
            int newCol = col + dc[i];

            if (isValid(newRow, newCol) &&!visited[newRow][newCol]) {
                Point newPoint = {newRow, newCol};
                enqueue(&q, newPoint);
                visited[newRow][newCol] = 1;
                parent[newRow][newCol] = current;
            }
        }
    }

    if (found) {
        Point path[ROWS * COLS];
        int len = 0;
        Point current = {endRow, endCol};
        while (current.row!= startRow || current.col!= startCol) {
            path[len++] = current;
            current = parent[current.row][current.col];
        }
        path[len++] = {startRow, startCol};

        printf("Shortest path: ");
        for (int i = len - 1; i >= 0; i--) {
            printf("(%d, %d) ", path[i].row, path[i].col);
        }
        printf("\n");
    } else {
        printf("No path found.\n");
    }
}
```

### 最短路径问题
在一个无权图中，使用BFS算法可以找到从一个顶点到另一个顶点的最短路径。

```c
void shortestPath(Graph *g, int src, int dest) {
    int visited[MAX_VERTICES] = {0};
    int distance[MAX_VERTICES] = {0};
    int parent[MAX_VERTICES] = {-1};
    Queue q;
    createQueue(&q);

    visited[src] = 1;
    enqueue(&q, src);

    while (!isQueueEmpty(&q)) {
        int currentVertex = dequeue(&q);

        if (currentVertex == dest) {
            break;
        }

        Node *temp = g->adjList[currentVertex];
        while (temp!= NULL) {
            int adjVertex = temp->vertex;
            if (!visited[adjVertex]) {
                visited[adjVertex] = 1;
                distance[adjVertex] = distance[currentVertex] + 1;
                parent[adjVertex] = currentVertex;
                enqueue(&q, adjVertex);
            }
            temp = temp->next;
        }
    }

    if (parent[dest]!= -1) {
        printf("Shortest distance from %d to %d is %d\n", src, dest, distance[dest]);
        printf("Path: ");
        int current = dest;
        while (current!= -1) {
            printf("%d ", current);
            current = parent[current];
        }
        printf("\n");
    } else {
        printf("No path from %d to %d\n", src, dest);
    }
}
```

## 最佳实践
### 优化BFS算法
- **双向BFS**：从起点和终点同时进行BFS，当两个搜索相遇时，找到最短路径。这种方法可以显著减少搜索空间，提高算法效率。
- **启发式搜索**：结合启发式函数，引导搜索朝着目标方向进行，减少不必要的搜索。A*算法就是一种结合了BFS和启发式函数的搜索算法。

### 内存管理
- **动态内存分配**：在使用邻接表表示图时，需要动态分配内存来存储节点。在程序结束时，要确保释放所有分配的内存，避免内存泄漏。
- **队列优化**：可以使用循环队列（Circular Queue）来提高队列的内存使用效率，避免频繁的内存分配和释放。

## 小结
本文详细介绍了C语言实现BFS算法的基础概念、使用方法、常见实践以及最佳实践。通过理解BFS算法的原理和应用场景，掌握图的表示方法和队列的实现，以及实际应用中的优化技巧，读者可以在各种问题中灵活运用BFS算法，解决路径规划、迷宫求解等实际问题。希望本文能够帮助读者深入理解并高效使用C语言实现BFS算法。
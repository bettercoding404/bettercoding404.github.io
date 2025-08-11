---
title:  C语言实现优先队列：从基础到实践
description:  简介在计算机科学中，优先队列（Priority Queue）是一种特殊的数据结构，它与普通队列的区别在于，优先队列中的元素按照某种优先级进行排序，优先级高的元素先出队。这种数据结构在很多算法和应用场景中都非常有用，比如 Dijkstra 算法求最短路径、赫夫曼编码等。本文将深入探讨如何使用 C 语言实现优先队列，包括基础概念、使用方法、常见实践以及最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在计算机科学中，优先队列（Priority Queue）是一种特殊的数据结构，它与普通队列的区别在于，优先队列中的元素按照某种优先级进行排序，优先级高的元素先出队。这种数据结构在很多算法和应用场景中都非常有用，比如 Dijkstra 算法求最短路径、赫夫曼编码等。本文将深入探讨如何使用 C 语言实现优先队列，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. **优先队列基础概念**
    - 定义与特点
    - 应用场景
2. **C语言实现优先队列的方法**
    - 基于数组实现
    - 基于链表实现
    - 基于堆实现
3. **常见实践**
    - 插入元素
    - 删除元素
    - 获取队首元素
4. **最佳实践**
    - 性能优化
    - 代码结构优化
5. **小结**

## 优先队列基础概念
### 定义与特点
优先队列是一种抽象数据类型（ADT），它维护一个元素集合，并且支持以下操作：
- **插入（Insert）**：将一个新元素插入到优先队列中。
- **删除（Delete）**：从优先队列中删除一个元素，通常删除的是优先级最高的元素。
- **获取队首元素（Get Front）**：返回优先队列中优先级最高的元素，但不删除它。

与普通队列不同，优先队列并不遵循“先进先出（FIFO）”的原则，而是按照元素的优先级来决定出队顺序。

### 应用场景
优先队列在许多领域都有广泛应用，以下是一些常见的场景：
- **任务调度**：在操作系统中，任务调度器可以使用优先队列来安排任务的执行顺序，优先级高的任务先执行。
- **图算法**：如 Dijkstra 算法用于计算图中从一个顶点到其他所有顶点的最短路径，优先队列可以用来存储顶点及其到源点的距离，每次选择距离最小的顶点进行扩展。
- **数据压缩**：赫夫曼编码算法使用优先队列来构建赫夫曼树，以实现数据的高效压缩。

## C语言实现优先队列的方法
### 基于数组实现
基于数组实现优先队列是一种简单直观的方法。我们可以使用一个数组来存储优先队列的元素，插入操作直接将元素添加到数组末尾，删除操作需要找到优先级最高的元素并将其删除，然后调整数组。

```c
#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 100

typedef struct {
    int data[MAX_SIZE];
    int size;
} PriorityQueue;

// 初始化优先队列
void initPriorityQueue(PriorityQueue *pq) {
    pq->size = 0;
}

// 插入元素
void insert(PriorityQueue *pq, int value) {
    if (pq->size >= MAX_SIZE) {
        printf("优先队列已满\n");
        return;
    }
    pq->data[pq->size++] = value;
}

// 删除优先级最高的元素
void deleteMax(PriorityQueue *pq) {
    if (pq->size == 0) {
        printf("优先队列已空\n");
        return;
    }
    int maxIndex = 0;
    for (int i = 1; i < pq->size; i++) {
        if (pq->data[i] > pq->data[maxIndex]) {
            maxIndex = i;
        }
    }
    for (int i = maxIndex; i < pq->size - 1; i++) {
        pq->data[i] = pq->data[i + 1];
    }
    pq->size--;
}

// 获取队首元素
int getMax(PriorityQueue *pq) {
    if (pq->size == 0) {
        printf("优先队列已空\n");
        return -1;
    }
    int maxValue = pq->data[0];
    for (int i = 1; i < pq->size; i++) {
        if (pq->data[i] > maxValue) {
            maxValue = pq->data[i];
        }
    }
    return maxValue;
}

int main() {
    PriorityQueue pq;
    initPriorityQueue(&pq);

    insert(&pq, 3);
    insert(&pq, 1);
    insert(&pq, 4);
    insert(&pq, 1);
    insert(&pq, 5);

    printf("队首元素: %d\n", getMax(&pq));
    deleteMax(&pq);
    printf("删除后队首元素: %d\n", getMax(&pq));

    return 0;
}
```

### 基于链表实现
基于链表实现优先队列可以动态地分配内存，避免数组可能出现的溢出问题。插入操作需要遍历链表找到合适的位置插入元素，删除操作同样需要找到优先级最高的元素并将其删除。

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node *next;
} Node;

typedef struct {
    Node *front;
} PriorityQueue;

// 初始化优先队列
void initPriorityQueue(PriorityQueue *pq) {
    pq->front = NULL;
}

// 插入元素
void insert(PriorityQueue *pq, int value) {
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->data = value;
    newNode->next = NULL;

    if (pq->front == NULL || value > pq->front->data) {
        newNode->next = pq->front;
        pq->front = newNode;
        return;
    }

    Node *current = pq->front;
    while (current->next!= NULL && value <= current->next->data) {
        current = current->next;
    }
    newNode->next = current->next;
    current->next = newNode;
}

// 删除优先级最高的元素
void deleteMax(PriorityQueue *pq) {
    if (pq->front == NULL) {
        printf("优先队列已空\n");
        return;
    }
    Node *temp = pq->front;
    pq->front = pq->front->next;
    free(temp);
}

// 获取队首元素
int getMax(PriorityQueue *pq) {
    if (pq->front == NULL) {
        printf("优先队列已空\n");
        return -1;
    }
    return pq->front->data;
}

int main() {
    PriorityQueue pq;
    initPriorityQueue(&pq);

    insert(&pq, 3);
    insert(&pq, 1);
    insert(&pq, 4);
    insert(&pq, 1);
    insert(&pq, 5);

    printf("队首元素: %d\n", getMax(&pq));
    deleteMax(&pq);
    printf("删除后队首元素: %d\n", getMax(&pq));

    return 0;
}
```

### 基于堆实现
堆是一种完全二叉树，它的每个节点的值都大于或等于其子节点的值（最大堆）或小于或等于其子节点的值（最小堆）。基于堆实现优先队列可以在 O(log n) 的时间复杂度内完成插入和删除操作，性能比基于数组和链表的实现更好。

```c
#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 100

typedef struct {
    int data[MAX_SIZE];
    int size;
} PriorityQueue;

// 交换两个元素
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// 调整堆以保持最大堆性质
void heapify(PriorityQueue *pq, int index) {
    int largest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < pq->size && pq->data[left] > pq->data[largest])
        largest = left;

    if (right < pq->size && pq->data[right] > pq->data[largest])
        largest = right;

    if (largest!= index) {
        swap(&pq->data[index], &pq->data[largest]);
        heapify(pq, largest);
    }
}

// 初始化优先队列
void initPriorityQueue(PriorityQueue *pq) {
    pq->size = 0;
}

// 插入元素
void insert(PriorityQueue *pq, int value) {
    if (pq->size >= MAX_SIZE) {
        printf("优先队列已满\n");
        return;
    }
    pq->data[pq->size] = value;
    pq->size++;

    for (int i = (pq->size / 2) - 1; i >= 0; i--) {
        heapify(pq, i);
    }
}

// 删除优先级最高的元素
void deleteMax(PriorityQueue *pq) {
    if (pq->size == 0) {
        printf("优先队列已空\n");
        return;
    }
    pq->data[0] = pq->data[pq->size - 1];
    pq->size--;

    for (int i = (pq->size / 2) - 1; i >= 0; i--) {
        heapify(pq, i);
    }
}

// 获取队首元素
int getMax(PriorityQueue *pq) {
    if (pq->size == 0) {
        printf("优先队列已空\n");
        return -1;
    }
    return pq->data[0];
}

int main() {
    PriorityQueue pq;
    initPriorityQueue(&pq);

    insert(&pq, 3);
    insert(&pq, 1);
    insert(&pq, 4);
    insert(&pq, 1);
    insert(&pq, 5);

    printf("队首元素: %d\n", getMax(&pq));
    deleteMax(&pq);
    printf("删除后队首元素: %d\n", getMax(&pq));

    return 0;
}
```

## 常见实践
### 插入元素
插入元素是优先队列的基本操作之一。在基于数组实现中，直接将元素添加到数组末尾；基于链表实现时，需要遍历链表找到合适的位置插入；基于堆实现则需要将元素添加到堆的末尾，然后调整堆以保持堆的性质。

### 删除元素
删除元素通常是删除优先级最高的元素。基于数组实现需要找到最大元素并将其删除，然后调整数组；基于链表实现直接删除链表头节点；基于堆实现则将堆顶元素与堆的末尾元素交换，然后调整堆。

### 获取队首元素
获取队首元素即返回优先级最高的元素。基于数组实现需要遍历数组找到最大元素；基于链表实现直接返回链表头节点的数据；基于堆实现直接返回堆顶元素。

## 最佳实践
### 性能优化
基于堆实现的优先队列在插入和删除操作上具有更好的性能，时间复杂度为 O(log n)，因此在对性能要求较高的场景中，应优先选择基于堆的实现。

### 代码结构优化
为了提高代码的可读性和可维护性，可以将优先队列的操作封装成独立的函数，并使用结构体来表示优先队列。同时，可以添加适当的注释来解释代码的功能和逻辑。

## 小结
本文详细介绍了使用 C 语言实现优先队列的方法，包括基于数组、链表和堆的实现。我们探讨了优先队列的基础概念、常见操作以及最佳实践。在实际应用中，应根据具体需求选择合适的实现方法，以达到最佳的性能和代码质量。希望通过本文的介绍，读者能够深入理解并高效使用 C 语言实现优先队列。
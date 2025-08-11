---
layout: post
date: 2024-12-09
title: "使用C语言实现队列：入门指南"
description:  "在编程世界中，队列（Queue）是一种非常基础且重要的数据结构。它遵循先进先出（FIFO, First In First Out）的原则，广泛应用于各种场景，比如任务调度、打印任务管理等。本篇博客将详细介绍如何使用C语言实现一个简单的队列。"
tags: [C]
cascade:
  - type: docs
---

在编程世界中，队列（Queue）是一种非常基础且重要的数据结构。它遵循先进先出（FIFO, First In First Out）的原则，广泛应用于各种场景，比如任务调度、打印任务管理等。本篇博客将详细介绍如何使用C语言实现一个简单的队列。

### 队列的基本概念

队列可以看作是一种特殊的线性表，允许在末端（通常称为“尾部”）进行插入操作，而在另一端（通常称为“头部”）进行删除操作。就像排队一样，先到的人先离开。

### 队列的基本操作

1. **初始化队列**：创建一个空队列。
2. **入队（Enqueue）**：在队列的尾部加入一个元素。
3. **出队（Dequeue）**：移除并返回队列头部的元素。
4. **获取队头元素（Peek/Front）**：返回队头的元素，但不移除它。
5. **检查队列是否为空**：判断队列中是否有元素。
6. **获得队列长度**：返回队列中元素的个数。

### 使用数组实现队列

首先，我们可以利用数组来实现一个基本的静态队列。需要注意的是，采用数组实现时，队列的容量是固定的，并且需要处理可能的“假溢出”现象。

```c
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_SIZE 100

typedef struct {
    int data[MAX_SIZE];
    int front;
    int rear;
    int size;
} Queue;

// 初始化队列
void initQueue(Queue* q) {
    q->front = 0;
    q->rear = 0;
    q->size = 0;
}

// 检查队列是否为空
bool isEmpty(Queue* q) {
    return q->size == 0;
}

// 检查队列是否已满
bool isFull(Queue* q) {
    return q->size == MAX_SIZE;
}

// 入队
bool enqueue(Queue* q, int value) {
    if(isFull(q)) {
        printf("Queue is full!\n");
        return false;
    }
    q->data[q->rear] = value;
    q->rear = (q->rear + 1) % MAX_SIZE;
    q->size++;
    return true;
}

// 出队
bool dequeue(Queue* q, int* value) {
    if(isEmpty(q)) {
        printf("Queue is empty!\n");
        return false;
    }
    *value = q->data[q->front];
    q->front = (q->front + 1) % MAX_SIZE;
    q->size--;
    return true;
}

// 获取队头元素
bool peek(Queue* q, int* value) {
    if(isEmpty(q)) {
        printf("Queue is empty!\n");
        return false;
    }
    *value = q->data[q->front];
    return true;
}

int main() {
    Queue q;
    initQueue(&q);

    enqueue(&q, 10);
    enqueue(&q, 20);
    enqueue(&q, 30);

    int value;
    if (dequeue(&q, &value)) {
        printf("Dequeued: %d\n", value);
    }

    if (peek(&q, &value)) {
        printf("Front element: %d\n", value);
    }

    return 0;
}
```

### 使用链表实现队列

使用链表实现队列能够动态调整大小，避免了数组实现中的“假溢出”问题。

```c
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

typedef struct {
    Node* front;
    Node* rear;
} Queue;

// 初始化队列
void initQueue(Queue* q) {
    q->front = q->rear = NULL;
}

// 检查队列是否为空
bool isEmpty(Queue* q) {
    return q->front == NULL;
}

// 入队
void enqueue(Queue* q, int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    if (!newNode) {
        printf("Memory allocation failed\n");
        return;
    }
    newNode->data = value;
    newNode->next = NULL;
    if (isEmpty(q)) {
        q->front = q->rear = newNode;
    } else {
        q->rear->next = newNode;
        q->rear = newNode;
    }
}

// 出队
bool dequeue(Queue* q, int* value) {
    if (isEmpty(q)) {
        printf("Queue is empty!\n");
        return false;
    }
    Node* temp = q->front;
    *value = temp->data;
    q->front = q->front->next;
    if (q->front == NULL) {
        q->rear = NULL;
    }
    free(temp);
    return true;
}

// 获取队头元素
bool peek(Queue* q, int* value) {
    if (isEmpty(q)) {
        printf("Queue is empty!\n");
        return false;
    }
    *value = q->front->data;
    return true;
}

int main() {
    Queue q;
    initQueue(&q);

    enqueue(&q, 10);
    enqueue(&q, 20);
    enqueue(&q, 30);

    int value;
    if (dequeue(&q, &value)) {
        printf("Dequeued: %d\n", value);
    }

    if (peek(&q, &value)) {
        printf("Front element: %d\n", value);
    }

    return 0;
}
```

### 结论

在这篇博客中，我们介绍了队列的基本概念及其在编程中的重要性，并通过C语言展示了如何使用数组和链表两种方式来实现队列。选择何种实现方式，可以根据实际需求权衡队列容量的大小和内存的动态管理。通过这些简单的实现，你可以更深入地理解队列的原理，并尝试在更多复杂的算法和系统中进行应用。
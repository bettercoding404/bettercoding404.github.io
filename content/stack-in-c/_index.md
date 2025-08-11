---
layout: post
date: 2024-12-09
title: "探索C语言中的栈：原理、实现与实战"
description: "栈是编程中一种非常重要的数据结构，广泛应用于各种算法和编程场景中。在C语言中，如何实现一个高效且易于使用的栈，是许多初学者和进阶程序员都需要掌握的技能。本文将深入探讨C语言中栈的原理、实现方法及实际应用。"
tags: [C]
cascade:
  - type: docs
---
栈是编程中一种非常重要的数据结构，广泛应用于各种算法和编程场景中。在C语言中，如何实现一个高效且易于使用的栈，是许多初学者和进阶程序员都需要掌握的技能。本文将深入探讨C语言中栈的原理、实现方法及实际应用。

### 什么是栈？

栈（Stack）是一种**后进先出（LIFO, Last In First Out）**的数据结构。这意味着最新添加的元素最先被移除，就像是一摞盘子，您只能从顶部拿盘子或放回盘子。

### 栈的基本操作

- **Push**: 在栈顶添加一个元素。
- **Pop**: 移除栈顶的元素。
- **Peek/Top**: 查看栈顶元素，但不移除它。
- **IsEmpty**: 检查栈是否为空。
- **IsFull**: 检查栈是否已满（这对于基于数组的实现是必要的）。

### 用数组实现栈

用数组来实现栈是最基础的方法之一。这种实现简单直观，易于理解，适合小规模或固定大小的栈需求。

```c
#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 100

typedef struct {
    int items[MAX_SIZE];
    int top;
} Stack;

// 初始化栈
void initStack(Stack* stack) {
    stack->top = -1;
}

// 检查栈是否为空
int isEmpty(Stack* stack) {
    return stack->top == -1;
}

// 检查栈是否为满
int isFull(Stack* stack) {
    return stack->top == MAX_SIZE - 1;
}

// 入栈操作
void push(Stack* stack, int item) {
    if (isFull(stack)) {
        printf("Stack overflow\n");
        return;
    }
    stack->items[++stack->top] = item;
}

// 出栈操作
int pop(Stack* stack) {
    if (isEmpty(stack)) {
        printf("Stack underflow\n");
        return -1;  // 使用-1表示出错
    }
    return stack->items[stack->top--];
}

// 查看栈顶元素
int peek(Stack* stack) {
    if (isEmpty(stack)) {
        printf("Stack is empty\n");
        return -1;  // 使用-1表示出错
    }
    return stack->items[stack->top];
}

int main() {
    Stack stack;
    initStack(&stack);

    push(&stack, 10);
    push(&stack, 20);
    push(&stack, 30);

    printf("Top element is %d\n", peek(&stack));
    printf("Popped element is %d\n", pop(&stack));
    printf("Top element is %d\n", peek(&stack));

    return 0;
}
```

### 用链表实现栈

链表实现比数组实现更灵活，因为它不需要预测栈的大小。链表不仅避免了栈的溢出问题，还能动态调整栈的大小。

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int data;
    struct Node* next;
} Node;

Node* createNode(int data) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->data = data;
    node->next = NULL;
    return node;
}

void push(Node** top, int data) {
    Node* node = createNode(data);
    node->next = *top;
    *top = node;
}

int pop(Node** top) {
    if (*top == NULL) {
        printf("Stack underflow\n");
        return -1;
    }
    Node* temp = *top;
    int popped = temp->data;
    *top = temp->next;
    free(temp);
    return popped;
}

int peek(Node* top) {
    if (top == NULL) {
        printf("Stack is empty\n");
        return -1;
    }
    return top->data;
}

int isEmpty(Node* top) {
    return top == NULL;
}

int main() {
    Node* stack = NULL;

    push(&stack, 10);
    push(&stack, 20);
    push(&stack, 30);

    printf("Top element is %d\n", peek(stack));
    printf("Popped element is %d\n", pop(&stack));
    printf("Top element is %d\n", peek(stack));

    return 0;
}
```

### 栈的应用场景

- **函数调用栈**：用于维护函数调用信息。
- **表达式求值**：支持中缀转后缀表达式、计算机计算器等。
- **撤销操作**：在文本编辑器中实现撤销功能。
- **树和图的遍历**：深度优先搜索（DFS）等算法用到栈。

### 总结

栈作为一种基础的数据结构，在计算机科学中的地位举足轻重。通过理解栈的原理以及用C语言进行实现，程序员可以在实际项目中更灵活地应用这种数据结构。无论是数组还是链表实现，掌握两种方法能够帮助您在不同场景下做出更好的选择。希望这篇文章能为你的C语言学习提供帮助！
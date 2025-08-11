---
title:  C语言实现平衡二叉树
description:  简介平衡二叉树（AVL树）是一种自平衡二叉查找树，由苏联数学家Adelson-Velsky和Landis在1962年发明。在AVL树中，任意节点的左子树和右子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树。这种特性保证了二叉查找树在插入和删除操作后依然能保持高效的查找性能，其平均和最坏情况下的时间复杂度均为O(log n)，其中n是节点的数量。本文将详细介绍如何使用C语言实现平衡二叉树。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
平衡二叉树（AVL树）是一种自平衡二叉查找树，由苏联数学家Adelson-Velsky和Landis在1962年发明。在AVL树中，任意节点的左子树和右子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树。这种特性保证了二叉查找树在插入和删除操作后依然能保持高效的查找性能，其平均和最坏情况下的时间复杂度均为O(log n)，其中n是节点的数量。本文将详细介绍如何使用C语言实现平衡二叉树。

## 目录
1. 基础概念
    - 平衡因子
    - 旋转操作
2. 使用方法
    - 节点定义
    - 树的初始化
    - 插入操作
    - 删除操作
    - 查找操作
3. 常见实践
    - 打印树结构
    - 计算树的高度
4. 最佳实践
    - 错误处理
    - 内存管理
5. 代码示例
6. 小结

## 基础概念

### 平衡因子
平衡因子是指一个节点的左子树高度减去右子树高度。对于平衡二叉树，每个节点的平衡因子只能是 -1、0 或 1。如果某个节点的平衡因子绝对值大于 1，则说明该树失去了平衡，需要进行调整。

### 旋转操作
为了使失衡的树重新恢复平衡，需要进行旋转操作。常见的旋转操作有左旋、右旋、先左旋后右旋、先右旋后左旋。
 - **左旋**：将一个节点的右子节点提升为父节点，并将原父节点变为右子节点的左子节点。
 - **右旋**：将一个节点的左子节点提升为父节点，并将原父节点变为左子节点的右子节点。
 - **先左旋后右旋**：先对节点的左子节点进行左旋，再对该节点进行右旋。
 - **先右旋后左旋**：先对节点的右子节点进行右旋，再对该节点进行左旋。

## 使用方法

### 节点定义
首先需要定义平衡二叉树的节点结构，每个节点包含数据、左子节点指针、右子节点指针以及高度信息。

```c
typedef struct AVLNode {
    int data;
    struct AVLNode *left;
    struct AVLNode *right;
    int height;
} AVLNode;

typedef struct AVLTree {
    AVLNode *root;
} AVLTree;
```

### 树的初始化
初始化一棵空的平衡二叉树。

```c
void initAVLTree(AVLTree *tree) {
    tree->root = NULL;
}
```

### 插入操作
插入操作与普通二叉查找树的插入类似，但插入后需要检查树是否失衡，并进行相应的旋转操作来恢复平衡。

```c
int height(AVLNode *node) {
    if (node == NULL) {
        return 0;
    }
    return node->height;
}

int max(int a, int b) {
    return (a > b)? a : b;
}

AVLNode* newNode(int data) {
    AVLNode *node = (AVLNode*)malloc(sizeof(AVLNode));
    node->data = data;
    node->left = NULL;
    node->right = NULL;
    node->height = 1;
    return node;
}

AVLNode* rightRotate(AVLNode *y) {
    AVLNode *x = y->left;
    AVLNode *T2 = x->right;

    x->right = y;
    y->left = T2;

    y->height = max(height(y->left), height(y->right)) + 1;
    x->height = max(height(x->left), height(x->right)) + 1;

    return x;
}

AVLNode* leftRotate(AVLNode *x) {
    AVLNode *y = x->right;
    AVLNode *T2 = y->left;

    y->left = x;
    x->right = T2;

    x->height = max(height(x->left), height(x->right)) + 1;
    y->height = max(height(y->left), height(y->right)) + 1;

    return y;
}

int getBalance(AVLNode *node) {
    if (node == NULL) {
        return 0;
    }
    return height(node->left) - height(node->right);
}

AVLNode* insert(AVLNode *node, int data) {
    if (node == NULL) {
        return newNode(data);
    }

    if (data < node->data) {
        node->left = insert(node->left, data);
    } else if (data > node->data) {
        node->right = insert(node->right, data);
    } else {
        return node;
    }

    node->height = 1 + max(height(node->left), height(node->right));

    int balance = getBalance(node);

    // 左左情况
    if (balance > 1 && data < node->left->data) {
        return rightRotate(node);
    }

    // 右右情况
    if (balance < -1 && data > node->right->data) {
        return leftRotate(node);
    }

    // 左右情况
    if (balance > 1 && data > node->left->data) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }

    // 右左情况
    if (balance < -1 && data < node->right->data) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }

    return node;
}

void insertIntoAVLTree(AVLTree *tree, int data) {
    tree->root = insert(tree->root, data);
}
```

### 删除操作
删除操作比插入操作更复杂，需要在删除节点后重新调整树的平衡。

```c
AVLNode* minValueNode(AVLNode *node) {
    AVLNode *current = node;
    while (current->left!= NULL) {
        current = current->left;
    }
    return current;
}

AVLNode* deleteNode(AVLNode *node, int data) {
    if (node == NULL) {
        return node;
    }

    if (data < node->data) {
        node->left = deleteNode(node->left, data);
    } else if (data > node->data) {
        node->right = deleteNode(node->right, data);
    } else {
        if ((node->left == NULL) || (node->right == NULL)) {
            AVLNode *temp = node->left? node->left : node->right;

            if (temp == NULL) {
                temp = node;
                node = NULL;
            } else {
                *node = *temp;
            }
            free(temp);
        } else {
            AVLNode *temp = minValueNode(node->right);
            node->data = temp->data;
            node->right = deleteNode(node->right, temp->data);
        }
    }

    if (node == NULL) {
        return node;
    }

    node->height = 1 + max(height(node->left), height(node->right));

    int balance = getBalance(node);

    // 左左情况
    if (balance > 1 && getBalance(node->left) >= 0) {
        return rightRotate(node);
    }

    // 右右情况
    if (balance < -1 && getBalance(node->right) <= 0) {
        return leftRotate(node);
    }

    // 左右情况
    if (balance > 1 && getBalance(node->left) < 0) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }

    // 右左情况
    if (balance < -1 && getBalance(node->right) > 0) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }

    return node;
}

void deleteFromAVLTree(AVLTree *tree, int data) {
    tree->root = deleteNode(tree->root, data);
}
```

### 查找操作
查找操作与普通二叉查找树相同。

```c
AVLNode* search(AVLNode *node, int data) {
    if (node == NULL || node->data == data) {
        return node;
    }

    if (node->data < data) {
        return search(node->right, data);
    }

    return search(node->left, data);
}

int searchInAVLTree(AVLTree *tree, int data) {
    AVLNode *result = search(tree->root, data);
    return result!= NULL;
}
```

## 常见实践

### 打印树结构
为了便于调试和查看树的结构，可以实现一个打印树的函数，这里采用中序遍历的方式打印节点数据。

```c
void inorderTraversal(AVLNode *node) {
    if (node!= NULL) {
        inorderTraversal(node->left);
        printf("%d ", node->data);
        inorderTraversal(node->right);
    }
}

void printAVLTree(AVLTree *tree) {
    inorderTraversal(tree->root);
    printf("\n");
}
```

### 计算树的高度
计算树的高度可以帮助我们了解树的结构和平衡状态。

```c
int treeHeight(AVLTree *tree) {
    return height(tree->root);
}
```

## 最佳实践

### 错误处理
在进行内存分配（如 `malloc`）时，应检查返回值是否为 `NULL`，以处理内存分配失败的情况。

```c
AVLNode* newNode(int data) {
    AVLNode *node = (AVLNode*)malloc(sizeof(AVLNode));
    if (node == NULL) {
        // 处理内存分配失败的情况，例如记录日志或抛出错误
        return NULL;
    }
    node->data = data;
    node->left = NULL;
    node->right = NULL;
    node->height = 1;
    return node;
}
```

### 内存管理
在删除节点时，确保释放所有分配的内存，避免内存泄漏。在 `deleteNode` 函数中，当节点被删除时，使用 `free` 函数释放内存。

## 代码示例
下面是一个完整的C语言实现平衡二叉树的代码示例，包含上述所有功能。

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct AVLNode {
    int data;
    struct AVLNode *left;
    struct AVLNode *right;
    int height;
} AVLNode;

typedef struct AVLTree {
    AVLNode *root;
} AVLTree;

void initAVLTree(AVLTree *tree) {
    tree->root = NULL;
}

int height(AVLNode *node) {
    if (node == NULL) {
        return 0;
    }
    return node->height;
}

int max(int a, int b) {
    return (a > b)? a : b;
}

AVLNode* newNode(int data) {
    AVLNode *node = (AVLNode*)malloc(sizeof(AVLNode));
    if (node == NULL) {
        return NULL;
    }
    node->data = data;
    node->left = NULL;
    node->right = NULL;
    node->height = 1;
    return node;
}

AVLNode* rightRotate(AVLNode *y) {
    AVLNode *x = y->left;
    AVLNode *T2 = x->right;

    x->right = y;
    y->left = T2;

    y->height = max(height(y->left), height(y->right)) + 1;
    x->height = max(height(x->left), height(x->right)) + 1;

    return x;
}

AVLNode* leftRotate(AVLNode *x) {
    AVLNode *y = x->right;
    AVLNode *T2 = y->left;

    y->left = x;
    x->right = T2;

    x->height = max(height(x->left), height(x->right)) + 1;
    y->height = max(height(y->left), height(y->right)) + 1;

    return y;
}

int getBalance(AVLNode *node) {
    if (node == NULL) {
        return 0;
    }
    return height(node->left) - height(node->right);
}

AVLNode* insert(AVLNode *node, int data) {
    if (node == NULL) {
        return newNode(data);
    }

    if (data < node->data) {
        node->left = insert(node->left, data);
    } else if (data > node->data) {
        node->right = insert(node->right, data);
    } else {
        return node;
    }

    node->height = 1 + max(height(node->left), height(node->right));

    int balance = getBalance(node);

    // 左左情况
    if (balance > 1 && data < node->left->data) {
        return rightRotate(node);
    }

    // 右右情况
    if (balance < -1 && data > node->right->data) {
        return leftRotate(node);
    }

    // 左右情况
    if (balance > 1 && data > node->left->data) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }

    // 右左情况
    if (balance < -1 && data < node->right->data) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }

    return node;
}

void insertIntoAVLTree(AVLTree *tree, int data) {
    tree->root = insert(tree->root, data);
}

AVLNode* minValueNode(AVLNode *node) {
    AVLNode *current = node;
    while (current->left!= NULL) {
        current = current->left;
    }
    return current;
}

AVLNode* deleteNode(AVLNode *node, int data) {
    if (node == NULL) {
        return node;
    }

    if (data < node->data) {
        node->left = deleteNode(node->left, data);
    } else if (data > node->data) {
        node->right = deleteNode(node->right, data);
    } else {
        if ((node->left == NULL) || (node->right == NULL)) {
            AVLNode *temp = node->left? node->left : node->right;

            if (temp == NULL) {
                temp = node;
                node = NULL;
            } else {
                *node = *temp;
            }
            free(temp);
        } else {
            AVLNode *temp = minValueNode(node->right);
            node->data = temp->data;
            node->right = deleteNode(node->right, temp->data);
        }
    }

    if (node == NULL) {
        return node;
    }

    node->height = 1 + max(height(node->left), height(node->right));

    int balance = getBalance(node);

    // 左左情况
    if (balance > 1 && getBalance(node->left) >= 0) {
        return rightRotate(node);
    }

    // 右右情况
    if (balance < -1 && getBalance(node->right) <= 0) {
        return leftRotate(node);
    }

    // 左右情况
    if (balance > 1 && getBalance(node->left) < 0) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }

    // 右左情况
    if (balance < -1 && getBalance(node->right) > 0) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }

    return node;
}

void deleteFromAVLTree(AVLTree *tree, int data) {
    tree->root = deleteNode(tree->root, data);
}

AVLNode* search(AVLNode *node, int data) {
    if (node == NULL || node->data == data) {
        return node;
    }

    if (node->data < data) {
        return search(node->right, data);
    }

    return search(node->left, data);
}

int searchInAVLTree(AVLTree *tree, int data) {
    AVLNode *result = search(tree->root, data);
    return result!= NULL;
}

void inorderTraversal(AVLNode *node) {
    if (node!= NULL) {
        inorderTraversal(node->left);
        printf("%d ", node->data);
        inorderTraversal(node->right);
    }
}

void printAVLTree(AVLTree *tree) {
    inorderTraversal(tree->root);
    printf("\n");
}

int treeHeight(AVLTree *tree) {
    return height
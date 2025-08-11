---
title:  C语言实现红黑树：从基础到最佳实践
description:  简介红黑树（Red-Black Tree）是一种自平衡二叉查找树，它在计算机科学中被广泛应用，例如在 Linux 内核的虚拟内存管理、C++ 的 STL 中的关联容器等。红黑树通过一些规则来保持树的平衡，从而保证了插入、删除和查找操作的时间复杂度为 O(log n)。本文将详细介绍如何使用 C 语言实现红黑树，包括基础概念、使用方法、常见实践以及最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
红黑树（Red-Black Tree）是一种自平衡二叉查找树，它在计算机科学中被广泛应用，例如在 Linux 内核的虚拟内存管理、C++ 的 STL 中的关联容器等。红黑树通过一些规则来保持树的平衡，从而保证了插入、删除和查找操作的时间复杂度为 O(log n)。本文将详细介绍如何使用 C 语言实现红黑树，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 红黑树基础概念
2. C语言实现红黑树的基本结构
3. 红黑树操作的实现
    - 插入操作
    - 删除操作
    - 旋转操作
    - 颜色调整操作
4. 使用方法与示例代码
5. 常见实践
6. 最佳实践
7. 小结

## 红黑树基础概念
红黑树具有以下几个重要特性：
1. **每个节点要么是红色，要么是黑色**
2. **根节点是黑色**
3. **每个叶子节点（NIL 节点）是黑色**
4. **如果一个节点是红色的，则它的子节点必须是黑色的**
5. **从一个节点到该节点的子孙节点的所有路径上包含相同数目的黑色节点**

这些特性保证了红黑树的平衡，使得树的高度始终保持在 O(log n) 的范围内，从而保证了各种操作的高效性。

## C语言实现红黑树的基本结构
首先，我们需要定义红黑树的节点结构和树的结构。

```c
#include <stdio.h>
#include <stdlib.h>

// 定义红黑树节点颜色
typedef enum {
    RED,
    BLACK
} Color;

// 定义红黑树节点结构
typedef struct Node {
    int key;
    Color color;
    struct Node *left, *right, *parent;
} Node;

// 定义红黑树结构
typedef struct {
    Node *root;
} RedBlackTree;
```

在上述代码中，我们定义了一个 `Color` 枚举类型来表示节点的颜色，以及一个 `Node` 结构体来表示红黑树的节点，每个节点包含键值、颜色以及指向左右子节点和父节点的指针。最后，我们定义了一个 `RedBlackTree` 结构体来表示整个红黑树，它只包含一个指向根节点的指针。

## 红黑树操作的实现

### 插入操作
插入操作首先按照二叉查找树的规则找到插入位置，然后将新节点插入树中，并通过旋转和颜色调整来保持红黑树的性质。

```c
// 创建新节点
Node* createNode(int key) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->color = RED;
    newNode->left = newNode->right = newNode->parent = NULL;
    return newNode;
}

// 插入操作辅助函数
void insertFixup(RedBlackTree* tree, Node* newNode) {
    while (newNode!= tree->root && newNode->parent->color == RED) {
        if (newNode->parent == newNode->parent->parent->left) {
            Node* uncle = newNode->parent->parent->right;
            if (uncle!= NULL && uncle->color == RED) {
                newNode->parent->color = BLACK;
                uncle->color = BLACK;
                newNode->parent->parent->color = RED;
                newNode = newNode->parent->parent;
            } else {
                if (newNode == newNode->parent->right) {
                    newNode = newNode->parent;
                    leftRotate(tree, newNode);
                }
                newNode->parent->color = BLACK;
                newNode->parent->parent->color = RED;
                rightRotate(tree, newNode->parent->parent);
            }
        } else {
            Node* uncle = newNode->parent->parent->left;
            if (uncle!= NULL && uncle->color == RED) {
                newNode->parent->color = BLACK;
                uncle->color = BLACK;
                newNode->parent->parent->color = RED;
                newNode = newNode->parent->parent;
            } else {
                if (newNode == newNode->parent->left) {
                    newNode = newNode->parent;
                    rightRotate(tree, newNode);
                }
                newNode->parent->color = BLACK;
                newNode->parent->parent->color = RED;
                leftRotate(tree, newNode->parent->parent);
            }
        }
    }
    tree->root->color = BLACK;
}

// 插入操作主函数
void insert(RedBlackTree* tree, int key) {
    Node* newNode = createNode(key);
    Node* current = tree->root;
    Node* parent = NULL;

    while (current!= NULL) {
        parent = current;
        if (newNode->key < current->key) {
            current = current->left;
        } else {
            current = current->right;
        }
    }

    newNode->parent = parent;
    if (parent == NULL) {
        tree->root = newNode;
    } else if (newNode->key < parent->key) {
        parent->left = newNode;
    } else {
        parent->right = newNode;
    }

    insertFixup(tree, newNode);
}
```

### 删除操作
删除操作首先按照二叉查找树的规则删除节点，然后通过旋转和颜色调整来保持红黑树的性质。

```c
// 找到节点的后继节点
Node* successor(Node* node) {
    if (node->right!= NULL) {
        Node* current = node->right;
        while (current->left!= NULL) {
            current = current->left;
        }
        return current;
    } else {
        Node* current = node->parent;
        while (current!= NULL && node == current->right) {
            node = current;
            current = current->parent;
        }
        return current;
    }
}

// 删除操作辅助函数
void deleteFixup(RedBlackTree* tree, Node* x) {
    while (x!= tree->root && (x == NULL || x->color == BLACK)) {
        if (x == x->parent->left) {
            Node* w = x->parent->right;
            if (w->color == RED) {
                w->color = BLACK;
                x->parent->color = RED;
                leftRotate(tree, x->parent);
                w = x->parent->right;
            }
            if ((w->left == NULL || w->left->color == BLACK) &&
                (w->right == NULL || w->right->color == BLACK)) {
                w->color = RED;
                x = x->parent;
            } else {
                if (w->right == NULL || w->right->color == BLACK) {
                    w->left->color = BLACK;
                    w->color = RED;
                    rightRotate(tree, w);
                    w = x->parent->right;
                }
                w->color = x->parent->color;
                x->parent->color = BLACK;
                w->right->color = BLACK;
                leftRotate(tree, x->parent);
                x = tree->root;
            }
        } else {
            Node* w = x->parent->left;
            if (w->color == RED) {
                w->color = BLACK;
                x->parent->color = RED;
                rightRotate(tree, x->parent);
                w = x->parent->left;
            }
            if ((w->right == NULL || w->right->color == BLACK) &&
                (w->left == NULL || w->left->color == BLACK)) {
                w->color = RED;
                x = x->parent;
            } else {
                if (w->left == NULL || w->left->color == BLACK) {
                    w->right->color = BLACK;
                    w->color = RED;
                    leftRotate(tree, w);
                    w = x->parent->left;
                }
                w->color = x->parent->color;
                x->parent->color = BLACK;
                w->left->color = BLACK;
                rightRotate(tree, x->parent);
                x = tree->root;
            }
        }
    }
    if (x!= NULL) {
        x->color = BLACK;
    }
}

// 删除操作主函数
void delete(RedBlackTree* tree, int key) {
    Node* current = tree->root;
    Node* toDelete = NULL;

    while (current!= NULL) {
        if (key == current->key) {
            toDelete = current;
            break;
        } else if (key < current->key) {
            current = current->left;
        } else {
            current = current->right;
        }
    }

    if (toDelete == NULL) {
        return;
    }

    Node* x;
    Node* y = toDelete;
    Color yOriginalColor = y->color;

    if (toDelete->left == NULL) {
        x = toDelete->right;
        transplant(tree, toDelete, toDelete->right);
    } else if (toDelete->right == NULL) {
        x = toDelete->left;
        transplant(tree, toDelete, toDelete->left);
    } else {
        y = successor(toDelete);
        yOriginalColor = y->color;
        x = y->right;
        if (y->parent == toDelete) {
            if (x!= NULL) {
                x->parent = y;
            }
        } else {
            transplant(tree, y, y->right);
            y->right = toDelete->right;
            y->right->parent = y;
        }
        transplant(tree, toDelete, y);
        y->left = toDelete->left;
        y->left->parent = y;
        y->color = toDelete->color;
    }

    if (yOriginalColor == BLACK) {
        deleteFixup(tree, x);
    }
}

// 辅助函数：用于移植节点
void transplant(RedBlackTree* tree, Node* u, Node* v) {
    if (u->parent == NULL) {
        tree->root = v;
    } else if (u == u->parent->left) {
        u->parent->left = v;
    } else {
        u->parent->right = v;
    }
    if (v!= NULL) {
        v->parent = u->parent;
    }
}
```

### 旋转操作
旋转操作分为左旋和右旋，用于调整树的结构以保持平衡。

```c
// 左旋操作
void leftRotate(RedBlackTree* tree, Node* x) {
    Node* y = x->right;
    x->right = y->left;
    if (y->left!= NULL) {
        y->left->parent = x;
    }
    y->parent = x->parent;
    if (x->parent == NULL) {
        tree->root = y;
    } else if (x == x->parent->left) {
        x->parent->left = y;
    } else {
        x->parent->right = y;
    }
    y->left = x;
    x->parent = y;
}

// 右旋操作
void rightRotate(RedBlackTree* tree, Node* y) {
    Node* x = y->left;
    y->left = x->right;
    if (x->right!= NULL) {
        x->right->parent = y;
    }
    x->parent = y->parent;
    if (y->parent == NULL) {
        tree->root = x;
    } else if (y == y->parent->right) {
        y->parent->right = x;
    } else {
        y->parent->left = x;
    }
    x->right = y;
    y->parent = x;
}
```

### 颜色调整操作
颜色调整操作在插入和删除操作后进行，用于恢复红黑树的性质。这部分代码已经包含在插入和删除操作的辅助函数中。

## 使用方法与示例代码
下面是一个完整的示例代码，展示了如何使用上述实现的红黑树。

```c
// 初始化红黑树
RedBlackTree* createRedBlackTree() {
    RedBlackTree* tree = (RedBlackTree*)malloc(sizeof(RedBlackTree));
    tree->root = NULL;
    return tree;
}

// 打印红黑树（简单的中序遍历，可扩展为更详细的打印）
void inorderTraversal(Node* node) {
    if (node!= NULL) {
        inorderTraversal(node->left);
        printf("Key: %d, Color: %s\n", node->key, node->color == RED? "RED" : "BLACK");
        inorderTraversal(node->right);
    }
}

int main() {
    RedBlackTree* tree = createRedBlackTree();

    insert(tree, 5);
    insert(tree, 3);
    insert(tree, 8);
    insert(tree, 2);
    insert(tree, 4);
    insert(tree, 7);
    insert(tree, 9);

    printf("Inorder traversal of the Red-Black Tree:\n");
    inorderTraversal(tree->root);

    delete(tree, 3);

    printf("\nInorder traversal after deleting 3:\n");
    inorderTraversal(tree->root);

    return 0;
}
```

## 常见实践
1. **错误处理**：在内存分配失败（如 `malloc` 返回 `NULL`）时，应进行适当的错误处理，例如释放已分配的内存并返回错误码。
2. **性能优化**：在实际应用中，如果数据量较大，可以考虑使用内存池技术来减少内存分配和释放的开销。
3. **测试与调试**：编写单元测试来验证红黑树的各种操作是否正确，使用调试工具（如 GDB）来查找潜在的错误。

## 最佳实践
1. **代码模块化**：将红黑树的实现封装成独立的模块，提供清晰的接口，方便在不同的项目中复用。
2. **文档化**：为代码添加详细的注释，特别是对于复杂的操作（如插入和删除的调整过程），以便其他开发者能够理解和维护代码。
3. **内存管理**：在删除红黑树节点时，确保正确释放所有分配的内存，避免内存泄漏。

## 小结
本文详细介绍了使用 C 语言实现红黑树的过程，包括红黑树的基础概念、基本结构、各种操作的实现、使用方法、常见实践以及最佳实践。通过掌握这些内容，读者可以在实际项目中灵活运用红黑树来提高算法的性能和效率。红黑树是一种强大的数据结构，理解其实现原理对于深入学习算法和数据结构具有重要意义。希望本文能够帮助读者更好地理解和应用 C 语言实现的红黑树。
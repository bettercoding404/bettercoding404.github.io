---
title:  C语言实现哈希表：从基础到实践
description:  简介哈希表（Hash Table），也叫散列表，是一种非常重要的数据结构，它提供了快速的数据查找、插入和删除操作。在C语言中实现哈希表，不仅能加深对数据结构和算法的理解，还能在实际编程中提高程序的性能。本文将详细介绍C语言实现哈希表的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
哈希表（Hash Table），也叫散列表，是一种非常重要的数据结构，它提供了快速的数据查找、插入和删除操作。在C语言中实现哈希表，不仅能加深对数据结构和算法的理解，还能在实际编程中提高程序的性能。本文将详细介绍C语言实现哈希表的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。

## 目录
1. **哈希表基础概念**
    - 什么是哈希表
    - 哈希函数
    - 冲突处理
2. **C语言实现哈希表的使用方法**
    - 定义哈希表结构
    - 实现哈希函数
    - 处理冲突
    - 插入、查找和删除操作
3. **常见实践**
    - 简单的整数哈希表实现
    - 字符串哈希表实现
4. **最佳实践**
    - 选择合适的哈希函数
    - 优化冲突处理
    - 动态调整哈希表大小
5. **小结**

## 哈希表基础概念
### 什么是哈希表
哈希表是一种基于键值对（key-value pair）的数据结构。它通过一个哈希函数将键映射到一个特定的索引位置，从而可以在接近常数时间内实现对值的查找、插入和删除操作。理想情况下，不同的键应该映射到不同的索引位置，但实际中很难做到，这就引出了冲突的概念。

### 哈希函数
哈希函数是哈希表的核心。它将输入的键转换为一个整数，这个整数作为哈希表的索引。一个好的哈希函数应该具备以下特点：
- **快速计算**：能够在短时间内计算出哈希值。
- **均匀分布**：将不同的键均匀地映射到哈希表的各个位置，减少冲突。

### 冲突处理
当两个或多个不同的键通过哈希函数计算得到相同的索引位置时，就发生了冲突。常见的冲突处理方法有：
- **开放地址法**：当发生冲突时，在哈希表中寻找下一个空闲位置来存储数据。
- **链地址法**：在每个哈希表位置维护一个链表，将冲突的元素都插入到这个链表中。

## C语言实现哈希表的使用方法
### 定义哈希表结构
首先，我们需要定义哈希表的结构。假设我们使用链地址法处理冲突，哈希表的结构可以如下定义：

```c
#include <stdio.h>
#include <stdlib.h>

// 定义哈希表节点结构
typedef struct HashNode {
    int key;
    int value;
    struct HashNode *next;
} HashNode;

// 定义哈希表结构
typedef struct HashTable {
    HashNode **table;
    int size;
} HashTable;
```

### 实现哈希函数
这里我们使用一个简单的哈希函数，对于整数键，直接取模运算：

```c
// 哈希函数
int hashFunction(int key, int size) {
    return key % size;
}
```

### 处理冲突
使用链地址法处理冲突，插入节点到链表中：

```c
// 插入键值对到哈希表
void insert(HashTable *hashTable, int key, int value) {
    int index = hashFunction(key, hashTable->size);
    HashNode *node = hashTable->table[index];
    while (node) {
        if (node->key == key) {
            node->value = value;
            return;
        }
        node = node->next;
    }
    HashNode *newNode = (HashNode *)malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->value = value;
    newNode->next = hashTable->table[index];
    hashTable->table[index] = newNode;
}
```

### 插入、查找和删除操作
查找和删除操作也基于链地址法实现：

```c
// 查找键对应的值
int search(HashTable *hashTable, int key) {
    int index = hashFunction(key, hashTable->size);
    HashNode *node = hashTable->table[index];
    while (node) {
        if (node->key == key) {
            return node->value;
        }
        node = node->next;
    }
    return -1; // 键不存在返回 -1
}

// 删除键值对
void delete(HashTable *hashTable, int key) {
    int index = hashFunction(key, hashTable->size);
    HashNode *prev = NULL;
    HashNode *node = hashTable->table[index];
    while (node) {
        if (node->key == key) {
            if (prev) {
                prev->next = node->next;
            } else {
                hashTable->table[index] = node->next;
            }
            free(node);
            return;
        }
        prev = node;
        node = node->next;
    }
}
```

## 常见实践
### 简单的整数哈希表实现
```c
int main() {
    HashTable hashTable;
    hashTable.size = 10;
    hashTable.table = (HashNode **)malloc(hashTable.size * sizeof(HashNode *));
    for (int i = 0; i < hashTable.size; i++) {
        hashTable.table[i] = NULL;
    }

    insert(&hashTable, 1, 100);
    insert(&hashTable, 2, 200);
    printf("查找键 1 的值: %d\n", search(&hashTable, 1));
    delete(&hashTable, 1);
    printf("查找键 1 的值: %d\n", search(&hashTable, 1));

    // 释放哈希表内存
    for (int i = 0; i < hashTable.size; i++) {
        HashNode *node = hashTable.table[i];
        while (node) {
            HashNode *temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(hashTable.table);

    return 0;
}
```

### 字符串哈希表实现
对于字符串，我们需要一个更复杂的哈希函数。下面是一个简单的字符串哈希函数示例：

```c
// 字符串哈希函数
int stringHashFunction(const char *str, int size) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c; // hash * 33 + c
    }
    return hash % size;
}

// 字符串哈希表节点结构
typedef struct StringHashNode {
    char key[100];
    int value;
    struct StringHashNode *next;
} StringHashNode;

// 字符串哈希表结构
typedef struct StringHashTable {
    StringHashNode **table;
    int size;
} StringHashTable;

// 插入字符串键值对
void stringInsert(StringHashTable *hashTable, const char *key, int value) {
    int index = stringHashFunction(key, hashTable->size);
    StringHashNode *node = hashTable->table[index];
    while (node) {
        if (strcmp(node->key, key) == 0) {
            node->value = value;
            return;
        }
        node = node->next;
    }
    StringHashNode *newNode = (StringHashNode *)malloc(sizeof(StringHashNode));
    strcpy(newNode->key, key);
    newNode->value = value;
    newNode->next = hashTable->table[index];
    hashTable->table[index] = newNode;
}

// 查找字符串键对应的值
int stringSearch(StringHashTable *hashTable, const char *key) {
    int index = stringHashFunction(key, hashTable->size);
    StringHashNode *node = hashTable->table[index];
    while (node) {
        if (strcmp(node->key, key) == 0) {
            return node->value;
        }
        node = node->next;
    }
    return -1;
}

// 删除字符串键值对
void stringDelete(StringHashTable *hashTable, const char *key) {
    int index = stringHashFunction(key, hashTable->size);
    StringHashNode *prev = NULL;
    StringHashNode *node = hashTable->table[index];
    while (node) {
        if (strcmp(node->key, key) == 0) {
            if (prev) {
                prev->next = node->next;
            } else {
                hashTable->table[index] = node->next;
            }
            free(node);
            return;
        }
        prev = node;
        node = node->next;
    }
}

int main() {
    StringHashTable hashTable;
    hashTable.size = 10;
    hashTable.table = (StringHashNode **)malloc(hashTable.size * sizeof(StringHashNode *));
    for (int i = 0; i < hashTable.size; i++) {
        hashTable.table[i] = NULL;
    }

    stringInsert(&hashTable, "apple", 10);
    stringInsert(&hashTable, "banana", 20);
    printf("查找键 apple 的值: %d\n", stringSearch(&hashTable, "apple"));
    stringDelete(&hashTable, "apple");
    printf("查找键 apple 的值: %d\n", stringSearch(&hashTable, "apple"));

    // 释放字符串哈希表内存
    for (int i = 0; i < hashTable.size; i++) {
        StringHashNode *node = hashTable->table[i];
        while (node) {
            StringHashNode *temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(hashTable.table);

    return 0;
}
```

## 最佳实践
### 选择合适的哈希函数
对于不同类型的数据，需要选择合适的哈希函数。对于整数，可以使用简单的取模运算，但对于字符串或复杂数据结构，需要更复杂的哈希算法，如FNV哈希、MurmurHash等，以保证哈希值的均匀分布。

### 优化冲突处理
链地址法在冲突较多时性能会下降，此时可以考虑开放地址法或其他优化策略。例如，二次探测法可以减少聚集现象，提高查找效率。

### 动态调整哈希表大小
当哈希表的负载因子（元素个数与哈希表大小的比值）超过一定阈值（通常为0.75）时，应该动态扩大哈希表的大小，重新计算所有元素的哈希值并重新插入，以保持哈希表的性能。

## 小结
本文详细介绍了C语言实现哈希表的各个方面，从基础概念到实际代码实现，以及常见实践和最佳实践。通过掌握哈希表的实现和优化，读者可以在实际编程中利用这一强大的数据结构提高程序的性能和效率。希望本文能帮助读者深入理解并高效使用C语言实现哈希表。

以上就是关于C语言实现哈希表的完整技术博客内容，希望对您有所帮助。
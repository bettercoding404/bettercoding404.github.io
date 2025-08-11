---
layout: post
date: 2024-12-09
title: "利用C语言实现堆排序算法"
description:  "堆排序（Heap Sort）是一种基于比较的排序算法，它利用了堆这种数据结构的性质。本文将深入探讨如何在C语言中实现堆排序。"
tags: [C]
cascade:
  - type: docs
---

堆排序（Heap Sort）是一种基于比较的排序算法，它利用了堆这种数据结构的性质。它具有良好的时间复杂度表现，平均和最坏情况下的时间复杂度均为O(n log n)。本文将深入探讨如何在C语言中实现堆排序。

#### 什么是堆？

堆是一种特殊的完全二叉树。根据堆的性质，它可以分为两种：

- **最大堆（Max Heap）**：任何一个非叶子节点的值都不大于其父节点。
- **最小堆（Min Heap）**：任何一个非叶子节点的值都不小于其父节点。

在堆排序中，我们通常使用最大堆来帮助我们进行升序排序。

#### 堆排序算法的步骤

1. **构建最大堆**：将数组变成一个最大堆，这是因为我们需要不断从堆顶（也就是当前数组的最大值）取出元素以实现排序。
   
2. **排序**：
   - 将堆的根节点（最大值）与堆的最后一个元素进行交换。
   - 减少堆的大小，调用 `heapify` 方法调整堆结构，以满足最大堆性质。
   - 重复上述步骤，直到堆的大小为1。

#### C语言实现

以下是使用C语言实现的堆排序算法：

```c
#include <stdio.h>

// 函数声明
void heapify(int arr[], int n, int i);
void heapSort(int arr[], int n);
void swap(int* a, int* b);

// 主函数
int main() {
    int arr[] = {12, 11, 13, 5, 6, 7};
    int n = sizeof(arr) / sizeof(arr[0]);

    heapSort(arr, n);

    printf("排序后的数组是: \n");
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    printf("\n");

    return 0;
}

// 堆化函数，将以i为根的子树调整为最大堆
void heapify(int arr[], int n, int i) {
    int largest = i;  // 初始化最大值为根节点
    int left = 2 * i + 1;  // 左子节点
    int right = 2 * i + 2; // 右子节点

    // 如果左子节点存在，且大于根节点
    if (left < n && arr[left] > arr[largest])
        largest = left;

    // 如果右子节点存在，且大于当前最大值
    if (right < n && arr[right] > arr[largest])
        largest = right;

    // 如果最大值不是根节点，则交换
    if (largest != i) {
        swap(&arr[i], &arr[largest]);

        // 递归调用，调整被影响的子树
        heapify(arr, n, largest);
    }
}

// 堆排序主函数
void heapSort(int arr[], int n) {
    // 构建最大堆
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);

    // 从堆中提取元素
    for (int i = n - 1; i > 0; i--) {
        // 当前根（最大值）移到数组末尾
        swap(&arr[0], &arr[i]);

        // 调整新的根节点位置
        heapify(arr, i, 0);
    }
}

// 辅助函数：交换两个整数
void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}
```

#### 代码解析

- `heapify` 函数：维护堆的性质。对于给定的根节点 `i`，检测其左右子节点，找到其中最大者，并与根节点交换。如果根节点不是最大，则继续对交换后的位置执行 `heapify`。
  
- `heapSort` 函数：首先将无序数组构造成一个最大堆。然后在排序中，逐步将根节点（最大元素）交换到数组末尾，递归地缩小堆的范围，并进行堆化。

- `swap` 函数：用于交换数组中两个元素的位置。

#### 总结

堆排序具有稳定的时间复杂度，不需要额外的存储空间（原地排序），适合需要在时间和空间上都有良好表现的排序任务。尽管不如快速排序在平均情况下表现出色，堆排序在数据序列接近有序时仍可避免快速排序的最坏情况。通过本文代码实例，读者应该掌握了如何在C语言中实现堆排序的基本步骤和技巧。
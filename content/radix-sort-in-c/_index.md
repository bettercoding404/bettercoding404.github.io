---
layout: post
date: 2024-12-09
title: "深入理解C语言中的基数排序算法"
description:  "基数排序是一种非比较型整数排序算法，适用于排序大量整数数据集。本文将深入探讨基数排序的基本原理，并提供一个在C语言中的实现示例。"
tags: [C]
cascade:
  - type: docs
---

基数排序（Radix Sort）是一种非比较型整数排序算法，其原理是通过将待排序数按照位进行分配和收集，从而实现排序。与其他排序算法不同，基数排序特别适用于排序大量整数数据集，尤其是当整数的范围相差较大时，是一种非常高效的排序方法。

## 基数排序的基本原理

基数排序的基本思想是将整数按位进行排序，通常从最低有效位开始，一直到最高有效位。基数排序的核心步骤包括：

1. **按位分配**：根据每一位的值，将数字分配到不同的桶（bucket）中。
2. **收集**：按各个桶的顺序，将数字重新收集起来。
3. **重复**：对每一个位重复以上两步操作，直到处理完所有位。

基数排序最常用于处理整数，但也可以经过扩展处理字符串等其他数据类型。

## 示例代码

在这里，我们将基数排序实现为一个C语言的函数。为了简单起见，我们以排序整数数组为例。

```c
#include <stdio.h>
#include <stdlib.h>

#define BASE 10

// 获取数组中的最大值
int getMax(int arr[], int n) {
    int max = arr[0];
    for (int i = 1; i < n; i++)
        if (arr[i] > max)
            max = arr[i];
    return max;
}

// 基于特定位进行计数排序
void countSort(int arr[], int n, int exp) {
    int* output = (int*)malloc(n * sizeof(int));
    int count[BASE] = {0};

    // 计算计数
    for (int i = 0; i < n; i++)
        count[(arr[i] / exp) % BASE]++;

    // 改变 count[i]，使其包含该位数的实际位置
    for (int i = 1; i < BASE; i++)
        count[i] += count[i - 1];

    // 构建输出数组
    for (int i = n - 1; i >= 0; i--) {
        output[count[(arr[i] / exp) % BASE] - 1] = arr[i];
        count[(arr[i] / exp) % BASE]--;
    }

    // 复制输出数组到 arr
    for (int i = 0; i < n; i++)
        arr[i] = output[i];

    free(output);
}

// 主函数，执行基数排序
void radixSort(int arr[], int n) {
    int max = getMax(arr, n);

    // 对每个位使用计数排序
    for (int exp = 1; max / exp > 0; exp *= BASE)
        countSort(arr, n, exp);
}

// 打印数组
void printArray(int arr[], int n) {
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

int main() {
    int arr[] = {170, 45, 75, 90, 802, 24, 2, 66};
    int n = sizeof(arr) / sizeof(arr[0]);

    printf("排序前: ");
    printArray(arr, n);
    
    radixSort(arr, n);

    printf("排序后: ");
    printArray(arr, n);

    return 0;
}
```

## 注意事项与优化

1. **适用场景**：基数排序对较短的整数和字符串非常有效，但对长整数或字符集较大的数据，效率可能不如其他排序算法。
2. **空间复杂度**：基数排序需要额外的空间存储临时输出数组和计数数组，因此比原地排序算法例如插入排序、西归快速排序等稍微占用更多内存。
3. **稳定性**：基数排序是稳定排序，使得相同的元素保持原有的相对顺序。

## 总结

基数排序是一种巧妙且高效的排序算法，特别适合处理非负整数集。在特定场景下，它的表现能够优于传统的比较型排序算法。然而，在应用之前需要考虑数据的特性和系统的内存限制。希望这篇博客能够帮助你更好地理解和实现基数排序。
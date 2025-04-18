---
layout: post
date: 2024-12-09
title: 使用C语言实现冒泡排序
description: 冒泡排序（Bubble Sort）是一种简单易懂的排序算法，常用于教学和小型数据集的排序。本文将深入探讨冒泡排序的原理及其在C语言中的实现。
tags: [C]
---

冒泡排序（Bubble Sort）是一种简单易懂的排序算法。尽管它的效率不是最高，但由于其实现简单，常用于教学和小型数据集的排序。在这篇博客中，我们将深入探讨冒泡排序的原理及其在C语言中的实现。

## 冒泡排序简介

冒泡排序的基本思想是重复地走访要排序的数列，一次比较两个元素，如果它们的顺序错误就交换它们。这个过程会持续反复直到没有再需要交换的元素，这时候数组就是有序的。每一轮比较中，最大的元素会“冒泡”到数组的末尾。

### 算法步骤

1. 从头开始遍历数组。
2. 比较相邻的两个元素，如果前者大于后者，则交换它们。
3. 重复步骤2，遍历完整个数组后，最大的元素已经放到最后。
4. 忽略已排好的元素，对剩余未排序的元素重复步骤1-3。
5. 持续以上步骤直到没有需要再进行交换的元素。

## C语言实现

下面是一个使用C语言编写的典型冒泡排序函数：

```c
#include <stdio.h>

void bubbleSort(int array[], int n) {
    for (int i = 0; i < n - 1; i++) {
        // 提高冒泡排序效率的标志位
        int swapped = 0;
        
        // 遍历数组，除去已排序完成的部分
        for (int j = 0; j < n - i - 1; j++) {
            if (array[j] > array[j + 1]) {
                // 交换元素
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
                
                // 发生交换，标志位置1
                swapped = 1;
            }
        }
        
        // 如果在某一轮没有发生任何交换，说明数组已经排序完成
        if (swapped == 0) {
            break;
        }
    }
}

void printArray(int array[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}

int main() {
    int data[] = {64, 34, 25, 12, 22, 11, 90};
    int size = sizeof(data) / sizeof(data[0]);
    
    printf("原始数组: \n");
    printArray(data, size);
    
    bubbleSort(data, size);
    
    printf("排序后的数组: \n");
    printArray(data, size);
    
    return 0;
}
```

### 代码解析

- **函数 `bubbleSort`**：实现冒泡排序算法。外层循环用于制定总共需要执行多少轮，内层循环用于执行元素之间的比较与可能的交换。
- **交换机制**：当 `array[j] > array[j + 1]` 时，两个元素交换。这个操作将较大的元素逐步移到后面。
- **优化**：添加一个 `swapped` 标志位，如果在某一轮遍历中没有发生任何交换，排序过程可以提前结束。
- **辅助函数 `printArray`**：用于打印数组内容，方便查看排序结果。

## 性能分析

- **时间复杂度**: 最差和平均情况下是O(n²)，当数组已经排序的情况下，可以通过标志位优化到O(n)。
- **空间复杂度**: O(1)，因为它是原地排序。

冒泡排序由于简单直接的算法过程，非常适合初学者学习理解排序的基本原理。然而，对于较大的数据集，冒泡排序的性能较差，实际应用中更常用的是其他效率更高的排序算法，如快速排序、归并排序等。

通过这篇博客，相信你已经理解了如何在C语言中实现冒泡排序以及它的工作原理。希望这能帮助到你的学习过程！
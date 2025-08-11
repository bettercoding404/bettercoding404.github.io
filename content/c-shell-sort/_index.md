---
title:  C语言希尔排序：原理、实践与优化
description:  简介希尔排序（Shell Sort）是插入排序的一种改进版本，也被称为“缩小增量排序”（Diminishing Increment Sort）。它由 Donald Shell 于 1959 年发明，旨在克服传统插入排序在处理大规模数据时效率低下的问题。希尔排序通过将原始数据分成多个子序列，每个子序列的元素间隔较大，然后逐渐减小间隔，最终在间隔为 1 时进行常规的插入排序。这种方法使得数据在早期阶段就能大致有序，从而减少了最终插入排序时的比较和移动次数，大大提高了排序效率。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
希尔排序（Shell Sort）是插入排序的一种改进版本，也被称为“缩小增量排序”（Diminishing Increment Sort）。它由 Donald Shell 于 1959 年发明，旨在克服传统插入排序在处理大规模数据时效率低下的问题。希尔排序通过将原始数据分成多个子序列，每个子序列的元素间隔较大，然后逐渐减小间隔，最终在间隔为 1 时进行常规的插入排序。这种方法使得数据在早期阶段就能大致有序，从而减少了最终插入排序时的比较和移动次数，大大提高了排序效率。

## 目录
1. **希尔排序基础概念**
    - 什么是希尔排序
    - 基本原理
    - 与插入排序的关系
2. **C语言中希尔排序的使用方法**
    - 函数定义与参数
    - 核心代码实现
    - 示例代码及解释
3. **希尔排序的常见实践**
    - 对不同类型数据排序
    - 处理大规模数据
    - 与其他排序算法对比
4. **希尔排序的最佳实践**
    - 选择合适的增量序列
    - 优化代码性能
    - 错误处理与边界条件
5. **小结**

## 希尔排序基础概念
### 什么是希尔排序
希尔排序是一种基于插入排序改进的排序算法。它打破了插入排序每次只比较相邻元素的局限，通过特定的增量序列，将原始数据分成多个子序列进行排序。随着增量逐渐减小，数据的有序程度逐渐提高，最终在增量为 1 时进行普通的插入排序，此时数据已经基本有序，大大减少了比较和移动的次数。

### 基本原理
希尔排序的核心在于选择合适的增量序列。增量序列是一系列递减的整数，例如初始增量可以选择数组长度的一半，然后每次减半，直到增量为 1。对于每个增量值 `gap`，将数组分成 `gap` 个子序列，每个子序列中的元素间隔为 `gap`。对每个子序列分别进行插入排序，这样在早期阶段就能使数据大致有序。随着 `gap` 的减小，数据的有序程度逐渐提高，最终在 `gap` 为 1 时，数组已经接近有序，此时进行普通的插入排序效率更高。

### 与插入排序的关系
希尔排序本质上是插入排序的扩展。插入排序在处理基本有序的数据时效率较高，而希尔排序通过增量序列将数据逐步调整为基本有序，从而利用了插入排序的这一特性。在增量为 1 时，希尔排序就退化为普通的插入排序。

## C语言中希尔排序的使用方法
### 函数定义与参数
```c
void shellSort(int arr[], int n) {
    // 这里 arr 是待排序的数组，n 是数组的长度
}
```
### 核心代码实现
```c
void shellSort(int arr[], int n) {
    int gap, i, j, temp;
    for (gap = n / 2; gap > 0; gap /= 2) {
        for (i = gap; i < n; i++) {
            temp = arr[i];
            j = i;
            while (j >= gap && arr[j - gap] > temp) {
                arr[j] = arr[j - gap];
                j = j - gap;
            }
            arr[j] = temp;
        }
    }
}
```
### 示例代码及解释
```c
#include <stdio.h>

// 希尔排序函数
void shellSort(int arr[], int n) {
    int gap, i, j, temp;
    for (gap = n / 2; gap > 0; gap /= 2) {
        for (i = gap; i < n; i++) {
            temp = arr[i];
            j = i;
            while (j >= gap && arr[j - gap] > temp) {
                arr[j] = arr[j - gap];
                j = j - gap;
            }
            arr[j] = temp;
        }
    }
}

// 打印数组函数
void printArray(int arr[], int n) {
    int i;
    for (i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90};
    int n = sizeof(arr) / sizeof(arr[0]);

    printf("Original array: ");
    printArray(arr, n);

    shellSort(arr, n);

    printf("Sorted array: ");
    printArray(arr, n);

    return 0;
}
```
在这段代码中：
1. `shellSort` 函数实现了希尔排序的核心逻辑。外层 `for` 循环控制增量 `gap` 的变化，每次将 `gap` 减半。
2. 内层 `for` 循环对每个子序列进行插入排序。在每个子序列中，通过 `while` 循环将当前元素插入到合适的位置。
3. `printArray` 函数用于打印数组元素，方便查看排序前后的数组状态。
4. 在 `main` 函数中，定义了一个测试数组并调用 `shellSort` 函数进行排序，最后打印排序后的数组。

## 希尔排序的常见实践
### 对不同类型数据排序
希尔排序不仅适用于整数数组，也可以用于其他数据类型，如浮点数、结构体等。只需修改比较函数中的比较逻辑即可。例如，对于浮点数数组：
```c
#include <stdio.h>

void shellSort(float arr[], int n) {
    int gap, i, j;
    float temp;
    for (gap = n / 2; gap > 0; gap /= 2) {
        for (i = gap; i < n; i++) {
            temp = arr[i];
            j = i;
            while (j >= gap && arr[j - gap] > temp) {
                arr[j] = arr[j - gap];
                j = j - gap;
            }
            arr[j] = temp;
        }
    }
}

void printArray(float arr[], int n) {
    int i;
    for (i = 0; i < n; i++) {
        printf("%.2f ", arr[i]);
    }
    printf("\n");
}

int main() {
    float arr[] = {64.5, 34.2, 25.7, 12.1, 22.9, 11.3, 90.4};
    int n = sizeof(arr) / sizeof(arr[0]);

    printf("Original array: ");
    printArray(arr, n);

    shellSort(arr, n);

    printf("Sorted array: ");
    printArray(arr, n);

    return 0;
}
```
### 处理大规模数据
希尔排序在处理大规模数据时表现优于简单的插入排序。但对于非常大规模的数据，可能需要进一步优化增量序列以提高性能。例如，可以使用 Hibbard 增量序列（1, 3, 7, 15, 31,..., 2^k - 1），相比简单的减半增量序列，Hibbard 增量序列能使数据更快地趋于有序。
```c
#include <stdio.h>

void shellSort(int arr[], int n) {
    int gap, i, j, temp;
    for (gap = 1; gap < n / 3; gap = gap * 3 + 1); // 生成 Hibbard 增量序列
    while (gap > 0) {
        for (i = gap; i < n; i++) {
            temp = arr[i];
            j = i;
            while (j >= gap && arr[j - gap] > temp) {
                arr[j] = arr[j - gap];
                j = j - gap;
            }
            arr[j] = temp;
        }
        gap = (gap - 1) / 3; // 计算下一个 Hibbard 增量
    }
}

void printArray(int arr[], int n) {
    int i;
    for (i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90};
    int n = sizeof(arr) / sizeof(arr[0]);

    printf("Original array: ");
    printArray(arr, n);

    shellSort(arr, n);

    printf("Sorted array: ");
    printArray(arr, n);

    return 0;
}
```
### 与其他排序算法对比
与冒泡排序相比，希尔排序在处理大规模数据时效率更高，因为冒泡排序每次只交换相邻元素，而希尔排序通过较大的增量可以快速移动元素到大致正确的位置。与快速排序相比，希尔排序的平均时间复杂度较高，但它的优点是实现简单，不需要额外的递归调用或复杂的分区操作，在某些情况下（如数据量较小或对稳定性有要求时）也有一定的应用价值。

## 希尔排序的最佳实践
### 选择合适的增量序列
除了前面提到的简单减半增量序列和 Hibbard 增量序列外，还有其他一些更复杂但性能更好的增量序列，如 Sedgewick 增量序列（1, 5, 19, 41, 109, 209, 505, 929, 2161, 3905,...）。使用 Sedgewick 增量序列可以使希尔排序的时间复杂度接近 O(n^(4/3))，相比简单增量序列有显著提升。
```c
#include <stdio.h>

// Sedgewick 增量序列数组
int sedgewick[] = {1, 5, 19, 41, 109, 209, 505, 929, 2161, 3905, 8929, 16001, 36289, 64769, 146305, 260609,
                    587521, 1045505, 2354689, 4188161, 9427969, 16764929, 37730305, 67084289, 150958081, 268386305,
                    603906049, 1073643521};

void shellSort(int arr[], int n) {
    int i, j, k, temp;
    for (k = 20; k >= 0; k--) { // Sedgewick 增量序列有 21 个元素
        int gap = sedgewick[k];
        if (gap < n) {
            for (i = gap; i < n; i++) {
                temp = arr[i];
                j = i;
                while (j >= gap && arr[j - gap] > temp) {
                    arr[j] = arr[j - gap];
                    j = j - gap;
                }
                arr[j] = temp;
            }
        }
    }
}

void printArray(int arr[], int n) {
    int i;
    for (i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90};
    int n = sizeof(arr) / sizeof(arr[0]);

    printf("Original array: ");
    printArray(arr, n);

    shellSort(arr, n);

    printf("Sorted array: ");
    printArray(arr, n);

    return 0;
}
```
### 优化代码性能
可以通过减少交换操作来进一步优化希尔排序的性能。例如，使用“移位”操作代替实际的交换，这样可以减少一些不必要的内存访问。
```c
void shellSort(int arr[], int n) {
    int gap, i, j;
    for (gap = n / 2; gap > 0; gap /= 2) {
        for (i = gap; i < n; i++) {
            int temp = arr[i];
            for (j = i; j >= gap && arr[j - gap] > temp; j -= gap) {
                arr[j] = arr[j - gap];
            }
            arr[j] = temp;
        }
    }
}
```
### 错误处理与边界条件
在实现希尔排序时，需要考虑一些边界条件，如输入数组为空或只有一个元素的情况。可以在函数开始时添加简单的检查：
```c
void shellSort(int arr[], int n) {
    if (n <= 1) {
        return;
    }
    // 希尔排序核心代码
}
```

## 小结
希尔排序作为插入排序的改进版本，在排序算法中占有重要地位。通过合理选择增量序列，希尔排序能够在处理大规模数据时显著提高排序效率。在实际应用中，根据数据特点和性能要求选择合适的增量序列和优化方法是关键。希望通过本文的介绍，读者能够深入理解希尔排序的原理，并在实际编程中灵活运用。
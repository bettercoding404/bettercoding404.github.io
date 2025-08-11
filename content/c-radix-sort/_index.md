---
title:  C语言基数排序：原理、实现与优化
description:  简介基数排序（Radix Sort）是一种非比较排序算法，它的独特之处在于不通过元素间的比较来确定顺序，而是利用数字的每一位来进行排序操作。这种排序算法在处理整数序列，特别是位数固定的整数序列时，展现出很高的效率。在C语言中，实现基数排序可以让我们在合适的场景下快速地对数据进行排序，本文将详细介绍其概念、使用方法、常见实践及最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
基数排序（Radix Sort）是一种非比较排序算法，它的独特之处在于不通过元素间的比较来确定顺序，而是利用数字的每一位来进行排序操作。这种排序算法在处理整数序列，特别是位数固定的整数序列时，展现出很高的效率。在C语言中，实现基数排序可以让我们在合适的场景下快速地对数据进行排序，本文将详细介绍其概念、使用方法、常见实践及最佳实践。

## 目录
1. 基数排序基础概念
2. C语言中基数排序的使用方法
3. 常见实践案例
4. 最佳实践建议
5. 小结

## 基数排序基础概念
基数排序基于“分配”和“收集”的过程。它按照数字的每一位（个位、十位、百位等）依次进行排序。具体来说，它从最低位开始，将所有元素按照该位的值分配到不同的“桶”中，然后再按照桶的顺序依次收集元素，这样经过一次分配和收集后，序列就会在该位上有序。接着对次低位重复这个过程，直到处理完所有的位。

例如，对于序列 `[329, 457, 657, 839, 436, 720, 355]`，首先按个位进行分配：
- 个位为0的桶：`[720]`
- 个位为5的桶：`[355]`
- 个位为6的桶：`[436]`
- 个位为7的桶：`[457, 657]`
- 个位为9的桶：`[329, 839]`

然后按桶的顺序收集：`[720, 355, 436, 457, 657, 329, 839]`。接着对十位、百位重复上述过程，最终得到有序序列。

## C语言中基数排序的使用方法
下面是一个简单的C语言实现基数排序的代码示例：

```c
#include <stdio.h>
#include <stdlib.h>

// 获取最大数
int getMax(int arr[], int n) {
    int max = arr[0];
    for (int i = 1; i < n; i++)
        if (arr[i] > max)
            max = arr[i];
    return max;
}

// 计数排序的辅助函数，用于按指定数位排序
void countingSort(int arr[], int n, int exp) {
    int *output = (int *)malloc(n * sizeof(int));
    int i, count[10] = {0};

    // 统计每个数位出现的次数
    for (i = 0; i < n; i++)
        count[(arr[i] / exp) % 10]++;

    // 计算每个数位的最终位置
    for (i = 1; i < 10; i++)
        count[i] += count[i - 1];

    // 构建输出数组
    for (i = n - 1; i >= 0; i--) {
        output[count[(arr[i] / exp) % 10] - 1] = arr[i];
        count[(arr[i] / exp) % 10]--;
    }

    // 复制回原数组
    for (i = 0; i < n; i++)
        arr[i] = output[i];

    free(output);
}

// 基数排序主函数
void radixSort(int arr[], int n) {
    int m = getMax(arr, n);

    // 对每一位进行计数排序
    for (int exp = 1; m / exp > 0; exp *= 10)
        countingSort(arr, n, exp);
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

    printf("Original array: ");
    printArray(arr, n);

    radixSort(arr, n);

    printf("Sorted array: ");
    printArray(arr, n);

    return 0;
}
```

### 代码说明
1. `getMax` 函数用于找到数组中的最大值，这是为了确定需要处理的最大数位。
2. `countingSort` 函数是基数排序中的核心辅助函数，它根据指定的数位 `exp` 对数组进行排序。
3. `radixSort` 函数驱动整个基数排序过程，通过循环调用 `countingSort` 对每一位进行排序。
4. `printArray` 函数用于打印数组内容，方便调试和查看排序结果。

## 常见实践案例
### 对学生成绩进行排序
假设有一个学生成绩数组，每个成绩都是三位数（000 - 999），可以使用基数排序快速对成绩进行排序。

```c
#include <stdio.h>
#include <stdlib.h>

// 前面的getMax、countingSort、radixSort函数定义省略

int main() {
    int scores[] = {345, 231, 567, 123, 789, 456};
    int n = sizeof(scores) / sizeof(scores[0]);

    printf("Original scores: ");
    for (int i = 0; i < n; i++)
        printf("%d ", scores[i]);
    printf("\n");

    radixSort(scores, n);

    printf("Sorted scores: ");
    for (int i = 0; i < n; i++)
        printf("%d ", scores[i]);
    printf("\n");

    return 0;
}
```

### 对电话号码进行排序
如果有一组电话号码，每个号码都是固定长度（例如11位），也可以使用基数排序。

```c
#include <stdio.h>
#include <stdlib.h>

// 假设电话号码是11位数字的整数表示
void radixSortForPhone(long long arr[], int n) {
    long long m = 0;
    for (int i = 0; i < n; i++)
        if (arr[i] > m)
            m = arr[i];

    for (long long exp = 1; m / exp > 0; exp *= 10)
        // 这里需要修改countingSort函数以适应long long类型
        // 例如修改数组类型和计算方式
        countingSortForPhone(arr, n, exp); 
}

// 打印电话号码数组
void printPhoneArray(long long arr[], int n) {
    for (int i = 0; i < n; i++)
        printf("%lld ", arr[i]);
    printf("\n");
}

int main() {
    long long phones[] = {13800138000, 13900139000, 13600136000};
    int n = sizeof(phones) / sizeof(phones[0]);

    printf("Original phones: ");
    printPhoneArray(phones, n);

    radixSortForPhone(phones, n);

    printf("Sorted phones: ");
    printPhoneArray(phones, n);

    return 0;
}
```

## 最佳实践建议
1. **数据类型适配**：确保基数排序的实现能够适应不同的数据类型和范围。如果处理大整数或负数，需要对算法进行适当的调整。
2. **空间优化**：在使用辅助数组时，尽量减少不必要的内存分配和释放。可以考虑复用已有的内存空间。
3. **稳定性维护**：基数排序是稳定排序算法，在实现过程中要注意保持其稳定性，以满足特定的应用需求。
4. **性能测试**：在实际应用中，对基数排序进行性能测试，与其他排序算法（如快速排序、归并排序）进行比较，确保在特定场景下选择最优的排序算法。

## 小结
基数排序是一种高效的非比较排序算法，在C语言中实现基数排序可以为处理整数序列提供快速的排序解决方案。通过理解其基础概念、掌握使用方法、进行常见实践并遵循最佳实践建议，开发者能够在合适的场景下灵活运用基数排序，提高程序的性能和效率。希望本文能帮助读者深入理解并高效使用C语言基数排序。
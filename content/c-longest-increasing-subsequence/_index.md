---
title:  C语言最长递增子序列：概念、方法与实践
description:  简介在算法和数据结构的领域中，最长递增子序列（Longest Increasing Subsequence，LIS）是一个经典的问题。它在许多实际应用中都有出现，例如生物信息学中的序列比对、金融数据的趋势分析等。本文将深入探讨如何使用C语言来解决最长递增子序列问题，包括基础概念、使用方法、常见实践以及最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在算法和数据结构的领域中，最长递增子序列（Longest Increasing Subsequence，LIS）是一个经典的问题。它在许多实际应用中都有出现，例如生物信息学中的序列比对、金融数据的趋势分析等。本文将深入探讨如何使用C语言来解决最长递增子序列问题，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 最长递增子序列基础概念
2. C语言实现最长递增子序列的方法
3. 常见实践案例
4. 最佳实践与优化
5. 小结

## 最长递增子序列基础概念
给定一个整数序列，最长递增子序列是该序列中一个长度最长的子序列，满足这个子序列中的元素是严格递增的。例如，对于序列 `[10, 9, 2, 5, 3, 7, 101, 18]`，它的一个最长递增子序列是 `[2, 3, 7, 18]`，长度为4。

需要注意的是，子序列不一定是连续的，只需要保持元素的顺序与原序列一致即可。

## C语言实现最长递增子序列的方法

### 动态规划法
动态规划是解决最长递增子序列问题的常用方法。基本思路是创建一个数组 `dp`，其中 `dp[i]` 表示以第 `i` 个元素结尾的最长递增子序列的长度。状态转移方程如下：

\[ dp[i] = \max_{0 \leq j < i, a[j] < a[i]}(dp[j]) + 1 \]

以下是使用动态规划法实现最长递增子序列的C语言代码：

```c
#include <stdio.h>

// 函数用于计算最长递增子序列的长度
int lengthOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    
    int dp[numsSize];
    int maxLen = 1;

    // 初始化dp数组
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
    }

    // 动态规划计算dp数组
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j] && dp[i] < dp[j] + 1) {
                dp[i] = dp[j] + 1;
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
        }
    }

    return maxLen;
}

int main() {
    int nums[] = {10, 9, 2, 5, 3, 7, 101, 18};
    int numsSize = sizeof(nums) / sizeof(nums[0]);

    int lisLength = lengthOfLIS(nums, numsSize);
    printf("最长递增子序列的长度是: %d\n", lisLength);

    return 0;
}
```

### 二分查找优化动态规划法
上述动态规划方法的时间复杂度为 \( O(n^2) \)，可以通过二分查找进行优化，将时间复杂度降低到 \( O(n \log n) \)。具体做法是维护一个数组 `tails`，其中 `tails[i]` 表示长度为 `i + 1` 的递增子序列的最小末尾元素。

以下是使用二分查找优化后的C语言代码：

```c
#include <stdio.h>
#include <string.h>

// 二分查找函数
int binarySearch(int* tails, int size, int target) {
    int left = 0, right = size - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (tails[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return left;
}

// 函数用于计算最长递增子序列的长度
int lengthOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    
    int tails[numsSize];
    int size = 0;

    for (int i = 0; i < numsSize; i++) {
        int pos = binarySearch(tails, size, nums[i]);
        tails[pos] = nums[i];
        if (pos == size) size++;
    }

    return size;
}

int main() {
    int nums[] = {10, 9, 2, 5, 3, 7, 101, 18};
    int numsSize = sizeof(nums) / sizeof(nums[0]);

    int lisLength = lengthOfLIS(nums, numsSize);
    printf("最长递增子序列的长度是: %d\n", lisLength);

    return 0;
}
```

## 常见实践案例

### 股票价格趋势分析
在金融领域，我们可以使用最长递增子序列算法来分析股票价格的上升趋势。例如，给定一系列股票价格，我们可以找出最长的价格上升子序列，以了解股票价格的最长连续上升阶段。

```c
#include <stdio.h>

// 函数用于计算最长递增子序列的长度
int lengthOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    
    int dp[numsSize];
    int maxLen = 1;

    // 初始化dp数组
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
    }

    // 动态规划计算dp数组
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j] && dp[i] < dp[j] + 1) {
                dp[i] = dp[j] + 1;
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
        }
    }

    return maxLen;
}

int main() {
    int stockPrices[] = {100, 110, 105, 120, 130, 125, 140};
    int pricesSize = sizeof(stockPrices) / sizeof(stockPrices[0]);

    int lisLength = lengthOfLIS(stockPrices, pricesSize);
    printf("股票价格最长上升趋势的长度是: %d\n", lisLength);

    return 0;
}
```

### 生物序列比对
在生物信息学中，最长递增子序列算法可以用于比对两个生物序列，找出它们之间的最长匹配子序列。

```c
#include <stdio.h>

// 函数用于计算最长递增子序列的长度
int lengthOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    
    int dp[numsSize];
    int maxLen = 1;

    // 初始化dp数组
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
    }

    // 动态规划计算dp数组
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j] && dp[i] < dp[j] + 1) {
                dp[i] = dp[j] + 1;
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
        }
    }

    return maxLen;
}

int main() {
    // 假设用整数表示生物序列中的元素
    int sequence1[] = {1, 3, 5, 7};
    int sequence2[] = {2, 3, 4, 6, 8};

    int len1 = sizeof(sequence1) / sizeof(sequence1[0]);
    int len2 = sizeof(sequence2) / sizeof(sequence2[0]);

    // 简单比对，将两个序列合并后计算最长递增子序列
    int combined[len1 + len2];
    for (int i = 0; i < len1; i++) {
        combined[i] = sequence1[i];
    }
    for (int i = 0; i < len2; i++) {
        combined[len1 + i] = sequence2[i];
    }

    int combinedSize = len1 + len2;
    int lisLength = lengthOfLIS(combined, combinedSize);
    printf("两个生物序列最长匹配子序列的长度是: %d\n", lisLength);

    return 0;
}
```

## 最佳实践与优化
1. **选择合适的算法**：对于小规模数据，动态规划法可以简单直观地解决问题。但对于大规模数据，二分查找优化的动态规划法能显著提高效率。
2. **空间优化**：在动态规划法中，可以使用滚动数组技巧将空间复杂度从 \( O(n) \) 降低到 \( O(1) \)，尤其是当只需要最终结果而不需要记录中间状态时。
3. **预处理数据**：如果数据有一定的规律或范围，可以对数据进行预处理，例如离散化，以减少计算量。

## 小结
本文详细介绍了最长递增子序列的基础概念，并通过C语言代码展示了动态规划法和二分查找优化的动态规划法两种实现方式。同时，通过常见实践案例展示了其在实际场景中的应用。在实际应用中，根据数据规模和问题特点选择合适的算法和优化策略，能够更高效地解决最长递增子序列问题。希望读者通过本文的学习，能够深入理解并灵活运用C语言解决最长递增子序列相关问题。
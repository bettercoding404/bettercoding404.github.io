---
title: "无需导入模块在 Python 中输出中位数"
description: "在数据分析和许多算法问题中，计算中位数是一项常见的任务。中位数是将一组数据按升序或降序排列后，位于中间位置的数值。如果数据集的元素个数是奇数，中位数就是中间的那个数；如果是偶数，中位数则是中间两个数的平均值。在 Python 中，我们通常可以使用 `statistics` 模块来轻松计算中位数，但有时候，我们可能不希望引入额外的模块，尤其是在一些对依赖要求严格或者代码简洁性要求高的场景下。本文将探讨如何在不导入任何模块的情况下在 Python 中输出中位数。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在数据分析和许多算法问题中，计算中位数是一项常见的任务。中位数是将一组数据按升序或降序排列后，位于中间位置的数值。如果数据集的元素个数是奇数，中位数就是中间的那个数；如果是偶数，中位数则是中间两个数的平均值。在 Python 中，我们通常可以使用 `statistics` 模块来轻松计算中位数，但有时候，我们可能不希望引入额外的模块，尤其是在一些对依赖要求严格或者代码简洁性要求高的场景下。本文将探讨如何在不导入任何模块的情况下在 Python 中输出中位数。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 手动排序计算中位数
    - 优化排序计算中位数
3. 常见实践
    - 处理整数列表
    - 处理浮点数列表
    - 处理混合数据类型列表
4. 最佳实践
    - 代码优化
    - 边界条件处理
5. 小结
6. 参考资料

## 基础概念
中位数的计算依赖于数据的排序。排序是将数据按照从小到大或从大到小的顺序排列的过程。在 Python 中，我们可以使用多种排序算法来实现数据的排序，例如冒泡排序、选择排序、插入排序等。一旦数据排序完成，我们就可以根据数据的长度来确定中位数。

## 使用方法

### 手动排序计算中位数
我们可以使用冒泡排序算法来手动对列表进行排序，然后计算中位数。以下是代码示例：

```python
def bubble_sort(lst):
    n = len(lst)
    for i in range(n):
        for j in range(0, n - i - 1):
            if lst[j] > lst[j + 1]:
                lst[j], lst[j + 1] = lst[j + 1], lst[j]
    return lst

def calculate_median(lst):
    sorted_lst = bubble_sort(lst)
    n = len(sorted_lst)
    if n % 2 == 1:
        return sorted_lst[n // 2]
    else:
        mid1 = sorted_lst[n // 2 - 1]
        mid2 = sorted_lst[n // 2]
        return (mid1 + mid2) / 2


# 测试代码
data = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
median = calculate_median(data)
print(f"中位数是: {median}")
```

### 优化排序计算中位数
冒泡排序的时间复杂度为 O(n^2)，对于大型数据集效率较低。我们可以使用 Python 内置的 `sorted()` 函数，它使用了高效的排序算法（如 Timsort），时间复杂度为 O(n log n)。以下是优化后的代码：

```python
def calculate_median(lst):
    sorted_lst = sorted(lst)
    n = len(sorted_lst)
    if n % 2 == 1:
        return sorted_lst[n // 2]
    else:
        mid1 = sorted_lst[n // 2 - 1]
        mid2 = sorted_lst[n // 2]
        return (mid1 + mid2) / 2


# 测试代码
data = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
median = calculate_median(data)
print(f"中位数是: {median}")
```

## 常见实践

### 处理整数列表
```python
data = [1, 2, 3, 4, 5]
median = calculate_median(data)
print(f"整数列表的中位数是: {median}")
```

### 处理浮点数列表
```python
data = [1.5, 2.5, 3.5, 4.5]
median = calculate_median(data)
print(f"浮点数列表的中位数是: {median}")
```

### 处理混合数据类型列表
```python
data = [1, 2.5, 3, 4]
median = calculate_median(data)
print(f"混合数据类型列表的中位数是: {median}")
```

## 最佳实践

### 代码优化
虽然使用 `sorted()` 函数已经是一种高效的排序方式，但如果数据量非常大，我们可以考虑使用更高级的算法，如快速选择算法，它的平均时间复杂度为 O(n)。不过，快速选择算法的实现相对复杂。

### 边界条件处理
在实际应用中，需要考虑一些边界条件，例如输入列表为空的情况。我们可以在 `calculate_median` 函数中添加如下检查：

```python
def calculate_median(lst):
    if not lst:
        raise ValueError("列表不能为空")
    sorted_lst = sorted(lst)
    n = len(sorted_lst)
    if n % 2 == 1:
        return sorted_lst[n // 2]
    else:
        mid1 = sorted_lst[n // 2 - 1]
        mid2 = sorted_lst[n // 2]
        return (mid1 + mid2) / 2


# 测试代码
try:
    data = []
    median = calculate_median(data)
    print(f"中位数是: {median}")
except ValueError as e:
    print(e)
```

## 小结
通过本文，我们学习了如何在不导入模块的情况下在 Python 中输出中位数。我们首先介绍了中位数的基础概念，然后展示了手动排序和使用内置 `sorted()` 函数两种计算中位数的方法。接着，我们探讨了常见实践场景以及最佳实践，包括代码优化和边界条件处理。希望这些知识能帮助你在实际编程中更高效地处理中位数计算问题。

## 参考资料
- 《Python 数据分析实战》
- 《算法导论》（关于排序算法的相关知识）
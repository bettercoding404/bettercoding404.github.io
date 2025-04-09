---
title: "如何在不导入模块的情况下在Python中输出中位数"
description: "在数据分析和许多算法场景中，计算中位数是一项常见的任务。中位数是将数据集按升序或降序排列后，位于中间位置的数值。如果数据集的元素个数为奇数，中位数就是中间的那个数；如果元素个数为偶数，中位数则是中间两个数的平均值。在Python中，我们可以不借助额外的模块来实现中位数的计算与输出，这篇博客将详细介绍相关方法。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在数据分析和许多算法场景中，计算中位数是一项常见的任务。中位数是将数据集按升序或降序排列后，位于中间位置的数值。如果数据集的元素个数为奇数，中位数就是中间的那个数；如果元素个数为偶数，中位数则是中间两个数的平均值。在Python中，我们可以不借助额外的模块来实现中位数的计算与输出，这篇博客将详细介绍相关方法。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
### 中位数的定义
中位数是数据集中的一个重要统计量，它反映了数据的中间水平。对于一个有序的数据集，中位数将数据集分为两部分，使得一半的数据小于或等于中位数，另一半的数据大于或等于中位数。

### 排序的重要性
在计算中位数之前，需要先对数据集进行排序。排序的目的是让数据按照从小到大或从大到小的顺序排列，这样才能准确找到中间位置的元素。在Python中，不使用模块的话，我们可以通过一些基本的排序算法来实现排序，比如冒泡排序、选择排序等。

## 使用方法
### 手动排序计算中位数
1. **冒泡排序**
冒泡排序是一种简单的排序算法，它比较相邻的元素，如果顺序错误就把它们交换过来。

```python
def bubble_sort(lst):
    n = len(lst)
    for i in range(n):
        for j in range(0, n - i - 1):
            if lst[j] > lst[j + 1]:
                lst[j], lst[j + 1] = lst[j + 1], lst[j]
    return lst


def find_median(lst):
    sorted_lst = bubble_sort(lst)
    n = len(sorted_lst)
    if n % 2 == 1:
        return sorted_lst[n // 2]
    else:
        mid1 = sorted_lst[n // 2 - 1]
        mid2 = sorted_lst[n // 2]
        return (mid1 + mid2) / 2


data = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
median = find_median(data)
print("中位数是:", median)
```

2. **选择排序**
选择排序每次从未排序序列中找到最小（大）元素，存放到排序序列的起始位置。

```python
def selection_sort(lst):
    n = len(lst)
    for i in range(n):
        min_index = i
        for j in range(i + 1, n):
            if lst[j] < lst[min_index]:
                min_index = j
        lst[i], lst[min_index] = lst[min_index], lst[i]
    return lst


def find_median_selection(lst):
    sorted_lst = selection_sort(lst)
    n = len(sorted_lst)
    if n % 2 == 1:
        return sorted_lst[n // 2]
    else:
        mid1 = sorted_lst[n // 2 - 1]
        mid2 = sorted_lst[n // 2]
        return (mid1 + mid2) / 2


data_selection = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
median_selection = find_median_selection(data_selection)
print("使用选择排序计算的中位数是:", median_selection)
```

### 直接计算法（适用于简单数据集）
如果数据集比较小且容易手动排序，可以直接计算中位数。

```python
data_simple = [1, 2, 3, 4, 5]
n_simple = len(data_simple)
if n_simple % 2 == 1:
    median_simple = data_simple[n_simple // 2]
else:
    mid1_simple = data_simple[n_simple // 2 - 1]
    mid2_simple = data_simple[n_simple // 2]
    median_simple = (mid1_simple + mid2_simple) / 2
print("简单数据集的中位数是:", median_simple)
```

## 常见实践
### 处理不同类型的数据
上述方法适用于数值型数据，如整数和浮点数。如果数据集中包含其他类型的数据，如字符串（在某些特定场景下需要根据字符串的字典序等进行排序计算中位数），则需要对排序和计算逻辑进行相应调整。

### 处理大规模数据集
对于大规模数据集，冒泡排序和选择排序的效率较低，会消耗大量的时间和内存。在这种情况下，可以考虑使用更高效的排序算法来实现中位数的计算。

## 最佳实践
### 优化排序算法
对于大规模数据集，使用快速排序或归并排序等高效排序算法来代替冒泡排序和选择排序，可以显著提高计算中位数的效率。

### 代码复用
将排序和计算中位数的逻辑封装成函数，方便在不同的场景中复用代码。

### 边界条件处理
在编写代码时，要充分考虑边界条件，如数据集为空的情况，避免程序出现异常。

```python
def find_median_optimized(lst):
    if not lst:
        raise ValueError("数据集不能为空")
    sorted_lst = sorted(lst)  # 使用Python内置的sorted函数，效率更高
    n = len(sorted_lst)
    if n % 2 == 1:
        return sorted_lst[n // 2]
    else:
        mid1 = sorted_lst[n // 2 - 1]
        mid2 = sorted_lst[n // 2]
        return (mid1 + mid2) / 2


data_optimized = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
try:
    median_optimized = find_median_optimized(data_optimized)
    print("优化后的中位数是:", median_optimized)
except ValueError as e:
    print(e)
```

## 小结
通过上述内容，我们了解了如何在不导入模块的情况下在Python中计算并输出中位数。介绍了手动排序（冒泡排序、选择排序）的方法，以及直接计算法。同时，还阐述了常见实践和最佳实践，包括处理不同类型和规模的数据集、优化算法和边界条件处理等。希望这些知识能帮助读者在实际编程中灵活运用，高效地计算中位数。

## 参考资料
- 《Python核心编程》
- 《算法导论》

以上就是关于如何在不导入模块的情况下在Python中输出中位数的全部内容。希望这篇博客对你有所帮助。如果你有任何问题或建议，欢迎在评论区留言。  
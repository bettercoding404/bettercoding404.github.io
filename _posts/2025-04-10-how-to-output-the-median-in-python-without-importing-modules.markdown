---
title: "不导入模块在 Python 中输出中位数"
description: "在数据分析和许多算法场景中，计算中位数是一项常见任务。中位数是将数据集合按升序或降序排列后，位于中间位置的值。如果数据集的元素个数为奇数，中位数就是中间的那个数；如果元素个数为偶数，中位数则是中间两个数的平均值。通常我们可以借助 Python 的一些模块（如 `statistics`）来计算中位数，但在某些情况下，我们可能不希望导入额外模块，本文将介绍如何在不导入模块的情况下在 Python 中输出中位数。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在数据分析和许多算法场景中，计算中位数是一项常见任务。中位数是将数据集合按升序或降序排列后，位于中间位置的值。如果数据集的元素个数为奇数，中位数就是中间的那个数；如果元素个数为偶数，中位数则是中间两个数的平均值。通常我们可以借助 Python 的一些模块（如 `statistics`）来计算中位数，但在某些情况下，我们可能不希望导入额外模块，本文将介绍如何在不导入模块的情况下在 Python 中输出中位数。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
中位数在统计学中具有重要意义，它能反映数据的集中趋势，相较于平均数，中位数对异常值更具抗性。例如，在一组薪资数据中，如果有个别极高的薪资（异常值），平均数可能会被拉高，而中位数则能更准确地代表大多数人的薪资水平。

## 使用方法
### 手动排序计算中位数
1. **数据个数为奇数的情况**
```python
data_odd = [3, 7, 1, 9, 5]
sorted_data_odd = sorted(data_odd)
length_odd = len(sorted_data_odd)
median_odd = sorted_data_odd[length_odd // 2]
print(median_odd)  
```
在上述代码中，首先使用 `sorted` 函数对数据进行排序，然后根据数据长度计算中间位置的索引，最后获取该位置的数据作为中位数。

2. **数据个数为偶数的情况**
```python
data_even = [3, 7, 1, 9, 5, 6]
sorted_data_even = sorted(data_even)
length_even = len(sorted_data_even)
mid_index1 = length_even // 2 - 1
mid_index2 = length_even // 2
median_even = (sorted_data_even[mid_index1] + sorted_data_even[mid_index2]) / 2
print(median_even)  
```
对于偶数个数据，计算中间两个位置的索引，获取这两个位置的数据并计算平均值作为中位数。

## 常见实践
### 从用户输入获取数据并计算中位数
```python
user_input = input("请输入一组数字，以空格分隔：")
nums = [int(num) for num in user_input.split()]
sorted_nums = sorted(nums)
length = len(sorted_nums)
if length % 2 == 1:
    median = sorted_nums[length // 2]
else:
    mid_index1 = length // 2 - 1
    mid_index2 = length // 2
    median = (sorted_nums[mid_index1] + sorted_nums[mid_index2]) / 2
print("中位数是：", median)
```
这段代码首先获取用户输入的数字，将其转换为整数列表，然后按照前面介绍的方法计算并输出中位数。

## 最佳实践
### 封装为函数
为了提高代码的可复用性，可以将计算中位数的逻辑封装为一个函数。
```python
def calculate_median(data):
    sorted_data = sorted(data)
    length = len(sorted_data)
    if length % 2 == 1:
        return sorted_data[length // 2]
    else:
        mid_index1 = length // 2 - 1
        mid_index2 = length // 2
        return (sorted_data[mid_index1] + sorted_data[mid_index2]) / 2


data_example = [12, 3, 5, 7, 19]
result = calculate_median(data_example)
print("中位数是：", result)
```
这样，在需要计算中位数的不同地方，只需调用 `calculate_median` 函数即可，提高了代码的模块化和可读性。

## 小结
通过本文，我们了解了不导入模块在 Python 中计算中位数的方法。首先明确了中位数的基础概念，然后介绍了手动排序计算中位数的使用方法，包括奇数和偶数个数数据的处理。在常见实践中，展示了如何从用户输入获取数据并计算中位数。最佳实践部分将计算逻辑封装为函数，提升了代码的可复用性。掌握这些方法，能帮助我们在不依赖外部模块的情况下灵活处理中位数计算任务。

## 参考资料
 - 《Python 数据分析实战》相关章节内容。 
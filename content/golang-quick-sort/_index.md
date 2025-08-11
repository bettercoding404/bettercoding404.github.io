---
layout: post
title:  "使用 Go 实现快速排序的几种不同版本"
description: "本文介绍了如何使用 Go 实现快速排序算法，包括递归版本、非递归版本和并发版本。并提供了完整的示例代码和参考资料。"
date:   2024-11-06 00:00:00 +0000
categories: [Golang, Concurrency]
cascade:
  - type: docs
---

快速排序（Quick Sort）是一种经典的分治算法，它被广泛用于排序任务，因为它具有较高的效率和灵活性。本文将使用 Go 语言来实现几个不同的版本的快速排序算法，从最基本的递归实现，到更高级的优化版本，以帮助开发者更好地理解和应用快速排序。

## 基本版：简单递归实现
   快速排序的基本思想是从数组中选择一个“基准值”（pivot），将数组分成两部分：一部分比基准值小，另一部分比基准值大。然后递归地对这两部分进行排序。下面是 Go 中的一个基础实现：

```go

package main

import (
	"fmt"
)

func quickSort(arr []int) []int {
	// 基础条件：如果数组的长度小于等于 1，则直接返回
	if len(arr) <= 1 {
		return arr
	}
	
	// 选择基准
	pivot := arr[0]
	left := []int{}
	right := []int{}
	
	// 分区：将小于 pivot 的放到左边，大于的放到右边
	for _, value := range arr[1:] {
		if value < pivot {
			left = append(left, value)
		} else {
			right = append(right, value)
		}
	}
	
	// 递归调用并合并结果
	return append(append(quickSort(left), pivot), quickSort(right)...)
}

func main() {
	arr := []int{9, -3, 5, 2, 6, 8, -6, 1, 3}
	fmt.Println("原始数组:", arr)
	sortedArr := quickSort(arr)
	fmt.Println("排序后数组:", sortedArr)
}

```

说明：

这里选取数组的第一个元素作为基准。
遍历剩余的元素，将比基准小的放入 left 数组，比基准大的放入 right 数组。
递归调用 quickSort，最后合并结果。
优缺点：这种简单的实现易于理解，但在效率上存在改进空间。尤其是额外创建 left 和 right 数组会消耗大量内存。

## 原地分区版：减少空间开销
   为了减少内存使用，我们可以在原地对数组进行分区，而不是创建额外的数组。这种方法叫做“原地分区”版快速排序。以下是具体代码：

```go

package main

import (
	"fmt"
)

func quickSortInPlace(arr []int, low, high int) {
	if low < high {
		// 获取分区位置
		pivotIndex := partition(arr, low, high)
		// 递归排序左右两部分
		quickSortInPlace(arr, low, pivotIndex-1)
		quickSortInPlace(arr, pivotIndex+1, high)
	}
}

func partition(arr []int, low, high int) int {
	pivot := arr[high]
	i := low - 1
	
	// 遍历数组并进行交换
	for j := low; j < high; j++ {
		if arr[j] <= pivot {
			i++
			arr[i], arr[j] = arr[j], arr[i]
		}
	}
	// 把 pivot 放到正确位置
	arr[i+1], arr[high] = arr[high], arr[i+1]
	return i + 1
}

func main() {
	arr := []int{9, -3, 5, 2, 6, 8, -6, 1, 3}
	fmt.Println("原始数组:", arr)
	quickSortInPlace(arr, 0, len(arr)-1)
	fmt.Println("排序后数组:", arr)
}

```

说明：

partition 函数用于分区，它返回基准元素的正确位置。
在 quickSortInPlace 中，我们递归排序左右分区。
优缺点：这种方法节省了额外内存，但操作稍微复杂，需要使用额外的指针来进行位置交换。它适用于大规模数据的排序。

## 随机化基准选择：优化性能
   在最坏情况下（如数组接近有序），快速排序的时间复杂度可能退化为
   𝑂(𝑛2)
   为了避免这种情况，我们可以随机选择基准，从而提高算法的稳定性。以下是加入随机化基准选择的版本：


```go

package main

import (
	"fmt"
	"math/rand"
	"time"
)

func quickSortRandom(arr []int, low, high int) {
	if low < high {
		pivotIndex := randomPartition(arr, low, high)
		quickSortRandom(arr, low, pivotIndex-1)
		quickSortRandom(arr, pivotIndex+1, high)
	}
}

func randomPartition(arr []int, low, high int) int {
	// 随机选择一个基准，并与高位交换
	rand.Seed(time.Now().UnixNano())
	randomIndex := low + rand.Intn(high-low+1)
	arr[randomIndex], arr[high] = arr[high], arr[randomIndex]
	
	// 使用普通分区逻辑
	return partition(arr, low, high)
}

func main() {
	arr := []int{9, -3, 5, 2, 6, 8, -6, 1, 3}
	fmt.Println("原始数组:", arr)
	quickSortRandom(arr, 0, len(arr)-1)
	fmt.Println("排序后数组:", arr)
}

```

说明：

使用 randomPartition 函数，在分区之前随机选择一个基准。
随机选择基准能有效减少最坏情况的出现，提高算法平均性能。
优缺点：通过随机选择基准，算法更具鲁棒性，可以处理接近有序的数组，适合多种实际应用场景。

## 双指针法：进一步优化分区效率
   使用双指针可以进一步优化分区过程。这个方法利用两个指针分别从数组的两端向中间扫描，找到需要交换的元素。代码如下：

```go
package main

import (
	"fmt"
)

func quickSortTwoPointers(arr []int, low, high int) {
	if low < high {
		pivotIndex := twoPointerPartition(arr, low, high)
		quickSortTwoPointers(arr, low, pivotIndex-1)
		quickSortTwoPointers(arr, pivotIndex+1, high)
	}
}

func twoPointerPartition(arr []int, low, high int) int {
	pivot := arr[low]
	left := low + 1
	right := high

	for left <= right {
		// 找到左边第一个大于 pivot 的元素
		for left <= right && arr[left] <= pivot {
			left++
		}
		// 找到右边第一个小于 pivot 的元素
		for left <= right && arr[right] >= pivot {
			right--
		}
		// 交换 left 和 right 元素
		if left < right {
			arr[left], arr[right] = arr[right], arr[left]
		}
	}

	// 将 pivot 放到最终位置
	arr[low], arr[right] = arr[right], arr[low]
	return right
}

func main() {
	arr := []int{9, -3, 5, 2, 6, 8, -6, 1, 3}
	fmt.Println("原始数组:", arr)
	quickSortTwoPointers(arr, 0, len(arr)-1)
	fmt.Println("排序后数组:", arr)
}
    
```

说明：
twoPointerPartition 函数使用两个指针从左右向中间移动，以找到需要交换的元素。
最后将基准值放置在正确位置。
优缺点：双指针法进一步优化了分区操作，减少了交换次数，提高了排序效率。

## 总结
本文展示了四种快速排序的不同实现方式：

简单递归版：入门级实现，代码简洁，但空间利用率不高。
原地分区版：减少内存使用，适合大规模数据。
随机化基准选择版：随机化基准选择，避免最坏情况出现。
双指针法版：进一步优化分区过程，减少不必要的交换操作。
通过选择适合的实现方式，Go 语言的快速排序能在不同的应用场景下发挥最佳性能。


## 参考资料
 - 算法导论（第三版）, Thomas H. Cormen 等
 - [Go官方文档](https://golang.org/pkg/)

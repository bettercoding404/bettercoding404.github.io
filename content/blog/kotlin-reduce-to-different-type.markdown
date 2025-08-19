---
title: "Kotlin Reduce to Different Type"
description: "
In Kotlin, the `reduce` function is a powerful tool for aggregating elements in a collection. By default, the `reduce` function combines elements of a collection into a single value of the same type as the elements in the collection. However, there are scenarios where you might want to reduce a collection to a different type. This blog post will explore the core concepts, typical usage scenarios, and best practices related to reducing a collection to a different type in Kotlin.
"
date: 2025-08-19
modified: 2025-08-19
---

## Table of Contents
1. [Core Concepts](#core-concepts)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Code Examples](#code-examples)
4. [Best Practices](#best-practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Core Concepts
### The `reduce` Function
The `reduce` function in Kotlin is an extension function on collections. It takes a binary operation as an argument and applies this operation to the elements of the collection in turn, starting from the first element. The result of each operation becomes the first argument of the next operation, and the second argument is the next element in the collection.

### Reducing to a Different Type
To reduce a collection to a different type, we typically use the `fold` function instead of `reduce`. The `fold` function is similar to `reduce`, but it takes an initial value of the target type as its first argument. This initial value is used as the starting point for the aggregation, and the result of the aggregation will be of the same type as the initial value.

## Typical Usage Scenarios
### Building a String from a Collection of Numbers
Suppose you have a collection of numbers, and you want to build a comma-separated string from these numbers. In this case, you can use `fold` to reduce the collection of numbers to a string.

### Calculating Statistics
When you have a collection of data and want to calculate some statistics, such as the average or the sum of squares, you can use `fold` to reduce the collection to a different type, such as a data class that holds the necessary statistics.

## Code Examples

### Building a String from a Collection of Numbers
```kotlin
fun main() {
    // Create a list of numbers
    val numbers = listOf(1, 2, 3, 4, 5)

    // Use fold to build a comma-separated string
    val result = numbers.fold("") { acc, num ->
        if (acc.isEmpty()) {
            num.toString()
        } else {
            "$acc, $num"
        }
    }

    println(result) // Output: 1, 2, 3, 4, 5
}
```
In this example, we start with an empty string as the initial value. For each number in the collection, we either convert the number to a string if the accumulator is empty or append the number to the accumulator with a comma.

### Calculating the Sum and Count of a Collection
```kotlin
data class Statistics(val sum: Int, val count: Int)

fun main() {
    // Create a list of numbers
    val numbers = listOf(1, 2, 3, 4, 5)

    // Use fold to calculate the sum and count
    val stats = numbers.fold(Statistics(0, 0)) { acc, num ->
        Statistics(acc.sum + num, acc.count + 1)
    }

    val average = stats.sum.toDouble() / stats.count
    println("Sum: ${stats.sum}, Count: ${stats.count}, Average: $average")
    // Output: Sum: 15, Count: 5, Average: 3.0
}
```
In this example, we use a data class `Statistics` to hold the sum and count of the collection. We start with an initial `Statistics` object with sum and count set to 0. For each number in the collection, we update the sum and count in the accumulator.

## Best Practices
### Choose the Right Initial Value
The initial value you choose for `fold` should be appropriate for the target type and the aggregation operation. For example, if you are building a string, an empty string is a good initial value. If you are calculating a sum, 0 is a good initial value.

### Keep the Aggregation Function Simple
The aggregation function passed to `fold` should be simple and easy to understand. Avoid complex logic in the aggregation function, as it can make the code hard to read and maintain.

### Use Data Classes for Complex Aggregation
If you need to aggregate multiple values, such as in the statistics example, use a data class to hold the aggregated values. This makes the code more organized and easier to work with.

## Conclusion
Reducing a collection to a different type in Kotlin is a powerful technique that can be used in various scenarios. By using the `fold` function, you can start with an initial value of the target type and aggregate the elements of the collection to get the desired result. Following the best practices, such as choosing the right initial value and keeping the aggregation function simple, can help you write more readable and maintainable code.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/collection-aggregate.html
- Effective Kotlin by Marcin Moskała: https://www.amazon.com/Effective-Kotlin-Marcin-Moska%C5%82a/dp/161729529X
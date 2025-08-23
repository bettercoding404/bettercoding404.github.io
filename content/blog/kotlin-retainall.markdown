---
title: "Mastering `retainAll` in Kotlin"
description: "
In the world of Kotlin programming, dealing with collections is a common task. Kotlin provides a rich set of collection APIs that simplify operations on data. One such useful function is `retainAll`. The `retainAll` function is available on mutable collections and is used to modify a collection in - place, keeping only the elements that are also present in another specified collection. This can be incredibly useful in various scenarios, such as filtering out unwanted elements based on a set of valid values. In this blog post, we will explore the core concepts, typical usage scenarios, and best practices related to the `retainAll` function in Kotlin.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts
The `retainAll` function is an extension function available on mutable collections in Kotlin. Its primary purpose is to modify the original collection by removing all elements that are not present in the specified collection. 

The function signature for `retainAll` is as follows:
```kotlin
fun <T> MutableCollection<T>.retainAll(elements: Collection<T>): Boolean
```
- **`MutableCollection<T>`**: This is the receiver of the function, which means it operates on a mutable collection of type `T`.
- **`elements: Collection<T>`**: This is the collection that contains the elements to be retained in the receiver collection.
- **`Boolean`**: The function returns `true` if the receiver collection was modified as a result of the operation, and `false` otherwise.

## Typical Usage Scenarios
### Filtering Based on a Set of Valid Values
Suppose you have a list of user - inputted values, and you want to keep only the values that are considered valid. You can use `retainAll` with a set of valid values.

### Data Cleaning
When working with large datasets, you might want to remove all elements that are not part of a specific set. For example, you have a list of product IDs, and you want to keep only the IDs that are currently in stock.

### Intersection of Collections
If you want to find the intersection of two collections and modify one of them to contain only the common elements, `retainAll` can be used.

## Code Examples
### Example 1: Filtering Based on a Set of Valid Values
```kotlin
fun main() {
    // List of user - inputted values
    val userInput = mutableListOf("apple", "banana", "cherry", "date")
    // Set of valid values
    val validValues = setOf("apple", "cherry")

    // Retain only the valid values in the userInput list
    val wasModified = userInput.retainAll(validValues)

    println("Was the list modified? $wasModified")
    println("Filtered list: $userInput")
}
```
In this example, the `userInput` list is modified to contain only the elements that are also present in the `validValues` set. The `wasModified` variable indicates whether the list was actually modified.

### Example 2: Data Cleaning
```kotlin
fun main() {
    // List of product IDs
    val productIds = mutableListOf(1, 2, 3, 4, 5)
    // List of product IDs in stock
    val inStockIds = listOf(2, 4)

    // Keep only the product IDs that are in stock
    productIds.retainAll(inStockIds)

    println("Product IDs in stock: $productIds")
}
```
Here, the `productIds` list is cleaned to contain only the IDs that are in stock.

### Example 3: Intersection of Collections
```kotlin
fun main() {
    val collection1 = mutableListOf(1, 2, 3, 4)
    val collection2 = listOf(3, 4, 5, 6)

    // Modify collection1 to contain only the common elements
    collection1.retainAll(collection2)

    println("Intersection of collections: $collection1")
}
```
This example shows how `retainAll` can be used to find the intersection of two collections and modify one of them.

## Best Practices
- **Use with Mutable Collections**: Remember that `retainAll` modifies the original collection in - place. So, make sure you are working with a mutable collection. If you need to keep the original collection intact, create a copy before using `retainAll`.
- **Check the Return Value**: The return value of `retainAll` can be useful in some cases. You can use it to determine whether the collection was actually modified.
- **Consider Performance**: If you are working with large collections, the performance of `retainAll` can be affected. Using a `Set` as the second collection can improve performance since checking for element existence in a `Set` is generally faster than in a `List`.

## Conclusion
The `retainAll` function in Kotlin is a powerful tool for modifying mutable collections. It simplifies the process of keeping only the elements that are present in another collection, which can be useful in various scenarios such as filtering, data cleaning, and finding intersections. By understanding the core concepts, typical usage scenarios, and best practices, you can effectively use `retainAll` in your Kotlin projects.

## References
- Kotlin official documentation: https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/retain-all.html
- Kotlin in Action by Dmitry Jemerov and Svetlana Isakova.
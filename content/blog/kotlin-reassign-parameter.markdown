---
title: "Kotlin Reassign Parameter: A Comprehensive Guide"
description: "
In Kotlin, parameters are generally considered immutable by default. However, there are scenarios where reassigning a parameter can be useful. Understanding how to reassign parameters in Kotlin is crucial for intermediate-to-advanced software engineers as it can lead to more flexible and efficient code. This blog post will explore the core concepts, typical usage scenarios, and best practices related to Kotlin parameter reassignment.
"
date: 2025-08-18
modified: 2025-08-18
---

## Table of Contents
1. Core Concepts
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts
In Kotlin, function parameters are `val` by default, which means they are read - only and cannot be reassigned. To make a parameter mutable, you can declare it as a `var`. When a parameter is declared as `var`, you can change its value within the function body.

Here is a simple example to illustrate the difference between `val` and `var` parameters:
```kotlin
// Function with a val parameter (immutable)
fun printValParameter(value: Int) {
    // This will cause a compilation error
    // value = value + 1 
    println(value)
}

// Function with a var parameter (mutable)
fun printVarParameter(var value: Int) {
    value = value + 1
    println(value)
}
```
In the `printValParameter` function, trying to reassign the `value` parameter will result in a compilation error because it is a `val`. In the `printVarParameter` function, the `value` parameter is declared as `var`, so it can be reassigned.

## Typical Usage Scenarios

### 1. Local State Management
When a function needs to maintain and update a local state based on the input parameter, reassigning the parameter can be a convenient way. For example, in a function that processes a counter value:
```kotlin
fun incrementCounter(var counter: Int): Int {
    counter = counter + 1
    return counter
}
```

### 2. Algorithm Implementation
Some algorithms require modifying the input values during the execution of the function. For instance, in a sorting algorithm that modifies the input array in - place:
```kotlin
fun sortArray(var array: IntArray) {
    // Sorting logic here, modifying the array
    array.sort()
    // You can also reassign the array reference if needed
    array = array.copyOf() 
}
```

### 3. Conditional Updates
When the input parameter needs to be updated based on certain conditions within the function:
```kotlin
fun updateValue(var value: Int): Int {
    if (value < 10) {
        value = 10
    }
    return value
}
```

## Code Examples

### Example 1: Basic Parameter Reassignment
```kotlin
fun updateString(var input: String): String {
    // Check if the string is empty
    if (input.isEmpty()) {
        input = "Default Value"
    }
    return input
}

fun main() {
    val emptyString = ""
    val result = updateString(emptyString)
    println(result) // Output: Default Value
}
```
In this example, the `updateString` function takes a `var` parameter `input`. If the input string is empty, it reassigns the `input` parameter to a default value.

### Example 2: Reassigning Array Parameter
```kotlin
fun doubleArrayValues(var array: IntArray): IntArray {
    for (i in array.indices) {
        array[i] = array[i] * 2
    }
    return array
}

fun main() {
    val originalArray = intArrayOf(1, 2, 3)
    val newArray = doubleArrayValues(originalArray)
    println(newArray.contentToString()) // Output: [2, 4, 6]
}
```
Here, the `doubleArrayValues` function takes a `var` parameter `array`. It iterates over the array and doubles each element.

## Best Practices

### 1. Use Sparingly
Reassigning parameters can make the code harder to understand, especially for other developers. Use it only when it significantly simplifies the code or is necessary for the algorithm.

### 2. Document Clearly
If you reassign a parameter, add comments to explain why the reassignment is necessary. This will help other developers understand the code's intent.

### 3. Consider Immutability First
In general, prefer immutability. Instead of reassigning a parameter, create a new variable with the updated value. This can lead to more predictable and thread - safe code.

## Conclusion
Reassigning parameters in Kotlin can be a powerful tool in certain situations, such as local state management, algorithm implementation, and conditional updates. However, it should be used with caution to maintain code readability and understandability. By following the best practices, you can effectively use parameter reassignment in your Kotlin code.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/reference/
- Effective Kotlin by Marcin Moskala and Artur Dryomov



---
title: "Understanding `kotlin.size`"
description: "
In Kotlin, the `size` property is a fundamental concept that plays a crucial role when dealing with collections, strings, and other data structures. It provides a straightforward way to determine the number of elements within a given data structure. This blog post aims to delve deep into the core concepts of `kotlin.size`, explore its typical usage scenarios, and share best practices to help intermediate - to - advanced software engineers make the most of this feature.
"
date: 2025-08-24
modified: 2025-08-24
---

## Table of Contents
1. Core Concepts
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts
The `size` property is an integer value that represents the number of elements in a collection or the number of characters in a string. In Kotlin, it is available on various types that implement the `Collection` interface, such as `List`, `Set`, and `Map`. For strings, it gives the length of the string.

### Collections
For collections, the `size` property is a read - only property. It is calculated when the collection is created and remains constant unless the collection is modified. For example, in an immutable list, the `size` will never change, while in a mutable list, adding or removing elements will update the `size` accordingly.

### Strings
In the case of strings, the `size` property (which is equivalent to the `length` property in Java) gives the number of Unicode code units in the string. This is useful for tasks like validating input lengths or iterating over each character in the string.

## Typical Usage Scenarios

### Collection Manipulation
- **Empty Check**: One of the most common use cases is to check if a collection is empty. Instead of comparing the `size` to zero, Kotlin provides a more idiomatic way using the `isEmpty()` or `isNotEmpty()` functions. However, understanding the `size` property is still important as these functions are often implemented using `size` internally.
- **Iteration**: When iterating over a collection, the `size` property can be used to determine the number of times the loop should run. For example, in a `for` loop, you can use the `size` to control the loop index.

### String Processing
- **Input Validation**: When accepting user input, you can use the `size` property to ensure that the input meets certain length requirements. For example, you might want to limit the length of a password or a username.
- **Substring Extraction**: The `size` property can be used to determine the valid range for extracting substrings from a string.

## Code Examples

### Collection Examples
```kotlin
// Create a mutable list
val mutableList = mutableListOf(1, 2, 3, 4, 5)
// Print the size of the list
println("Size of mutableList: ${mutableList.size}")

// Add an element to the list
mutableList.add(6)
// Print the updated size
println("Size of mutableList after adding an element: ${mutableList.size}")

// Create an immutable list
val immutableList = listOf(10, 20, 30)
// Print the size of the immutable list
println("Size of immutableList: ${immutableList.size}")

// Check if the list is empty
if (immutableList.isEmpty()) {
    println("The immutable list is empty.")
} else {
    println("The immutable list is not empty and has ${immutableList.size} elements.")
}

// Iterate over the list using the size
for (i in 0 until immutableList.size) {
    println("Element at index $i: ${immutableList[i]}")
}
```

### String Examples
```kotlin
// Create a string
val message = "Hello, Kotlin!"
// Print the size of the string
println("Size of the string: ${message.size}")

// Input validation example
fun validateUsername(username: String): Boolean {
    return username.size in 3..20
}

val validUsername = "user123"
val invalidUsername = "ab"
println("Is $validUsername a valid username? ${validateUsername(validUsername)}")
println("Is $invalidUsername a valid username? ${validateUsername(invalidUsername)}")

// Substring extraction using size
val substring = message.substring(0, message.size / 2)
println("Substring: $substring")
```

## Best Practices

### Avoid Unnecessary Calculations
In most cases, the `size` property is a constant - time operation. However, in some custom collections, calculating the `size` might be an expensive operation. Avoid calling the `size` property multiple times in a loop if possible. Instead, store the value in a variable.

```kotlin
val myList = listOf(1, 2, 3, 4, 5)
// Bad practice
for (i in 0 until myList.size) {
    println("Element at index $i: ${myList[i]}")
}

// Good practice
val listSize = myList.size
for (i in 0 until listSize) {
    println("Element at index $i: ${myList[i]}")
}
```

### Use Idiomatic Functions
As mentioned earlier, Kotlin provides functions like `isEmpty()` and `isNotEmpty()` for collections. Use these functions instead of directly comparing the `size` to zero for better readability.

```kotlin
val mySet = setOf(1, 2, 3)
// Bad practice
if (mySet.size == 0) {
    println("The set is empty.")
}

// Good practice
if (mySet.isEmpty()) {
    println("The set is empty.")
}
```

## Conclusion
The `kotlin.size` property is a simple yet powerful feature that is essential for working with collections and strings in Kotlin. By understanding its core concepts, typical usage scenarios, and following best practices, intermediate - to - advanced software engineers can write more efficient and readable code. Whether you are validating user input, manipulating collections, or processing strings, the `size` property will be a valuable tool in your Kotlin programming toolkit.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/
- Effective Kotlin book by Marcin Moskala and Artur Dryomov



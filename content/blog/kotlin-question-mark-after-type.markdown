---
title: "Understanding the Kotlin Question Mark After Type"
description: "
In Kotlin, the question mark (`?`) after a type is a powerful feature that plays a crucial role in handling nullability. Nullability is a common source of bugs in programming languages, as dereferencing a null reference can lead to runtime errors such as `NullPointerException`. Kotlin addresses this issue by introducing a more explicit and safer way to deal with null values. This blog post will delve into the core concepts, typical usage scenarios, and best practices related to using the question mark after a type in Kotlin.
"
date: 2025-08-15
modified: 2025-08-15
---

## Table of Contents
1. [Core Concepts](#core-concepts)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Best Practices](#best-practices)
4. [Conclusion](#conclusion)
5. [References](#references)

## Core Concepts
In Kotlin, types are non - nullable by default. This means that a variable of a certain type cannot hold a null value. For example, the following code will not compile if you try to assign null to a non - nullable variable:
```kotlin
// This will not compile
var nonNullableString: String = null 
```
To allow a variable to hold a null value, you need to make the type nullable by appending a question mark (`?`) after the type. Here is an example:
```kotlin
// This compiles
var nullableString: String? = null 
```
The question mark after the type indicates that the variable can either hold a value of the specified type or a null value.

When you have a nullable type, you cannot directly call methods or access properties on it, because the variable might be null. Kotlin enforces this safety measure to prevent `NullPointerException`. For example:
```kotlin
var nullableString: String? = null
// This will not compile
// println(nullableString.length) 
```
To work with nullable types, you need to use one of the null - safe operators provided by Kotlin.

## Typical Usage Scenarios

### 1. Working with External APIs
When you interact with external APIs, the data returned might be null. For example, a database query might return null if no record is found.
```kotlin
// Assume this function queries a database and might return null
fun getUserNameFromDatabase(): String? {
    // Simulating a database query that might return null
    return if (Math.random() > 0.5) "John" else null
}

fun main() {
    val userName = getUserNameFromDatabase()
    // Using the safe call operator
    val nameLength = userName?.length
    println("The length of the user name is: $nameLength")
}
```
In this example, the `getUserNameFromDatabase` function might return null. We use the safe call operator (`?.`) to call the `length` property on the `userName` variable. If `userName` is null, the entire expression will evaluate to null instead of throwing a `NullPointerException`.

### 2. Optional Function Parameters
You can make function parameters nullable to indicate that they are optional.
```kotlin
fun printFullName(firstName: String, lastName: String?) {
    if (lastName != null) {
        println("$firstName $lastName")
    } else {
        println(firstName)
    }
}

fun main() {
    printFullName("Alice", "Smith")
    printFullName("Bob", null)
}
```
Here, the `lastName` parameter is nullable, which means it can be omitted when calling the function.

### 3. Collections with Nullable Elements
You can have collections where the elements are nullable.
```kotlin
val nullableList: List<String?> = listOf("Apple", null, "Banana")
for (item in nullableList) {
    // Using the safe call operator
    val length = item?.length
    println("Length of item: $length")
}
```
In this example, the `nullableList` contains nullable strings. We use the safe call operator to get the length of each item in the list.

## Best Practices

### 1. Use Null - Safe Operators
Kotlin provides several null - safe operators such as the safe call operator (`?.`), the Elvis operator (`?:`), and the non - null assertion operator (`!!`). Use the safe call operator whenever possible to avoid `NullPointerException`.
```kotlin
var nullableString: String? = null
// Using the Elvis operator to provide a default value
val result = nullableString?.length ?: 0
println("The length is: $result")
```
The Elvis operator returns the left - hand side value if it is not null, otherwise it returns the right - hand side value.

### 2. Avoid Using the Non - Null Assertion Operator (`!!`)
The non - null assertion operator (`!!`) converts a nullable type to a non - nullable type. If the variable is null, it will throw a `NullPointerException`. It should be used sparingly, only when you are absolutely sure that the variable is not null.
```kotlin
var nullableString: String? = "Hello"
// Using the non - null assertion operator
val nonNullableString: String = nullableString!!
println(nonNullableString.length)
```

### 3. Be Explicit in Function Signatures
When defining functions, be explicit about whether the parameters and return types are nullable or not. This makes the code more readable and less error - prone.
```kotlin
// Explicitly stating that the return type is nullable
fun getNullableResult(): Int? {
    return if (Math.random() > 0.5) 10 else null
}
```

## Conclusion
The question mark after a type in Kotlin is a fundamental feature for handling nullability. It allows you to write safer and more robust code by explicitly indicating which variables can hold null values. By understanding the core concepts, typical usage scenarios, and best practices, you can effectively use nullable types in your Kotlin projects and avoid common null - related bugs.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/null-safety.html
- "Kotlin in Action" by Dmitry Jemerov and Svetlana Isakova
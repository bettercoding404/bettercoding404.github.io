---
title: "Kotlin Scope Functions Cheat Sheet"
description: "
Kotlin scope functions are a powerful feature that allows developers to execute a block of code within the context of an object. They provide a concise and readable way to perform operations on an object without having to repeat its reference multiple times. This cheat sheet will explore the core concepts, typical usage scenarios, and best practices for Kotlin scope functions, helping intermediate-to-advanced software engineers leverage these functions effectively in their projects.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. [Core Concepts](#core-concepts)
2. [Scope Functions Overview](#scope-functions-overview)
    - [let](#let)
    - [run](#run)
    - [with](#with)
    - [apply](#apply)
    - [also](#also)
3. [Typical Usage Scenarios](#typical-usage-scenarios)
4. [Best Practices](#best-practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Core Concepts
Scope functions in Kotlin are used to execute a block of code within the scope of an object. They provide a way to access the object's properties and methods without explicitly referring to the object itself. Each scope function has a specific way of accessing the object and returning a result, which makes them suitable for different use cases.

The main differences between scope functions lie in two aspects:
- **How the object is accessed inside the lambda**: Some functions use `this` to refer to the object, while others use `it`.
- **What the function returns**: Some functions return the result of the lambda, while others return the original object.

## Scope Functions Overview

### let
- **Access**: `it` (implicitly named single parameter)
- **Return**: The result of the lambda expression

```kotlin
// Example of using let
val numbers = listOf(1, 2, 3, 4, 5)
val sum = numbers.let {
    var result = 0
    for (num in it) {
        result += num
    }
    result
}
println(sum) // Output: 15
```

### run
- **Access**: `this` (receiver object)
- **Return**: The result of the lambda expression

```kotlin
// Example of using run
val person = Person("John", 30)
val description = person.run {
    "Name: $name, Age: $age"
}
println(description) // Output: Name: John, Age: 30

class Person(var name: String, var age: Int)
```

### with
- **Access**: `this` (receiver object)
- **Return**: The result of the lambda expression

```kotlin
// Example of using with
val person = Person("Jane", 25)
val message = with(person) {
    "Hello, my name is $name and I'm $age years old."
}
println(message) // Output: Hello, my name is Jane and I'm 25 years old.
```

### apply
- **Access**: `this` (receiver object)
- **Return**: The original object

```kotlin
// Example of using apply
val person = Person("Bob", 40).apply {
    age = 41
    name = "Robert"
}
println("Name: ${person.name}, Age: ${person.age}") // Output: Name: Robert, Age: 41
```

### also
- **Access**: `it` (implicitly named single parameter)
- **Return**: The original object

```kotlin
// Example of using also
val numbers = mutableListOf(1, 2, 3)
numbers.also {
    it.add(4)
}.also {
    it.remove(1)
}
println(numbers) // Output: [2, 3, 4]
```

## Typical Usage Scenarios
- **Null checks**: Use `let` to perform operations on an object only if it is not null.
```kotlin
val nullableString: String? = "Hello"
nullableString?.let {
    println(it.length)
}
```
- **Object configuration**: Use `apply` to configure an object's properties.
```kotlin
val file = File("test.txt").apply {
    createNewFile()
    writeText("Hello, World!")
}
```
- **Chaining operations**: Use `also` to perform side effects while chaining operations on an object.
```kotlin
val list = mutableListOf<Int>()
list.also { it.add(1) }
    .also { it.add(2) }
    .forEach { println(it) }
```

## Best Practices
- **Choose the right function**: Select the scope function based on how you need to access the object and what you want to return.
- **Keep the lambda concise**: Scope functions are meant to simplify code, so keep the lambda expressions short and focused.
- **Avoid overusing scope functions**: While scope functions can make code more concise, overusing them can make the code hard to read.

## Conclusion
Kotlin scope functions are a valuable tool for writing concise and readable code. By understanding the core concepts, typical usage scenarios, and best practices, intermediate-to-advanced software engineers can effectively use these functions to improve the quality of their Kotlin code. Whether it's null checks, object configuration, or chaining operations, scope functions provide a flexible and powerful way to work with objects in Kotlin.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/scope-functions.html
- "Kotlin in Action" by Dmitry Jemerov and Svetlana Isakova

This blog post provides a comprehensive cheat sheet for Kotlin scope functions, covering their core concepts, usage scenarios, and best practices. By referring to this cheat sheet, developers can make informed decisions when choosing the appropriate scope function for their specific use cases.
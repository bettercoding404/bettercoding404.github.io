---
title: "Mastering the `also` Keyword in Kotlin"
description: "
Kotlin is a modern, concise programming language that offers a plethora of useful features to simplify code and enhance readability. One such feature is the `also` keyword, which is a part of the Kotlin standard library's scope functions. Scope functions in Kotlin are used to execute a block of code within the context of an object. The `also` function, in particular, is incredibly handy for performing additional operations on an object while keeping the object itself as the result. In this blog post, we will explore the core concepts, typical usage scenarios, and best practices related to the `also` keyword in Kotlin.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. [Core Concepts of the `also` Keyword](#core-concepts-of-the-also-keyword)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Best Practices](#best-practices)
4. [Conclusion](#conclusion)
5. [References](#references)

## Core Concepts of the `also` Keyword
The `also` function is an extension function available on all types in Kotlin. It takes a lambda expression as an argument and returns the original object on which it was called. Inside the lambda, the object is referred to using the `it` keyword.

Here is a simple example to illustrate the basic concept:
```kotlin
// Define a data class
data class Person(var name: String, var age: Int)

fun main() {
    // Create a Person object
    val person = Person("John", 30)
        .also {
            // Perform additional operations on the object
            it.age = 31
            println("Updated age: ${it.age}")
        }

    // The original object is returned
    println("Person name: ${person.name}, age: ${person.age}")
}
```
In this example, we create a `Person` object and use the `also` function to update the `age` property and print the updated age. The `also` function returns the original `Person` object, which we can then use for further operations.

## Typical Usage Scenarios

### 1. Initializing and Logging
The `also` function is great for initializing an object and logging its state at the same time.
```kotlin
data class User(var id: Int, var email: String)

fun main() {
    val user = User(1, "example@example.com")
        .also {
            println("User created with ID: ${it.id} and email: ${it.email}")
        }
    // Use the user object further
    println("User email: ${user.email}")
}
```

### 2. Chaining Operations
You can use `also` to chain multiple operations on an object.
```kotlin
data class Book(var title: String, var author: String)

fun main() {
    val book = Book("Kotlin in Action", "Dmitry Jemerov")
        .also { it.title = "Updated: ${it.title}" }
        .also { println("Book title updated to: ${it.title}") }
    println("Final book title: ${book.title}")
}
```

### 3. Working with Collections
The `also` function can be used to perform additional operations on collections.
```kotlin
fun main() {
    val numbers = mutableListOf(1, 2, 3)
        .also { it.add(4) }
        .also { println("Numbers after adding 4: $it") }
    println("Final list: $numbers")
}
```

## Best Practices

### 1. Keep the Lambda Focused
The lambda inside the `also` function should have a single responsibility. Avoid performing too many complex operations inside the lambda to keep the code readable.

### 2. Use Descriptive Logging
When using `also` for logging, make sure the log messages are descriptive so that it's easy to understand the state of the object at different points in the code.

### 3. Avoid Overusing `also`
While `also` is a powerful tool, overusing it can make the code hard to read. Use it only when it simplifies the code and makes the intent clear.

## Conclusion
The `also` keyword in Kotlin is a versatile and useful tool for performing additional operations on an object while keeping the object itself as the result. It can be used in various scenarios such as initialization, logging, and chaining operations. By following the best practices, you can write more concise and readable code. Understanding and effectively using the `also` keyword will enhance your Kotlin programming skills and make your code more maintainable.

## References
- Kotlin Documentation: [Scope Functions](https://kotlinlang.org/docs/scope-functions.html)
- Kotlin in Action by Dmitry Jemerov and Svetlana Isakova
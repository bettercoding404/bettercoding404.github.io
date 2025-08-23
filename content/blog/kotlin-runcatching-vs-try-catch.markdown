---
title: "Kotlin `runCatching` vs `try-catch`: A Comprehensive Comparison"
description: "
In Kotlin, error handling is a crucial aspect of writing robust and reliable code. Two common ways to handle exceptions are using the traditional `try-catch` block and the more modern `runCatching` function. This blog post aims to provide an in - depth comparison between `runCatching` and `try-catch`, explaining their core concepts, typical usage scenarios, and best practices. By the end of this post, intermediate - to - advanced software engineers will have a better understanding of when to use each approach and how to apply them effectively in their Kotlin projects.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts
    - `try-catch`
    - `runCatching`
2. Typical Usage Scenarios
    - `try-catch`
    - `runCatching`
3. Code Examples
    - `try-catch` Examples
    - `runCatching` Examples
4. Best Practices
    - When to Use `try-catch`
    - When to Use `runCatching`
5. Conclusion
6. References

## Core Concepts

### `try-catch`
The `try-catch` block is a well - known construct in many programming languages, including Kotlin. It allows you to enclose a block of code that might throw an exception within the `try` block. If an exception occurs during the execution of the `try` block, the control is transferred to the appropriate `catch` block. The `catch` block takes an exception type as a parameter and can handle the exception in a specific way. Optionally, a `finally` block can be added, which will be executed regardless of whether an exception occurred or not.

```kotlin
try {
    // Code that might throw an exception
    val result = 1 / 0
} catch (e: ArithmeticException) {
    // Handle the exception
    println("An arithmetic exception occurred: ${e.message}")
} finally {
    // This block is always executed
    println("Finally block executed")
}
```

### `runCatching`
`runCatching` is a Kotlin standard library function introduced to simplify exception handling. It takes a lambda expression as an argument and executes it. If the lambda execution is successful, it returns a `Success` instance containing the result of the lambda. If an exception occurs during the execution of the lambda, it returns a `Failure` instance containing the thrown exception. You can then use methods like `getOrNull()`, `getOrThrow()`, or `getOrDefault()` to handle the result.

```kotlin
val result = runCatching {
    1 / 0
}

if (result.isSuccess) {
    println("The result is: ${result.getOrThrow()}")
} else {
    println("An exception occurred: ${result.exceptionOrNull()?.message}")
}
```

## Typical Usage Scenarios

### `try-catch`
- **Fine - grained exception handling**: When you need to handle different types of exceptions in different ways, `try-catch` is a better choice. For example, in a file reading operation, you might want to handle `FileNotFoundException` and `IOException` differently.
- **Resource management**: When using resources that need to be properly closed, the `try-with-resources` (in Java) or `use` function in Kotlin can be combined with `try-catch` to ensure that resources are released even if an exception occurs.

### `runCatching`
- **Simplifying error handling**: When you just want to perform an operation and handle the success or failure in a more concise way, `runCatching` can be used. For example, when making a simple API call and handling the result or error.
- **Functional programming style**: `runCatching` fits well into a functional programming style, as it returns a result that can be further processed using functions like `map`, `flatMap`, etc.

## Code Examples

### `try-catch` Examples

#### File Reading
```kotlin
import java.io.File
import java.io.FileNotFoundException
import java.io.IOException

fun readFileContent(filePath: String): String? {
    try {
        val file = File(filePath)
        return file.readText()
    } catch (e: FileNotFoundException) {
        println("File not found: ${e.message}")
    } catch (e: IOException) {
        println("An I/O error occurred: ${e.message}")
    }
    return null
}
```

### `runCatching` Examples

#### API Call Simulation
```kotlin
data class ApiResponse(val data: String)

fun simulateApiCall(): ApiResponse? {
    return runCatching {
        // Simulate an API call that might throw an exception
        if (Math.random() < 0.5) {
            throw RuntimeException("API call failed")
        }
        ApiResponse("Sample data")
    }.getOrNull()
}
```

## Best Practices

### When to Use `try-catch`
- **Complex exception hierarchies**: If your code can throw multiple types of exceptions that need different handling logic, use `try-catch`. For example, in a database operation, you might have different exceptions for connection errors, query errors, etc.
- **Resource management**: When working with resources that need explicit closing, such as file streams or database connections, combine `try-catch` with resource management constructs.

### When to Use `runCatching`
- **Simple operations**: For simple operations where you just want to handle success or failure in a concise way, `runCatching` is a great choice. For example, when performing a simple calculation or a single API call.
- **Functional chaining**: If you want to chain multiple operations together and handle exceptions in a functional way, `runCatching` can be used with functions like `map` and `flatMap`.

```kotlin
val result = runCatching {
    2 * 2
}.map { it + 1 }

if (result.isSuccess) {
    println("The final result is: ${result.getOrThrow()}")
} else {
    println("An exception occurred: ${result.exceptionOrNull()?.message}")
}
```

## Conclusion
Both `try-catch` and `runCatching` have their own strengths and are suitable for different scenarios. `try-catch` is a traditional and powerful way to handle exceptions, especially when dealing with complex exception hierarchies and resource management. On the other hand, `runCatching` simplifies error handling and fits well into a functional programming style, making it ideal for simple operations and functional chaining. As a Kotlin developer, understanding when to use each approach will help you write more robust and maintainable code.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/
- Effective Kotlin by Marcin Moskała: https://www.amazon.com/Effective-Kotlin-Marcin-Moska%C5%82a/dp/161729529X
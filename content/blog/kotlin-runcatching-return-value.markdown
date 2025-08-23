---
title: "Mastering Kotlin's `runCatching` Return Value"
description: "
In the realm of Kotlin programming, error handling is a crucial aspect of writing robust and reliable code. One of the powerful tools provided by the Kotlin standard library for this purpose is the `runCatching` function. This function allows you to execute a block of code and handle any exceptions that might occur in a concise and elegant way. Understanding the return value of `runCatching` is essential for leveraging its full potential. In this blog post, we will delve into the core concepts, typical usage scenarios, and best practices related to the return value of `runCatching` in Kotlin.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. [Core Concepts of `runCatching` Return Value](#core-concepts-of-runcatching-return-value)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Best Practices](#best-practices)
4. [Code Examples](#code-examples)
5. [Conclusion](#conclusion)
6. [References](#references)

## Core Concepts of `runCatching` Return Value
The `runCatching` function in Kotlin is an extension function on the `Function0<R>` type, which means it can be used to execute a lambda expression that takes no arguments and returns a value of type `R`. The return value of `runCatching` is an instance of the `Result` class.

The `Result` class is a sealed class that has two sub - classes:
- `Success<T>`: Represents a successful execution of the code block. It contains the value returned by the code block.
- `Failure`: Represents a failed execution of the code block. It contains the exception that was thrown during the execution.

Here is a simple example to illustrate the basic structure:
```kotlin
// A function that might throw an exception
fun divide(a: Int, b: Int): Int {
    if (b == 0) {
        throw ArithmeticException("Division by zero")
    }
    return a / b
}

fun main() {
    val result = runCatching {
        divide(10, 2)
    }
    // result is an instance of Result<Int>
    if (result.isSuccess) {
        println("The result of division is: ${result.getOrThrow()}")
    } else {
        println("An error occurred: ${result.exceptionOrNull()?.message}")
    }
}
```
In this example, the `runCatching` function executes the lambda expression that calls the `divide` function. If the division is successful, the `result` will be an instance of `Success<Int>` containing the result of the division. If a `DivisionByZeroException` is thrown, the `result` will be an instance of `Failure` containing the exception.

## Typical Usage Scenarios
### 1. API Calls
When making API calls, there are many things that can go wrong, such as network issues, invalid responses, or server errors. Using `runCatching` can simplify the error handling process.
```kotlin
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL

suspend fun fetchData(url: String): Result<String> {
    return runCatching {
        withContext(Dispatchers.IO) {
            val connection = URL(url).openConnection() as HttpURLConnection
            connection.requestMethod = "GET"
            val responseCode = connection.responseCode
            if (responseCode == HttpURLConnection.HTTP_OK) {
                connection.inputStream.bufferedReader().use { it.readText() }
            } else {
                throw IOException("HTTP request failed with code $responseCode")
            }
        }
    }
}
```
### 2. File Operations
File operations like reading or writing files can also throw exceptions. `runCatching` can be used to handle these exceptions gracefully.
```kotlin
import java.io.File

fun readFileContent(filePath: String): Result<String> {
    return runCatching {
        File(filePath).readText()
    }
}
```

## Best Practices
### 1. Check for Success or Failure Explicitly
It is important to check whether the `Result` is a success or a failure before accessing the value. Using methods like `getOrThrow` without checking can lead to unexpected exceptions.
```kotlin
val result = runCatching {
    // Some code that might throw an exception
    10 / 0
}
if (result.isSuccess) {
    println(result.getOrThrow())
} else {
    println("Error: ${result.exceptionOrNull()?.message}")
}
```
### 2. Use `getOrElse` or `getOrDefault`
Instead of using `getOrThrow`, consider using `getOrElse` or `getOrDefault` to provide a default value in case of failure.
```kotlin
val result = runCatching {
    // Some code that might throw an exception
    10 / 0
}
val value = result.getOrElse { 0 }
println(value)
```

## Code Examples
### 1. Handling a List of Operations
```kotlin
fun processList(numbers: List<Int>): Result<List<Int>> {
    return runCatching {
        numbers.map {
            if (it == 0) {
                throw IllegalArgumentException("Zero is not allowed")
            }
            it * 2
        }
    }
}

fun main() {
    val numbers = listOf(1, 2, 3, 0, 4)
    val result = processList(numbers)
    if (result.isSuccess) {
        println("Processed list: ${result.getOrThrow()}")
    } else {
        println("Error: ${result.exceptionOrNull()?.message}")
    }
}
```
### 2. Chaining Operations
```kotlin
fun squareRoot(x: Double): Double {
    if (x < 0) {
        throw IllegalArgumentException("Cannot calculate square root of a negative number")
    }
    return Math.sqrt(x)
}

fun main() {
    val result = runCatching {
        25.0
    }.map { squareRoot(it) }
    if (result.isSuccess) {
        println("The square root is: ${result.getOrThrow()}")
    } else {
        println("Error: ${result.exceptionOrNull()?.message}")
    }
}
```

## Conclusion
The `runCatching` function in Kotlin provides a powerful and concise way to handle exceptions and manage the return values of code blocks that might throw exceptions. By understanding the core concepts of the `Result` class and its sub - classes, and by following the best practices, you can write more robust and reliable code. Whether you are making API calls, performing file operations, or processing lists, `runCatching` can simplify your error handling process.

## References
- [Kotlin Standard Library Documentation](https://kotlinlang.org/api/latest/jvm/stdlib/)
- [Kotlin Coroutines Guide](https://kotlinlang.org/docs/coroutines-guide.html)
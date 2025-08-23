---
title: "Kotlin `runCatching` and `onFailure`: A Comprehensive Guide"
description: "
In Kotlin, error handling is a crucial aspect of building robust applications. The `runCatching` function, introduced in the Kotlin Standard Library, provides a concise and idiomatic way to handle exceptions. Alongside `runCatching`, the `onFailure` function is used to perform actions when an exception occurs within the block of code wrapped by `runCatching`. This blog post will delve into the core concepts, typical usage scenarios, and best practices related to `kotlin runCatching onFailure`.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. [Core Concepts](#core-concepts)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Code Examples](#code-examples)
4. [Best Practices](#best-practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Core Concepts

### `runCatching`
The `runCatching` function is an extension function available on the `Any` type in Kotlin. It takes a lambda expression as an argument and executes it. If the lambda expression completes successfully, `runCatching` returns a `Success` instance of the `Result` type, which contains the result of the lambda. If an exception is thrown during the execution of the lambda, `runCatching` returns a `Failure` instance of the `Result` type, which contains the thrown exception.

### `onFailure`
The `onFailure` function is an extension function available on the `Result` type. It takes a lambda expression that accepts a single parameter of type `Throwable`. If the `Result` instance is a `Failure`, the lambda expression is executed with the thrown exception as an argument. If the `Result` instance is a `Success`, the lambda expression is skipped.

## Typical Usage Scenarios

### API Calls
When making API calls, exceptions can occur due to network issues, server errors, or invalid input. `runCatching` can be used to handle these exceptions gracefully, and `onFailure` can be used to log the error or display an appropriate error message to the user.

### File Operations
File operations such as reading or writing files can also throw exceptions. `runCatching` and `onFailure` can be used to handle these exceptions and ensure that the application does not crash.

### Parsing Data
Parsing data from JSON, XML, or other formats can result in exceptions if the data is invalid. `runCatching` and `onFailure` can be used to handle these exceptions and provide a fallback mechanism.

## Code Examples

### Example 1: Basic Usage
```kotlin
fun divide(a: Int, b: Int): Result<Int> {
    return runCatching {
        a / b
    }.onFailure { exception ->
        println("An error occurred: ${exception.message}")
    }
}

fun main() {
    val result1 = divide(10, 2)
    if (result1.isSuccess) {
        println("Result: ${result1.getOrThrow()}")
    }

    val result2 = divide(10, 0)
    if (result2.isFailure) {
        println("Division failed.")
    }
}
```
In this example, the `divide` function uses `runCatching` to perform the division operation. If the division is successful, the result is returned as a `Success` instance. If an exception occurs (e.g., division by zero), the `onFailure` block is executed, and an error message is printed.

### Example 2: API Call
```kotlin
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL

fun makeApiCall(url: String): Result<String> {
    return runCatching {
        val connection = URL(url).openConnection() as HttpURLConnection
        connection.requestMethod = "GET"
        val responseCode = connection.responseCode
        if (responseCode == HttpURLConnection.HTTP_OK) {
            connection.inputStream.bufferedReader().use { it.readText() }
        } else {
            throw IOException("HTTP request failed with response code $responseCode")
        }
    }.onFailure { exception ->
        println("API call failed: ${exception.message}")
    }
}

fun main() = runBlocking(Dispatchers.IO) {
    val url = "https://api.example.com/data"
    val result = makeApiCall(url)
    if (result.isSuccess) {
        println("API response: ${result.getOrThrow()}")
    } else {
        println("Failed to get API response.")
    }
}
```
In this example, the `makeApiCall` function uses `runCatching` to make an HTTP GET request to an API. If the request is successful, the response body is returned as a `Success` instance. If an exception occurs (e.g., network error or HTTP error), the `onFailure` block is executed, and an error message is printed.

## Best Practices

### Keep the `runCatching` Block Small
The `runCatching` block should be kept as small as possible to isolate the code that can potentially throw an exception. This makes it easier to identify and handle errors.

### Use `onFailure` for Logging and Error Handling
The `onFailure` block should be used primarily for logging errors and performing any necessary cleanup or error handling. Avoid performing complex operations in the `onFailure` block, as it can make the code harder to understand and maintain.

### Check the Result
After using `runCatching`, always check the result using the `isSuccess` or `isFailure` methods before accessing the value using `getOrThrow()`. This helps prevent unexpected exceptions from occurring.

## Conclusion
The `runCatching` and `onFailure` functions in Kotlin provide a powerful and concise way to handle exceptions. By understanding the core concepts, typical usage scenarios, and best practices, intermediate-to-advanced software engineers can use these functions effectively to build more robust and reliable applications.

## References
- [Kotlin Documentation: Result](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-result/)
- [Kotlin Documentation: runCatching](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/run-catching.html)
- [Effective Kotlin: Chapter 14 - Error Handling](https://www.baeldung.com/kotlin/effective-kotlin-error-handling)
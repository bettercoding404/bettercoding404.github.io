---
title: "Mastering `removeSuffix` in Kotlin"
description: "
Kotlin, a modern and concise programming language, offers a plethora of useful string manipulation functions. One such function is `removeSuffix`, which is designed to simplify the process of removing a specific suffix from a given string. This blog post aims to provide an in - depth understanding of the `removeSuffix` function, including its core concepts, typical usage scenarios, and best practices. By the end of this article, intermediate - to - advanced software engineers will be well - equipped to use `removeSuffix` effectively in their Kotlin projects.
"
date: 2025-08-22
modified: 2025-08-22
---

## Table of Contents
1. Core Concepts of `removeSuffix`
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts of `removeSuffix`
The `removeSuffix` function is a member of the Kotlin `String` class. Its primary purpose is to return a new string with the specified suffix removed from the original string, if the suffix exists. If the original string does not end with the specified suffix, the original string is returned unchanged.

The function signature is as follows:
```kotlin
fun String.removeSuffix(suffix: String): String
```
Here, `suffix` is the string that you want to remove from the end of the original string.

## Typical Usage Scenarios
### File Path Manipulation
When working with file paths, you might want to remove the file extension (which is a suffix). For example, if you have a file path like `"example.txt"` and you want to get just the file name (`"example"`), you can use `removeSuffix`.

### Data Cleaning
In data processing, strings might have unwanted suffixes that need to be removed. For instance, in a dataset of names, some names might have a title suffix like `" Jr."` or `" Sr."` that you want to remove for normalization.

### URL Manipulation
When dealing with URLs, you may need to remove query parameters or specific segments at the end of the URL. For example, if you have a URL like `"https://example.com/page?param=value"` and you want to get just the base URL (`"https://example.com/page"`), `removeSuffix` can be useful.

## Code Examples

### Removing File Extension
```kotlin
fun main() {
    // Define a file path
    val filePath = "document.pdf"
    // Define the file extension (suffix)
    val fileExtension = ".pdf"
    // Use removeSuffix to get the file name without the extension
    val fileName = filePath.removeSuffix(fileExtension)
    println("File name without extension: $fileName")
}
```
In this example, we first define a file path and the file extension. Then we use the `removeSuffix` function to remove the extension from the file path. The result is the file name without the extension, which is printed to the console.

### Removing Title Suffix from Names
```kotlin
fun main() {
    // Define a name with a title suffix
    val fullName = "John Doe Jr."
    // Define the title suffix
    val titleSuffix = " Jr."
    // Use removeSuffix to get the name without the title suffix
    val cleanName = fullName.removeSuffix(titleSuffix)
    println("Name without title suffix: $cleanName")
}
```
Here, we have a full name with a title suffix. By using `removeSuffix`, we can easily get the name without the suffix.

### Removing Query Parameters from a URL
```kotlin
fun main() {
    // Define a URL with query parameters
    val url = "https://example.com/search?keyword=kotlin"
    // Define the query parameter part (suffix)
    val queryParams = "?keyword=kotlin"
    // Use removeSuffix to get the base URL
    val baseUrl = url.removeSuffix(queryParams)
    println("Base URL: $baseUrl")
}
```
This example demonstrates how to use `removeSuffix` to remove the query parameters from a URL and obtain the base URL.

## Best Practices
- **Case Sensitivity**: The `removeSuffix` function is case - sensitive. If you need a case - insensitive removal, you can convert both the original string and the suffix to either upper or lower case before using `removeSuffix`.
```kotlin
fun main() {
    val original = "Example.TXT"
    val suffix = ".txt"
    val result = original.lowercase().removeSuffix(suffix.lowercase())
    println(result)
}
```
- **Error Handling**: Since `removeSuffix` returns the original string if the suffix is not found, you don't need to worry about null pointer exceptions. However, if you want to perform additional actions based on whether the suffix was removed or not, you can compare the original and the result strings.
```kotlin
fun main() {
    val original = "Hello"
    val suffix = "World"
    val result = original.removeSuffix(suffix)
    if (original != result) {
        println("Suffix was removed.")
    } else {
        println("Suffix was not found.")
    }
}
```

## Conclusion
The `removeSuffix` function in Kotlin is a powerful and convenient tool for string manipulation. It simplifies the process of removing specific suffixes from strings, making it useful in various scenarios such as file path manipulation, data cleaning, and URL processing. By understanding its core concepts, typical usage scenarios, and following best practices, software engineers can effectively use `removeSuffix` to write more concise and efficient code in their Kotlin projects.

## References
- Kotlin official documentation: https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.text/remove-suffix.html
- Kotlin in Action by Dmitry Jemerov and Svetlana Isakova
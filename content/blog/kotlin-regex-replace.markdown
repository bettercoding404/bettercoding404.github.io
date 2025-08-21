---
title: "Kotlin Regex Replace: A Comprehensive Guide"
description: "
Regular expressions are a powerful tool in programming, allowing developers to perform complex text matching and manipulation tasks. In Kotlin, the `Regex` class provides a robust set of features for working with regular expressions, including the ability to replace text that matches a given pattern. This blog post will delve into the core concepts, typical usage scenarios, and best practices related to Kotlin's `Regex.replace` function. By the end of this article, intermediate-to-advanced software engineers will have a better understanding of how to use `Regex.replace` effectively in their projects.
"
date: 2025-08-21
modified: 2025-08-21
---

## Table of Contents
1. [Core Concepts](#core-concepts)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Code Examples](#code-examples)
4. [Best Practices](#best-practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Core Concepts
### Regular Expressions
A regular expression is a sequence of characters that forms a search pattern. In Kotlin, regular expressions are represented by the `Regex` class. You can create a `Regex` object by passing a string containing the regular expression pattern to the constructor. For example:
```kotlin
val pattern = Regex("abc")
```
This creates a `Regex` object that matches the exact sequence "abc" in a given string.

### Regex.replace
The `replace` function is a member of the `Regex` class and is used to replace all occurrences of the pattern in a given string with a specified replacement string. The basic syntax is as follows:
```kotlin
val result = pattern.replace(input, replacement)
```
Here, `pattern` is the `Regex` object, `input` is the string in which you want to perform the replacement, and `replacement` is the string that will replace the matched pattern.

### Capture Groups
Capture groups are used to extract parts of the matched text. In a regular expression, you can define capture groups by enclosing a part of the pattern in parentheses. For example:
```kotlin
val pattern = Regex("(\\d{2})-(\\d{2})-(\\d{4})")
```
This pattern matches dates in the format "dd-mm-yyyy" and defines three capture groups: one for the day, one for the month, and one for the year. You can refer to these capture groups in the replacement string using the syntax `$n`, where `n` is the index of the capture group (starting from 1).

## Typical Usage Scenarios
### Data Cleaning
Regular expressions are commonly used for data cleaning tasks, such as removing unwanted characters from a string. For example, you might want to remove all non-alphanumeric characters from a user input:
```kotlin
val input = "Hello!@# World123"
val pattern = Regex("[^a-zA-Z0-9]")
val result = pattern.replace(input, "")
println(result) // Output: HelloWorld123
```

### Formatting
You can use `Regex.replace` to format text in a specific way. For example, you might want to convert dates from the format "dd-mm-yyyy" to "yyyy/mm/dd":
```kotlin
val input = "01-02-2023"
val pattern = Regex("(\\d{2})-(\\d{2})-(\\d{4})")
val result = pattern.replace(input, "$3/$2/$1")
println(result) // Output: 2023/02/01
```

### Substitution
Regular expressions can be used to perform more complex substitutions. For example, you might want to replace all occurrences of a word with a synonym:
```kotlin
val input = "The quick brown fox jumps over the lazy dog"
val pattern = Regex("quick")
val result = pattern.replace(input, "fast")
println(result) // Output: The fast brown fox jumps over the lazy dog
```

## Code Examples
### Simple Replacement
```kotlin
fun simpleReplacement() {
    // Create a Regex object to match the word "apple"
    val pattern = Regex("apple")
    // Input string
    val input = "I like apple and banana"
    // Replace all occurrences of "apple" with "orange"
    val result = pattern.replace(input, "orange")
    println(result) // Output: I like orange and banana
}
```

### Using Capture Groups
```kotlin
fun usingCaptureGroups() {
    // Create a Regex object to match phone numbers in the format "xxx-xxx-xxxx"
    val pattern = Regex("(\\d{3})-(\\d{3})-(\\d{4})")
    // Input string
    val input = "My phone number is 123-456-7890"
    // Replace the matched phone number with the format "(xxx) xxx-xxxx"
    val result = pattern.replace(input, "($1) $2-$3")
    println(result) // Output: My phone number is (123) 456-7890
}
```

### Replacing with a Lambda
```kotlin
fun replacingWithLambda() {
    // Create a Regex object to match all digits
    val pattern = Regex("\\d")
    // Input string
    val input = "abc123def"
    // Replace each digit with its square
    val result = pattern.replace(input) { matchResult ->
        val digit = matchResult.value.toInt()
        (digit * digit).toString()
    }
    println(result) // Output: abc149def
}
```

## Best Practices
### Use Raw Strings
In Kotlin, you can use raw strings (triple-quoted strings) to avoid having to escape backslashes in regular expressions. For example:
```kotlin
val pattern = Regex("""\d{2}-\d{2}-\d{4}""")
```
This makes the regular expression more readable and easier to maintain.

### Compile Regular Expressions Once
If you need to use the same regular expression multiple times, it's a good idea to compile it once and reuse the `Regex` object. This can improve performance, especially if the regular expression is complex.

### Test Regular Expressions
Before using a regular expression in production code, it's important to test it thoroughly. You can use online tools like [Regex101](https://regex101.com/) to test your regular expressions and visualize the matches.

## Conclusion
Kotlin's `Regex.replace` function is a powerful tool for text manipulation. By understanding the core concepts, typical usage scenarios, and best practices, intermediate-to-advanced software engineers can use `Regex.replace` effectively in their projects. Whether you're cleaning data, formatting text, or performing complex substitutions, regular expressions can help you achieve your goals with less code and greater efficiency.

## References
- [Kotlin Regex Documentation](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.text/-regex/)
- [Regular-Expressions.info](https://www.regular-expressions.info/)
- [Regex101](https://regex101.com/)
---
title: "Kotlin: Converting Snake Case to Camel Case"
description: "
In software development, naming conventions play a crucial role in code readability and maintainability. Two common naming conventions are snake case and camel case. Snake case uses underscores to separate words (e.g., `user_name`), while camel case either starts with a lowercase letter (lower camel case, e.g., `userName`) or an uppercase letter (upper camel case, e.g., `UserName`).   In Kotlin, there are scenarios where you might need to convert strings from snake case to camel case, such as when dealing with data mapping between different naming conventions in APIs or databases. This blog post will explore the core concepts, typical usage scenarios, and best practices for converting snake case to camel case in Kotlin.
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
### Snake Case
Snake case is a naming convention where words are separated by underscores. It is commonly used in Python, databases, and some configuration files. For example, in a database table, column names might follow the snake case convention like `first_name`, `last_name`, etc.

### Camel Case
Camel case has two variants: lower camel case and upper camel case. Lower camel case starts with a lowercase letter, and subsequent words start with an uppercase letter. It is widely used in Java, JavaScript, and Kotlin for variable and method names. Upper camel case, also known as Pascal case, starts with an uppercase letter and is often used for class names.

### Conversion Logic
The basic logic for converting snake case to camel case involves splitting the snake case string by underscores and then capitalizing the first letter of each word except the first one.

## Typical Usage Scenarios
### Data Mapping
When working with databases or APIs that use snake case naming conventions, but your Kotlin code follows camel case, you need to convert the names for proper data mapping. For example, if a database returns a result set with column names in snake case, you might want to map them to Kotlin data classes with camel case property names.

### Configuration Files
Some configuration files use snake case for keys, but in your Kotlin application, you prefer to use camel case for better readability. Converting the keys allows for seamless integration.

## Code Examples

### Using a Custom Function
```kotlin
fun snakeToCamel(snakeCase: String): String {
    // Split the snake case string by underscores
    val parts = snakeCase.split("_")
    // Initialize a StringBuilder to build the camel case string
    val camelCase = StringBuilder()
    // Iterate through each part
    for ((index, part) in parts.withIndex()) {
        if (index == 0) {
            // Keep the first part in lowercase
            camelCase.append(part)
        } else {
            // Capitalize the first letter of subsequent parts
            camelCase.append(part.replaceFirstChar { it.uppercase() })
        }
    }
    return camelCase.toString()
}

fun main() {
    val snakeCaseString = "user_name"
    val camelCaseString = snakeToCamel(snakeCaseString)
    println("Snake case: $snakeCaseString")
    println("Camel case: $camelCaseString")
}
```
In this example, the `snakeToCamel` function takes a snake case string as input, splits it by underscores, and then builds the camel case string by capitalizing the first letter of each part except the first one.

### Using Regular Expressions
```kotlin
fun snakeToCamelRegex(snakeCase: String): String {
    // Use a regular expression to match underscores followed by a letter
    return snakeCase.replace(Regex("_([a-z])")) {
        // Replace the underscore and the following letter with the uppercase letter
        it.groupValues[1].uppercase()
    }
}

fun main() {
    val snakeCaseString = "user_name"
    val camelCaseString = snakeToCamelRegex(snakeCaseString)
    println("Snake case: $snakeCaseString")
    println("Camel case: $camelCaseString")
}
```
This example uses a regular expression to match underscores followed by a lowercase letter and replaces them with the uppercase letter, effectively converting the snake case string to camel case.

## Best Practices
- **Error Handling**: Consider adding error handling in case the input string contains invalid characters or is not in snake case format.
- **Performance**: If you are dealing with a large number of conversions, the custom function approach might be more performant than using regular expressions.
- **Code Readability**: Choose the approach that makes your code more readable and maintainable. If the conversion logic is simple, the custom function might be sufficient. If you need more complex pattern matching, regular expressions can be a good option.

## Conclusion
Converting snake case to camel case in Kotlin is a common task when dealing with different naming conventions. By understanding the core concepts, typical usage scenarios, and best practices, you can choose the most appropriate approach for your specific use case. Whether you use a custom function or regular expressions, the goal is to ensure that your code is readable, maintainable, and efficient.

## References
- Kotlin Documentation: https://kotlinlang.org/docs/home.html
- Regular Expressions in Kotlin: https://kotlinlang.org/docs/regexp.html
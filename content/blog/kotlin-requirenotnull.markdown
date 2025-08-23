---
title: "Mastering `requireNotNull` in Kotlin"
description: "
In Kotlin, null safety is one of the most powerful features that helps developers avoid the dreaded `NullPointerException` (NPE). However, there are still cases where you might expect a non - null value, but the compiler can't guarantee it. This is where the `requireNotNull` function comes in handy. `requireNotNull` is a built - in Kotlin function that allows you to assert that a value is not null at runtime. If the value is null, it throws an `IllegalArgumentException`. In this blog post, we'll explore the core concepts, typical usage scenarios, and best practices related to `requireNotNull` in Kotlin.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts of `requireNotNull`
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts of `requireNotNull`
The `requireNotNull` function is defined in the Kotlin standard library. Its signature is as follows:
```kotlin
fun <T : Any> requireNotNull(value: T?, lazyMessage: () -> Any): T
```
Here, `value` is the nullable value that you want to check for nullity. The `lazyMessage` is a lambda expression that provides an error message to be included in the `IllegalArgumentException` if the `value` is null. The function returns the non - null value of type `T` if the `value` is not null.

If you don't provide the `lazyMessage` lambda, there is an overloaded version of `requireNotNull` that uses a default error message:
```kotlin
fun <T : Any> requireNotNull(value: T?): T
```

## Typical Usage Scenarios

### Constructor Parameter Validation
When creating a class, you might expect certain constructor parameters to be non - null. You can use `requireNotNull` to ensure that these parameters are not null when an instance of the class is created.

### Function Parameter Validation
Similar to constructor parameters, you can use `requireNotNull` to validate function parameters. This helps in preventing NPEs within the function body.

### Configuration or Environment Variable Checks
When reading configuration values or environment variables, you might expect them to have non - null values. `requireNotNull` can be used to validate these values.

## Code Examples

### Constructor Parameter Validation
```kotlin
class User(val name: String, val email: String) {
    init {
        // Validate that the name is not null
        requireNotNull(name) { "Name cannot be null" }
        // Validate that the email is not null
        requireNotNull(email) { "Email cannot be null" }
    }
}

fun main() {
    try {
        // This will throw an IllegalArgumentException
        val user = User(null, "test@example.com")
    } catch (e: IllegalArgumentException) {
        println(e.message)
    }

    // This will create a valid user object
    val validUser = User("John Doe", "john.doe@example.com")
    println("Valid user created: ${validUser.name}, ${validUser.email}")
}
```
In this example, the `User` class has a constructor with two parameters: `name` and `email`. The `init` block uses `requireNotNull` to validate that both parameters are not null. If a null value is passed, an `IllegalArgumentException` is thrown.

### Function Parameter Validation
```kotlin
fun calculateLength(str: String?) {
    // Validate that the input string is not null
    val nonNullStr = requireNotNull(str) { "Input string cannot be null" }
    println("Length of the string: ${nonNullStr.length}")
}

fun main() {
    try {
        // This will throw an IllegalArgumentException
        calculateLength(null)
    } catch (e: IllegalArgumentException) {
        println(e.message)
    }

    // This will calculate the length of the string
    calculateLength("Hello, Kotlin!")
}
```
Here, the `calculateLength` function takes a nullable string as a parameter. The `requireNotNull` function is used to ensure that the input string is not null before calculating its length.

### Configuration or Environment Variable Checks
```kotlin
fun readConfigValue(): String {
    val configValue = System.getenv("MY_CONFIG_VARIABLE")
    // Validate that the environment variable is not null
    return requireNotNull(configValue) { "MY_CONFIG_VARIABLE environment variable is not set" }
}

fun main() {
    try {
        val value = readConfigValue()
        println("Config value: $value")
    } catch (e: IllegalArgumentException) {
        println(e.message)
    }
}
```
In this example, the `readConfigValue` function reads an environment variable. The `requireNotNull` function is used to ensure that the environment variable is set before returning its value.

## Best Practices

### Provide Meaningful Error Messages
When using `requireNotNull`, always provide a meaningful error message. This makes it easier to debug issues when an `IllegalArgumentException` is thrown.

### Use Early in the Function or Constructor
Validate parameters as early as possible in a function or constructor. This helps in quickly identifying the source of the problem if a null value is passed.

### Don't Overuse in Performance - Critical Sections
Since `requireNotNull` involves a null check and potential exception throwing, avoid using it in performance - critical sections of your code.

## Conclusion
The `requireNotNull` function in Kotlin is a powerful tool for runtime null validation. It helps in preventing NPEs by ensuring that values that are expected to be non - null are indeed non - null. By understanding its core concepts, typical usage scenarios, and following best practices, you can write more robust and reliable Kotlin code.

## References
- Kotlin official documentation: https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/require-not-null.html
- Effective Kotlin book by Marcin Moskala and Artur Dryomov.
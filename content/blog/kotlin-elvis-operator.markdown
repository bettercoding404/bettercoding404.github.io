---
title: "Mastering the Kotlin Elvis Operator"
description: "
In the world of Kotlin programming, null safety is a fundamental concept that helps developers write more reliable and robust code. One of the powerful tools in Kotlin's null safety arsenal is the Elvis operator (`?:`). The Elvis operator provides a concise and expressive way to handle null values, making code cleaner and more readable. In this blog post, we will explore the core concepts, typical usage scenarios, and best practices related to the Kotlin Elvis operator.
"
date: 2025-08-12
modified: 2025-08-12
---

## Table of Contents
1. [Core Concepts of the Elvis Operator](#core-concepts-of-the-elvis-operator)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
    - [Providing Default Values](#providing-default-values)
    - [Null Checks in Function Calls](#null-checks-in-function-calls)
    - [Simplifying Conditional Assignments](#simplifying-conditional-assignments)
3. [Best Practices](#best-practices)
4. [Conclusion](#conclusion)
5. [References](#references)

## Core Concepts of the Elvis Operator
The Elvis operator (`?:`) is a binary operator in Kotlin that is used to provide a default value in case the left - hand side expression evaluates to `null`. Its syntax is as follows:
```kotlin
val result = expression1 ?: expression2
```
Here, `expression1` is evaluated first. If `expression1` is not `null`, then its value is assigned to `result`. If `expression1` is `null`, then `expression2` is evaluated, and its value is assigned to `result`.

Let's look at a simple example:
```kotlin
fun main() {
    // A nullable string
    val nullableString: String? = null
    // Using the Elvis operator to provide a default value
    val nonNullableString = nullableString ?: "Default Value"
    println(nonNullableString) // Output: Default Value
}
```
In this example, since `nullableString` is `null`, the right - hand side of the Elvis operator, which is the string `"Default Value"`, is assigned to `nonNullableString`.

## Typical Usage Scenarios

### Providing Default Values
One of the most common use cases of the Elvis operator is to provide default values for nullable variables. Consider the following example where we have a function that returns a nullable integer, and we want to use a default value if the result is `null`.
```kotlin
fun getNullableInt(): Int? {
    // Simulating a null return value
    return null
}

fun main() {
    val result = getNullableInt() ?: 0
    println(result) // Output: 0
}
```
Here, if `getNullableInt()` returns `null`, the default value `0` is used.

### Null Checks in Function Calls
The Elvis operator can also be used to perform null checks before making function calls. Suppose we have a nullable object and a method that we want to call on it, but only if the object is not `null`.
```kotlin
class Person(val name: String) {
    fun sayHello() {
        println("Hello, my name is $name")
    }
}

fun main() {
    val person: Person? = null
    (person ?: return).sayHello()
    // If person is null, the function will return here
    // If person is not null, sayHello() will be called
}
```
In this example, if `person` is `null`, the `return` statement on the right - hand side of the Elvis operator is executed, and the function terminates. Otherwise, the `sayHello()` method is called on the `person` object.

### Simplifying Conditional Assignments
The Elvis operator can simplify conditional assignments. Instead of using a traditional `if - else` block to handle null values, we can use the Elvis operator.
```kotlin
fun main() {
    var nullableValue: String? = null
    var nonNullableValue: String
    // Traditional if - else approach
    if (nullableValue != null) {
        nonNullableValue = nullableValue
    } else {
        nonNullableValue = "Default"
    }
    // Using the Elvis operator
    nonNullableValue = nullableValue ?: "Default"
    println(nonNullableValue)
}
```
As you can see, the Elvis operator provides a more concise way to achieve the same result.

## Best Practices
- **Keep it Simple**: The Elvis operator is designed to handle simple null checks. Avoid using complex expressions on the right - hand side, as it can make the code hard to read. For example, instead of `val result = nullableVar ?: someFunctionWithSideEffects()`, consider using a more traditional `if - else` block if the right - hand side is complex.
- **Use for Quick Null Checks**: Use the Elvis operator when you need a quick and simple way to handle null values. It is especially useful in one - line expressions.
- **Understand the Evaluation Order**: Remember that the left - hand side of the Elvis operator is evaluated first. If the left - hand side is not `null`, the right - hand side is not evaluated.

## Conclusion
The Kotlin Elvis operator is a powerful and versatile tool for handling null values in a concise and readable way. It simplifies code by providing a straightforward mechanism for providing default values, performing null checks before function calls, and simplifying conditional assignments. By following the best practices, you can use the Elvis operator effectively in your Kotlin projects, making your code more robust and easier to maintain.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/null-safety.html
- Kotlin in Action by Dmitry Jemerov and Svetlana Isakova
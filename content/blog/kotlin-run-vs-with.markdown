---
title: "Kotlin `run` vs `with`: A Comprehensive Comparison"
description: "
Kotlin is a modern programming language that offers a rich set of built - in functions to simplify code and make it more concise. Among these functions, `run` and `with` are two widely used scope functions. They might seem similar at first glance, but they have distinct characteristics and usage scenarios. In this blog post, we will explore the core concepts of `run` and `with`, their typical usage scenarios, and best practices.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts
    - `run` Function
    - `with` Function
2. Typical Usage Scenarios
    - Using `run`
    - Using `with`
3. Code Examples
    - `run` Examples
    - `with` Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts

### `run` Function
The `run` function in Kotlin can be used in two different forms: as an extension function and as a non - extension function.

As an extension function, it takes a receiver object and allows you to call its members without explicitly referencing the receiver. The `run` function returns the result of the last expression in its lambda.

```kotlin
// run as an extension function
val result = someObject.run {
    // Inside this block, 'this' refers to someObject
    // You can call members of someObject directly
    memberFunction()
    anotherMemberProperty
}
```

As a non - extension function, `run` is used to create a new scope and can be used to initialize local variables or perform a series of operations.

```kotlin
// run as a non - extension function
val result = run {
    val localVar = someCalculation()
    localVar * 2
}
```

### `with` Function
The `with` function is a non - extension function. It takes an object as its first argument and a lambda as the second argument. Inside the lambda, you can call the members of the passed object without explicitly referencing it. The `with` function also returns the result of the last expression in its lambda.

```kotlin
val result = with(someObject) {
    // Inside this block, 'this' refers to someObject
    memberFunction()
    anotherMemberProperty
}
```

## Typical Usage Scenarios

### Using `run`
- **Null safety**: `run` is often used in combination with the safe call operator (`?.`) to perform operations on a nullable object only if it is not null.
- **Initializing and returning a value**: When you need to initialize some local variables, perform a series of operations, and then return a result, `run` can be a great choice.

### Using `with`
- **Grouping operations on an object**: When you have a series of operations to perform on a single object, `with` can make the code more concise and readable. It is especially useful when you are working with an object's properties and methods extensively.

## Code Examples

### `run` Examples

#### Null safety example
```kotlin
data class Person(val name: String, val age: Int)

fun main() {
    val person: Person? = null
    val result = person?.run {
        // This block will only execute if person is not null
        "Name: $name, Age: $age"
    }
    println(result) // Prints null
}
```

#### Initializing and returning a value
```kotlin
fun main() {
    val result = run {
        val num1 = 5
        val num2 = 10
        num1 + num2
    }
    println(result) // Prints 15
}
```

### `with` Examples

#### Grouping operations on an object
```kotlin
data class Rectangle(var width: Double, var height: Double)

fun main() {
    val rectangle = Rectangle(5.0, 10.0)
    val area = with(rectangle) {
        width *= 2
        height *= 3
        width * height
    }
    println(area) // Prints 300.0
}
```

## Best Practices
- **Use `run` for null safety**: When dealing with nullable objects, `run` combined with the safe call operator is a clear and concise way to handle null cases.
- **Choose `with` for readability**: If you have a series of operations on a non - nullable object, `with` can make the code more readable by reducing the need to repeat the object reference.
- **Avoid overusing scope functions**: While scope functions can make the code more concise, overusing them can make the code hard to understand. Use them only when they truly simplify the code.

## Conclusion
In conclusion, both `run` and `with` are powerful scope functions in Kotlin. `run` is more versatile as it can be used as an extension function and is great for null safety. `with` is a non - extension function that excels at grouping operations on a single object. By understanding their core concepts, typical usage scenarios, and following the best practices, you can effectively use these functions to write more concise and readable Kotlin code.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/reference/scope-functions.html
- "Kotlin in Action" by Dmitry Jemerov and Svetlana Isakova.
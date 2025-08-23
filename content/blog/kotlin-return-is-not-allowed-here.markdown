---
title: "Understanding Kotlin return is not allowed here"
description: "
Kotlin is a modern, concise, and expressive programming language that offers a wide range of features to make software development more efficient. However, one common error that developers may encounter is the return is not allowed here message. This error typically occurs when you try to use the `return` keyword in a context where it is not permitted. In this blog post, we will explore the core concepts behind this error, look at typical usage scenarios, and discuss best practices to avoid or handle it.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts
2. Typical Usage Scenarios
    - Returning from Inner Functions
    - Returning from Lambdas
3. Best Practices
    - Using Labels
    - Refactoring Code
4. Conclusion
5. References

## Core Concepts
In Kotlin, the `return` keyword is used to exit a function and return a value. However, its usage is restricted by the scope in which it is used. A `return` statement can only be used inside a function or a lambda expression that is used as a function literal. When you try to use `return` outside of these valid scopes, the compiler will throw the "return is not allowed here" error.

## Typical Usage Scenarios

### Returning from Inner Functions
Consider the following code example:

```kotlin
fun outerFunction() {
    fun innerFunction() {
        // This return statement is valid as it is inside a function
        return
    }
    // This return statement is also valid as it is inside the outer function
    return
}
```

In the above code, both `return` statements are valid because they are used inside functions. However, if you try to use `return` outside of a function, you will get an error:

```kotlin
// This will result in "return is not allowed here" error
return
```

### Returning from Lambdas
Lambdas in Kotlin are a way to create anonymous functions. By default, a `return` statement in a lambda will return from the enclosing function. Consider the following example:

```kotlin
fun processList(list: List<Int>) {
    list.forEach {
        if (it == 5) {
            // This return will return from the processList function
            return
        }
        println(it)
    }
    println("End of processing")
}

fun main() {
    val numbers = listOf(1, 2, 3, 4, 5, 6)
    processList(numbers)
}
```

In the above code, when the lambda encounters the number 5, the `return` statement will return from the `processList` function, and the "End of processing" message will not be printed.

## Best Practices

### Using Labels
To return from a lambda without returning from the enclosing function, you can use labels. A label is a name followed by the `@` symbol. Consider the following example:

```kotlin
fun processListWithLabel(list: List<Int>) {
    list.forEach lit@{
        if (it == 5) {
            // This return will return from the lambda
            return@lit
        }
        println(it)
    }
    println("End of processing")
}

fun main() {
    val numbers = listOf(1, 2, 3, 4, 5, 6)
    processListWithLabel(numbers)
}
```

In the above code, the `return@lit` statement will return from the lambda, and the "End of processing" message will be printed.

### Refactoring Code
If you find yourself struggling with the `return` statements in a complex lambda, it may be a sign that your code needs refactoring. You can extract the lambda into a separate function to make the code more readable and maintainable. Consider the following example:

```kotlin
fun processNumber(num: Int): Boolean {
    if (num == 5) {
        return false
    }
    println(num)
    return true
}

fun processListRefactored(list: List<Int>) {
    list.forEach {
        if (!processNumber(it)) {
            return@forEach
        }
    }
    println("End of processing")
}

fun main() {
    val numbers = listOf(1, 2, 3, 4, 5, 6)
    processListRefactored(numbers)
}
```

In the above code, the logic of processing a single number is extracted into a separate function `processNumber`. This makes the code more modular and easier to understand.

## Conclusion
The "Kotlin return is not allowed here" error is a common error that occurs when you try to use the `return` keyword in an invalid scope. By understanding the core concepts, typical usage scenarios, and best practices, you can avoid or handle this error effectively. Using labels and refactoring your code can make your Kotlin code more readable and maintainable.

## References
- Kotlin Documentation: https://kotlinlang.org/docs/reference/
- Kotlin in Action by Dmitry Jemerov and Svetlana Isakova
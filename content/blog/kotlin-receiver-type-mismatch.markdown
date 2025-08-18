---
title: "Kotlin Receiver Type Mismatch: Understanding, Scenarios, and Best Practices"
description: "
In Kotlin, the concept of receivers is fundamental when dealing with extension functions, property accessors, and more. A receiver can be thought of as an implicit `this` object that a function or property operates on. However, a receiver type mismatch can occur when the actual type of the receiver object doesn't match the expected type in the context of a function or property call. This blog post aims to provide a comprehensive understanding of Kotlin receiver type mismatch, including its core concepts, typical usage scenarios, and best practices.
"
date: 2025-08-18
modified: 2025-08-18
---

## Table of Contents
1. **Core Concepts**
    - What are Receivers in Kotlin?
    - Understanding Receiver Type Mismatch
2. **Typical Usage Scenarios**
    - Extension Functions and Receiver Type Mismatch
    - Lambda Expressions with Receivers
3. **Code Examples**
    - Example of Receiver Type Mismatch in Extension Functions
    - Resolving Receiver Type Mismatch
4. **Best Practices**
    - Type Checking and Casting
    - Using Generic Receivers
5. **Conclusion**
6. **References**

## Core Concepts

### What are Receivers in Kotlin?
In Kotlin, a receiver is an object on which a function or property is invoked. There are two main types of receivers:
- **Extension Receivers**: Used in extension functions and properties. An extension function allows you to add new functionality to an existing class without inheriting from it. For example:
```kotlin
// Extension function with a receiver of type String
fun String.printLength() {
    println("The length of this string is ${this.length}")
}

fun main() {
    val str = "Hello"
    str.printLength() // Here, 'str' is the receiver object
}
```
- **Dispatch Receivers**: Used in nested classes and interfaces. A dispatch receiver determines the object on which the member function is called.

### Understanding Receiver Type Mismatch
Receiver type mismatch occurs when the type of the receiver object passed to a function or property doesn't match the expected type declared in the function or property definition. This can lead to compilation errors or runtime exceptions if not handled properly.

## Typical Usage Scenarios

### Extension Functions and Receiver Type Mismatch
Extension functions are a common source of receiver type mismatch. Consider the following example:
```kotlin
fun Int.doubleValue(): Int {
    return this * 2
}

fun main() {
    val num: Double = 3.0
    // This will cause a compilation error because the receiver type is Int
    // num.doubleValue() 
}
```
In this example, the `doubleValue` extension function expects an `Int` receiver, but we are trying to call it on a `Double` object, resulting in a receiver type mismatch.

### Lambda Expressions with Receivers
Lambda expressions can also have receivers. For example, in Kotlin, the `apply` function uses a lambda with a receiver:
```kotlin
class Person {
    var name: String = ""
    var age: Int = 0
}

fun main() {
    val person = Person()
    // This lambda has a receiver of type Person
    person.apply {
        name = "John"
        age = 30
    }

    // If we try to use a different type as a receiver, it will cause a type mismatch
    // val number = 10
    // number.apply {
    //     name = "John" // Compilation error: 'name' is not a member of Int
    // }
}
```

## Code Examples

### Example of Receiver Type Mismatch in Extension Functions
```kotlin
// Extension function for List<Int>
fun List<Int>.sumElements(): Int {
    var sum = 0
    for (element in this) {
        sum += element
    }
    return sum
}

fun main() {
    val listOfStrings: List<String> = listOf("a", "b", "c")
    // This will cause a compilation error because the receiver type is List<Int>
    // listOfStrings.sumElements() 
}
```

### Resolving Receiver Type Mismatch
We can resolve the receiver type mismatch by ensuring that the receiver object has the correct type. One way to do this is by type checking and casting:
```kotlin
fun List<Int>.sumElements(): Int {
    var sum = 0
    for (element in this) {
        sum += element
    }
    return sum
}

fun main() {
    val list: List<Any> = listOf(1, 2, 3)
    if (list is List<Int>) {
        val sum = list.sumElements()
        println("The sum is $sum")
    }
}
```

## Best Practices

### Type Checking and Casting
As shown in the previous example, type checking and casting can be used to ensure that the receiver object has the correct type before calling a function or property. This helps to avoid compilation errors and runtime exceptions.

### Using Generic Receivers
Generic receivers can be used to make functions more flexible. For example:
```kotlin
fun <T> List<T>.printSize() {
    println("The size of the list is ${this.size}")
}

fun main() {
    val listOfInts = listOf(1, 2, 3)
    val listOfStrings = listOf("a", "b", "c")
    listOfInts.printSize()
    listOfStrings.printSize()
}
```
In this example, the `printSize` function can accept a list of any type as a receiver.

## Conclusion
Receiver type mismatch is an important concept to understand in Kotlin, especially when working with extension functions and lambda expressions with receivers. By being aware of the expected receiver types and using best practices such as type checking, casting, and generic receivers, we can avoid compilation errors and write more robust code.

## References
- Kotlin Documentation: https://kotlinlang.org/docs/home.html
- "Kotlin in Action" by Dmitry Jemerov and Svetlana Isakova

This blog post should help intermediate-to-advanced software engineers gain a better understanding of Kotlin receiver type mismatch and how to apply it effectively in their projects.
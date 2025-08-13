---
title: "Kotlin Property Reference: A Deep Dive"
description: "
In Kotlin, property references are a powerful feature that allows you to refer to a property without actually accessing its value. This concept is similar to function references in Kotlin, but instead of referring to a function, you are referring to a property. Property references can be used in a variety of scenarios, such as passing a property as an argument to a function, using it in higher - order functions, or for reflection purposes. This blog post will explore the core concepts, typical usage scenarios, and best practices related to Kotlin property references.
"
date: 2025-08-13
modified: 2025-08-13
---

## Table of Contents
1. [Core Concepts](#core-concepts)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Best Practices](#best-practices)
4. [Conclusion](#conclusion)
5. [References](#references)

## Core Concepts
### Syntax
The basic syntax for a property reference in Kotlin is `::propertyName`. Here is a simple example:
```kotlin
// Define a class
class Person(val name: String, var age: Int)

fun main() {
    // Create a property reference to the 'age' property of the Person class
    val ageProperty = Person::age
    println(ageProperty.name) // Output: age
}
```
In this example, `Person::age` creates a reference to the `age` property of the `Person` class. The `name` property of the property reference gives the name of the referenced property.

### Bound and Unbound References
- **Unbound References**: An unbound property reference is a reference to a property without an instance. It can be used to get or set the property value on any instance of the class.
```kotlin
class Rectangle(var width: Int, var height: Int)

fun main() {
    val widthProperty = Rectangle::width
    val rect = Rectangle(10, 20)
    // Get the value using the property reference
    println(widthProperty.get(rect)) // Output: 10
    // Set the value using the property reference
    widthProperty.set(rect, 30)
    println(rect.width) // Output: 30
}
```
- **Bound References**: A bound property reference is a reference to a property on a specific instance.
```kotlin
class Circle(var radius: Double)

fun main() {
    val circle = Circle(5.0)
    val radiusProperty = circle::radius
    println(radiusProperty.get()) // Output: 5.0
    radiusProperty.set(7.0)
    println(circle.radius) // Output: 7.0
}
```

## Typical Usage Scenarios
### Using in Higher - Order Functions
Property references can be used as arguments in higher - order functions. For example, you can use them with the `sortedBy` function to sort a list based on a specific property.
```kotlin
data class Book(val title: String, val price: Double)

fun main() {
    val books = listOf(
        Book("Book A", 20.0),
        Book("Book B", 15.0),
        Book("Book C", 25.0)
    )
    val sortedBooks = books.sortedBy(Book::price)
    sortedBooks.forEach { println(it.title) }
    // Output:
    // Book B
    // Book A
    // Book C
}
```

### Reflection
Property references can be used for reflection purposes. You can access metadata about a property, such as its name, type, and annotations.
```kotlin
import kotlin.reflect.full.findAnnotation

annotation class Important

class MyClass(@Important var myProperty: String)

fun main() {
    val myPropertyRef = MyClass::myProperty
    val annotation = myPropertyRef.findAnnotation<Important>()
    println(annotation != null) // Output: true
}
```

## Best Practices
- **Use Descriptive Names**: When creating property references, use descriptive names that clearly indicate what property they refer to. This makes the code more readable and maintainable.
- **Avoid Overusing Reflection**: While property references can be used for reflection, overusing reflection can lead to performance issues and make the code harder to understand. Use reflection only when necessary.
- **Understand Bound and Unbound References**: Make sure you understand the difference between bound and unbound references. Use the appropriate type of reference based on your use case.

## Conclusion
Kotlin property references are a powerful feature that provides a flexible way to refer to properties. They can be used in various scenarios, such as higher - order functions and reflection. By understanding the core concepts, typical usage scenarios, and best practices, intermediate - to - advanced software engineers can effectively use property references in their Kotlin code to make it more concise and expressive.

## References
- Kotlin Official Documentation: https://kotlinlang.org/docs/reference/reflection.html
- "Kotlin in Action" by Dmitry Jemerov and Svetlana Isakova.
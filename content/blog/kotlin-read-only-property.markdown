---
title: "Understanding Kotlin Read - Only Properties"
description: "
In Kotlin, read - only properties play a crucial role in writing robust and maintainable code. They provide a way to encapsulate data in a class or object, allowing access to the data without the risk of accidental modification. This is particularly useful in scenarios where data integrity needs to be maintained, such as configuration settings, constants, or immutable data models. In this blog post, we will explore the core concepts, typical usage scenarios, and best practices related to Kotlin read - only properties.
"
date: 2025-08-18
modified: 2025-08-18
---

## Table of Contents
1. Core Concepts of Read - Only Properties
2. Typical Usage Scenarios
3. Best Practices
4. Code Examples
5. Conclusion
6. References

## Core Concepts of Read - Only Properties
In Kotlin, a read - only property is declared using the `val` keyword, as opposed to the `var` keyword which is used for mutable properties. Once a `val` property is initialized, its value cannot be changed. 

Under the hood, a `val` property has a getter method, but no setter method. This means that external code can access the property's value, but cannot modify it directly. 

```kotlin
class Person {
    // Read - only property
    val name: String = "John"
}

fun main() {
    val person = Person()
    // We can access the read - only property
    println(person.name) 
    // The following line would cause a compilation error
    // person.name = "Jane" 
}
```
In the above example, the `name` property of the `Person` class is read - only. We can access its value using the dot notation, but attempting to assign a new value to it will result in a compilation error.

## Typical Usage Scenarios

### Configuration Settings
When an application has certain configuration settings that should not be changed during the runtime, read - only properties are a great choice. For example, in a web application, the base URL of an API might be a configuration setting that remains constant throughout the application's lifecycle.

```kotlin
class ApiConfig {
    val baseUrl: String = "https://api.example.com"
}

fun main() {
    val config = ApiConfig()
    println(config.baseUrl)
}
```

### Immutable Data Models
In functional programming and data - centric applications, immutable data models are often used to ensure data consistency and thread - safety. Read - only properties are used to define the fields of these immutable data models.

```kotlin
data class Book(val title: String, val author: String)

fun main() {
    val book = Book("Kotlin in Action", "Dmitry Jemerov")
    println(book.title)
    // The following line would cause a compilation error
    // book.title = "Another Book" 
}
```

### Constants
Kotlin allows the use of `const` modifier with `val` properties at the top - level or in companion objects to define compile - time constants.

```kotlin
const val PI: Double = 3.14159265359

class Circle {
    companion object {
        const val MAX_RADIUS: Int = 100
    }
}

fun main() {
    println(PI)
    println(Circle.MAX_RADIUS)
}
```

## Best Practices

### Initialization
It is important to initialize read - only properties properly. A `val` property must be initialized either at the point of declaration or in the primary constructor. If you need to initialize it later, you can use the `lateinit` modifier (for non - null types) or use a custom getter.

```kotlin
class LazyInitExample {
    lateinit var lazyProperty: String

    fun initProperty() {
        lazyProperty = "Initialized value"
    }
}

class CustomGetterExample {
    val customProperty: Int
        get() = 42
}
```

### Use `const` for Compile - Time Constants
When defining constants that are known at compile - time, use the `const` modifier. This ensures that the constant is inlined at the call site, which can lead to better performance.

### Keep the Scope Narrow
Limit the scope of read - only properties as much as possible. If a property is only used within a single class or function, declare it within that scope. This improves code readability and maintainability.

## Code Examples

### Read - Only Property with a Custom Getter
```kotlin
class Rectangle(val width: Int, val height: Int) {
    // Read - only property with a custom getter
    val area: Int
        get() = width * height
}

fun main() {
    val rectangle = Rectangle(5, 10)
    println(rectangle.area)
}
```

### Read - Only Property in a Singleton
```kotlin
object AppSettings {
    val defaultTimeout: Long = 5000
}

fun main() {
    println(AppSettings.defaultTimeout)
}
```

## Conclusion
Kotlin read - only properties are a powerful feature that helps in writing more secure, maintainable, and efficient code. By using `val` properties, we can ensure data integrity, prevent accidental modifications, and follow best practices in software development. Whether it's for configuration settings, immutable data models, or constants, read - only properties are an essential part of Kotlin programming.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/reference/properties.html
- "Kotlin in Action" by Dmitry Jemerov and Svetlana Isakova
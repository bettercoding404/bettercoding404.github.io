---
title: "Kotlin Setter for Constructor Parameter"
description: "
In Kotlin, constructor parameters are a fundamental part of creating objects. While they provide a straightforward way to initialize an object's properties, sometimes you may need more control over how these properties are set. This is where custom setters for constructor parameters come into play. Custom setters allow you to define custom logic that will be executed every time a property is assigned a new value. In this blog post, we will explore the core concepts, typical usage scenarios, and best practices related to Kotlin setters for constructor parameters.
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
### Constructor Parameters in Kotlin
In Kotlin, constructor parameters can be used to initialize properties of a class. There are two types of constructor parameters: primary and secondary. Primary constructor parameters are defined in the class header, while secondary constructor parameters are defined inside the class body.

```kotlin
// Primary constructor
class Person(val name: String, var age: Int)

// Secondary constructor
class Animal {
    var species: String
    var age: Int

    constructor(species: String, age: Int) {
        this.species = species
        this.age = age
    }
}
```

### Setters in Kotlin
A setter is a method that is used to set the value of a property. In Kotlin, you can define a custom setter for a property by using the `set` keyword. When a custom setter is defined, the code inside the setter will be executed every time the property is assigned a new value.

```kotlin
class Rectangle(var width: Int, var height: Int) {
    var area: Int
        get() = width * height
        set(value) {
            // Calculate new width and height based on the new area
            width = value / height
        }
}
```

### Setter for Constructor Parameter
You can define a custom setter for a constructor parameter just like you would for any other property. This allows you to add custom logic to the assignment of the constructor parameter.

```kotlin
class Temperature(var celsius: Double) {
    var celsius: Double
        set(value) {
            if (value < -273.15) {
                throw IllegalArgumentException("Temperature cannot be below absolute zero.")
            }
            field = value
        }
}
```

## Typical Usage Scenarios
### Input Validation
One of the most common use cases for a custom setter on a constructor parameter is input validation. You can use the setter to ensure that the value assigned to the property meets certain criteria.

```kotlin
class User(var email: String) {
    var email: String
        set(value) {
            if (!value.contains("@")) {
                throw IllegalArgumentException("Invalid email address.")
            }
            field = value
        }
}
```

### Data Transformation
You can use a custom setter to transform the data before storing it in the property. For example, you might want to convert a string to uppercase or round a number to a certain precision.

```kotlin
class Product(var name: String) {
    var name: String
        set(value) {
            field = value.toUpperCase()
        }
}
```

### Side Effects
A custom setter can also be used to perform side effects when the property is assigned a new value. For example, you might want to log the change or update another property.

```kotlin
class Counter(var count: Int) {
    var count: Int
        set(value) {
            println("Count changed from $field to $value")
            field = value
        }
}
```

## Code Examples
### Input Validation Example
```kotlin
// Define a class with a constructor parameter and a custom setter for input validation
class Password(var password: String) {
    var password: String
        set(value) {
            if (value.length < 8) {
                throw IllegalArgumentException("Password must be at least 8 characters long.")
            }
            field = value
        }
}

fun main() {
    try {
        // This will throw an exception
        val userPassword = Password("abc")
    } catch (e: IllegalArgumentException) {
        println(e.message)
    }

    // This will work
    val validPassword = Password("abcdefgh")
    println("Valid password set: ${validPassword.password}")
}
```

### Data Transformation Example
```kotlin
// Define a class with a constructor parameter and a custom setter for data transformation
class FullName(var name: String) {
    var name: String
        set(value) {
            field = value.split(" ").map { it.capitalize() }.joinToString(" ")
        }
}

fun main() {
    val person = FullName("john doe")
    println("Formatted name: ${person.name}")
}
```

### Side Effects Example
```kotlin
// Define a class with a constructor parameter and a custom setter for side effects
class Account(var balance: Double) {
    var balance: Double
        set(value) {
            if (value < 0) {
                println("Warning: Account balance is negative!")
            }
            field = value
        }
}

fun main() {
    val account = Account(100.0)
    account.balance = -50.0
    println("Account balance: ${account.balance}")
}
```

## Best Practices
### Keep the Setter Simple
The setter should have a single responsibility. Avoid putting too much complex logic inside the setter. If you need to perform complex operations, consider moving the logic to a separate method.

### Use the `field` Keyword
The `field` keyword in Kotlin refers to the backing field of the property. Use it to access and modify the actual value stored in the property.

### Follow the Principle of Least Surprise
The behavior of the setter should be predictable. Users of the class should not be surprised by the behavior of the setter when they assign a value to the property.

## Conclusion
Kotlin setters for constructor parameters provide a powerful way to add custom logic to the assignment of properties. They are useful for input validation, data transformation, and performing side effects. By following the best practices, you can ensure that your setters are simple, predictable, and easy to maintain.

## References
- Kotlin Documentation: https://kotlinlang.org/docs/properties.html
- Effective Kotlin: https://www.amazon.com/Effective-Kotlin-Best-Practices-Developers/dp/161729529X
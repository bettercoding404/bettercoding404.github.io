---
title: "Kotlin Set Visibility: A Comprehensive Guide"
description: "
In Kotlin, set visibility is a crucial aspect of encapsulation, which is one of the fundamental principles of object - oriented programming. It allows developers to control how and where the setter methods of properties can be accessed. By setting appropriate visibility for setters, we can ensure that the internal state of an object is modified in a controlled and safe manner. This blog post aims to provide an in - depth understanding of Kotlin set visibility, including core concepts, typical usage scenarios, and best practices.
"
date: 2025-08-24
modified: 2025-08-24
---

## Table of Contents
1. Core Concepts of Kotlin Set Visibility
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts of Kotlin Set Visibility
In Kotlin, a property can have a getter and a setter. By default, both the getter and setter have the same visibility as the property itself. However, Kotlin allows us to change the visibility of the setter independently.

Kotlin provides several visibility modifiers that can be applied to setters:
- **public**: This is the default visibility. A public setter can be accessed from anywhere in the codebase where the property is accessible.
- **private**: A private setter can only be accessed within the class or file where the property is declared.
- **protected**: A protected setter can be accessed within the class where the property is declared and its sub - classes.
- **internal**: An internal setter can be accessed from anywhere within the same module.

## Typical Usage Scenarios
### 1. Encapsulation and Data Integrity
When we want to ensure that the internal state of an object is not modified in an inappropriate way, we can use a private or protected setter. For example, if we have a `User` class with an `age` property, we may want to restrict the direct modification of the `age` to only within the class to validate the input.

### 2. Module - Level Access
In a multi - module project, we may want to allow only classes within the same module to modify a property. An internal setter can be used in such cases.

### 3. Sub - class Customization
A protected setter allows sub - classes to modify a property while still restricting external access. This can be useful when we want to provide some level of customization to sub - classes.

## Code Examples

### Example 1: Private Setter for Data Integrity
```kotlin
class User {
    // The age property with a private setter
    var age: Int = 0
        private set

    // Method to set the age with validation
    fun setAge(newAge: Int) {
        if (newAge >= 0) {
            field = newAge
        } else {
            println("Age cannot be negative.")
        }
    }
}

fun main() {
    val user = User()
    // This will not compile because the setter is private
    // user.age = -5 

    user.setAge(25)
    println(user.age) 
}
```
In this example, the `age` property has a private setter. We cannot directly assign a value to `age` from outside the class. Instead, we use the `setAge` method which includes validation to ensure that the age is non - negative.

### Example 2: Internal Setter for Module - Level Access
```kotlin
// Assume this code is in a module
internal class Config {
    var maxConnections: Int = 10
        internal set
}

// This code is also in the same module
fun accessConfig() {
    val config = Config()
    config.maxConnections = 20
    println(config.maxConnections)
}
```
In this example, the `maxConnections` property has an internal setter. It can be modified from anywhere within the same module.

### Example 3: Protected Setter for Sub - class Customization
```kotlin
open class Shape {
    protected var color: String = "red"
        protected set
}

class Circle : Shape() {
    fun changeColor(newColor: String) {
        color = newColor
    }
}

fun main() {
    val circle = Circle()
    circle.changeColor("blue")
    // We cannot directly access or modify color from here
    // println(circle.color) 
}
```
Here, the `color` property in the `Shape` class has a protected setter. The `Circle` sub - class can modify the `color` property using the `changeColor` method, but external code cannot directly access or modify it.

## Best Practices
- **Use Private Setters for Validation**: When a property needs to be validated before assignment, use a private setter and provide a public method for setting the value with proper validation logic.
- **Be Careful with Public Setters**: Public setters can expose the internal state of an object and may lead to unexpected behavior. Only use public setters when it is absolutely necessary.
- **Follow the Principle of Least Privilege**: Always assign the most restrictive visibility to a setter that still allows the required functionality.

## Conclusion
Kotlin set visibility is a powerful feature that enhances encapsulation and data integrity. By understanding the core concepts, typical usage scenarios, and best practices, developers can effectively control how properties are modified in their applications. Whether it's ensuring data integrity, restricting access within a module, or allowing sub - class customization, set visibility provides the flexibility needed for robust software development.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/properties.html
- "Effective Kotlin" by Marcin Moskala, which provides in - depth knowledge about Kotlin best practices. 
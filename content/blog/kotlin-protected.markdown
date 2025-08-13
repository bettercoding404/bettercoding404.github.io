---
title: "Understanding Kotlin `protected`"
description: "
In Kotlin, access modifiers play a crucial role in controlling the visibility and accessibility of classes, properties, and functions. One such access modifier is `protected`. The `protected` modifier in Kotlin provides a level of access that is more restricted than `public` but more permissive than `private`. It allows members of a class to be accessed within the class itself, its sub - classes, and the same package. This blog post aims to explore the core concepts, typical usage scenarios, and best practices related to the `protected` access modifier in Kotlin.
"
date: 2025-08-13
modified: 2025-08-13
---

## Table of Contents
1. Core Concepts of `protected` in Kotlin
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts of `protected` in Kotlin
- **Visibility Scope**: A `protected` member (property or function) of a class is visible within the class where it is declared, all its sub - classes, and the same package. This means that if you have a base class with a `protected` member, any derived class can access that member, regardless of the package in which the derived class is located. However, non - sub - class entities outside the package cannot access the `protected` member.
- **Inheritance and Access**: When a class inherits from another class with `protected` members, the sub - class can use those members as if they were its own. This is useful for providing a certain level of encapsulation while still allowing sub - classes to build on the functionality of the base class.

## Typical Usage Scenarios
### 1. Code Reusability and Extension
When you want to create a base class with some common functionality that you expect sub - classes to use and potentially extend. For example, a base `Shape` class might have a `protected` method for calculating the area that can be used and overridden by sub - classes like `Circle` and `Rectangle`.

### 2. Encapsulation with Flexibility
You can use the `protected` modifier to hide the implementation details of a class from the outside world while still allowing sub - classes to access and modify certain aspects. For instance, a base `DatabaseConnection` class might have a `protected` property for the database connection string, which can be accessed and modified by sub - classes that need to customize the connection.

## Code Examples

### Example 1: Basic Usage of `protected` in Inheritance
```kotlin
// Base class
open class Animal {
    // Protected property
    protected var energy: Int = 100

    // Protected function
    protected fun makeSound() {
        println("Generic animal sound")
    }

    fun play() {
        energy -= 10
        makeSound()
        println("Energy left: $energy")
    }
}

// Sub - class
class Dog : Animal() {
    override fun makeSound() {
        super.makeSound()
        println("Woof!")
    }

    fun bark() {
        // Accessing protected property
        if (energy > 20) {
            makeSound()
        } else {
            println("Too tired to bark")
        }
    }
}

fun main() {
    val dog = Dog()
    dog.play()
    dog.bark()
}
```
In this example, the `energy` property and `makeSound` function in the `Animal` class are declared as `protected`. The `Dog` class, which inherits from `Animal`, can access and override the `makeSound` function and access the `energy` property.

### Example 2: `protected` in Package - Level Access
```kotlin
// File: base.kt
package com.example.base

open class BaseClass {
    protected fun protectedFunction() {
        println("This is a protected function")
    }
}

// File: sub.kt
package com.example.base

class SubClass : BaseClass() {
    fun callProtected() {
        protectedFunction()
    }
}

// File: main.kt
package com.example.main

import com.example.base.SubClass

fun main() {
    val sub = SubClass()
    // This will not compile because protectedFunction is not directly accessible here
    // sub.protectedFunction() 
    sub.callProtected()
}
```
In this example, the `protectedFunction` in the `BaseClass` is accessible within the `SubClass` (since it's a sub - class) and within the same package. The `main` function in a different package cannot directly access the `protectedFunction` but can call the `callProtected` function in the `SubClass`.

## Best Practices
- **Limit Over - Exposing**: Only use the `protected` modifier when you really need to provide access to sub - classes. Avoid making too many members `protected` as it can break the encapsulation principle.
- **Document Intention**: Clearly document the purpose of `protected` members in your code. This helps other developers understand why certain members are made `protected` and how they should be used.
- **Use with Inheritance in Mind**: When designing a base class with `protected` members, think about how sub - classes might use and extend those members. Ensure that the `protected` members provide a useful and coherent set of functionality for sub - classes.

## Conclusion
The `protected` access modifier in Kotlin is a powerful tool for achieving a balance between encapsulation and flexibility. It allows you to share certain functionality and data between a base class and its sub - classes while hiding them from the outside world. By understanding the core concepts, typical usage scenarios, and best practices, you can use the `protected` modifier effectively in your Kotlin projects.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/visibility-modifiers.html
- "Kotlin in Action" by Dmitry Jemerov and Svetlana Isakova
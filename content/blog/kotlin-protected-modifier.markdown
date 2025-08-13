---
title: "Understanding the Kotlin `protected` Modifier"
description: "
In object - oriented programming, access modifiers play a crucial role in controlling the visibility and accessibility of class members. Kotlin, a modern programming language for the JVM, Android, and other platforms, provides several access modifiers, including `protected`. The `protected` modifier in Kotlin offers a middle - ground between the more restrictive `private` and the more permissive `public` access levels. It allows a class member to be accessed within the class itself, its subclasses, and also within the same package. This blog post will delve deep into the core concepts, typical usage scenarios, and best practices related to the Kotlin `protected` modifier.
"
date: 2025-08-13
modified: 2025-08-13
---

## Table of Contents
1. Core Concepts of the `protected` Modifier
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts of the `protected` Modifier
### Visibility Rules
- **Within the Class**: A `protected` member (property or function) can be accessed from anywhere within the class in which it is declared.
- **Subclasses**: Subclasses of the class that declares a `protected` member can access that member. This is useful for providing a level of encapsulation while still allowing subclasses to build upon the functionality of the superclass.
- **Same Package**: In addition to subclasses, a `protected` member can also be accessed from other classes within the same package. This is different from Java, where `protected` members are only accessible from subclasses and not from other classes in the same package.

### Comparison with Other Access Modifiers
- **`private`**: A `private` member is only accessible within the class where it is declared. It offers the highest level of encapsulation and restricts access to the internal implementation details of a class.
- **`public`**: A `public` member is accessible from anywhere. It is used when you want to expose the functionality of a class to other parts of the program.
- **`internal`**: An `internal` member is accessible within the same module. It is a Kotlin - specific access modifier that provides a way to limit access to code within a module.

## Typical Usage Scenarios
### Inheritance and Code Reusability
When designing a class hierarchy, the `protected` modifier can be used to expose certain members to subclasses without making them publicly available. For example, a base class might have some utility methods that are only relevant for its subclasses. By making these methods `protected`, subclasses can reuse this code while the external codebase cannot access these methods directly.

### Package - Level Encapsulation
In a package, you might have a set of related classes. The `protected` modifier can be used to share some members between these classes while still keeping them hidden from the outside world. This helps in maintaining a clean and modular code structure.

## Code Examples

### Example 1: Accessing `protected` Members in Subclasses
```kotlin
// Base class
open class Animal {
    // Protected property
    protected var energy: Int = 100

    // Protected method
    protected fun makeSound() {
        println("Some generic animal sound")
    }
}

// Subclass
class Dog : Animal() {
    fun bark() {
        // Accessing protected property
        energy -= 10
        println("Dog barked! Energy left: $energy")
        // Accessing protected method
        makeSound()
    }
}

fun main() {
    val dog = Dog()
    dog.bark()
    // The following line would cause a compilation error
    // println(dog.energy) 
}
```
In this example, the `energy` property and the `makeSound` method in the `Animal` class are declared as `protected`. The `Dog` class, which is a subclass of `Animal`, can access these members. However, trying to access the `energy` property directly from the `main` function results in a compilation error.

### Example 2: Accessing `protected` Members in the Same Package
```kotlin
// File 1: BaseClass.kt
package com.example

open class BaseClass {
    protected fun printMessage() {
        println("This is a protected message")
    }
}

// File 2: AnotherClass.kt
package com.example

class AnotherClass {
    fun accessProtected() {
        val base = BaseClass()
        // Accessing protected method from the same package
        base.printMessage()
    }
}

// File 3: Main.kt
package com.example

fun main() {
    val another = AnotherClass()
    another.accessProtected()
}
```
In this example, the `printMessage` method in the `BaseClass` is `protected`. The `AnotherClass` in the same package can access this method, demonstrating the package - level accessibility of `protected` members.

## Best Practices
### Limit the Scope of `protected` Members
Only make members `protected` if they are truly needed by subclasses or other classes in the same package. Overusing the `protected` modifier can lead to a lack of encapsulation and make the code harder to maintain.

### Document `protected` Members
Since `protected` members are accessible to subclasses and classes in the same package, it is important to document their purpose and usage. This helps other developers understand how to use these members correctly.

### Use `protected` for Implementation Details
`protected` members are a good way to expose implementation details to subclasses without making them public. This allows subclasses to build upon the existing functionality while keeping the external API clean.

## Conclusion
The Kotlin `protected` modifier is a powerful tool for controlling access to class members. It provides a balance between encapsulation and code reuse, allowing subclasses to access certain members while still keeping them hidden from the outside world. By understanding the core concepts, typical usage scenarios, and best practices, intermediate - to - advanced software engineers can use the `protected` modifier effectively in their Kotlin projects.

## References
- Kotlin Documentation: https://kotlinlang.org/docs/visibility-modifiers.html
- Effective Java by Joshua Bloch (for general principles of access modifiers in object - oriented programming)
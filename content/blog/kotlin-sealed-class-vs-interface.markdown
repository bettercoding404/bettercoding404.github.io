---
title: "Kotlin Sealed Class vs Interface"
description: "
In Kotlin, both sealed classes and interfaces are powerful language features that play crucial roles in designing object - oriented and functional programming structures. They provide different ways to define contracts and hierarchies in your code. Understanding the differences between sealed classes and interfaces, their core concepts, typical usage scenarios, and best practices can significantly improve your Kotlin programming skills. This blog post aims to explore these aspects in detail, helping intermediate - to - advanced software engineers make informed decisions when choosing between them.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts
    - Sealed Classes
    - Interfaces
2. Typical Usage Scenarios
    - Sealed Classes
    - Interfaces
3. Code Examples
    - Sealed Class Example
    - Interface Example
4. Best Practices
    - When to Use Sealed Classes
    - When to Use Interfaces
5. Conclusion
6. References

## Core Concepts

### Sealed Classes
A sealed class in Kotlin is a special kind of abstract class that restricts the hierarchy of its subclasses. All subclasses of a sealed class must be declared in the same file as the sealed class itself. This means that the set of possible subclasses is known at compile - time. Sealed classes are useful when you have a fixed number of types that inherit from a common superclass.

```kotlin
// Sealed class definition
sealed class Result {
    class Success(val data: String) : Result()
    class Error(val message: String) : Result()
}
```

### Interfaces
An interface in Kotlin is a collection of abstract methods and properties. It defines a contract that a class must implement. A class can implement multiple interfaces, which allows for a high degree of code reuse and flexibility. Interfaces can also have default implementations for methods, which is a feature introduced in Kotlin to provide some behavior out - of - the - box.

```kotlin
// Interface definition
interface Shape {
    fun area(): Double
    fun perimeter(): Double
}
```

## Typical Usage Scenarios

### Sealed Classes
- **Representing a Fixed Set of States**: Sealed classes are great for representing a finite number of states in an application. For example, in a network request, the result can be either a success or a failure.
- **Pattern Matching**: Since the set of subclasses is known at compile - time, sealed classes work very well with Kotlin's `when` expression, which can be exhaustive without the need for an `else` branch.

### Interfaces
- **Code Reuse and Multiple Inheritance**: Interfaces allow a class to implement multiple contracts. For example, a class can implement both a `Drawable` interface and a `Clickable` interface.
- **Dependency Injection**: Interfaces are commonly used in dependency injection frameworks to define contracts that different implementations can adhere to.

## Code Examples

### Sealed Class Example
```kotlin
// Sealed class definition
sealed class NetworkResult {
    class Success(val data: String) : NetworkResult()
    class Error(val message: String) : NetworkResult()
    object Loading : NetworkResult()
}

fun handleNetworkResult(result: NetworkResult) {
    when (result) {
        is NetworkResult.Success -> println("Data received: ${result.data}")
        is NetworkResult.Error -> println("Error: ${result.message}")
        is NetworkResult.Loading -> println("Loading...")
    }
}

fun main() {
    val successResult = NetworkResult.Success("Sample data")
    handleNetworkResult(successResult)
}
```
In this example, the `NetworkResult` sealed class represents the possible states of a network request. The `handleNetworkResult` function uses a `when` expression to handle each state.

### Interface Example
```kotlin
// Interface definition
interface Animal {
    fun makeSound()
}

// Class implementing the interface
class Dog : Animal {
    override fun makeSound() {
        println("Woof!")
    }
}

class Cat : Animal {
    override fun makeSound() {
        println("Meow!")
    }
}

fun main() {
    val dog = Dog()
    val cat = Cat()
    dog.makeSound()
    cat.makeSound()
}
```
Here, the `Animal` interface defines a contract for making a sound. The `Dog` and `Cat` classes implement this interface and provide their own implementations of the `makeSound` method.

## Best Practices

### When to Use Sealed Classes
- **Finite State Representation**: If you need to represent a limited number of states or types, use a sealed class.
- **Exhaustive Pattern Matching**: When you want to use `when` expressions without the need for an `else` branch, sealed classes are a good choice.

### When to Use Interfaces
- **Multiple Implementations**: If a class needs to implement multiple contracts, use interfaces.
- **Decoupling**: When you want to decouple the implementation details from the contract, interfaces are the way to go.

## Conclusion
In summary, both Kotlin sealed classes and interfaces are valuable tools in a developer's toolkit. Sealed classes are ideal for representing a fixed set of types and working with exhaustive pattern matching, while interfaces are better suited for code reuse, multiple inheritance, and dependency injection. By understanding their core concepts, typical usage scenarios, and best practices, you can make more informed decisions when designing your Kotlin applications.

## References
- Kotlin Official Documentation: https://kotlinlang.org/docs/
- Effective Kotlin by Marcin Moskala: https://effectivekotlin.com/
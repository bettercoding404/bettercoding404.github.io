---
title: "Understanding Kotlin Sealed Interfaces"
description: "
Kotlin is a modern, statically typed programming language that offers a plethora of features to make development more efficient and expressive. One such powerful feature is the sealed interface, introduced in Kotlin 1.5. Sealed interfaces build upon the concept of sealed classes, providing a more flexible way to define a restricted hierarchy of types. This blog post will explore the core concepts, typical usage scenarios, and best practices related to Kotlin sealed interfaces.
"
date: 2025-08-24
modified: 2025-08-24
---

## Table of Contents
1. [Core Concepts of Kotlin Sealed Interfaces](#core-concepts-of-kotlin-sealed-interfaces)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Best Practices](#best-practices)
4. [Conclusion](#conclusion)
5. [References](#references)

## Core Concepts of Kotlin Sealed Interfaces

### What are Sealed Interfaces?
A sealed interface is an interface that restricts the set of classes or interfaces that can implement it. All implementing classes or interfaces must be declared in the same file as the sealed interface. This creates a closed hierarchy, which means that the compiler knows all possible subtypes at compile time.

### Difference from Sealed Classes
Sealed classes are used to represent a fixed set of classes. A class can only inherit from a single sealed class. On the other hand, a class can implement multiple sealed interfaces, providing more flexibility in type composition.

### Example of a Sealed Interface
```kotlin
// Define a sealed interface
sealed interface Shape {
    fun area(): Double
}

// Implementing classes
class Circle(val radius: Double) : Shape {
    override fun area(): Double {
        return Math.PI * radius * radius
    }
}

class Rectangle(val length: Double, val width: Double) : Shape {
    override fun area(): Double {
        return length * width
    }
}

fun main() {
    val circle: Shape = Circle(5.0)
    val rectangle: Shape = Rectangle(4.0, 6.0)
    println("Circle area: ${circle.area()}")
    println("Rectangle area: ${rectangle.area()}")
}
```
In this example, the `Shape` sealed interface defines a single method `area()`. The `Circle` and `Rectangle` classes implement the `Shape` interface and provide their own implementations of the `area()` method.

## Typical Usage Scenarios

### Representing a State Machine
Sealed interfaces are ideal for representing state machines. Each state can be represented by an implementing class or interface, and the state transitions can be easily managed.

```kotlin
sealed interface NetworkState {
    object Loading : NetworkState
    data class Success(val data: String) : NetworkState
    data class Error(val message: String) : NetworkState
}

fun handleNetworkState(state: NetworkState) {
    when (state) {
        is NetworkState.Loading -> println("Loading data...")
        is NetworkState.Success -> println("Data loaded: ${state.data}")
        is NetworkState.Error -> println("Error: ${state.message}")
    }
}

fun main() {
    val loadingState: NetworkState = NetworkState.Loading
    handleNetworkState(loadingState)
    val successState = NetworkState.Success("Sample data")
    handleNetworkState(successState)
    val errorState = NetworkState.Error("Network error")
    handleNetworkState(errorState)
}
```
In this example, the `NetworkState` sealed interface represents the different states of a network operation. The `handleNetworkState` function uses a `when` expression to handle each state.

### Parsing Different Types of Input
Sealed interfaces can be used to parse different types of input. Each implementing class or interface can represent a different type of input, and the parsing logic can be implemented accordingly.

```kotlin
sealed interface Input {
    object TextInput : Input
    object NumberInput : Input
}

fun parseInput(input: Input) {
    when (input) {
        is Input.TextInput -> println("Parsing text input...")
        is Input.NumberInput -> println("Parsing number input...")
    }
}

fun main() {
    val textInput: Input = Input.TextInput
    parseInput(textInput)
    val numberInput: Input = Input.NumberInput
    parseInput(numberInput)
}
```
In this example, the `Input` sealed interface represents different types of input. The `parseInput` function uses a `when` expression to handle each type of input.

## Best Practices

### Keep the Hierarchy Small
Since all implementing classes or interfaces must be declared in the same file, it's important to keep the hierarchy small. A large hierarchy can make the code difficult to maintain.

### Use Data Classes for Implementing States
When representing states, it's often a good idea to use data classes. Data classes provide automatic implementations of `equals()`, `hashCode()`, and `toString()` methods, which can be useful for debugging and testing.

### Leverage the `when` Expression
The `when` expression in Kotlin is very powerful when used with sealed interfaces. It provides exhaustive checking, which means that the compiler will ensure that all possible cases are handled.

## Conclusion
Kotlin sealed interfaces are a powerful feature that provides a flexible way to define a restricted hierarchy of types. They are useful in many scenarios, such as representing state machines and parsing different types of input. By following the best practices, you can use sealed interfaces effectively in your Kotlin projects.

## References
- [Kotlin Documentation - Sealed Interfaces](https://kotlinlang.org/docs/sealed-interfaces.html)
- [Effective Kotlin - Sealed Classes and Interfaces](https://www.baeldung.com/kotlin/sealed-classes-interfaces)
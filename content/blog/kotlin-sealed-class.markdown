---
title: "Understanding Kotlin Sealed Classes"
description: "
In the world of Kotlin programming, sealed classes are a powerful and unique feature that offers a way to restrict the hierarchy of a class. They are a special kind of abstract class that can have a predefined set of sub - classes. Sealed classes provide a way to model a restricted set of choices in a type - safe manner, making the code more robust and easier to maintain. This blog post will delve into the core concepts, typical usage scenarios, and best practices related to Kotlin sealed classes.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. Core Concepts
2. Typical Usage Scenarios
    - Representing States
    - Handling Results
3. Best Practices
4. Conclusion
5. References

## Core Concepts
A sealed class in Kotlin is declared using the `sealed` keyword before the `class` keyword. The main characteristic of a sealed class is that all its sub - classes must be declared within the same file where the sealed class is declared. This restriction ensures that the set of possible sub - classes is known at compile - time.

Here is a simple example of a sealed class:
```kotlin
// Sealed class declaration
sealed class Shape {
    // Sub - class representing a circle
    class Circle(val radius: Double) : Shape()
    // Sub - class representing a rectangle
    class Rectangle(val width: Double, val height: Double) : Shape()
}

// Function to calculate the area of a shape
fun calculateArea(shape: Shape): Double {
    return when (shape) {
        is Shape.Circle -> Math.PI * shape.radius * shape.radius
        is Shape.Rectangle -> shape.width * shape.height
    }
}
```
In this example, the `Shape` class is a sealed class with two sub - classes: `Circle` and `Rectangle`. The `calculateArea` function uses a `when` expression to handle each type of shape. Since the set of possible sub - classes of `Shape` is known at compile - time, the `when` expression doesn't require an `else` branch.

## Typical Usage Scenarios

### Representing States
Sealed classes are often used to represent different states of an object. For example, consider a network request. It can be in one of several states: loading, success, or error.

```kotlin
// Sealed class to represent network request states
sealed class NetworkState {
    object Loading : NetworkState()
    data class Success(val data: String) : NetworkState()
    data class Error(val message: String) : NetworkState()
}

// Function to handle network state
fun handleNetworkState(state: NetworkState) {
    when (state) {
        is NetworkState.Loading -> println("Request is loading...")
        is NetworkState.Success -> println("Request succeeded with data: ${state.data}")
        is NetworkState.Error -> println("Request failed with message: ${state.message}")
    }
}
```
In this code, the `NetworkState` sealed class has three sub - classes: `Loading`, `Success`, and `Error`. The `handleNetworkState` function uses a `when` expression to handle each state.

### Handling Results
Sealed classes can also be used to handle the result of an operation. For example, a function that performs a division operation can return either a successful result or an error if the divisor is zero.

```kotlin
// Sealed class to represent division result
sealed class DivisionResult {
    data class Success(val result: Double) : DivisionResult()
    object Error : DivisionResult()
}

// Function to perform division
fun divide(dividend: Double, divisor: Double): DivisionResult {
    return if (divisor == 0.0) {
        DivisionResult.Error
    } else {
        DivisionResult.Success(dividend / divisor)
    }
}

// Function to handle division result
fun handleDivisionResult(result: DivisionResult) {
    when (result) {
        is DivisionResult.Success -> println("Division result: ${result.result}")
        is DivisionResult.Error -> println("Error: Division by zero")
    }
}
```
In this example, the `divide` function returns a `DivisionResult` object, which can be either a `Success` or an `Error`. The `handleDivisionResult` function uses a `when` expression to handle the result.

## Best Practices
- **Keep Sub - classes in the Same File**: As mentioned earlier, all sub - classes of a sealed class must be declared in the same file. This ensures that the set of possible sub - classes is known at compile - time.
- **Use `when` Expressions**: Since the set of possible sub - classes is known, `when` expressions can be used without an `else` branch, which makes the code more type - safe.
- **Limit the Number of Sub - classes**: Sealed classes are designed for a restricted set of choices. If the number of sub - classes becomes too large, it may be a sign that a different design pattern should be used.

## Conclusion
Kotlin sealed classes are a powerful tool for modeling a restricted set of choices in a type - safe manner. They are particularly useful for representing states, handling results, and other scenarios where the set of possible types is known at compile - time. By following the best practices, developers can write more robust and maintainable code using sealed classes.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/sealed-classes.html
- Effective Kotlin by Marcin Moskala: A great resource for in - depth Kotlin programming techniques.
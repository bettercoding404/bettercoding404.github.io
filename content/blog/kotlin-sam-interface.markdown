---
title: "Understanding Kotlin SAM Interfaces"
description: "
In the realm of Kotlin programming, SAM (Single Abstract Method) interfaces play a significant role in enhancing code readability and reducing boilerplate. A SAM interface is an interface that contains exactly one abstract method. Java 8 introduced support for SAM interfaces through lambda expressions, and Kotlin takes this concept a step further by providing seamless integration and additional syntactic sugar. In this blog post, we'll explore the core concepts of Kotlin SAM interfaces, their typical usage scenarios, and best practices.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. [Core Concepts of Kotlin SAM Interfaces](#core-concepts-of-kotlin-sam-interfaces)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Code Examples](#code-examples)
4. [Best Practices](#best-practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Core Concepts of Kotlin SAM Interfaces
A SAM interface in Kotlin is an interface with a single abstract method. This single method represents the contract that any implementation of the interface must fulfill. Kotlin allows you to use lambda expressions as implementations of SAM interfaces, which simplifies the code significantly. 

For example, consider the following Java SAM interface:
```java
// Java code
@FunctionalInterface
interface MyFunction {
    void apply(int value);
}
```
In Kotlin, we can define a similar SAM interface:
```kotlin
// Kotlin code
fun interface MyFunction {
    fun apply(value: Int)
}
```
The `fun` keyword in front of the `interface` declaration indicates that it is a SAM interface.

## Typical Usage Scenarios
### Event Handling
One of the most common use cases for SAM interfaces is event handling. For example, in Android development, you often need to handle button clicks. Instead of creating a full-fledged anonymous inner class, you can use a lambda expression with a SAM interface.

### Callbacks
SAM interfaces are also widely used for callbacks. When an asynchronous operation completes, a callback function is called to handle the result. Using a SAM interface makes the callback code more concise.

### Functional Programming
In functional programming, functions are first-class citizens. SAM interfaces can be used to represent functions and pass them around as arguments.

## Code Examples
### Basic Usage
```kotlin
// Define a SAM interface
fun interface Calculator {
    fun calculate(a: Int, b: Int): Int
}

fun main() {
    // Use a lambda expression to implement the SAM interface
    val addition: Calculator = Calculator { a, b -> a + b }
    val result = addition.calculate(5, 3)
    println("The result of addition is: $result")
}
```
In this example, we define a `Calculator` SAM interface with a single abstract method `calculate`. We then use a lambda expression to create an instance of the `Calculator` interface and perform an addition operation.

### Android Button Click Example
```kotlin
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity

// Assume this is an Android activity
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val button: Button = findViewById(R.id.my_button)
        // Use a lambda expression for button click event
        button.setOnClickListener {
            println("Button clicked!")
        }
    }
}
```
Here, the `OnClickListener` is a SAM interface. We use a lambda expression to handle the button click event.

## Best Practices
### Keep Interfaces Simple
SAM interfaces should have a single, well-defined responsibility. Avoid adding multiple methods to a SAM interface, as it defeats the purpose of using a lambda expression.

### Use Descriptive Names
Give your SAM interfaces descriptive names that clearly indicate their purpose. This makes the code more readable and maintainable.

### Document the Interface
Add documentation to your SAM interfaces to explain the purpose of the single abstract method and any requirements for its implementation.

## Conclusion
Kotlin SAM interfaces are a powerful feature that simplifies code and enhances readability. By allowing lambda expressions to implement single abstract method interfaces, Kotlin reduces the amount of boilerplate code. Understanding the core concepts, typical usage scenarios, and best practices of SAM interfaces will help you write more concise and efficient Kotlin code.

## References
- [Kotlin Documentation](https://kotlinlang.org/docs/reference/fun-interfaces.html)
- [Android Developers Documentation](https://developer.android.com/reference/android/view/View.OnClickListener)
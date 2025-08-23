---
title: "Kotlin SAM: Simplifying Single Abstract Method Implementations"
description: "
In the world of Kotlin programming, Single Abstract Method (SAM) interfaces play a crucial role in enabling more concise and readable code. SAM interfaces are interfaces that have exactly one abstract method. Java has long supported the concept of SAM interfaces through the use of lambda expressions in Java 8 and later. Kotlin takes this a step further, providing seamless integration and even more flexibility when dealing with such interfaces.  In this blog post, we will explore the core concepts of Kotlin SAM, typical usage scenarios, and best practices to help intermediate - to - advanced software engineers make the most of this powerful feature.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts of Kotlin SAM
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts of Kotlin SAM
### What is a SAM Interface?
A SAM interface is an interface that contains exactly one abstract method. In Java, well - known examples of SAM interfaces are `Runnable` and `ActionListener`. Kotlin allows you to use lambda expressions to implement these interfaces in a more concise way.

### SAM Conversions in Kotlin
Kotlin automatically converts lambda expressions to instances of SAM interfaces when appropriate. This means that instead of creating an anonymous inner class to implement a SAM interface, you can simply pass a lambda expression where an instance of the SAM interface is expected.

### Kotlin's Built - in SAM Interfaces
Kotlin also has its own set of built - in SAM interfaces. For example, the `kotlin.jvm.functions` package contains a series of function interfaces like `Function0`, `Function1`, etc., which can be used in a similar way.

## Typical Usage Scenarios
### Event Handling
In GUI programming, event handlers are often implemented using SAM interfaces. For example, in Android development, you can use SAM conversions to handle button clicks more concisely.

### Asynchronous Programming
When working with asynchronous operations, callbacks are commonly used. These callbacks are often defined as SAM interfaces, and Kotlin's SAM support makes it easier to write asynchronous code.

### Functional Programming
In functional programming, functions are first - class citizens. Kotlin's SAM support allows you to use lambda expressions to pass functions around, enabling more functional - style programming.

## Code Examples

### Example 1: Using Java's `Runnable` Interface
```kotlin
fun main() {
    // Traditional way of implementing Runnable using an anonymous inner class
    val runnable1 = object : Runnable {
        override fun run() {
            println("Running using anonymous inner class")
        }
    }

    // Using Kotlin's SAM conversion with a lambda expression
    val runnable2 = Runnable {
        println("Running using lambda expression")
    }

    // Start the threads
    Thread(runnable1).start()
    Thread(runnable2).start()
}
```
In this example, we first create a `Runnable` instance using an anonymous inner class, which is the traditional Java way. Then we use Kotlin's SAM conversion to create another `Runnable` instance using a lambda expression, which is much more concise.

### Example 2: Custom SAM Interface
```kotlin
// Define a custom SAM interface
interface MyClickListener {
    fun onClick()
}

fun registerClickListener(listener: MyClickListener) {
    // Simulate a click event
    listener.onClick()
}

fun main() {
    // Using an anonymous inner class to implement the custom SAM interface
    registerClickListener(object : MyClickListener {
        override fun onClick() {
            println("Clicked using anonymous inner class")
        }
    })

    // Using Kotlin's SAM conversion with a lambda expression
    registerClickListener {
        println("Clicked using lambda expression")
    }
}
```
Here, we define a custom SAM interface `MyClickListener` and a function `registerClickListener` that takes an instance of this interface. We then show how to implement the interface using both an anonymous inner class and a lambda expression.

### Example 3: Android Button Click Handling
```kotlin
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val myButton = findViewById<Button>(R.id.myButton)

        // Traditional way of setting a click listener
        myButton.setOnClickListener(object : android.view.View.OnClickListener {
            override fun onClick(v: android.view.View?) {
                println("Button clicked using anonymous inner class")
            }
        })

        // Using Kotlin's SAM conversion
        myButton.setOnClickListener {
            println("Button clicked using lambda expression")
        }
    }
}
```
This example shows how to handle button clicks in an Android application. We first set a click listener using an anonymous inner class and then use Kotlin's SAM conversion to achieve the same result more concisely.

## Best Practices
### Keep Lambda Expressions Readable
While lambda expressions are concise, they can become hard to read if they are too long or complex. If a lambda expression becomes too long, consider extracting it into a named function.

### Use SAM Interfaces Wisely
Not all interfaces should be designed as SAM interfaces. Only use SAM interfaces when it makes sense, such as when you have a single operation that needs to be performed.

### Leverage Kotlin's Built - in Function Interfaces
Instead of creating custom SAM interfaces for simple operations, consider using Kotlin's built - in function interfaces from the `kotlin.jvm.functions` package.

## Conclusion
Kotlin's support for Single Abstract Method (SAM) interfaces provides a powerful and concise way to implement interfaces with a single abstract method. By using lambda expressions for SAM conversions, developers can write more readable and maintainable code. Whether you are working on GUI programming, asynchronous operations, or functional programming, Kotlin's SAM support can greatly simplify your code.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/reference/
- Android Developer Documentation: https://developer.android.com/
- Effective Java by Joshua Bloch
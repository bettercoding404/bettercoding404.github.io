---
title: "Kotlin SAM Conversion: A Deep Dive"
description: "
In the world of Kotlin, SAM (Single Abstract Method) conversion is a powerful feature that simplifies the interaction with Java libraries that rely on single - abstract - method interfaces. Java 8 introduced lambda expressions to handle single - abstract - method interfaces more concisely, and Kotlin takes this a step further by providing seamless integration with such interfaces. This blog post will explore the core concepts, typical usage scenarios, and best practices related to Kotlin SAM conversion, enabling intermediate - to - advanced software engineers to use this feature effectively.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. [Core Concepts of Kotlin SAM Conversion](#core-concepts-of-kotlin-sam-conversion)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Best Practices](#best-practices)
4. [Code Examples](#code-examples)
5. [Conclusion](#conclusion)
6. [References](#references)

## Core Concepts of Kotlin SAM Conversion
In Java, a single - abstract - method interface is an interface that contains exactly one abstract method. For example, the `Runnable` interface in Java has a single abstract method `run()`.

```java
// Java code
@FunctionalInterface
public interface Runnable {
    public abstract void run();
}
```

In Kotlin, when you need to implement such an interface, instead of creating an anonymous inner class, you can use a lambda expression. This is what Kotlin SAM conversion is all about. It automatically converts a lambda expression into an instance of a single - abstract - method interface.

SAM conversion only works for Java interfaces, not for Kotlin interfaces. Kotlin has its own function types, which are generally more lightweight and convenient to use.

## Typical Usage Scenarios
### 1. Threading and Concurrency
When working with Java's threading API, the `Runnable` interface is commonly used. With Kotlin SAM conversion, you can create a new thread more concisely.

### 2. Event Handling in GUI Libraries
Many Java GUI libraries use single - abstract - method interfaces for event handling. For example, the `ActionListener` interface in Java's Swing library can be easily implemented using Kotlin SAM conversion.

### 3. Working with Java Streams
Java Streams often use single - abstract - method interfaces like `Predicate`, `Consumer`, and `Function`. Kotlin SAM conversion simplifies the code when working with these interfaces.

## Best Practices
### 1. Keep Lambda Expressions Readable
Although lambda expressions can make the code more concise, overly long or complex lambda expressions can reduce code readability. If a lambda expression becomes too complex, consider extracting it into a named function.

### 2. Use Type Annotations Sparingly
Kotlin can usually infer the types of lambda expressions used in SAM conversion. Excessive type annotations can make the code more verbose. Only use type annotations when the type inference fails or to make the code more explicit.

### 3. Be Aware of the Limitations
Remember that SAM conversion only works for Java interfaces. If you are working with Kotlin interfaces, use Kotlin's function types instead.

## Code Examples

### 1. Using `Runnable` with Kotlin SAM Conversion
```kotlin
fun main() {
    // Without SAM conversion, using anonymous inner class
    val runnable1 = object : Runnable {
        override fun run() {
            println("Running without SAM conversion")
        }
    }

    // With SAM conversion, using lambda expression
    val runnable2 = Runnable {
        println("Running with SAM conversion")
    }

    Thread(runnable1).start()
    Thread(runnable2).start()
}
```

### 2. Event Handling in Swing
```kotlin
import javax.swing.*
import java.awt.event.ActionEvent
import java.awt.event.ActionListener

fun main() {
    val frame = JFrame("SAM Conversion Example")
    val button = JButton("Click me")

    // Without SAM conversion, using anonymous inner class
    button.addActionListener(object : ActionListener {
        override fun actionPerformed(e: ActionEvent?) {
            println("Button clicked without SAM conversion")
        }
    })

    // With SAM conversion, using lambda expression
    button.addActionListener {
        println("Button clicked with SAM conversion")
    }

    frame.add(button)
    frame.setSize(300, 200)
    frame.defaultCloseOperation = JFrame.EXIT_ON_CLOSE
    frame.setVisible(true)
}
```

### 3. Working with Java Streams
```kotlin
import java.util.stream.Stream

fun main() {
    val numbers = listOf(1, 2, 3, 4, 5)

    // Using SAM conversion with Predicate
    val evenNumbers = numbers.stream()
      .filter { it % 2 == 0 }
      .toList()

    println(evenNumbers)
}
```

## Conclusion
Kotlin SAM conversion is a valuable feature that simplifies the interaction with Java single - abstract - method interfaces. It allows developers to write more concise and readable code when working with Java libraries. By understanding the core concepts, typical usage scenarios, and best practices, intermediate - to - advanced software engineers can leverage this feature effectively in their projects. However, it's important to be aware of its limitations and use it appropriately.

## References
1. Kotlin official documentation: https://kotlinlang.org/docs/reference/java-interop.html#sam-conversions
2. Java official documentation: https://docs.oracle.com/javase/8/docs/api/
3. Effective Java by Joshua Bloch


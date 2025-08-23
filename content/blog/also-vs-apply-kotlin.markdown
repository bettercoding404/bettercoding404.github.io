---
title: "Understanding `also` vs `apply` in Kotlin"
description: "
In Kotlin, both `also` and `apply` are part of the standard library's scope functions. These functions are extremely useful when you need to perform operations on an object within a specific scope. They allow you to chain operations on an object, making your code more concise and readable. However, `also` and `apply` have distinct behaviors, and understanding their differences is crucial for writing efficient and maintainable Kotlin code. In this blog post, we will explore the core concepts, typical usage scenarios, and best practices for using `also` and `apply`.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. [Core Concepts](#core-concepts)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Best Practices](#best-practices)
4. [Conclusion](#conclusion)
5. [References](#references)

## Core Concepts

### `also`
The `also` function is an extension function that takes a lambda as an argument. It returns the original object on which it is called. Inside the lambda, the object is referred to as `it`. This makes `also` useful for performing side - effects on an object, such as logging, debugging, or performing additional operations that do not modify the object's state significantly.

Here is a simple example:
```kotlin
// Create a Person class
data class Person(var name: String, var age: Int)

fun main() {
    val person = Person("Alice", 25)
        .also {
            // Log the person's information
            println("Person created: ${it.name}, ${it.age} years old")
        }
    println(person.name) // Output: Alice
}
```
In this example, the `also` function is used to log the person's information. After the `also` call, the `person` object remains the same, and we can continue using it as usual.

### `apply`
The `apply` function is also an extension function that takes a lambda as an argument. It returns the original object on which it is called. However, inside the lambda, the object is referred to as `this`. This makes `apply` ideal for initializing or configuring an object, as you can directly access and modify its properties without using the `it` or any other reference.

Here is an example:
```kotlin
data class Config(var timeout: Int, var retries: Int)

fun main() {
    val config = Config(0, 0).apply {
        // Configure the object
        timeout = 5000
        retries = 3
    }
    println("Timeout: ${config.timeout}, Retries: ${config.retries}") 
    // Output: Timeout: 5000, Retries: 3
}
```
In this example, the `apply` function is used to configure the `Config` object. The lambda passed to `apply` allows us to directly set the `timeout` and `retries` properties of the `Config` object.

## Typical Usage Scenarios

### Using `also`
- **Logging and Debugging**: As shown in the previous example, `also` is great for logging the state of an object at different points in your code.
```kotlin
val numbers = listOf(1, 2, 3, 4, 5)
val squaredNumbers = numbers.map { it * it }
    .also { println("Squared numbers: $it") }
```
- **Performing Side - Effects**: You can use `also` to perform operations that do not change the object's state, such as saving an object to a file or sending a notification.
```kotlin
data class User(val id: Int, val name: String)

fun saveUserToFile(user: User) {
    // Code to save user to file
    println("User ${user.name} saved to file")
}

fun main() {
    val user = User(1, "Bob")
        .also { saveUserToFile(it) }
}
```

### Using `apply`
- **Object Initialization and Configuration**: `apply` is commonly used to initialize and configure objects, especially when there are multiple properties to set.
```kotlin
class Button {
    var text: String = ""
    var onClick: () -> Unit = {}
}

fun main() {
    val button = Button().apply {
        text = "Click me"
        onClick = { println("Button clicked!") }
    }
}
```
- **Building Complex Objects**: When building complex objects with multiple nested configurations, `apply` can make the code more readable.
```kotlin
data class Car(var make: String, var model: String, var engine: Engine)
data class Engine(var power: Int, var fuelType: String)

fun main() {
    val car = Car("", "", Engine(0, "")).apply {
        make = "Toyota"
        model = "Corolla"
        engine.apply {
            power = 150
            fuelType = "Gasoline"
        }
    }
}
```

## Best Practices

### When to Use `also`
- Use `also` when you want to perform side - effects on an object without changing its state.
- If you need to access the object using the `it` reference in a concise way, `also` is a good choice.

### When to Use `apply`
- Use `apply` when you are initializing or configuring an object.
- If you want to directly access the object's properties and methods without using a reference (`this` is implicit), `apply` is more suitable.

### Avoiding Overuse
Both `also` and `apply` are powerful, but overusing them can make the code hard to read. Use them only when they genuinely improve the readability and maintainability of your code.

## Conclusion
In summary, `also` and `apply` are two important scope functions in Kotlin. `also` is mainly used for performing side - effects on an object, while `apply` is used for initializing and configuring an object. By understanding their core concepts and typical usage scenarios, you can choose the right function for the right situation, making your Kotlin code more concise, readable, and maintainable.

## References
- Kotlin Documentation: [Scope Functions](https://kotlinlang.org/docs/scope-functions.html)
- Baeldung: [Kotlin Scope Functions](https://www.baeldung.com/kotlin-scope-functions)
---
title: "Kotlin Sealed Class Copy: A Comprehensive Guide"
description: "
Kotlin sealed classes are a powerful tool in the Kotlin programming language. They are used to represent a restricted hierarchy of classes where all the subclasses are known at compile - time. This feature is particularly useful in scenarios such as representing different states of an application or different types of events.  The `copy` function in Kotlin is a convenient way to create a new instance of a class with some or all of its properties copied from an existing instance. When it comes to sealed classes, the `copy` function can be used in a more nuanced way, especially when dealing with the hierarchy of sub - classes. In this blog post, we will explore the core concepts, typical usage scenarios, and best practices related to Kotlin sealed class `copy`.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts
    - Sealed Classes in Kotlin
    - The `copy` Function in Kotlin
    - Sealed Class `copy`
2. Typical Usage Scenarios
    - State Representation and Update
    - Event Handling
3. Best Practices
    - Using `copy` for Immutability
    - Handling Hierarchical Structures
4. Code Examples
    - Basic Sealed Class `copy`
    - `copy` in a Hierarchical Sealed Class
5. Conclusion
6. References

## Core Concepts

### Sealed Classes in Kotlin
Sealed classes in Kotlin are used to represent a restricted class hierarchy. All subclasses of a sealed class must be declared in the same file as the sealed class. This restriction allows the compiler to know all possible sub - classes at compile - time, which is useful for pattern matching.

```kotlin
// Sealed class representing different shapes
sealed class Shape {
    object Circle : Shape()
    object Square : Shape()
    data class Rectangle(val width: Int, val height: Int) : Shape()
}
```

### The `copy` Function in Kotlin
The `copy` function is available for data classes in Kotlin. It creates a new instance of the data class with the same property values as the original instance, unless some properties are explicitly specified.

```kotlin
data class Person(val name: String, val age: Int)

fun main() {
    val person1 = Person("John", 30)
    val person2 = person1.copy(age = 31)
    println(person2) // Output: Person(name=John, age=31)
}
```

### Sealed Class `copy`
When a sealed class contains data class sub - classes, the `copy` function can be used to create new instances of those sub - classes. This is useful when you want to update some properties of a particular state or event represented by the sealed class.

```kotlin
sealed class UserState {
    data class LoggedIn(val username: String, val token: String) : UserState()
    object LoggedOut : UserState()
}

fun main() {
    val loggedInState = UserState.LoggedIn("user123", "abc123")
    val newLoggedInState = loggedInState.copy(token = "def456")
    println(newLoggedInState) // Output: LoggedIn(username=user123, token=def456)
}
```

## Typical Usage Scenarios

### State Representation and Update
Sealed classes are often used to represent different states of an application. The `copy` function can be used to update the state while keeping the immutability of the state objects.

```kotlin
sealed class NetworkState {
    object Loading : NetworkState()
    data class Success(val data: String) : NetworkState()
    data class Error(val message: String) : NetworkState()
}

fun main() {
    val successState = NetworkState.Success("Data fetched successfully")
    val newSuccessState = successState.copy(data = "New data fetched")
    println(newSuccessState) // Output: Success(data=New data fetched)
}
```

### Event Handling
Sealed classes can also be used to represent different types of events in an application. The `copy` function can be used to create new event instances with updated properties.

```kotlin
sealed class UserEvent {
    data class Login(val username: String, val password: String) : UserEvent()
    data class Logout(val reason: String) : UserEvent()
}

fun main() {
    val loginEvent = UserEvent.Login("user123", "password123")
    val newLoginEvent = loginEvent.copy(password = "newpassword")
    println(newLoginEvent) // Output: Login(username=user123, password=newpassword)
}
```

## Best Practices

### Using `copy` for Immutability
Immutability is an important concept in Kotlin. By using the `copy` function, you can create new instances instead of modifying existing ones. This helps in avoiding side - effects and makes the code more predictable.

```kotlin
sealed class CounterState {
    data class Counting(val value: Int) : CounterState()
    object Stopped : CounterState()
}

fun incrementCounter(state: CounterState.Counting): CounterState.Counting {
    return state.copy(value = state.value + 1)
}
```

### Handling Hierarchical Structures
When dealing with hierarchical sealed classes, make sure to use the `copy` function appropriately at each level of the hierarchy. This ensures that the state or event updates are handled correctly.

```kotlin
sealed class ParentState {
    sealed class ChildState : ParentState() {
        data class SubChildState(val value: Int) : ChildState()
    }
}

fun updateSubChildState(state: ParentState.ChildState.SubChildState): ParentState.ChildState.SubChildState {
    return state.copy(value = state.value * 2)
}
```

## Code Examples

### Basic Sealed Class `copy`
```kotlin
// Sealed class representing different payment methods
sealed class PaymentMethod {
    data class CreditCard(val cardNumber: String, val expiryDate: String) : PaymentMethod()
    data class PayPal(val email: String) : PaymentMethod()
}

fun main() {
    val creditCardPayment = PaymentMethod.CreditCard("1234567890123456", "12/25")
    val newCreditCardPayment = creditCardPayment.copy(expiryDate = "01/26")
    println(newCreditCardPayment) // Output: CreditCard(cardNumber=1234567890123456, expiryDate=01/26)
}
```

### `copy` in a Hierarchical Sealed Class
```kotlin
sealed class Animal {
    sealed class Mammal : Animal() {
        data class Dog(val name: String, val breed: String) : Mammal()
    }
}

fun main() {
    val dog = Animal.Mammal.Dog("Buddy", "Golden Retriever")
    val newDog = dog.copy(breed = "Labrador")
    println(newDog) // Output: Dog(name=Buddy, breed=Labrador)
}
```

## Conclusion
Kotlin sealed class `copy` is a powerful feature that combines the benefits of sealed classes and the `copy` function. It allows for efficient state and event management in applications, especially when dealing with restricted class hierarchies. By following the best practices of using `copy` for immutability and handling hierarchical structures, developers can write more robust and maintainable code.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/
- "Effective Kotlin" by Marcin Moskała and Artur Dryomov

In summary, understanding and using Kotlin sealed class `copy` can significantly enhance your Kotlin programming skills and the quality of your applications. 
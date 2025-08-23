---
title: "Kotlin Sealed Class Serializable: A Comprehensive Guide"
description: "
In Kotlin, sealed classes are a powerful tool that provides a way to represent a restricted hierarchy of classes. They are used when you know all possible sub - classes at compile - time. Serialization, on the other hand, is the process of converting an object into a format that can be stored or transmitted, such as JSON or XML. Combining Kotlin sealed classes with serialization can be extremely useful in many scenarios, especially in modern software development where data transfer between different components or systems is common.  This blog post will explore the core concepts, typical usage scenarios, and best practices related to making Kotlin sealed classes serializable.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts
    - Sealed Classes in Kotlin
    - Serialization Basics
2. Making Sealed Classes Serializable
    - Using Kotlinx Serialization
3. Typical Usage Scenarios
    - API Response Handling
    - State Management
4. Best Practices
    - Handling Unknown Sub - classes
    - Versioning and Compatibility
5. Conclusion
6. References

## Core Concepts

### Sealed Classes in Kotlin
A sealed class in Kotlin is a class that restricts the hierarchy of its sub - classes. All sub - classes of a sealed class must be declared in the same file as the sealed class. This allows the compiler to know all possible sub - classes at compile - time, which is useful for exhaustiveness checks in `when` expressions.

```kotlin
// Sealed class example
sealed class Result<out T> {
    data class Success<out T>(val data: T) : Result<T>()
    data class Error(val message: String) : Result<Nothing>()
}
```

### Serialization Basics
Serialization is the process of converting an object's state into a format that can be stored or transmitted. In the context of Kotlin, common serialization formats include JSON, XML, and Protocol Buffers. Serialization is crucial for tasks like saving data to disk, sending data over a network, or caching data.

## Making Sealed Classes Serializable

### Using Kotlinx Serialization
Kotlinx Serialization is a Kotlin library that provides a way to serialize and deserialize Kotlin objects easily. To make a sealed class serializable, you need to add the necessary annotations and configure the serialization library.

First, add the Kotlinx Serialization dependency to your project. If you are using Gradle, add the following to your `build.gradle.kts` file:

```kotlin
dependencies {
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.4.1")
}
```

Here is an example of making the `Result` sealed class serializable:

```kotlin
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

// Mark the sealed class and its sub - classes as serializable
@Serializable
sealed class Result<out T> {
    @Serializable
    data class Success<out T>(val data: T) : Result<T>()

    @Serializable
    data class Error(val message: String) : Result<Nothing>()
}

fun main() {
    // Create a Success result
    val successResult = Result.Success("Hello, World!")
    // Serialize the result to JSON
    val json = Json.encodeToString(successResult)
    println(json)
}
```

In this example, we mark the `Result` sealed class and its sub - classes with the `@Serializable` annotation. Then we use the `Json.encodeToString` method to serialize an instance of the `Success` sub - class to a JSON string.

## Typical Usage Scenarios

### API Response Handling
When working with APIs, the response can have different states. A sealed class can represent these states, and serialization can be used to send and receive these responses.

```kotlin
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

@Serializable
sealed class ApiResponse<out T> {
    @Serializable
    data class Success<out T>(val data: T) : ApiResponse<T>()

    @Serializable
    data class Error(val message: String) : ApiResponse<Nothing>()
}

fun main() {
    // Simulate an API success response
    val apiSuccess = ApiResponse.Success(listOf("Item 1", "Item 2"))
    val json = Json.encodeToString(apiSuccess)
    println(json)
}
```

### State Management
In a state management system, different states of an application can be represented using a sealed class. Serialization can be used to save and restore the application state.

```kotlin
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

@Serializable
sealed class AppState {
    @Serializable
    object Loading : AppState()

    @Serializable
    data class Loaded(val data: List<String>) : AppState()

    @Serializable
    data class Error(val message: String) : AppState()
}

fun main() {
    val loadedState = AppState.Loaded(listOf("Data 1", "Data 2"))
    val json = Json.encodeToString(loadedState)
    println(json)
}
```

## Best Practices

### Handling Unknown Sub - classes
In some cases, during deserialization, you may encounter an unknown sub - class. Kotlinx Serialization provides a way to handle this situation using custom serializers.

```kotlin
import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.SerializationException
import kotlinx.serialization.Serializable
import kotlinx.serialization.Serializer
import kotlinx.serialization.builtins.serializer
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.Json

@Serializable
sealed class Shape {
    @Serializable
    data class Circle(val radius: Double) : Shape()

    @Serializable
    data class Square(val side: Double) : Shape()
}

@OptIn(ExperimentalSerializationApi::class)
@Serializer(forClass = Shape::class)
object ShapeSerializer : KSerializer<Shape> {
    override val descriptor: SerialDescriptor = String.serializer().descriptor

    override fun serialize(encoder: Encoder, value: Shape) {
        when (value) {
            is Shape.Circle -> encoder.encodeString("Circle(${value.radius})")
            is Shape.Square -> encoder.encodeString("Square(${value.side})")
        }
    }

    override fun deserialize(decoder: Decoder): Shape {
        val string = decoder.decodeString()
        return when {
            string.startsWith("Circle(") -> {
                val radius = string.removePrefix("Circle(").removeSuffix(")").toDouble()
                Shape.Circle(radius)
            }
            string.startsWith("Square(") -> {
                val side = string.removePrefix("Square(").removeSuffix(")").toDouble()
                Shape.Square(side)
            }
            else -> throw SerializationException("Unknown shape: $string")
        }
    }
}

fun main() {
    val circle = Shape.Circle(5.0)
    val json = Json.encodeToString(ShapeSerializer, circle)
    println(json)
    try {
        val deserialized = Json.decodeFromString(ShapeSerializer, json)
        println(deserialized)
    } catch (e: SerializationException) {
        println("Deserialization error: ${e.message}")
    }
}
```

### Versioning and Compatibility
When your sealed class hierarchy changes over time, you need to ensure compatibility with existing serialized data. You can use techniques like adding new sub - classes without removing old ones and using custom serializers to handle versioning.

## Conclusion
Kotlin sealed classes combined with serialization provide a powerful way to represent restricted hierarchies of classes and transfer data between different components or systems. By understanding the core concepts, typical usage scenarios, and best practices, intermediate - to - advanced software engineers can effectively use Kotlin sealed classes in their projects. Whether it's API response handling, state management, or other scenarios, serialization of sealed classes can simplify the development process and improve code maintainability.

## References
- Kotlin Documentation: https://kotlinlang.org/docs/
- Kotlinx Serialization Documentation: https://github.com/Kotlin/kotlinx.serialization
- Kotlin in Action by Dmitry Jemerov and Svetlana Isakova
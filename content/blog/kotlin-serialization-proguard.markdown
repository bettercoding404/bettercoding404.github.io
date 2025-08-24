---
title: "Kotlin Serialization ProGuard: A Comprehensive Guide"
description: "
Kotlin Serialization is a powerful library that allows developers to convert Kotlin objects to and from various formats like JSON, XML, and more. On the other hand, ProGuard is a tool used for shrinking, optimizing, and obfuscating Java bytecode. When using Kotlin Serialization in an Android or Java project, integrating ProGuard becomes crucial to ensure that the serialization process works correctly even after the code has been optimized and obfuscated. This blog post will delve into the core concepts, typical usage scenarios, and best practices related to Kotlin Serialization ProGuard.
"
date: 2025-08-24
modified: 2025-08-24
---

## Table of Contents
1. Core Concepts
    - Kotlin Serialization
    - ProGuard
    - Interaction between Kotlin Serialization and ProGuard
2. Typical Usage Scenarios
    - Android App Development
    - Server - Side Kotlin Applications
3. Best Practices
    - Configuration Rules
    - Testing
4. Code Examples
    - Basic Kotlin Serialization with ProGuard
    - Custom Serializers and ProGuard
5. Conclusion
6. References

## Core Concepts

### Kotlin Serialization
Kotlin Serialization is a built - in feature in Kotlin that enables developers to convert Kotlin objects to and from different data formats. It uses annotations like `@Serializable` to mark classes that can be serialized. For example:
```kotlin
import kotlinx.serialization.Serializable

@Serializable
data class User(val name: String, val age: Int)
```
Here, the `User` class can be easily serialized to JSON or other formats using the Kotlin Serialization library.

### ProGuard
ProGuard is a tool that processes Java bytecode. It performs three main functions:
- **Shrinking**: Removes unused classes, fields, methods, and attributes from the code, reducing the APK size in Android applications.
- **Optimization**: Optimizes the bytecode by making various improvements, such as inlining methods.
- **Obfuscation**: Renames classes, fields, and methods to make the code harder to reverse - engineer.

### Interaction between Kotlin Serialization and ProGuard
Kotlin Serialization relies on reflection to access the properties of serialized classes. However, ProGuard's obfuscation can change the names of classes and properties, which can break the serialization process. Therefore, we need to configure ProGuard to preserve the necessary information for Kotlin Serialization.

## Typical Usage Scenarios

### Android App Development
In Android app development, reducing the APK size is crucial. ProGuard helps in achieving this by shrinking and obfuscating the code. At the same time, Kotlin Serialization is often used to communicate with servers by serializing and deserializing data. For example, when an Android app sends user data to a server in JSON format, Kotlin Serialization is used for the conversion, and ProGuard is used to optimize the app's code.

### Server - Side Kotlin Applications
On the server - side, Kotlin is becoming increasingly popular for building RESTful APIs. Kotlin Serialization can be used to handle incoming and outgoing data in different formats. ProGuard can be used to optimize the server code, reducing memory usage and improving performance.

## Best Practices

### Configuration Rules
To ensure that Kotlin Serialization works correctly after ProGuard processing, we need to add the following rules to the ProGuard configuration file:
```
# Preserve Kotlin serialization classes
-keep class kotlinx.serialization.** { *; }
# Preserve all classes annotated with @Serializable
-keep @kotlinx.serialization.Serializable class * { *; }
# Preserve constructors and methods used by serialization
-keepclassmembers class * {
    constructor(...);
    *** Companion;
    companion object {
        <methods>;
    }
}
```
These rules ensure that the Kotlin Serialization library and the serialized classes are not obfuscated.

### Testing
After applying ProGuard rules, it is essential to thoroughly test the serialization and deserialization process. Create test cases that cover different scenarios, such as serializing and deserializing simple objects, nested objects, and objects with custom serializers.

## Code Examples

### Basic Kotlin Serialization with ProGuard
```kotlin
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json

@Serializable
data class Book(val title: String, val author: String)

fun main() {
    val book = Book("Kotlin in Action", "Dmitry Jemerov")
    val jsonString = Json.encodeToString(book)
    println(jsonString)
    val deserializedBook = Json.decodeFromString<Book>(jsonString)
    println(deserializedBook)
}
```
With the ProGuard rules mentioned above, this code will work correctly even after ProGuard processing.

### Custom Serializers and ProGuard
```kotlin
import kotlinx.serialization.*
import kotlinx.serialization.json.Json
import java.time.LocalDate
import java.time.format.DateTimeFormatter

@Serializable(with = LocalDateSerializer::class)
data class Event(val name: String, val date: LocalDate)

object LocalDateSerializer : KSerializer<LocalDate> {
    private val formatter = DateTimeFormatter.ISO_LOCAL_DATE
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("LocalDate", PrimitiveKind.STRING)

    override fun serialize(encoder: Encoder, value: LocalDate) {
        encoder.encodeString(value.format(formatter))
    }

    override fun deserialize(decoder: Decoder): LocalDate {
        return LocalDate.parse(decoder.decodeString(), formatter)
    }
}

fun main() {
    val event = Event("Conference", LocalDate.of(2024, 10, 15))
    val jsonString = Json.encodeToString(event)
    println(jsonString)
    val deserializedEvent = Json.decodeFromString<Event>(jsonString)
    println(deserializedEvent)
}
```
In this example, we have a custom serializer for `LocalDate`. We need to ensure that the custom serializer class and the `@Serializable` annotation are preserved in the ProGuard configuration.

## Conclusion
Kotlin Serialization and ProGuard are both powerful tools in the Kotlin ecosystem. However, they need to be used together carefully to avoid serialization issues caused by ProGuard's obfuscation. By understanding the core concepts, following the best practices, and thoroughly testing the code, developers can effectively use Kotlin Serialization in projects that also use ProGuard.

## References
- [Kotlin Serialization Documentation](https://kotlinlang.org/docs/serialization.html)
- [ProGuard Manual](https://www.guardsquare.com/manual/introduction)
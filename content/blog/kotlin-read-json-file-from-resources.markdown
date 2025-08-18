---
title: "Kotlin: Reading JSON Files from Resources"
description: "
In modern software development, working with JSON (JavaScript Object Notation) data is a common task. JSON is a lightweight data - interchange format that is easy for humans to read and write and easy for machines to parse and generate. Kotlin, a modern programming language that runs on the Java Virtual Machine (JVM), offers powerful features to handle JSON data. One common requirement is to read a JSON file stored in the project's resources directory. This blog post will guide you through the process of reading a JSON file from resources in Kotlin, covering core concepts, typical usage scenarios, and best practices.
"
date: 2025-08-18
modified: 2025-08-18
---

## Table of Contents
1. [Core Concepts](#core-concepts)
2. [Typical Usage Scenarios](#typical-usage-scenarios)
3. [Reading a JSON File from Resources in Kotlin](#reading-a-json-file-from-resources-in-kotlin)
4. [Best Practices](#best-practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Core Concepts
### Resources in Kotlin Projects
In a Kotlin project, the `resources` directory is a special directory where you can store files that are part of your application, such as configuration files, images, and JSON data. These resources are packaged with your application and can be accessed at runtime.

### JSON Parsing
JSON parsing is the process of converting a JSON string into a data structure that can be used in your Kotlin code. There are several libraries available for JSON parsing in Kotlin, such as Gson, Jackson, and Kotlinx Serialization.

## Typical Usage Scenarios
### Configuration Management
You can store application configuration data in a JSON file in the resources directory. For example, you might have a JSON file with database connection settings, API keys, or other configuration parameters. Reading this JSON file at startup allows you to easily manage and update your application's configuration.

### Mock Data for Testing
When writing unit tests, you may need to use mock data. Storing mock data in a JSON file in the resources directory makes it easy to manage and reuse the data across multiple tests.

### Initializing Data Structures
You can use a JSON file to initialize complex data structures in your application. For example, you might have a JSON file that represents a list of users or products, and you can read this file to populate a list or map in your Kotlin code.

## Reading a JSON File from Resources in Kotlin

### Using Kotlinx Serialization
Kotlinx Serialization is a Kotlin - native library for serialization and deserialization of data. Here is an example of how to read a JSON file from resources using Kotlinx Serialization:

```kotlin
import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import java.io.InputStreamReader

// Define a data class to represent the JSON structure
@Serializable
data class Person(val name: String, val age: Int)

fun main() {
    // Read the JSON file from resources
    val inputStream = Person::class.java.classLoader.getResourceAsStream("data.json")
    requireNotNull(inputStream) { "Resource not found" }
    val reader = InputStreamReader(inputStream)
    val jsonString = reader.readText()

    // Parse the JSON string
    val json = Json { ignoreUnknownKeys = true }
    val person = json.decodeFromString<Person>(jsonString)

    println(person)
}
```

In this example:
1. We first define a `Person` data class with `@Serializable` annotation to indicate that it can be serialized and deserialized.
2. We use the `getResourceAsStream` method to get an `InputStream` for the JSON file in the resources directory.
3. We read the contents of the file into a string using `InputStreamReader` and `readText`.
4. We create a `Json` instance with `ignoreUnknownKeys = true` to ignore any unknown keys in the JSON data.
5. Finally, we use `decodeFromString` to parse the JSON string into a `Person` object.

### Using Gson
Gson is a popular Java library for JSON parsing. Here is an example of how to read a JSON file from resources using Gson:

```kotlin
import com.google.gson.Gson
import java.io.InputStreamReader

// Define a data class to represent the JSON structure
data class Person(val name: String, val age: Int)

fun main() {
    // Read the JSON file from resources
    val inputStream = Person::class.java.classLoader.getResourceAsStream("data.json")
    requireNotNull(inputStream) { "Resource not found" }
    val reader = InputStreamReader(inputStream)
    val gson = Gson()
    val person = gson.fromJson(reader, Person::class.java)

    println(person)
}
```

In this example:
1. We define a `Person` data class to represent the JSON structure.
2. We use `getResourceAsStream` to get an `InputStream` for the JSON file.
3. We create an `InputStreamReader` to read the contents of the file.
4. We create a `Gson` instance and use the `fromJson` method to parse the JSON data into a `Person` object.

## Best Practices
### Error Handling
Always handle errors when reading the JSON file. In the examples above, we used `requireNotNull` to ensure that the resource exists. You should also handle exceptions that may occur during file reading or JSON parsing, such as `IOException` or `JsonSyntaxException`.

### Use Data Classes
Using data classes to represent the JSON structure makes your code more readable and maintainable. Data classes provide automatic getters, setters, `equals`, `hashCode`, and `toString` methods.

### Choose the Right JSON Library
Choose a JSON library based on your project's requirements. Kotlinx Serialization is a good choice for Kotlin - native projects, while Gson is a popular choice for Java - based projects with Kotlin interop.

## Conclusion
Reading a JSON file from resources in Kotlin is a common task that can be easily accomplished using libraries such as Kotlinx Serialization or Gson. By understanding the core concepts and following best practices, you can effectively manage JSON data in your Kotlin projects. Whether you are managing configuration data, using mock data for testing, or initializing data structures, reading JSON files from resources provides a flexible and convenient way to work with JSON data.

## References
- [Kotlinx Serialization Documentation](https://github.com/Kotlin/kotlinx.serialization)
- [Gson Documentation](https://github.com/google/gson)
- [Kotlin Documentation](https://kotlinlang.org/docs/home.html)
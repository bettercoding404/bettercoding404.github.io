---
title: "Kotlin Property Delegate: A Comprehensive Guide"
description: "
Kotlin property delegates are a powerful feature that allows you to reuse the logic of how a property gets its value or how it is stored. Instead of writing the same getter and setter code for multiple properties, you can delegate these responsibilities to a separate class or object. This not only reduces code duplication but also makes your code more modular and easier to maintain. In this blog post, we will explore the core concepts of Kotlin property delegates, their typical usage scenarios, and best practices.
"
date: 2025-08-13
modified: 2025-08-13
---

## Table of Contents
1. Core Concepts
    - What are Property Delegates?
    - Syntax
2. Typical Usage Scenarios
    - Lazy Initialization
    - Storing Properties in a Map
    - Observing Property Changes
3. Best Practices
    - Choosing the Right Delegate
    - Error Handling
    - Testing
4. Conclusion
5. References

## Core Concepts

### What are Property Delegates?
In Kotlin, a property delegate is an object that implements the `ReadWriteProperty` interface for mutable properties or the `ReadOnlyProperty` interface for read - only properties. These interfaces define the methods that are used to get and set the value of a property. When you delegate a property to an object, Kotlin calls the appropriate methods of the delegate object whenever the property is accessed or modified.

### Syntax
The syntax for using a property delegate is as follows:

```kotlin
// Read - only property delegate
val property: Type by delegate

// Mutable property delegate
var property: Type by delegate
```

Here, `delegate` is an object that implements the appropriate interface (`ReadOnlyProperty` for `val` and `ReadWriteProperty` for `var`).

Let's look at a simple example of a custom property delegate:

```kotlin
import kotlin.reflect.KProperty

// A simple read - only property delegate
class ReadOnlyDelegate : ReadOnlyProperty<Any?, String> {
    override fun getValue(thisRef: Any?, property: KProperty<*>): String {
        return "Hello from delegate"
    }
}

fun main() {
    // Using the delegate
    val myProperty: String by ReadOnlyDelegate()
    println(myProperty) // Output: Hello from delegate
}
```

In this example, the `ReadOnlyDelegate` class implements the `ReadOnlyProperty` interface. The `getValue` method is called whenever the `myProperty` is accessed, and it returns a fixed string.

## Typical Usage Scenarios

### Lazy Initialization
Lazy initialization is a common use case for property delegates. You can use the built - in `lazy` function to defer the initialization of a property until it is first accessed.

```kotlin
fun main() {
    val lazyValue: String by lazy {
        println("Initializing lazy value")
        "Lazy value"
    }

    println("Before accessing lazy value")
    println(lazyValue) // Initialization happens here
    println(lazyValue) // No re - initialization
}
```

In this example, the code inside the `lazy` block is executed only when `lazyValue` is first accessed. Subsequent accesses use the already initialized value.

### Storing Properties in a Map
You can use a property delegate to store properties in a map. This is useful when you have a dynamic set of properties that you want to manage in a single data structure.

```kotlin
import kotlin.reflect.KProperty

class MapDelegate(private val map: MutableMap<String, Any?>) : ReadWriteProperty<Any?, Any?> {
    override fun getValue(thisRef: Any?, property: KProperty<*>): Any? {
        return map[property.name]
    }

    override fun setValue(thisRef: Any?, property: KProperty<*>, value: Any?) {
        map[property.name] = value
    }
}

fun main() {
    val propertyMap = mutableMapOf<String, Any?>()
    var myProperty: String by MapDelegate(propertyMap)

    myProperty = "New value"
    println(propertyMap["myProperty"]) // Output: New value
}
```

In this example, the `MapDelegate` class stores the property values in a map. The `getValue` method retrieves the value from the map using the property name, and the `setValue` method updates the map with the new value.

### Observing Property Changes
You can use the `Delegates.observable` function to observe changes to a property.

```kotlin
import kotlin.properties.Delegates

fun main() {
    var observedValue: Int by Delegates.observable(0) { property, oldValue, newValue ->
        println("Property ${property.name} changed from $oldValue to $newValue")
    }

    observedValue = 10 // Output: Property observedValue changed from 0 to 10
    observedValue = 20 // Output: Property observedValue changed from 10 to 20
}
```

In this example, the lambda passed to `Delegates.observable` is called whenever the `observedValue` property is changed. It receives the property, the old value, and the new value as parameters.

## Best Practices

### Choosing the Right Delegate
When choosing a property delegate, consider the requirements of your use case. For lazy initialization, use the `lazy` function. If you need to store properties in a map, create a custom delegate like the `MapDelegate` shown above. For observing property changes, use `Delegates.observable`.

### Error Handling
When implementing custom property delegates, make sure to handle errors properly. For example, in the `MapDelegate` example, you may want to handle the case where the map does not contain the property key in a more graceful way.

```kotlin
import kotlin.reflect.KProperty

class MapDelegate(private val map: MutableMap<String, Any?>) : ReadWriteProperty<Any?, Any?> {
    override fun getValue(thisRef: Any?, property: KProperty<*>): Any? {
        return map[property.name] ?: throw IllegalArgumentException("Property ${property.name} not found in map")
    }

    override fun setValue(thisRef: Any?, property: KProperty<*>, value: Any?) {
        map[property.name] = value
    }
}
```

### Testing
When using property delegates, write unit tests to ensure that the delegate behaves as expected. For example, if you have a custom delegate, test the `getValue` and `setValue` methods separately.

```kotlin
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith
import org.junit.jupiter.api.Test

class MapDelegateTest {
    @Test
    fun testGetValue() {
        val map = mutableMapOf<String, Any?>()
        map["testProperty"] = "Test value"
        val delegate = MapDelegate(map)
        assertEquals("Test value", delegate.getValue(null, object : KProperty<Any?> {
            override val name: String = "testProperty"
            // Other methods can be implemented as empty stubs
            override val isConst: Boolean = false
            override val isLateinit: Boolean = false
            override val getter: Any = {}
            override val setter: Any = {}
        }))
    }

    @Test
    fun testGetValueNotFound() {
        val map = mutableMapOf<String, Any?>()
        val delegate = MapDelegate(map)
        assertFailsWith<IllegalArgumentException> {
            delegate.getValue(null, object : KProperty<Any?> {
                override val name: String = "nonExistentProperty"
                override val isConst: Boolean = false
                override val isLateinit: Boolean = false
                override val getter: Any = {}
                override val setter: Any = {}
            })
        }
    }
}
```

## Conclusion
Kotlin property delegates are a powerful feature that can significantly improve the modularity and maintainability of your code. By understanding the core concepts, typical usage scenarios, and best practices, you can effectively use property delegates in your Kotlin projects. Whether you need to perform lazy initialization, store properties in a map, or observe property changes, property delegates provide a flexible and reusable solution.

## References
- Kotlin official documentation: https://kotlinlang.org/docs/delegated-properties.html
- Effective Kotlin by Marcin Moskala: https://www.amazon.com/Effective-Kotlin-Marcin-Moskala/dp/1617295293
---
title: "Understanding Kotlin `@PublishedApi`"
description: "
In Kotlin, the `@PublishedApi` annotation plays a crucial role when it comes to the internal implementation of a library or a modular project. When developing a Kotlin library, you often have internal functions and classes that are used within the library but are not meant to be part of the public API. However, sometimes these internal components need to be accessed from other parts of the library, especially when dealing with inline functions. The `@PublishedApi` annotation allows you to expose internal declarations to inline functions while still keeping them hidden from the public API.
"
date: 2025-08-14
modified: 2025-08-14
---

## Table of Contents
1. Core Concepts
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts
### What is `@PublishedApi`?
The `@PublishedApi` annotation is used to make internal declarations accessible to inline functions in other modules or parts of the same library. In Kotlin, an `inline` function can expand its body at the call site, which means that if an inline function needs to access an internal declaration, it must be able to see it. By default, internal declarations are only visible within the same module. The `@PublishedApi` annotation overrides this behavior for inline functions.

### How it works
When you mark an internal declaration with `@PublishedApi`, Kotlin generates additional code to make that declaration accessible to inline functions. This way, you can keep the internal implementation details hidden from the public API while still allowing inline functions to use them.

## Typical Usage Scenarios
### Library Development
In library development, you want to expose a clean and stable public API to your users. However, you may have internal functions and classes that are used to implement the public API. The `@PublishedApi` annotation allows you to keep these internal components hidden from the public while still using them in inline functions.

### Modular Projects
In a modular project, different modules may need to share some internal functionality. The `@PublishedApi` annotation can be used to make internal declarations in one module accessible to inline functions in another module.

## Code Examples

### Example 1: Basic Usage
```kotlin
// Module 1: Internal declarations
internal fun internalFunction() {
    println("This is an internal function.")
}

// Inline function that needs to access the internal function
@PublishedApi
internal inline fun inlineFunction() {
    internalFunction()
}

// Module 2: Using the inline function
fun main() {
    // Call the inline function
    inlineFunction()
}
```
In this example, `internalFunction` is an internal function that is not part of the public API. The `inlineFunction` is marked with `@PublishedApi` to allow it to access the `internalFunction`. The `main` function in another module can call the `inlineFunction` without having direct access to the `internalFunction`.

### Example 2: Using `@PublishedApi` with Classes
```kotlin
// Internal class
internal class InternalClass {
    fun internalMethod() {
        println("This is an internal method.")
    }
}

// Inline function that uses the internal class
@PublishedApi
internal inline fun useInternalClass() {
    val internalObj = InternalClass()
    internalObj.internalMethod()
}

fun main() {
    useInternalClass()
}
```
In this example, the `InternalClass` is an internal class. The `useInternalClass` inline function is marked with `@PublishedApi` to allow it to create an instance of the `InternalClass` and call its internal method.

## Best Practices
- **Limit the Use of `@PublishedApi`**: Only use `@PublishedApi` when necessary. Overusing it can lead to a leaky abstraction and make it harder to maintain the internal implementation of your library.
- **Document the Use of `@PublishedApi`**: Clearly document which declarations are marked with `@PublishedApi` and why. This will help other developers understand the internal implementation and avoid accidentally relying on internal details.
- **Keep the Internal API Stable**: Even though the internal API is not part of the public API, it should still be kept stable. Changes to the internal API can break the functionality of inline functions that rely on it.

## Conclusion
The `@PublishedApi` annotation in Kotlin is a powerful tool for library developers and modular project maintainers. It allows you to keep the internal implementation details hidden from the public API while still allowing inline functions to access them. By following the best practices, you can use `@PublishedApi` effectively and maintain a clean and stable public API.

## References
- [Kotlin Documentation: Visibility Modifiers](https://kotlinlang.org/docs/visibility-modifiers.html)
- [Kotlin Language Specification: @PublishedApi](https://kotlinlang.org/spec/annotations.html#publishedapi-annotation)
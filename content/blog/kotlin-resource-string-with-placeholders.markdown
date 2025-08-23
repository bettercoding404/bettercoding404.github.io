---
title: "Kotlin Resource String with Placeholders"
description: "
In Android development, managing strings is a crucial aspect, especially when it comes to localization and dynamic content. Kotlin provides a powerful way to handle strings through resource files. One of the most useful features is the ability to use placeholders in resource strings. Placeholders allow you to insert dynamic values into strings at runtime, making your app more flexible and user - friendly. This blog post will explore the core concepts, typical usage scenarios, and best practices related to Kotlin resource strings with placeholders.
"
date: 2025-08-23
modified: 2025-08-23
---

## Table of Contents
1. Core Concepts
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts
### Resource Strings in Android
In Android, string resources are stored in XML files located in the `res/values` directory. These files are used to store all the text that your app displays. By using resource strings, you can easily manage and localize your app's text.

### Placeholders
Placeholders are special tokens in a string resource that can be replaced with dynamic values at runtime. In Android, placeholders are represented using the `%` symbol followed by a format specifier. For example, `%s` is used for strings, `%d` for integers, and `%f` for floating - point numbers.

When you retrieve a string with placeholders in Kotlin, you need to provide the actual values to replace the placeholders.

## Typical Usage Scenarios
### Localization
When you are developing a multi - language app, you need to provide translations for all the strings in your app. Placeholders make it easier to manage translations because the structure of the sentence remains the same across different languages, and only the values change.

### Dynamic Content
If your app displays user - specific information, such as a welcome message with the user's name or a notification with the number of new messages, placeholders are essential. You can use a single string resource and insert different values depending on the user's data.

### Formatting Numbers and Dates
Placeholders can also be used to format numbers and dates. For example, you can display a price with the correct currency symbol or a date in the user's preferred format.

## Code Examples
### Defining a String with Placeholders in XML
First, let's define a string with placeholders in the `strings.xml` file:
```xml
<!-- strings.xml -->
<resources>
    <string name="welcome_message">Welcome, %s! You have %d new messages.</string>
</resources>
```

### Using the String with Placeholders in Kotlin
```kotlin
// MainActivity.kt
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Get the TextView where we will display the message
        val textView = findViewById<TextView>(R.id.textView)

        // Define the values to replace the placeholders
        val userName = "John"
        val newMessagesCount = 5

        // Retrieve the string with placeholders and insert the values
        val welcomeMessage = getString(R.string.welcome_message, userName, newMessagesCount)

        // Set the text of the TextView
        textView.text = welcomeMessage
    }
}
```
In this example, we first define a string with two placeholders in the `strings.xml` file. Then, in the Kotlin code, we retrieve the string using the `getString` method and pass the values to replace the placeholders. Finally, we set the text of a `TextView` to the resulting string.

### Formatting Numbers
```xml
<!-- strings.xml -->
<resources>
    <string name="price_format">The price is %.2f dollars.</string>
</resources>
```
```kotlin
// MainActivity.kt
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textView = findViewById<TextView>(R.id.textView)

        val price = 9.99

        val priceMessage = getString(R.string.price_format, price)

        textView.text = priceMessage
    }
}
```
In this example, we use the `%.2f` placeholder to format a floating - point number with two decimal places.

## Best Practices
### Keep Placeholder Order Consistent
When defining strings with multiple placeholders, make sure to keep the order of the placeholders consistent across all translations. This will ensure that the values are inserted correctly in all languages.

### Use Descriptive Placeholder Names
Although Android doesn't support named placeholders directly, you can use comments in the `strings.xml` file to describe the purpose of each placeholder. This makes the code more readable and easier to maintain.

```xml
<!-- strings.xml -->
<resources>
    <!-- %1$s is the user's name, %2$d is the number of new messages -->
    <string name="welcome_message">Welcome, %1$s! You have %2$d new messages.</string>
</resources>
```

### Validate Input Values
Before inserting values into placeholders, make sure to validate them. For example, if you are using a `%d` placeholder, ensure that the value is an integer. Otherwise, you may encounter a `NumberFormatException`.

## Conclusion
Kotlin resource strings with placeholders are a powerful feature in Android development. They provide a flexible and efficient way to manage dynamic content and localize your app. By understanding the core concepts, typical usage scenarios, and best practices, you can use placeholders effectively in your projects. Whether you are displaying user - specific information or formatting numbers, placeholders can help you create a more user - friendly and maintainable app.

## References
- Android Developers Documentation: [Strings Resources](https://developer.android.com/guide/topics/resources/string-resource)
- Kotlin Documentation: [String Templates](https://kotlinlang.org/docs/string-templates.html)
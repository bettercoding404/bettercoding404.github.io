---
title: "Understanding `registerReceiver` in Kotlin"
description: "
In Android development, handling system events and broadcasts is a crucial part of building interactive and responsive applications. One of the key mechanisms to achieve this is by using the `registerReceiver` method. In the context of Kotlin, which has become the preferred language for Android development, `registerReceiver` provides a way to register a `BroadcastReceiver` to listen for particular system or application - level broadcasts. This blog post will delve into the core concepts, typical usage scenarios, and best practices associated with `registerReceiver` in Kotlin.
"
date: 2025-08-21
modified: 2025-08-21
---

## Table of Contents
1. Core Concepts
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts

### BroadcastReceiver
A `BroadcastReceiver` is a component in Android that allows applications to receive system or application - level broadcasts. These broadcasts can be related to various events such as battery low, screen on/off, or custom intents sent by other applications.

### registerReceiver
The `registerReceiver` method is used to register a `BroadcastReceiver` with the Android system. It takes two main parameters:
- A `BroadcastReceiver` instance: This is the receiver that will handle the incoming broadcasts.
- An `IntentFilter`: It specifies the types of broadcasts the receiver is interested in. The `IntentFilter` can be configured to listen for specific actions, categories, or data types.

### Unregistering the Receiver
It is important to unregister the `BroadcastReceiver` when it is no longer needed. Failure to do so can lead to memory leaks, as the receiver will continue to hold references to the context and other resources. This is typically done using the `unregisterReceiver` method.

## Typical Usage Scenarios

### System Events
Applications can use `registerReceiver` to listen for system - wide events. For example, an application may want to be notified when the device's battery is low so that it can take appropriate actions such as saving user data or reducing resource consumption.

### Custom Intents
Developers can also use `registerReceiver` to handle custom intents sent within their own application. For instance, if one part of the application needs to communicate with another part, it can send a custom intent, and a `BroadcastReceiver` can be registered to handle that intent.

### Third - Party Integrations
When integrating with third - party services or libraries, `registerReceiver` can be used to listen for broadcasts sent by those services. For example, a payment gateway library may send a broadcast to indicate the success or failure of a payment transaction.

## Code Examples

### Listening for Battery Low Broadcast
```kotlin
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.util.Log

class BatteryLowActivity : AppCompatActivity() {

    // Create a BroadcastReceiver to handle the battery low event
    private val batteryLowReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (Intent.ACTION_BATTERY_LOW == intent?.action) {
                Log.d("BatteryLowActivity", "Battery is low!")
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_battery_low)

        // Create an IntentFilter to listen for the battery low action
        val filter = IntentFilter(Intent.ACTION_BATTERY_LOW)

        // Register the receiver
        registerReceiver(batteryLowReceiver, filter)
    }

    override fun onDestroy() {
        super.onDestroy()
        // Unregister the receiver to avoid memory leaks
        unregisterReceiver(batteryLowReceiver)
    }
}
```
In this example, we create a `BroadcastReceiver` to handle the `ACTION_BATTERY_LOW` broadcast. We register the receiver in the `onCreate` method and unregister it in the `onDestroy` method.

### Handling Custom Intents
```kotlin
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.Toast

class CustomIntentActivity : AppCompatActivity() {

    companion object {
        const val CUSTOM_ACTION = "com.example.CUSTOM_ACTION"
    }

    private val customReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (CUSTOM_ACTION == intent?.action) {
                Toast.makeText(context, "Custom intent received!", Toast.LENGTH_SHORT).show()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_custom_intent)

        val filter = IntentFilter(CUSTOM_ACTION)
        registerReceiver(customReceiver, filter)

        // Send a custom intent
        val customIntent = Intent(CUSTOM_ACTION)
        sendBroadcast(customIntent)
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(customReceiver)
    }
}
```
In this example, we define a custom action and create a `BroadcastReceiver` to handle it. We register the receiver and then send a custom intent using the `sendBroadcast` method.

## Best Practices

### Unregister the Receiver
As mentioned earlier, always unregister the `BroadcastReceiver` when it is no longer needed. This is typically done in the `onDestroy` method of an activity or in the `onDestroyView` method of a fragment.

### Use LocalBroadcastManager for Internal Communication
If you are only interested in handling broadcasts within your own application, consider using `LocalBroadcastManager`. It is more efficient and secure than the global `registerReceiver` method as it only allows broadcasts to be sent and received within the same application.

### Handle Concurrency
When handling broadcasts, be aware of concurrency issues. Multiple broadcasts may be received simultaneously, so make sure your `BroadcastReceiver` code is thread - safe.

## Conclusion
The `registerReceiver` method in Kotlin is a powerful tool for handling system and application - level broadcasts in Android development. By understanding the core concepts, typical usage scenarios, and best practices, intermediate - to - advanced software engineers can effectively use `registerReceiver` to build more interactive and responsive applications. However, it is important to remember to unregister the receiver to avoid memory leaks and to handle concurrency issues appropriately.

## References
- Android Developers Documentation: https://developer.android.com/reference/android/content/Context#registerReceiver(android.content.BroadcastReceiver,%20android.content.IntentFilter)
- Kotlin Programming Language Documentation: https://kotlinlang.org/
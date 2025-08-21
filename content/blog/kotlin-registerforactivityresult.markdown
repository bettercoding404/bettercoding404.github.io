---
title: "Mastering `registerForActivityResult` in Kotlin"
description: "
In Android development, starting activities and handling their results has traditionally been a somewhat cumbersome process. The old `startActivityForResult` method, which was the standard way to launch an activity and receive a result, had several limitations. It required overriding the `onActivityResult` method in the activity or fragment, which made the code less modular and harder to manage, especially in complex scenarios.  Kotlin's `registerForActivityResult` is a new and improved way to handle activity results in Android. It provides a more straightforward and type - safe approach, making the code cleaner and easier to understand. This blog post will explore the core concepts, typical usage scenarios, and best practices of `registerForActivityResult`.
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
### What is `registerForActivityResult`?
`registerForActivityResult` is a function introduced in the AndroidX Activity and Fragment libraries. It allows you to register a launcher for an activity result in a more modular and type - safe way. Instead of overriding the `onActivityResult` method, you define a launcher with a specific contract that describes how to start the activity and how to handle the result.

### Contracts
A contract is a key concept in `registerForActivityResult`. It defines the input and output types of the activity launch and result handling. Android provides several pre - defined contracts for common use cases, such as taking a picture, selecting a file, or requesting permissions. You can also create your own custom contracts if needed.

### Launchers
Once you have a contract, you can use `registerForActivityResult` to create a launcher. The launcher is an object that you can call to start the activity with the appropriate input. When the activity finishes, the result is automatically passed to the callback you provided when registering the launcher.

## Typical Usage Scenarios
### 1. Requesting Permissions
One of the most common use cases is requesting runtime permissions. In the past, you had to handle permission requests in a rather complex way, including handling permission results in the `onRequestPermissionsResult` method. With `registerForActivityResult`, you can simplify this process.

### 2. Starting Another Activity for Result
Whether you want to launch a settings activity, a login activity, or any other activity that returns a result, `registerForActivityResult` makes it easier to manage the result handling.

### 3. Using System Intents
System intents like taking a picture, picking a contact, or selecting a file can be easily handled with `registerForActivityResult` and the appropriate contracts.

## Code Examples

### Requesting Permissions
```kotlin
import android.Manifest
import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts

class PermissionActivity : ComponentActivity() {
    // Create a launcher for requesting permissions
    private val requestPermissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { isGranted: Boolean ->
        if (isGranted) {
            // Permission is granted
            Toast.makeText(this, "Permission granted", Toast.LENGTH_SHORT).show()
        } else {
            // Permission is denied
            Toast.makeText(this, "Permission denied", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Request the permission
        requestPermissionLauncher.launch(Manifest.permission.CAMERA)
    }
}
```
In this example, we create a launcher using the `ActivityResultContracts.RequestPermission` contract. When the launcher is called with the `CAMERA` permission, the system shows a permission dialog. The result of the permission request is then handled in the callback.

### Starting Another Activity for Result
```kotlin
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts

class MainActivity : ComponentActivity() {
    // Create a launcher for starting an activity for result
    private val startForResult = registerForActivityResult(
        ActivityResultContracts.StartActivityForResult()
    ) { result ->
        if (result.resultCode == RESULT_OK) {
            val data = result.data
            val resultText = data?.getStringExtra("result")
            findViewById<TextView>(R.id.result_text).text = resultText
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<Button>(R.id.start_activity_button).setOnClickListener {
            val intent = Intent(this, SecondActivity::class.java)
            // Start the activity using the launcher
            startForResult.launch(intent)
        }
    }
}

class SecondActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_second)

        val resultIntent = Intent()
        resultIntent.putExtra("result", "This is the result")
        setResult(RESULT_OK, resultIntent)
        finish()
    }
}
```
In this example, we create a launcher using the `ActivityResultContracts.StartActivityForResult` contract. When the button is clicked, we launch the `SecondActivity` using the launcher. When the `SecondActivity` finishes, the result is handled in the callback.

## Best Practices
### 1. Initialize Launchers Early
It's important to initialize the launchers early, preferably in the `onCreate` method of the activity or fragment. This ensures that the launcher is ready to be used when needed.

### 2. Keep Callbacks Simple
The callbacks for handling the results should be kept simple. Avoid performing complex operations directly in the callback. Instead, call other methods or use view models to handle the result.

### 3. Use View Models for Data Handling
If the result needs to be shared across different parts of the application, consider using view models to store and manage the data. This helps in keeping the code more organized and modular.

## Conclusion
`registerForActivityResult` is a powerful and convenient feature in Kotlin for Android development. It simplifies the process of starting activities and handling their results, making the code more modular and type - safe. By understanding the core concepts, typical usage scenarios, and best practices, you can effectively use `registerForActivityResult` in your projects and improve the overall quality of your code.

## References
- [Android Developers Documentation - Activity Result API](https://developer.android.com/training/basics/intents/result)
- [Kotlin Android Extensions - Working with Activity Results](https://kotlinlang.org/docs/android-activity-results.html)
---
title: "Mastering `runOnUiThread` in Kotlin"
description: "
In Android development, the user interface (UI) is single - threaded. This means that all UI updates must occur on the main thread, also known as the UI thread. If you try to update the UI from a background thread, you'll likely encounter a `CalledFromWrongThreadException`, which can lead to application crashes.   Kotlin provides a convenient way to handle UI updates from background threads using the `runOnUiThread` method. This method allows you to execute a block of code on the UI thread, ensuring that any UI - related operations are performed safely. In this blog post, we'll explore the core concepts, typical usage scenarios, and best practices related to `runOnUiThread` in Kotlin.
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
The `runOnUiThread` method is a member of the `Activity` class in Android. It takes a `Runnable` object as a parameter and schedules the `Runnable` to run on the main UI thread. When you call `runOnUiThread`, the system adds the `Runnable` to the UI thread's message queue. The UI thread then processes this message at the next available opportunity and executes the code inside the `Runnable`.

Here is a simple example of how `runOnUiThread` works conceptually:
```kotlin
// Inside an Activity
val runnable = Runnable {
    // Code to update the UI
    textView.text = "Hello, World!"
}
runOnUiThread(runnable)
```
In this example, the code inside the `Runnable` will be executed on the UI thread, allowing us to safely update the `textView`'s text.

## Typical Usage Scenarios
### 1. Updating UI after Network Operations
When performing network operations, such as making an HTTP request, these operations are typically done on a background thread to avoid blocking the UI. Once the network operation is complete, you need to update the UI with the received data. `runOnUiThread` can be used to safely perform these UI updates.

### 2. Updating UI after Long - Running Computations
If you have a long - running computation, like complex mathematical calculations or file processing, it should be done on a background thread. After the computation is finished, you can use `runOnUiThread` to update the UI with the results.

### 3. Animating UI Elements
Animating UI elements often requires frequent updates to the UI. If you want to perform animations based on some background events or calculations, `runOnUiThread` can be used to ensure that the animation updates are done on the UI thread.

## Code Examples

### Example 1: Updating UI after Network Operation
```kotlin
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import okhttp3.OkHttpClient
import okhttp3.Request

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textView = findViewById<TextView>(R.id.textView)

        // Perform network operation on a background thread
        GlobalScope.launch(Dispatchers.IO) {
            val client = OkHttpClient()
            val request = Request.Builder()
               .url("https://jsonplaceholder.typicode.com/todos/1")
               .build()

            val response = client.newCall(request).execute()
            if (response.isSuccessful) {
                val result = response.body?.string()
                // Update UI on the main thread
                runOnUiThread {
                    textView.text = result
                }
            }
        }
    }
}
```
In this example, we use Kotlin Coroutines to perform a network operation on a background thread (`Dispatchers.IO`). Once the network operation is complete, we use `runOnUiThread` to update the `textView` with the received data.

### Example 2: Updating UI after Long - Running Computation
```kotlin
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textView = findViewById<TextView>(R.id.textView)

        // Perform long - running computation on a background thread
        GlobalScope.launch(Dispatchers.Default) {
            val result = performLongRunningComputation()
            // Update UI on the main thread
            runOnUiThread {
                textView.text = "Result: $result"
            }
        }
    }

    private fun performLongRunningComputation(): Int {
        var sum = 0
        for (i in 1..1000000) {
            sum += i
        }
        return sum
    }
}
```
Here, we perform a long - running computation on a background thread using Kotlin Coroutines (`Dispatchers.Default`). After the computation is done, we use `runOnUiThread` to update the `textView` with the result.

## Best Practices
### 1. Use Coroutines or AsyncTask Wisely
While `runOnUiThread` is a simple way to update the UI from a background thread, it's often better to use more structured concurrency mechanisms like Kotlin Coroutines or Android's `AsyncTask` (although `AsyncTask` is deprecated in newer Android versions). Coroutines provide better control over the lifecycle of background tasks and can make your code more readable and maintainable.

### 2. Keep UI Updates Minimal
When using `runOnUiThread`, try to keep the code inside the `Runnable` as minimal as possible. Avoid performing long - running operations or complex calculations inside the `Runnable` as it can block the UI thread and cause the app to become unresponsive.

### 3. Check Activity Lifecycle
Before using `runOnUiThread`, make sure that the activity is still valid. If the activity has been destroyed, calling `runOnUiThread` can lead to crashes. You can use the `isFinishing` or `isDestroyed` methods of the activity to check its state.

```kotlin
if (!isFinishing &&!isDestroyed) {
    runOnUiThread {
        // Update UI
    }
}
```

## Conclusion
The `runOnUiThread` method in Kotlin is a powerful tool for updating the UI from background threads in Android development. It ensures that all UI - related operations are performed on the main UI thread, preventing crashes due to incorrect thread usage. However, it's important to use it in conjunction with other concurrency mechanisms and follow best practices to write robust and efficient code. By understanding the core concepts, typical usage scenarios, and best practices, you can effectively use `runOnUiThread` in your Android applications.

## References
- Android Developers Documentation: https://developer.android.com/
- Kotlin Coroutines Documentation: https://kotlinlang.org/docs/coroutines-overview.html
- OkHttp Documentation: https://square.github.io/okhttp/
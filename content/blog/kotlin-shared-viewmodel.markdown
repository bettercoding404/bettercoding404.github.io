---
title: "Kotlin Shared ViewModel: A Comprehensive Guide"
description: "
In modern Android development, the Model - View - ViewModel (MVVM) architecture has become a popular choice for building robust and maintainable applications. The ViewModel class, introduced by the Android Architecture Components, plays a crucial role in separating the UI logic from the business logic. A Shared ViewModel, as the name suggests, is a ViewModel that can be shared across multiple fragments or activities. This allows different parts of the application to communicate and share data in a structured and lifecycle - aware manner. In this blog post, we will explore the core concepts, typical usage scenarios, and best practices of Kotlin Shared ViewModel.
"
date: 2025-08-24
modified: 2025-08-24
---

## Table of Contents
1. Core Concepts of Kotlin Shared ViewModel
2. Typical Usage Scenarios
3. Code Examples
4. Best Practices
5. Conclusion
6. References

## Core Concepts of Kotlin Shared ViewModel

### ViewModel Basics
The ViewModel class is designed to store and manage UI - related data in a lifecycle - conscious way. It survives configuration changes such as screen rotations, ensuring that the data remains available to the UI without being re - fetched or re - computed.

### Shared ViewModel
A Shared ViewModel is a ViewModel instance that can be accessed by multiple fragments or activities. It is typically scoped to the activity level, which means that all fragments within the same activity can share the same ViewModel instance. This sharing of data between different UI components helps in reducing code duplication and maintaining a single source of truth.

### Lifecycle Awareness
One of the key features of the ViewModel is its lifecycle awareness. The ViewModel is automatically cleared when the associated activity or fragment is destroyed (except in the case of configuration changes). This ensures that there are no memory leaks and that the resources are managed efficiently.

## Typical Usage Scenarios

### Data Sharing between Fragments
When you have multiple fragments within an activity that need to share data, a Shared ViewModel can be used. For example, in a news application, one fragment might display a list of articles, and another fragment might show the details of a selected article. The Shared ViewModel can hold the selected article data, allowing the details fragment to access it.

### Navigation and State Management
During navigation between different screens in an application, a Shared ViewModel can be used to maintain the state. For instance, in a multi - step form, the Shared ViewModel can store the user's input across different steps, ensuring that the data is not lost when the user navigates back and forth.

## Code Examples

### Step 1: Add Dependencies
First, make sure you have the necessary dependencies in your `build.gradle` file:
```groovy
dependencies {
    def lifecycle_version = "2.4.1"
    implementation "androidx.lifecycle:lifecycle - viewmodel - ktx:$lifecycle_version"
    implementation "androidx.lifecycle:lifecycle - livedata - ktx:$lifecycle_version"
}
```

### Step 2: Create a Shared ViewModel
```kotlin
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class SharedViewModel : ViewModel() {
    // MutableLiveData to hold the shared data
    val selectedItem = MutableLiveData<String>()

    // Method to update the selected item
    fun selectItem(item: String) {
        selectedItem.value = item
    }
}
```

### Step 3: Use the Shared ViewModel in Fragments
#### Fragment 1: Setting the Data
```kotlin
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.example.sharedviewmodel.databinding.FragmentOneBinding

class FragmentOne : Fragment() {

    private var _binding: FragmentOneBinding? = null
    private val binding get() = _binding!!
    private lateinit var sharedViewModel: SharedViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentOneBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        // Get the shared ViewModel instance
        sharedViewModel = ViewModelProvider(requireActivity())[SharedViewModel::class.java]

        binding.button.setOnClickListener {
            val item = "Selected Item"
            // Update the shared data
            sharedViewModel.selectItem(item)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
```

#### Fragment 2: Observing the Data
```kotlin
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.example.sharedviewmodel.databinding.FragmentTwoBinding

class FragmentTwo : Fragment() {

    private var _binding: FragmentTwoBinding? = null
    private val binding get() = _binding!!
    private lateinit var sharedViewModel: SharedViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentTwoBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        // Get the shared ViewModel instance
        sharedViewModel = ViewModelProvider(requireActivity())[SharedViewModel::class.java]

        // Observe the shared data
        sharedViewModel.selectedItem.observe(viewLifecycleOwner) { item ->
            binding.textView.text = item
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}
```

## Best Practices

### Keep the ViewModel Focused
The ViewModel should only contain the data and logic related to the UI. Avoid putting business logic that belongs to other layers, such as the repository or use cases, in the ViewModel.

### Use LiveData for Data Updates
LiveData is a lifecycle - aware observable data holder. It ensures that the UI is updated only when the data changes and the observer is in an active state. This helps in preventing memory leaks and unnecessary UI updates.

### Follow the Single Responsibility Principle
Each ViewModel should have a single responsibility. If you find that a ViewModel is doing too many things, consider splitting it into multiple ViewModels.

## Conclusion
Kotlin Shared ViewModel is a powerful tool in Android development that allows different UI components to share data in a lifecycle - aware and structured way. By understanding the core concepts, typical usage scenarios, and best practices, intermediate - to - advanced software engineers can effectively use Shared ViewModel to build more maintainable and robust applications.

## References
- Android Developers Documentation: https://developer.android.com/topic/libraries/architecture/viewmodel
- Kotlin Documentation: https://kotlinlang.org/
- Android Architecture Components codelabs: https://developer.android.com/codelabs/android - architecture - components
---
title:  C语言设计模式之策略模式
description:  简介在软件开发过程中，我们常常会遇到这样的情况：一个系统需要根据不同的条件执行不同的算法或行为。传统的做法可能是使用大量的条件判断语句（如`if-else`或`switch`），但随着业务逻辑的复杂，代码会变得难以维护和扩展。策略模式就是为了解决这类问题而诞生的一种设计模式。它将算法的定义和使用分离开来，使得算法可以独立于使用它的客户端而变化，提高了代码的可维护性和可扩展性。在C语言中，虽然没有像面向对象语言那样直接的类和继承等概念，但我们依然可以通过函数指针和结构体等方式来实现策略模式。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发过程中，我们常常会遇到这样的情况：一个系统需要根据不同的条件执行不同的算法或行为。传统的做法可能是使用大量的条件判断语句（如`if-else`或`switch`），但随着业务逻辑的复杂，代码会变得难以维护和扩展。策略模式就是为了解决这类问题而诞生的一种设计模式。它将算法的定义和使用分离开来，使得算法可以独立于使用它的客户端而变化，提高了代码的可维护性和可扩展性。在C语言中，虽然没有像面向对象语言那样直接的类和继承等概念，但我们依然可以通过函数指针和结构体等方式来实现策略模式。

## 目录
1. 策略模式基础概念
2. 使用方法
    - 定义策略接口
    - 实现具体策略
    - 使用策略
3. 常见实践
    - 排序算法示例
    - 图形绘制示例
4. 最佳实践
    - 代码结构优化
    - 错误处理
    - 代码复用
5. 小结

## 策略模式基础概念
策略模式定义了一系列算法，将每个算法都封装起来，并且使它们之间可以互换。在策略模式中，有三个主要的角色：
- **上下文（Context）**：持有一个策略对象的引用，负责调用策略对象的算法。
- **策略（Strategy）**：定义了一个公共接口，所有具体的策略都必须实现这个接口。
- **具体策略（Concrete Strategy）**：实现了策略接口中定义的算法。

## 使用方法

### 定义策略接口
在C语言中，我们可以通过函数指针来定义策略接口。例如，假设我们有一个计算两个整数之和的策略接口：
```c
// 定义策略接口
typedef int (*CalculateStrategy)(int a, int b);
```
这里定义了一个函数指针类型`CalculateStrategy`，它指向一个返回`int`类型，接受两个`int`类型参数的函数。

### 实现具体策略
接下来，我们实现具体的策略。比如，实现加法和乘法两种具体策略：
```c
// 加法策略
int add(int a, int b) {
    return a + b;
}

// 乘法策略
int multiply(int a, int b) {
    return a * b;
}
```

### 使用策略
最后，我们创建一个上下文对象，在这个对象中使用不同的策略：
```c
// 上下文结构体
typedef struct {
    CalculateStrategy strategy;
} Context;

// 设置上下文的策略
void setStrategy(Context *context, CalculateStrategy strategy) {
    context->strategy = strategy;
}

// 执行策略
int executeStrategy(Context *context, int a, int b) {
    return context->strategy(a, b);
}

#include <stdio.h>

int main() {
    Context context;

    // 使用加法策略
    setStrategy(&context, add);
    int result1 = executeStrategy(&context, 3, 5);
    printf("加法结果: %d\n", result1);

    // 使用乘法策略
    setStrategy(&context, multiply);
    int result2 = executeStrategy(&context, 3, 5);
    printf("乘法结果: %d\n", result2);

    return 0;
}
```
在上述代码中，`Context`结构体持有一个`CalculateStrategy`类型的函数指针，通过`setStrategy`函数可以设置不同的策略，`executeStrategy`函数则负责执行当前设置的策略。

## 常见实践

### 排序算法示例
假设有多种排序算法，如冒泡排序和快速排序，我们可以使用策略模式来实现。
```c
// 策略接口：排序函数指针
typedef void (*SortStrategy)(int *arr, int size);

// 冒泡排序策略
void bubbleSort(int *arr, int size) {
    int i, j;
    for (i = 0; i < size - 1; i++) {
        for (j = 0; j < size - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

// 快速排序策略
void quickSort(int *arr, int low, int high) {
    if (low < high) {
        int pi = arr[high];
        int i = (low - 1);
        for (int j = low; j <= high - 1; j++) {
            if (arr[j] < pi) {
                i++;
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
        int temp = arr[i + 1];
        arr[i + 1] = arr[high];
        arr[high] = temp;
        int piIndex = i + 1;
        quickSort(arr, low, piIndex - 1);
        quickSort(arr, piIndex + 1, high);
    }
}

// 上下文结构体
typedef struct {
    SortStrategy strategy;
} SortContext;

// 设置排序策略
void setSortStrategy(SortContext *context, SortStrategy strategy) {
    context->strategy = strategy;
}

// 执行排序策略
void executeSort(SortContext *context, int *arr, int size) {
    context->strategy(arr, size);
}

#include <stdio.h>

void printArray(int *arr, int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90};
    int size = sizeof(arr) / sizeof(arr[0]);

    SortContext context;

    // 使用冒泡排序策略
    setSortStrategy(&context, bubbleSort);
    executeSort(&context, arr, size);
    printf("冒泡排序结果: ");
    printArray(arr, size);

    // 使用快速排序策略
    setSortStrategy(&context, quickSort);
    executeSort(&context, arr, size);
    printf("快速排序结果: ");
    printArray(arr, size);

    return 0;
}
```

### 图形绘制示例
假设有不同类型的图形（如圆形、矩形），每种图形有自己的绘制方法。
```c
// 策略接口：绘制图形函数指针
typedef void (*DrawStrategy)();

// 绘制圆形策略
void drawCircle() {
    printf("绘制圆形\n");
}

// 绘制矩形策略
void drawRectangle() {
    printf("绘制矩形\n");
}

// 上下文结构体
typedef struct {
    DrawStrategy strategy;
} DrawContext;

// 设置绘制策略
void setDrawStrategy(DrawContext *context, DrawStrategy strategy) {
    context->strategy = strategy;
}

// 执行绘制策略
void executeDraw(DrawContext *context) {
    context->strategy();
}

#include <stdio.h>

int main() {
    DrawContext context;

    // 使用绘制圆形策略
    setDrawStrategy(&context, drawCircle);
    executeDraw(&context);

    // 使用绘制矩形策略
    setDrawStrategy(&context, drawRectangle);
    executeDraw(&context);

    return 0;
}
```

## 最佳实践

### 代码结构优化
将相关的策略函数和上下文结构体定义放在一个独立的头文件和源文件中，提高代码的模块化程度。例如，对于排序策略，可以创建`sort_strategy.h`和`sort_strategy.c`文件。

### 错误处理
在策略函数和上下文函数中添加适当的错误处理机制。比如，在执行策略前检查输入参数的有效性，在策略执行过程中捕获可能出现的错误并进行处理。

### 代码复用
尽量将通用的策略逻辑封装成可复用的函数，避免重复代码。例如，在排序算法中，可以将交换元素的逻辑封装成一个独立的函数。

## 小结
策略模式在C语言中是一种非常实用的设计模式，它通过将算法的定义和使用分离，使得代码更加灵活、可维护和可扩展。通过函数指针和结构体等方式，我们可以轻松地实现策略模式。在实际应用中，遵循最佳实践可以进一步提高代码的质量和性能。希望通过本文的介绍，读者能够深入理解并在实际项目中高效使用C语言的策略模式。
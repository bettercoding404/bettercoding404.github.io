---
title:  C语言设计模式之模板模式：从基础到实践
description:  简介在软件开发中，设计模式是经过反复实践总结出来的通用解决方案，能够帮助开发者更高效地构建软件系统。模板模式（Template Pattern）作为一种行为型设计模式，在C语言开发中具有重要的应用价值。它定义了一个操作中的算法骨架，而将一些步骤延迟到子类中实现，使得子类可以在不改变算法结构的情况下重新定义该算法的某些特定步骤。本文将深入探讨C语言中模板模式的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一强大的设计模式。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发中，设计模式是经过反复实践总结出来的通用解决方案，能够帮助开发者更高效地构建软件系统。模板模式（Template Pattern）作为一种行为型设计模式，在C语言开发中具有重要的应用价值。它定义了一个操作中的算法骨架，而将一些步骤延迟到子类中实现，使得子类可以在不改变算法结构的情况下重新定义该算法的某些特定步骤。本文将深入探讨C语言中模板模式的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一强大的设计模式。

## 目录
1. **模板模式基础概念**
    - 定义与原理
    - 结构与角色
2. **C语言中模板模式的使用方法**
    - 基本实现步骤
    - 代码示例
3. **常见实践**
    - 在文件处理中的应用
    - 在排序算法中的应用
4. **最佳实践**
    - 遵循单一职责原则
    - 合理使用指针与函数指针
    - 代码复用与扩展
5. **小结**

## 模板模式基础概念
### 定义与原理
模板模式定义了一个操作的通用流程或算法框架，将具体的实现细节留给子类去完成。其核心原理是通过继承和多态，使得子类可以根据自身需求定制算法中的某些步骤，同时保持整体算法结构的一致性。这种模式在需要复用通用算法结构，但部分步骤因具体情况而异的场景中非常有用。

### 结构与角色
模板模式通常包含以下几个角色：
- **抽象类（Abstract Class）**：定义了模板方法（Template Method），该方法包含了算法的骨架，由一系列步骤组成，其中一些步骤可以是抽象的，需要子类实现。
- **具体子类（Concrete Subclass）**：继承自抽象类，实现抽象类中定义的抽象步骤，提供具体的实现细节。

## C语言中模板模式的使用方法
### 基本实现步骤
1. **定义抽象类**：在C语言中，可以通过结构体和函数指针来模拟抽象类。定义一个结构体，其中包含指向各个步骤函数的指针，以及一个模板方法函数指针。
2. **定义抽象步骤函数指针**：在抽象类结构体中，声明指向各个抽象步骤函数的指针，这些函数将由具体子类实现。
3. **定义模板方法**：在抽象类结构体中，定义一个模板方法函数指针，该函数按照固定的顺序调用各个抽象步骤函数。
4. **实现具体子类**：创建具体子类结构体，继承抽象类结构体，并实现抽象步骤函数。
5. **使用模板模式**：通过实例化具体子类结构体，并调用模板方法，实现算法的执行。

### 代码示例
```c
#include <stdio.h>

// 抽象类定义
typedef struct {
    void (*step1)();
    void (*step2)();
    void (*templateMethod)();
} AbstractClass;

// 抽象步骤1
void abstractStep1() {
    printf("这是抽象步骤1，在子类中实现\n");
}

// 抽象步骤2
void abstractStep2() {
    printf("这是抽象步骤2，在子类中实现\n");
}

// 模板方法
void templateMethod(AbstractClass* self) {
    if (self->step1!= NULL) {
        self->step1();
    }
    if (self->step2!= NULL) {
        self->step2();
    }
}

// 具体子类1
typedef struct {
    AbstractClass base;
} ConcreteSubclass1;

// 具体子类1的步骤1实现
void concreteStep1() {
    printf("具体子类1的步骤1实现\n");
}

// 具体子类1的步骤2实现
void concreteStep2() {
    printf("具体子类1的步骤2实现\n");
}

// 初始化具体子类1
ConcreteSubclass1* createConcreteSubclass1() {
    ConcreteSubclass1* subclass = (ConcreteSubclass1*)malloc(sizeof(ConcreteSubclass1));
    subclass->base.step1 = concreteStep1;
    subclass->base.step2 = concreteStep2;
    subclass->base.templateMethod = templateMethod;
    return subclass;
}

// 具体子类2
typedef struct {
    AbstractClass base;
} ConcreteSubclass2;

// 具体子类2的步骤1实现
void concreteStep3() {
    printf("具体子类2的步骤1实现\n");
}

// 具体子类2的步骤2实现
void concreteStep4() {
    printf("具体子类2的步骤2实现\n");
}

// 初始化具体子类2
ConcreteSubclass2* createConcreteSubclass2() {
    ConcreteSubclass2* subclass = (ConcreteSubclass2*)malloc(sizeof(ConcreteSubclass2));
    subclass->base.step1 = concreteStep3;
    subclass->base.step2 = concreteStep4;
    subclass->base.templateMethod = templateMethod;
    return subclass;
}

int main() {
    ConcreteSubclass1* subclass1 = createConcreteSubclass1();
    subclass1->base.templateMethod(&subclass1->base);

    ConcreteSubclass2* subclass2 = createConcreteSubclass2();
    subclass2->base.templateMethod(&subclass2->base);

    free(subclass1);
    free(subclass2);

    return 0;
}
```

## 常见实践
### 在文件处理中的应用
在文件处理场景中，不同类型的文件（如文本文件、二进制文件）可能有不同的读取和写入方式，但整体的文件处理流程（如打开文件、处理文件、关闭文件）是相似的。可以使用模板模式来定义通用的文件处理流程，将具体的读取和写入操作留给子类实现。

```c
#include <stdio.h>
#include <stdlib.h>

// 抽象文件处理类
typedef struct {
    FILE* (*openFile)(const char* filename, const char* mode);
    void (*processFile)(FILE* file);
    void (*closeFile)(FILE* file);
    void (*templateMethod)(const char* filename, const char* mode);
} FileProcessor;

// 打开文件
FILE* openFile(const char* filename, const char* mode) {
    return fopen(filename, mode);
}

// 关闭文件
void closeFile(FILE* file) {
    if (file!= NULL) {
        fclose(file);
    }
}

// 模板方法
void templateMethod(const char* filename, const char* mode, FileProcessor* self) {
    FILE* file = self->openFile(filename, mode);
    if (file!= NULL) {
        self->processFile(file);
        self->closeFile(file);
    }
}

// 文本文件处理子类
typedef struct {
    FileProcessor base;
} TextFileProcessor;

// 处理文本文件
void processTextFile(FILE* file) {
    char buffer[100];
    while (fgets(buffer, sizeof(buffer), file)!= NULL) {
        printf("%s", buffer);
    }
}

// 初始化文本文件处理子类
TextFileProcessor* createTextFileProcessor() {
    TextFileProcessor* processor = (TextFileProcessor*)malloc(sizeof(TextFileProcessor));
    processor->base.openFile = openFile;
    processor->base.processFile = processTextFile;
    processor->base.closeFile = closeFile;
    processor->base.templateMethod = templateMethod;
    return processor;
}

// 二进制文件处理子类
typedef struct {
    FileProcessor base;
} BinaryFileProcessor;

// 处理二进制文件
void processBinaryFile(FILE* file) {
    char buffer[100];
    size_t readSize;
    while ((readSize = fread(buffer, 1, sizeof(buffer), file)) > 0) {
        // 简单打印二进制数据的长度
        printf("Read %zu bytes\n", readSize);
    }
}

// 初始化二进制文件处理子类
BinaryFileProcessor* createBinaryFileProcessor() {
    BinaryFileProcessor* processor = (BinaryFileProcessor*)malloc(sizeof(BinaryFileProcessor));
    processor->base.openFile = openFile;
    processor->base.processFile = processBinaryFile;
    processor->base.closeFile = closeFile;
    processor->base.templateMethod = templateMethod;
    return processor;
}

int main() {
    TextFileProcessor* textProcessor = createTextFileProcessor();
    textProcessor->base.templateMethod("example.txt", "r");

    BinaryFileProcessor* binaryProcessor = createBinaryFileProcessor();
    binaryProcessor->base.templateMethod("example.bin", "rb");

    free(textProcessor);
    free(binaryProcessor);

    return 0;
}
```

### 在排序算法中的应用
排序算法有多种，如冒泡排序、选择排序、插入排序等。虽然它们的具体实现不同，但都遵循一定的通用流程（如比较元素、交换元素）。可以使用模板模式定义通用的排序流程，将具体的比较和交换操作留给子类实现。

```c
#include <stdio.h>
#include <stdlib.h>

// 抽象排序类
typedef struct {
    int (*compare)(int a, int b);
    void (*swap)(int* a, int* b);
    void (*sort)(int* arr, int size);
} Sorter;

// 比较函数指针类型定义
typedef int (*CompareFunction)(int a, int b);

// 交换函数
void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// 冒泡排序模板方法
void bubbleSort(int* arr, int size, CompareFunction compare, void (*swap)(int*, int*)) {
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (compare(arr[j], arr[j + 1]) > 0) {
                swap(&arr[j], &arr[j + 1]);
            }
        }
    }
}

// 从小到大比较
int ascendingCompare(int a, int b) {
    return a - b;
}

// 从大到小比较
int descendingCompare(int a, int b) {
    return b - a;
}

// 初始化排序器
Sorter* createSorter(CompareFunction compare) {
    Sorter* sorter = (Sorter*)malloc(sizeof(Sorter));
    sorter->compare = compare;
    sorter->swap = swap;
    sorter->sort = (void (*)(int*, int))bubbleSort;  // 强制类型转换
    return sorter;
}

int main() {
    int arr[] = {5, 3, 8, 1, 9};
    int size = sizeof(arr) / sizeof(arr[0]);

    Sorter* ascendingSorter = createSorter(ascendingCompare);
    ascendingSorter->sort(arr, size);

    printf("从小到大排序结果: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    Sorter* descendingSorter = createSorter(descendingCompare);
    descendingSorter->sort(arr, size);

    printf("从大到小排序结果: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    free(ascendingSorter);
    free(descendingSorter);

    return 0;
}
```

## 最佳实践
### 遵循单一职责原则
每个类应该只负责一项职责，避免一个类承担过多的职责。在模板模式中，抽象类应该专注于定义算法骨架，具体子类应该专注于实现抽象步骤。

### 合理使用指针与函数指针
在C语言中，指针和函数指针是实现模板模式的关键。要确保指针的正确使用，避免悬空指针和内存泄漏。同时，合理使用函数指针可以提高代码的灵活性和可扩展性。

### 代码复用与扩展
模板模式的核心优势在于代码复用和扩展。在设计抽象类和具体子类时，要充分考虑代码的复用性和扩展性，使得新的子类能够轻松地继承和扩展现有功能。

## 小结
模板模式是C语言中一种强大的设计模式，它通过定义算法骨架和延迟具体实现步骤，提高了代码的复用性和可扩展性。通过本文的介绍，读者应该对模板模式的基础概念、使用方法、常见实践以及最佳实践有了深入的理解。在实际开发中，合理运用模板模式可以使代码更加清晰、灵活，提高开发效率和软件质量。希望读者能够将模板模式应用到自己的项目中，提升编程能力和解决问题的能力。
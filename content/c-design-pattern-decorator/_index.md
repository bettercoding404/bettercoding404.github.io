---
title:  C语言设计模式之装饰器模式
description:  简介在软件开发过程中，我们常常需要为对象添加新的行为或功能。传统的继承方式在某些情况下可能会导致类层次结构变得复杂且难以维护。装饰器模式（Decorator Pattern）作为一种结构型设计模式，提供了一种优雅的方式来动态地为对象添加功能，而无需修改对象的原有结构。本文将深入探讨C语言中装饰器模式的基础概念、使用方法、常见实践以及最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发过程中，我们常常需要为对象添加新的行为或功能。传统的继承方式在某些情况下可能会导致类层次结构变得复杂且难以维护。装饰器模式（Decorator Pattern）作为一种结构型设计模式，提供了一种优雅的方式来动态地为对象添加功能，而无需修改对象的原有结构。本文将深入探讨C语言中装饰器模式的基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 装饰器模式基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结

## 装饰器模式基础概念
装饰器模式允许向一个现有的对象添加新的功能，同时又不改变其结构。它通过创建一个装饰器类，该类持有一个被装饰对象的引用，并在需要时调用被装饰对象的方法，同时添加额外的功能。

### 角色
- **Component（组件）**：定义一个对象接口，可以给这些对象动态地添加职责。
- **ConcreteComponent（具体组件）**：实现Component接口，定义一个具体的对象，也可以给这个对象添加一些职责。
- **Decorator（装饰器）**：持有一个指向Component对象的引用，并定义一个与Component接口一致的接口。
- **ConcreteDecorator（具体装饰器）**：负责给组件添加职责。

## 使用方法
### 代码示例
```c
#include <stdio.h>
#include <stdlib.h>

// Component
typedef struct Component {
    void (*operation)(struct Component*);
} Component;

// ConcreteComponent
typedef struct ConcreteComponent {
    Component base;
} ConcreteComponent;

void concreteComponentOperation(Component* component) {
    printf("ConcreteComponent operation\n");
}

// Decorator
typedef struct Decorator {
    Component base;
    Component* component;
} Decorator;

void decoratorOperation(Component* component) {
    Decorator* decorator = (Decorator*)component;
    decorator->component->operation(decorator->component);
}

// ConcreteDecorator
typedef struct ConcreteDecorator {
    Decorator base;
} ConcreteDecorator;

void concreteDecoratorExtraOperation(Decorator* decorator) {
    printf("ConcreteDecorator extra operation\n");
}

void concreteDecoratorOperation(Component* component) {
    ConcreteDecorator* concreteDecorator = (ConcreteDecorator*)component;
    decoratorOperation(&concreteDecorator->base);
    concreteDecoratorExtraOperation(&concreteDecorator->base);
}

int main() {
    // 创建具体组件
    ConcreteComponent* concreteComponent = (ConcreteComponent*)malloc(sizeof(ConcreteComponent));
    concreteComponent->base.operation = concreteComponentOperation;

    // 创建装饰器
    ConcreteDecorator* concreteDecorator = (ConcreteDecorator*)malloc(sizeof(ConcreteDecorator));
    concreteDecorator->base.component = &concreteComponent->base;
    concreteDecorator->base.operation = decoratorOperation;
    concreteDecorator->base.operation = concreteDecoratorOperation;

    // 调用操作
    concreteDecorator->base.operation(&concreteDecorator->base);

    free(concreteComponent);
    free(concreteDecorator);

    return 0;
}
```

### 代码解析
1. **组件（Component）**：定义了一个操作接口`operation`。
2. **具体组件（ConcreteComponent）**：实现了组件接口`operation`，提供了具体的操作实现。
3. **装饰器（Decorator）**：持有一个组件对象的引用，并实现了与组件接口一致的操作，在操作中调用被装饰对象的操作。
4. **具体装饰器（ConcreteDecorator）**：继承自装饰器，添加了额外的操作，并在其操作中调用装饰器的操作和额外操作。

## 常见实践
### 日志记录装饰器
在实际开发中，我们常常需要为某些操作添加日志记录功能。可以使用装饰器模式来实现。

```c
#include <stdio.h>
#include <stdlib.h>

// Component
typedef struct Component {
    void (*operation)(struct Component*);
} Component;

// ConcreteComponent
typedef struct ConcreteComponent {
    Component base;
} ConcreteComponent;

void concreteComponentOperation(Component* component) {
    printf("ConcreteComponent operation\n");
}

// Decorator
typedef struct LoggerDecorator {
    Component base;
    Component* component;
} LoggerDecorator;

void loggerDecoratorOperation(Component* component) {
    LoggerDecorator* loggerDecorator = (LoggerDecorator*)component;
    printf("Logging before operation\n");
    loggerDecorator->component->operation(loggerDecorator->component);
    printf("Logging after operation\n");
}

int main() {
    // 创建具体组件
    ConcreteComponent* concreteComponent = (ConcreteComponent*)malloc(sizeof(ConcreteComponent));
    concreteComponent->base.operation = concreteComponentOperation;

    // 创建日志记录装饰器
    LoggerDecorator* loggerDecorator = (LoggerDecorator*)malloc(sizeof(LoggerDecorator));
    loggerDecorator->base.component = &concreteComponent->base;
    loggerDecorator->base.operation = loggerDecoratorOperation;

    // 调用操作
    loggerDecorator->base.operation(&loggerDecorator->base);

    free(concreteComponent);
    free(loggerDecorator);

    return 0;
}
```

### 性能监控装饰器
另一个常见的实践是为函数添加性能监控功能，记录函数执行的时间。

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Component
typedef struct Component {
    void (*operation)(struct Component*);
} Component;

// ConcreteComponent
typedef struct ConcreteComponent {
    Component base;
} ConcreteComponent;

void concreteComponentOperation(Component* component) {
    printf("ConcreteComponent operation\n");
}

// Decorator
typedef struct PerformanceDecorator {
    Component base;
    Component* component;
} PerformanceDecorator;

void performanceDecoratorOperation(Component* component) {
    PerformanceDecorator* performanceDecorator = (PerformanceDecorator*)component;
    clock_t start = clock();
    performanceDecorator->component->operation(performanceDecorator->component);
    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Performance: %f seconds\n", time_spent);
}

int main() {
    // 创建具体组件
    ConcreteComponent* concreteComponent = (ConcreteComponent*)malloc(sizeof(ConcreteComponent));
    concreteComponent->base.operation = concreteComponentOperation;

    // 创建性能监控装饰器
    PerformanceDecorator* performanceDecorator = (PerformanceDecorator*)malloc(sizeof(PerformanceDecorator));
    performanceDecorator->base.component = &concreteComponent->base;
    performanceDecorator->base.operation = performanceDecoratorOperation;

    // 调用操作
    performanceDecorator->base.operation(&performanceDecorator->base);

    free(concreteComponent);
    free(performanceDecorator);

    return 0;
}
```

## 最佳实践
- **保持组件接口简单**：组件接口应该尽量简单，只包含必要的操作。这样可以确保装饰器和具体组件都能轻松实现该接口。
- **避免过度装饰**：过多的装饰器可能会导致代码复杂度过高，难以维护。在使用装饰器模式时，要确保装饰的必要性。
- **使用工厂函数**：为了简化对象的创建过程，可以使用工厂函数来创建组件和装饰器对象。

## 小结
装饰器模式是一种强大的设计模式，它允许我们动态地为对象添加功能，而无需修改对象的原有结构。通过本文的介绍，我们了解了装饰器模式的基础概念、使用方法、常见实践以及最佳实践。希望读者能够在实际开发中灵活运用装饰器模式，提高代码的可维护性和可扩展性。
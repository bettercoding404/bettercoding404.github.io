---
title:  C语言设计模式之观察者模式
description:  简介在软件开发过程中，我们常常会遇到这样的场景：一个对象的状态发生变化时，需要通知其他多个对象做出相应的反应。观察者模式（Observer Pattern）就是为解决这类问题而生的一种设计模式。它定义了一种一对多的依赖关系，让多个观察者对象同时监听一个主题对象。这个主题对象在状态发生变化时，会通知所有观察者对象，使它们能够自动更新自己的状态。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发过程中，我们常常会遇到这样的场景：一个对象的状态发生变化时，需要通知其他多个对象做出相应的反应。观察者模式（Observer Pattern）就是为解决这类问题而生的一种设计模式。它定义了一种一对多的依赖关系，让多个观察者对象同时监听一个主题对象。这个主题对象在状态发生变化时，会通知所有观察者对象，使它们能够自动更新自己的状态。

在C语言中，虽然没有像一些面向对象语言那样直接的类和继承等概念来支持设计模式，但我们可以通过结构体和函数指针等方式来实现观察者模式。本文将详细介绍C语言中观察者模式的基础概念、使用方法、常见实践以及最佳实践，帮助读者深入理解并在实际项目中高效使用这一设计模式。

## 目录
1. **观察者模式基础概念**
    - 主题（Subject）
    - 观察者（Observer）
    - 依赖关系
2. **C语言中观察者模式的使用方法**
    - 定义主题结构体
    - 定义观察者结构体
    - 实现注册、注销和通知函数
3. **常见实践**
    - 简单的事件通知系统
    - 游戏中的状态变化通知
4. **最佳实践**
    - 内存管理
    - 错误处理
    - 代码结构优化
5. **小结**

## 观察者模式基础概念
### 主题（Subject）
主题也被称为被观察对象，它是一个拥有状态的对象，并且维护了一个观察者列表。当主题的状态发生变化时，它会遍历这个列表，调用每个观察者的更新函数，通知它们状态的改变。

### 观察者（Observer）
观察者是一个对象，它对主题的状态变化感兴趣。它提供一个更新函数，当主题状态发生变化时，主题会调用这个函数，使观察者能够根据主题的新状态进行相应的操作。

### 依赖关系
观察者和主题之间存在一种依赖关系。观察者依赖于主题的状态变化，而主题则负责维护观察者列表并在状态变化时通知观察者。这种依赖关系使得系统具有良好的可扩展性和维护性，当需要添加或移除观察者时，只需要在主题的观察者列表中进行相应操作，而不会影响到其他部分的代码。

## C语言中观察者模式的使用方法
### 定义主题结构体
```c
#include <stdio.h>
#include <stdlib.h>

// 定义观察者结构体的前向声明
typedef struct Observer Observer;

// 定义主题结构体
typedef struct Subject {
    int state; // 主题的状态
    Observer** observers; // 观察者数组
    int observerCount; // 观察者数量
    int capacity; // 观察者数组的容量
} Subject;

// 初始化主题
Subject* createSubject() {
    Subject* subject = (Subject*)malloc(sizeof(Subject));
    subject->state = 0;
    subject->observerCount = 0;
    subject->capacity = 10;
    subject->observers = (Observer**)malloc(subject->capacity * sizeof(Observer*));
    return subject;
}

// 释放主题内存
void destroySubject(Subject* subject) {
    free(subject->observers);
    free(subject);
}
```
### 定义观察者结构体
```c
// 定义观察者结构体
typedef struct Observer {
    void (*update)(Subject* subject, void* arg); // 更新函数指针
    void* arg; // 传递给更新函数的参数
} Observer;

// 创建一个观察者
Observer* createObserver(void (*update)(Subject* subject, void* arg), void* arg) {
    Observer* observer = (Observer*)malloc(sizeof(Observer));
    observer->update = update;
    observer->arg = arg;
    return observer;
}

// 释放观察者内存
void destroyObserver(Observer* observer) {
    free(observer);
}
```
### 实现注册、注销和通知函数
```c
// 注册观察者
void registerObserver(Subject* subject, Observer* observer) {
    if (subject->observerCount >= subject->capacity) {
        subject->capacity *= 2;
        subject->observers = (Observer**)realloc(subject->observers, subject->capacity * sizeof(Observer*));
    }
    subject->observers[subject->observerCount++] = observer;
}

// 注销观察者
void unregisterObserver(Subject* subject, Observer* observer) {
    for (int i = 0; i < subject->observerCount; i++) {
        if (subject->observers[i] == observer) {
            for (int j = i; j < subject->observerCount - 1; j++) {
                subject->observers[j] = subject->observers[j + 1];
            }
            subject->observerCount--;
            break;
        }
    }
}

// 通知所有观察者
void notifyObservers(Subject* subject) {
    for (int i = 0; i < subject->observerCount; i++) {
        subject->observers[i]->update(subject, subject->observers[i]->arg);
    }
}
```

### 使用示例
```c
// 观察者的更新函数
void observerUpdate(Subject* subject, void* arg) {
    printf("Observer notified. Subject state: %d, arg: %d\n", subject->state, *((int*)arg));
}

int main() {
    Subject* subject = createSubject();
    int arg = 42;
    Observer* observer1 = createObserver(observerUpdate, &arg);
    Observer* observer2 = createObserver(observerUpdate, &arg);

    registerObserver(subject, observer1);
    registerObserver(subject, observer2);

    subject->state = 10;
    notifyObservers(subject);

    unregisterObserver(subject, observer1);
    subject->state = 20;
    notifyObservers(subject);

    destroyObserver(observer1);
    destroyObserver(observer2);
    destroySubject(subject);

    return 0;
}
```

## 常见实践
### 简单的事件通知系统
在一个图形界面应用中，我们可能有一个按钮对象作为主题，当按钮被点击（状态变化）时，需要通知多个观察者，比如更新界面显示、记录日志等。我们可以按照上述的观察者模式实现，将每个需要响应按钮点击事件的功能作为一个观察者注册到按钮主题上。

### 游戏中的状态变化通知
在游戏开发中，角色的状态（如生命值、等级等）变化时，可能需要通知多个系统，如UI系统更新角色信息显示，任务系统检查是否满足任务条件等。角色对象作为主题，UI系统和任务系统的相关模块作为观察者，通过观察者模式实现状态变化的通知和相应处理。

## 最佳实践
### 内存管理
在使用观察者模式时，要特别注意内存管理。因为涉及到多个对象的创建和销毁，如主题和观察者的结构体实例。确保在不再使用这些对象时，及时释放它们所占用的内存，避免内存泄漏。例如，在上述代码中，我们提供了`destroySubject`和`destroyObserver`函数来释放相应的内存。

### 错误处理
在注册、注销和通知函数中添加适当的错误处理。比如，在`registerObserver`函数中，当内存重新分配失败时，应该返回一个错误码并进行相应的处理，而不是让程序继续运行导致未定义行为。

### 代码结构优化
为了提高代码的可读性和可维护性，可以将相关的函数和结构体定义放在不同的源文件和头文件中。例如，将主题相关的代码放在`subject.c`和`subject.h`中，观察者相关的代码放在`observer.c`和`observer.h`中。同时，合理使用注释来解释代码的功能和设计思路。

## 小结
观察者模式是一种非常实用的设计模式，它在C语言中通过结构体和函数指针等方式能够有效地实现对象间的一对多依赖关系。通过本文的介绍，读者应该对观察者模式的基础概念、C语言中的实现方法、常见实践以及最佳实践有了较为深入的理解。在实际项目中，合理运用观察者模式可以提高代码的可扩展性和维护性，使系统更加灵活和健壮。希望读者能够将这些知识运用到实际开发中，提升自己的编程能力和项目质量。
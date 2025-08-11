---
title:  C语言设计模式：中介者模式
description:  简介在软件开发过程中，对象之间的交互往往变得复杂且难以维护。中介者模式作为一种行为型设计模式，旨在通过引入一个中介者对象，来封装一系列对象之间的交互，从而降低对象之间的耦合度，提高系统的可维护性和可扩展性。在C语言中，虽然没有像面向对象语言那样原生的类和对象支持，但我们依然可以通过结构体和函数指针来实现中介者模式。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发过程中，对象之间的交互往往变得复杂且难以维护。中介者模式作为一种行为型设计模式，旨在通过引入一个中介者对象，来封装一系列对象之间的交互，从而降低对象之间的耦合度，提高系统的可维护性和可扩展性。在C语言中，虽然没有像面向对象语言那样原生的类和对象支持，但我们依然可以通过结构体和函数指针来实现中介者模式。

## 目录
1. 中介者模式基础概念
2. 使用方法
    - 定义中介者结构体
    - 定义同事结构体
    - 实现中介者和同事的交互
3. 常见实践
    - 事件处理系统
    - 分布式系统中的节点通信
4. 最佳实践
    - 合理划分职责
    - 避免中介者对象过于庞大
5. 代码示例
6. 小结

## 中介者模式基础概念
中介者模式包含以下几个角色：
- **中介者（Mediator）**：定义一个接口用于各个同事对象之间的通信。它知道所有的同事对象，并协调它们之间的交互。
- **同事（Colleague）**：所有同事类都继承自一个抽象同事类。每个同事对象都持有一个中介者对象的引用，通过该引用与中介者进行通信，同事对象之间不直接交互。

## 使用方法

### 定义中介者结构体
首先，我们需要定义一个中介者结构体，该结构体包含指向处理同事之间交互的函数指针。

```c
#include <stdio.h>

// 前向声明同事结构体
typedef struct Colleague Colleague;

// 中介者结构体
typedef struct Mediator {
    // 处理同事之间交互的函数指针
    void (*handleInteraction)(Colleague*, Colleague*);
} Mediator;

// 创建中介者实例
Mediator* createMediator() {
    Mediator* mediator = (Mediator*)malloc(sizeof(Mediator));
    mediator->handleInteraction = NULL;
    return mediator;
}
```

### 定义同事结构体
接下来，定义同事结构体，每个同事结构体包含一个指向中介者的指针，以便与中介者进行通信。

```c
// 同事结构体
typedef struct Colleague {
    int id;
    Mediator* mediator;
} Colleague;

// 创建同事实例
Colleague* createColleague(int id, Mediator* mediator) {
    Colleague* colleague = (Colleague*)malloc(sizeof(Colleague));
    colleague->id = id;
    colleague->mediator = mediator;
    return colleague;
}
```

### 实现中介者和同事的交互
实现中介者的交互处理函数，并让同事通过中介者进行交互。

```c
// 中介者处理交互的具体实现
void mediatorHandleInteraction(Colleague* colleague1, Colleague* colleague2) {
    printf("Mediator handling interaction between Colleague %d and Colleague %d\n", colleague1->id, colleague2->id);
}

// 同事发送消息给中介者
void sendMessage(Colleague* sender, Colleague* receiver) {
    if (sender->mediator!= NULL && sender->mediator->handleInteraction!= NULL) {
        sender->mediator->handleInteraction(sender, receiver);
    }
}
```

## 常见实践

### 事件处理系统
在图形用户界面（GUI）开发中，不同的组件（如按钮、文本框等）可能需要相互交互。通过中介者模式，可以将这些组件之间的交互逻辑封装在一个中介者对象中，使得每个组件只需要与中介者通信，而不需要直接依赖其他组件。

### 分布式系统中的节点通信
在分布式系统中，各个节点之间的通信和协调可以通过中介者模式来实现。中介者可以负责管理节点之间的消息传递、任务分配等功能，从而简化节点之间的直接通信。

## 最佳实践

### 合理划分职责
中介者应该只负责处理同事之间的交互逻辑，而不应该承担过多的业务逻辑。同事对象应该专注于自身的业务功能，通过中介者进行间接交互。

### 避免中介者对象过于庞大
随着系统的发展，中介者可能会变得非常庞大和复杂。为了避免这种情况，可以将中介者的职责进一步细分，或者采用分层架构来管理中介者的功能。

## 代码示例
下面是一个完整的示例代码，展示了如何使用中介者模式实现两个同事之间的交互。

```c
#include <stdio.h>
#include <stdlib.h>

// 前向声明同事结构体
typedef struct Colleague Colleague;

// 中介者结构体
typedef struct Mediator {
    // 处理同事之间交互的函数指针
    void (*handleInteraction)(Colleague*, Colleague*);
} Mediator;

// 创建中介者实例
Mediator* createMediator() {
    Mediator* mediator = (Mediator*)malloc(sizeof(Mediator));
    mediator->handleInteraction = NULL;
    return mediator;
}

// 同事结构体
typedef struct Colleague {
    int id;
    Mediator* mediator;
} Colleague;

// 创建同事实例
Colleague* createColleague(int id, Mediator* mediator) {
    Colleague* colleague = (Colleague*)malloc(sizeof(Colleague));
    colleague->id = id;
    colleague->mediator = mediator;
    return colleague;
}

// 中介者处理交互的具体实现
void mediatorHandleInteraction(Colleague* colleague1, Colleague* colleague2) {
    printf("Mediator handling interaction between Colleague %d and Colleague %d\n", colleague1->id, colleague2->id);
}

// 同事发送消息给中介者
void sendMessage(Colleague* sender, Colleague* receiver) {
    if (sender->mediator!= NULL && sender->mediator->handleInteraction!= NULL) {
        sender->mediator->handleInteraction(sender, receiver);
    }
}

int main() {
    // 创建中介者
    Mediator* mediator = createMediator();
    mediator->handleInteraction = mediatorHandleInteraction;

    // 创建同事
    Colleague* colleague1 = createColleague(1, mediator);
    Colleague* colleague2 = createColleague(2, mediator);

    // 同事之间通过中介者进行交互
    sendMessage(colleague1, colleague2);

    // 释放内存
    free(colleague1);
    free(colleague2);
    free(mediator);

    return 0;
}
```

## 小结
中介者模式在C语言中为我们提供了一种有效的方式来管理对象之间的复杂交互。通过引入中介者对象，我们降低了同事对象之间的耦合度，提高了系统的可维护性和可扩展性。在实际应用中，合理运用中介者模式，并遵循最佳实践原则，可以帮助我们构建更加健壮和易于维护的软件系统。希望本文能帮助你深入理解并在实际项目中高效使用C语言设计模式中的中介者模式。
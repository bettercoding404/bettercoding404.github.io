---
title:  C语言设计模式之命令模式
description:  简介在软件开发过程中，我们经常会遇到需要将请求发送者和请求接收者解耦的场景。命令模式（Command Pattern）就是一种能够很好地解决这一问题的设计模式。它将一个请求封装为一个对象，从而使你可以用不同的请求对客户进行参数化，对请求排队或记录请求日志，以及支持可撤销的操作。在C语言中，虽然没有像面向对象语言那样原生的类和对象支持，但我们依然可以通过结构体和函数指针来实现命令模式。本文将深入探讨C语言中命令模式的基础概念、使用方法、常见实践以及最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发过程中，我们经常会遇到需要将请求发送者和请求接收者解耦的场景。命令模式（Command Pattern）就是一种能够很好地解决这一问题的设计模式。它将一个请求封装为一个对象，从而使你可以用不同的请求对客户进行参数化，对请求排队或记录请求日志，以及支持可撤销的操作。在C语言中，虽然没有像面向对象语言那样原生的类和对象支持，但我们依然可以通过结构体和函数指针来实现命令模式。本文将深入探讨C语言中命令模式的基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 命令模式基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结

## 命令模式基础概念
命令模式涉及到以下几个关键角色：
- **命令（Command）**：定义一个执行操作的接口，在C语言中通常用函数指针来表示。
- **具体命令（ConcreteCommand）**：实现命令接口，封装一个接收者对象和一个操作，调用接收者的相应操作来执行命令。
- **接收者（Receiver）**：执行命令的实际对象，知道如何执行与请求相关的操作。
- **调用者（Invoker）**：请求的发送者，它拥有一个命令对象，并通过调用命令对象的执行方法来发起请求。

## 使用方法
### 1. 定义接收者
首先，我们定义一个接收者结构体，它包含执行具体操作的函数。
```c
// 接收者结构体
typedef struct Receiver {
    void (*action)();
} Receiver;

// 接收者的具体操作
void receiverAction() {
    printf("Receiver is performing action.\n");
}
```

### 2. 定义命令接口
接下来，定义命令接口，用函数指针来表示。
```c
// 命令接口（函数指针）
typedef void (*CommandExecute)();

// 命令结构体
typedef struct Command {
    CommandExecute execute;
} Command;
```

### 3. 定义具体命令
然后，创建具体命令结构体，它包含接收者对象，并实现命令接口。
```c
// 具体命令结构体
typedef struct ConcreteCommand {
    Command base;
    Receiver* receiver;
} ConcreteCommand;

// 创建具体命令实例
ConcreteCommand* createConcreteCommand(Receiver* receiver) {
    ConcreteCommand* command = (ConcreteCommand*)malloc(sizeof(ConcreteCommand));
    command->receiver = receiver;
    command->base.execute = (CommandExecute) &receiverAction;
    return command;
}
```

### 4. 定义调用者
最后，定义调用者结构体，它持有命令对象并调用命令的执行方法。
```c
// 调用者结构体
typedef struct Invoker {
    Command* command;
} Invoker;

// 设置调用者的命令
void setCommand(Invoker* invoker, Command* command) {
    invoker->command = command;
}

// 调用者执行命令
void executeCommand(Invoker* invoker) {
    if (invoker->command!= NULL) {
        invoker->command->execute();
    }
}
```

### 5. 主函数测试
```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    // 创建接收者
    Receiver receiver;
    receiver.action = receiverAction;

    // 创建具体命令
    ConcreteCommand* command = createConcreteCommand(&receiver);

    // 创建调用者
    Invoker invoker;
    setCommand(&invoker, &command->base);

    // 执行命令
    executeCommand(&invoker);

    // 释放内存
    free(command);
    return 0;
}
```

## 常见实践
### 1. 菜单系统
在一个简单的菜单系统中，每个菜单项可以看作是一个命令。用户选择菜单项时，调用者（菜单界面）执行相应的命令，而接收者（具体的功能模块）负责实际的操作。

### 2. 游戏控制
在游戏开发中，玩家的各种操作（如移动、攻击等）可以用命令模式实现。调用者（游戏输入模块）接收玩家输入，然后执行相应的命令，接收者（游戏角色对象）执行具体的动作。

## 最佳实践
### 1. 内存管理
在C语言中，使用命令模式时要特别注意内存管理。动态分配的内存（如具体命令结构体）要及时释放，避免内存泄漏。

### 2. 错误处理
为命令接口添加错误处理机制，以便在命令执行失败时能够及时反馈。例如，可以在命令执行函数中返回错误码。

### 3. 代码结构优化
将相关的结构体和函数定义放在头文件和源文件中，保持代码的清晰和模块化。同时，使用注释来解释关键代码的功能。

## 小结
命令模式在C语言中是一种非常实用的设计模式，它通过将请求封装为对象，有效地解耦了请求发送者和接收者。通过合理使用结构体和函数指针，我们可以在C语言中实现命令模式，应用于各种场景，如菜单系统和游戏控制等。在实践中，要注意内存管理、错误处理和代码结构优化，以确保程序的稳定性和可维护性。希望本文能帮助读者深入理解并高效使用C语言中的命令模式。
---
title:  C语言设计模式之责任链模式
description:  简介在软件开发过程中，我们常常会遇到这样的场景：一个请求需要经过一系列对象的处理才能得到最终结果，而且这些对象处理请求的过程是链式的。责任链模式（Chain of Responsibility Pattern）就是为了解决这类问题而诞生的一种设计模式。它允许你将请求沿着对象链进行传递，直到有一个对象能够处理它为止。在C语言中，通过合理的结构体和函数指针的运用，我们可以有效地实现责任链模式。本文将深入探讨C语言中责任链模式的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用这一模式进行程序设计。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发过程中，我们常常会遇到这样的场景：一个请求需要经过一系列对象的处理才能得到最终结果，而且这些对象处理请求的过程是链式的。责任链模式（Chain of Responsibility Pattern）就是为了解决这类问题而诞生的一种设计模式。它允许你将请求沿着对象链进行传递，直到有一个对象能够处理它为止。在C语言中，通过合理的结构体和函数指针的运用，我们可以有效地实现责任链模式。本文将深入探讨C语言中责任链模式的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用这一模式进行程序设计。

## 目录
1. **责任链模式基础概念**
2. **C语言中责任链模式的使用方法**
    - **结构体定义**
    - **节点创建与连接**
    - **请求处理**
3. **常见实践**
    - **日志处理**
    - **权限验证**
4. **最佳实践**
    - **错误处理**
    - **性能优化**
5. **小结**

## 责任链模式基础概念
责任链模式是一种行为设计模式，它将请求的发送者和接收者解耦，使多个对象都有机会处理这个请求。这些对象组成一条链，请求沿着链传递，直到有一个对象处理它。每个对象都有两个选择：自己处理请求或者将请求传递给链中的下一个对象。

在责任链模式中，有几个关键角色：
- **抽象处理者（Handler）**：定义了一个处理请求的接口，包含一个指向下一个处理者的引用。
- **具体处理者（Concrete Handler）**：实现了抽象处理者的接口，具体处理请求或者将请求传递给下一个处理者。
- **客户端（Client）**：创建请求并将其发送到责任链的起始端。

## C语言中责任链模式的使用方法

### 结构体定义
首先，我们需要定义抽象处理者和具体处理者的结构体。抽象处理者结构体包含一个函数指针用于处理请求，以及一个指向下一个处理者的指针。

```c
#include <stdio.h>
#include <stdlib.h>

// 抽象处理者结构体
typedef struct Handler {
    void (*handleRequest)(int request);
    struct Handler* nextHandler;
} Handler;

// 具体处理者结构体
typedef struct ConcreteHandler1 {
    Handler handler;
} ConcreteHandler1;

typedef struct ConcreteHandler2 {
    Handler handler;
} ConcreteHandler2;
```

### 节点创建与连接
接下来，我们要创建具体处理者节点，并将它们连接成一条链。

```c
// 创建具体处理者1
ConcreteHandler1* createConcreteHandler1() {
    ConcreteHandler1* handler1 = (ConcreteHandler1*)malloc(sizeof(ConcreteHandler1));
    handler1->handler.handleRequest = [](int request) {
        if (request >= 0 && request < 10) {
            printf("ConcreteHandler1处理请求: %d\n", request);
        } else {
            if (handler1->handler.nextHandler!= NULL) {
                handler1->handler.nextHandler->handleRequest(request);
            }
        }
    };
    handler1->handler.nextHandler = NULL;
    return handler1;
}

// 创建具体处理者2
ConcreteHandler2* createConcreteHandler2() {
    ConcreteHandler2* handler2 = (ConcreteHandler2*)malloc(sizeof(ConcreteHandler2));
    handler2->handler.handleRequest = [](int request) {
        if (request >= 10 && request < 20) {
            printf("ConcreteHandler2处理请求: %d\n", request);
        } else {
            if (handler2->handler.nextHandler!= NULL) {
                handler2->handler.nextHandler->handleRequest(request);
            }
        }
    };
    handler2->handler.nextHandler = NULL;
    return handler2;
}

// 连接处理者
void setNextHandler(Handler* current, Handler* next) {
    current->nextHandler = next;
}
```

### 请求处理
最后，我们可以创建请求并将其发送到责任链中进行处理。

```c
int main() {
    // 创建处理者
    ConcreteHandler1* handler1 = createConcreteHandler1();
    ConcreteHandler2* handler2 = createConcreteHandler2();

    // 连接处理者
    setNextHandler(&handler1->handler, &handler2->handler);

    // 发送请求
    int request1 = 5;
    int request2 = 15;
    handler1->handler.handleRequest(request1);
    handler1->handler.handleRequest(request2);

    // 释放内存
    free(handler1);
    free(handler2);

    return 0;
}
```

在上述代码中，`ConcreteHandler1`和`ConcreteHandler2`是具体处理者，它们实现了处理请求的逻辑。`setNextHandler`函数用于连接两个处理者，形成责任链。在`main`函数中，我们创建了处理者对象，连接它们，并发送请求进行处理。

## 常见实践

### 日志处理
在日志处理场景中，责任链模式可以用于根据日志级别进行不同的处理。例如，将错误日志发送到文件，将调试日志打印到控制台。

```c
// 日志处理抽象处理者
typedef struct Logger {
    void (*log)(int level, const char* message);
    struct Logger* nextLogger;
} Logger;

// 具体文件日志处理者
typedef struct FileLogger {
    Logger logger;
} FileLogger;

// 具体控制台日志处理者
typedef struct ConsoleLogger {
    Logger logger;
} ConsoleLogger;

// 创建文件日志处理者
FileLogger* createFileLogger() {
    FileLogger* fileLogger = (FileLogger*)malloc(sizeof(FileLogger));
    fileLogger->logger.log = [](int level, const char* message) {
        if (level >= 3) { // 假设错误日志级别为3及以上
            FILE* file = fopen("error.log", "a");
            fprintf(file, "错误日志: %s\n", message);
            fclose(file);
        } else {
            if (fileLogger->logger.nextLogger!= NULL) {
                fileLogger->logger.nextLogger->log(level, message);
            }
        }
    };
    fileLogger->logger.nextLogger = NULL;
    return fileLogger;
}

// 创建控制台日志处理者
ConsoleLogger* createConsoleLogger() {
    ConsoleLogger* consoleLogger = (ConsoleLogger*)malloc(sizeof(ConsoleLogger));
    consoleLogger->logger.log = [](int level, const char* message) {
        if (level < 3) { // 假设调试日志级别小于3
            printf("调试日志: %s\n", message);
        } else {
            if (consoleLogger->logger.nextLogger!= NULL) {
                consoleLogger->logger.nextLogger->log(level, message);
            }
        }
    };
    consoleLogger->logger.nextLogger = NULL;
    return consoleLogger;
}

// 连接日志处理者
void setNextLogger(Logger* current, Logger* next) {
    current->nextLogger = next;
}

int main() {
    FileLogger* fileLogger = createFileLogger();
    ConsoleLogger* consoleLogger = createConsoleLogger();

    setNextLogger(&fileLogger->logger, &consoleLogger->logger);

    fileLogger->logger.log(1, "这是一条调试日志");
    fileLogger->logger.log(4, "这是一条错误日志");

    free(fileLogger);
    free(consoleLogger);

    return 0;
}
```

### 权限验证
在权限验证场景中，责任链模式可以用于依次检查用户的不同权限。例如，先检查用户是否登录，再检查用户是否有特定操作的权限。

```c
// 权限验证抽象处理者
typedef struct AuthHandler {
    int (*authorize)(const char* username, const char* operation);
    struct AuthHandler* nextHandler;
} AuthHandler;

// 登录验证处理者
typedef struct LoginAuthHandler {
    AuthHandler authHandler;
} LoginAuthHandler;

// 操作权限验证处理者
typedef struct OperationAuthHandler {
    AuthHandler authHandler;
} OperationAuthHandler;

// 创建登录验证处理者
LoginAuthHandler* createLoginAuthHandler() {
    LoginAuthHandler* loginHandler = (LoginAuthHandler*)malloc(sizeof(LoginAuthHandler));
    loginHandler->authHandler.authorize = [](const char* username, const char* operation) {
        // 假设这里有实际的登录验证逻辑
        if (strcmp(username, "admin") == 0) {
            if (loginHandler->authHandler.nextHandler!= NULL) {
                return loginHandler->authHandler.nextHandler->authorize(username, operation);
            }
            return 1;
        }
        return 0;
    };
    loginHandler->authHandler.nextHandler = NULL;
    return loginHandler;
}

// 创建操作权限验证处理者
OperationAuthHandler* createOperationAuthHandler() {
    OperationAuthHandler* operationHandler = (OperationAuthHandler*)malloc(sizeof(OperationAuthHandler));
    operationHandler->authHandler.authorize = [](const char* username, const char* operation) {
        // 假设这里有实际的操作权限验证逻辑
        if (strcmp(operation, "delete") == 0 && strcmp(username, "admin") == 0) {
            return 1;
        }
        return 0;
    };
    operationHandler->authHandler.nextHandler = NULL;
    return operationHandler;
}

// 连接权限验证处理者
void setNextAuthHandler(AuthHandler* current, AuthHandler* next) {
    current->nextHandler = next;
}

int main() {
    LoginAuthHandler* loginHandler = createLoginAuthHandler();
    OperationAuthHandler* operationHandler = createOperationAuthHandler();

    setNextAuthHandler(&loginHandler->authHandler, &operationHandler->authHandler);

    int result1 = loginHandler->authHandler.authorize("admin", "delete");
    int result2 = loginHandler->authHandler.authorize("user", "delete");

    printf("admin删除操作权限: %d\n", result1);
    printf("user删除操作权限: %d\n", result2);

    free(loginHandler);
    free(operationHandler);

    return 0;
}
```

## 最佳实践

### 错误处理
在责任链模式中，错误处理非常重要。当一个处理者无法处理请求时，应该确保请求能够正确地传递给下一个处理者，或者在链的末尾给出合适的错误提示。

### 性能优化
如果责任链很长，可能会影响性能。可以考虑在必要时对责任链进行优化，例如减少不必要的节点，或者使用缓存来避免重复处理。

### 可维护性
为了提高代码的可维护性，每个处理者的职责应该单一且明确。同时，使用清晰的命名和注释来提高代码的可读性。

## 小结
责任链模式是一种强大的设计模式，它在C语言中通过结构体和函数指针的结合得以有效实现。通过将请求处理逻辑分散到多个处理者中，我们可以提高代码的灵活性和可维护性。在实际应用中，责任链模式在日志处理、权限验证等场景中发挥着重要作用。遵循最佳实践，如合理的错误处理、性能优化和提高可维护性，能够让我们更好地运用责任链模式，编写出高质量的C语言代码。希望本文能帮助你深入理解并高效使用C语言中的责任链模式。
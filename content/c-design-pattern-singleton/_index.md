---
title:  C语言设计模式之单例模式：深入解析与实践
description:  简介在软件开发中，设计模式是解决反复出现问题的通用解决方案。单例模式作为一种创建型设计模式，确保一个类仅有一个实例，并提供一个全局访问点来访问这个实例。在C语言中，由于没有像C++和Java那样的类和对象的直接支持，但通过巧妙地使用结构体和函数指针等特性，同样可以实现单例模式。本文将深入探讨C语言中如何实现单例模式，包括基础概念、使用方法、常见实践以及最佳实践。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发中，设计模式是解决反复出现问题的通用解决方案。单例模式作为一种创建型设计模式，确保一个类仅有一个实例，并提供一个全局访问点来访问这个实例。在C语言中，由于没有像C++和Java那样的类和对象的直接支持，但通过巧妙地使用结构体和函数指针等特性，同样可以实现单例模式。本文将深入探讨C语言中如何实现单例模式，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 单例模式基础概念
2. C语言实现单例模式的使用方法
    - 饿汉式单例模式
    - 懒汉式单例模式
3. 常见实践
    - 线程安全的单例模式
    - 单例模式与资源管理
4. 最佳实践
    - 错误处理
    - 内存管理
5. 小结

## 单例模式基础概念
单例模式的核心思想是确保一个类只有一个实例，并提供一个全局访问点来访问这个实例。这个全局访问点通常是一个静态函数，它返回唯一实例的指针。在C语言中，我们可以使用静态变量和函数来模拟类的静态成员，通过结构体来表示类的实例。

单例模式适用于以下场景：
- 当系统中需要一个全局唯一的资源，例如日志记录器、数据库连接池等。
- 当需要控制对象的创建数量，避免重复创建对象带来的资源浪费。

## C语言实现单例模式的使用方法

### 饿汉式单例模式
饿汉式单例模式在程序启动时就创建好唯一的实例，无论是否需要使用。这种方式简单直接，并且天生是线程安全的。

```c
#include <stdio.h>

// 定义单例结构体
typedef struct Singleton {
    int data;
} Singleton;

// 静态全局变量，在程序启动时创建唯一实例
static Singleton instance = {0};

// 获取单例实例的函数
Singleton* getSingleton() {
    return &instance;
}

int main() {
    Singleton* s1 = getSingleton();
    Singleton* s2 = getSingleton();

    // 检查s1和s2是否指向同一个实例
    if (s1 == s2) {
        printf("s1和s2是同一个实例\n");
    } else {
        printf("s1和s2不是同一个实例\n");
    }

    s1->data = 10;
    printf("s2->data的值为：%d\n", s2->data);

    return 0;
}
```

### 懒汉式单例模式
懒汉式单例模式在第一次使用时才创建实例，实现了延迟初始化。但在多线程环境下，这种方式不是线程安全的。

```c
#include <stdio.h>
#include <stdlib.h>

// 定义单例结构体
typedef struct Singleton {
    int data;
} Singleton;

// 静态全局变量，初始化为NULL
static Singleton* instance = NULL;

// 获取单例实例的函数
Singleton* getSingleton() {
    if (instance == NULL) {
        instance = (Singleton*)malloc(sizeof(Singleton));
        instance->data = 0;
    }
    return instance;
}

// 释放单例实例的函数
void freeSingleton() {
    if (instance!= NULL) {
        free(instance);
        instance = NULL;
    }
}

int main() {
    Singleton* s1 = getSingleton();
    Singleton* s2 = getSingleton();

    // 检查s1和s2是否指向同一个实例
    if (s1 == s2) {
        printf("s1和s2是同一个实例\n");
    } else {
        printf("s1和s2不是同一个实例\n");
    }

    s1->data = 10;
    printf("s2->data的值为：%d\n", s2->data);

    // 释放单例实例
    freeSingleton();

    return 0;
}
```

## 常见实践

### 线程安全的单例模式
在多线程环境下，懒汉式单例模式需要进行线程安全处理。可以使用互斥锁（mutex）来确保在多线程环境下实例只被创建一次。

```c
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

// 定义单例结构体
typedef struct Singleton {
    int data;
} Singleton;

// 静态全局变量，初始化为NULL
static Singleton* instance = NULL;
// 静态互斥锁
static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

// 获取单例实例的函数
Singleton* getSingleton() {
    pthread_mutex_lock(&mutex);
    if (instance == NULL) {
        instance = (Singleton*)malloc(sizeof(Singleton));
        instance->data = 0;
    }
    pthread_mutex_unlock(&mutex);
    return instance;
}

// 释放单例实例的函数
void freeSingleton() {
    pthread_mutex_lock(&mutex);
    if (instance!= NULL) {
        free(instance);
        instance = NULL;
    }
    pthread_mutex_unlock(&mutex);
}

// 线程函数
void* threadFunction(void* arg) {
    Singleton* s = getSingleton();
    s->data += 1;
    printf("线程 %ld 中，data的值为：%d\n", pthread_self(), s->data);
    return NULL;
}

int main() {
    pthread_t thread1, thread2;

    // 创建两个线程
    pthread_create(&thread1, NULL, threadFunction, NULL);
    pthread_create(&thread2, NULL, threadFunction, NULL);

    // 等待线程结束
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    // 释放单例实例
    freeSingleton();

    // 销毁互斥锁
    pthread_mutex_destroy(&mutex);

    return 0;
}
```

### 单例模式与资源管理
单例模式常用于管理系统资源，如数据库连接。以下是一个简单的数据库连接单例示例：

```c
#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

// 定义数据库连接单例结构体
typedef struct DatabaseSingleton {
    MYSQL* connection;
} DatabaseSingleton;

// 静态全局变量，初始化为NULL
static DatabaseSingleton* dbInstance = NULL;
// 静态互斥锁
static pthread_mutex_t dbMutex = PTHREAD_MUTEX_INITIALIZER;

// 获取数据库连接单例实例的函数
DatabaseSingleton* getDatabaseSingleton() {
    pthread_mutex_lock(&dbMutex);
    if (dbInstance == NULL) {
        dbInstance = (DatabaseSingleton*)malloc(sizeof(DatabaseSingleton));
        dbInstance->connection = mysql_init(NULL);
        if (mysql_real_connect(dbInstance->connection, "localhost", "username", "password", "database", 0, NULL, 0) == NULL) {
            fprintf(stderr, "数据库连接错误: %s\n", mysql_error(dbInstance->connection));
            free(dbInstance);
            dbInstance = NULL;
        }
    }
    pthread_mutex_unlock(&dbMutex);
    return dbInstance;
}

// 释放数据库连接单例实例的函数
void freeDatabaseSingleton() {
    pthread_mutex_lock(&dbMutex);
    if (dbInstance!= NULL) {
        mysql_close(dbInstance->connection);
        free(dbInstance);
        dbInstance = NULL;
    }
    pthread_mutex_unlock(&dbMutex);
}

int main() {
    DatabaseSingleton* db1 = getDatabaseSingleton();
    DatabaseSingleton* db2 = getDatabaseSingleton();

    // 检查db1和db2是否指向同一个实例
    if (db1 == db2) {
        printf("db1和db2是同一个实例\n");
    } else {
        printf("db1和db2不是同一个实例\n");
    }

    // 释放数据库连接单例实例
    freeDatabaseSingleton();

    // 销毁互斥锁
    pthread_mutex_destroy(&dbMutex);

    return 0;
}
```

## 最佳实践

### 错误处理
在单例模式的实现中，尤其是涉及资源分配（如内存分配、文件打开、数据库连接等）时，要进行充分的错误处理。例如，在创建单例实例时，如果资源分配失败，应返回合适的错误信息，并确保不会产生悬空指针。

### 内存管理
在单例模式中，要注意内存的正确分配和释放。对于使用`malloc`分配的内存，在不再需要单例实例时，应调用`free`进行释放。同时，要避免多次释放同一内存块。

## 小结
本文详细介绍了C语言中实现单例模式的方法，包括饿汉式和懒汉式单例模式，以及如何处理线程安全和资源管理问题。单例模式在C语言开发中是一种强大的设计模式，适用于许多需要全局唯一资源管理的场景。通过遵循最佳实践，如错误处理和内存管理，可以确保单例模式的稳定性和可靠性。希望本文能帮助读者深入理解并高效使用C语言中的单例模式。

以上博客内容全面涵盖了C语言设计模式中单例模式的相关知识，通过清晰的代码示例和详细的解释，希望能帮助读者更好地掌握这一设计模式。在实际应用中，应根据具体需求选择合适的单例模式实现方式，并注意遵循最佳实践以确保程序的质量。
---
title:  C语言设计模式之享元模式：优化资源利用的利器
description:  简介在软件开发过程中，我们常常会遇到这样的情况：创建大量相似对象会消耗过多的系统资源，导致性能下降。享元模式（Flyweight Pattern）作为一种设计模式，旨在通过共享对象来减少内存消耗，提高系统的性能和效率。本文将深入探讨C语言中享元模式的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和运用这一强大的设计模式。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发过程中，我们常常会遇到这样的情况：创建大量相似对象会消耗过多的系统资源，导致性能下降。享元模式（Flyweight Pattern）作为一种设计模式，旨在通过共享对象来减少内存消耗，提高系统的性能和效率。本文将深入探讨C语言中享元模式的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和运用这一强大的设计模式。

## 目录
1. **享元模式基础概念**
    - 定义
    - 结构与角色
2. **享元模式使用方法**
    - 享元工厂的创建
    - 享元对象的获取与使用
3. **常见实践**
    - 文本渲染示例
    - 游戏开发中的应用
4. **最佳实践**
    - 确定可共享的状态
    - 管理享元对象的生命周期
5. **小结**

## 享元模式基础概念
### 定义
享元模式是一种结构型设计模式，它通过共享已经存在的对象来避免创建大量相同或相似的对象，从而节省内存空间，提高系统性能。享元对象通常是不可变的，它们只包含内部状态（intrinsic state），而外部状态（extrinsic state）则由客户端在使用时提供。

### 结构与角色
享元模式主要包含以下几个角色：
- **享元（Flyweight）**：定义一个接口或抽象类，通过这个接口或抽象类可以接受并作用于外部状态。
- **具体享元（ConcreteFlyweight）**：实现享元接口，包含内部状态并处理外部状态。
- **享元工厂（FlyweightFactory）**：创建并管理享元对象，确保享元对象可以被共享。

## 享元模式使用方法
### 享元工厂的创建
在C语言中，我们可以通过结构体和函数指针来实现享元模式。以下是一个简单的享元工厂示例：

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 享元接口
typedef struct Flyweight Flyweight;
struct Flyweight {
    void (*operation)(Flyweight* self, const char* extrinsicState);
};

// 具体享元
typedef struct ConcreteFlyweight ConcreteFlyweight;
struct ConcreteFlyweight {
    Flyweight flyweight;
    char* intrinsicState;
};

// 具体享元的操作函数
void ConcreteFlyweight_operation(Flyweight* self, const char* extrinsicState) {
    ConcreteFlyweight* concreteFlyweight = (ConcreteFlyweight*)self;
    printf("Intrinsic State: %s, Extrinsic State: %s\n", concreteFlyweight->intrinsicState, extrinsicState);
}

// 享元工厂
typedef struct FlyweightFactory FlyweightFactory;
struct FlyweightFactory {
    Flyweight** flyweights;
    int capacity;
    int count;
};

// 创建享元工厂
FlyweightFactory* FlyweightFactory_create(int initialCapacity) {
    FlyweightFactory* factory = (FlyweightFactory*)malloc(sizeof(FlyweightFactory));
    factory->flyweights = (Flyweight**)malloc(initialCapacity * sizeof(Flyweight*));
    factory->capacity = initialCapacity;
    factory->count = 0;
    return factory;
}

// 获取享元对象
Flyweight* FlyweightFactory_getFlyweight(FlyweightFactory* factory, const char* key) {
    for (int i = 0; i < factory->count; i++) {
        ConcreteFlyweight* flyweight = (ConcreteFlyweight*)factory->flyweights[i];
        if (strcmp(flyweight->intrinsicState, key) == 0) {
            return factory->flyweights[i];
        }
    }
    if (factory->count == factory->capacity) {
        factory->capacity *= 2;
        factory->flyweights = (Flyweight**)realloc(factory->flyweights, factory->capacity * sizeof(Flyweight*));
    }
    ConcreteFlyweight* newFlyweight = (ConcreteFlyweight*)malloc(sizeof(ConcreteFlyweight));
    newFlyweight->flyweight.operation = ConcreteFlyweight_operation;
    newFlyweight->intrinsicState = (char*)malloc((strlen(key) + 1) * sizeof(char));
    strcpy(newFlyweight->intrinsicState, key);
    factory->flyweights[factory->count++] = &newFlyweight->flyweight;
    return &newFlyweight->flyweight;
}

// 销毁享元工厂
void FlyweightFactory_destroy(FlyweightFactory* factory) {
    for (int i = 0; i < factory->count; i++) {
        ConcreteFlyweight* flyweight = (ConcreteFlyweight*)factory->flyweights[i];
        free(flyweight->intrinsicState);
        free(flyweight);
    }
    free(factory->flyweights);
    free(factory);
}
```

### 享元对象的获取与使用
在创建了享元工厂之后，我们可以通过工厂获取享元对象并使用它们：

```c
int main() {
    FlyweightFactory* factory = FlyweightFactory_create(10);
    Flyweight* flyweight1 = FlyweightFactory_getFlyweight(factory, "shared state 1");
    Flyweight* flyweight2 = FlyweightFactory_getFlyweight(factory, "shared state 2");
    Flyweight* flyweight3 = FlyweightFactory_getFlyweight(factory, "shared state 1"); // 共享同一个对象

    flyweight1->operation(flyweight1, "external state 1");
    flyweight2->operation(flyweight2, "external state 2");
    flyweight3->operation(flyweight3, "external state 3");

    FlyweightFactory_destroy(factory);
    return 0;
}
```

## 常见实践
### 文本渲染示例
在文本渲染中，字符的字形（font glyph）可以作为享元对象。不同的文本片段可能包含相同的字符，通过共享字形对象可以减少内存消耗。

```c
// 假设已经有上述享元模式的基本代码

// 文本渲染相关结构体
typedef struct TextRendering TextRendering;
struct TextRendering {
    FlyweightFactory* factory;
};

// 初始化文本渲染
TextRendering* TextRendering_create() {
    TextRendering* rendering = (TextRendering*)malloc(sizeof(TextRendering));
    rendering->factory = FlyweightFactory_create(10);
    return rendering;
}

// 渲染文本
void TextRendering_renderText(TextRendering* rendering, const char* text) {
    for (int i = 0; text[i]!= '\0'; i++) {
        char key[2] = {text[i], '\0'};
        Flyweight* flyweight = FlyweightFactory_getFlyweight(rendering->factory, key);
        flyweight->operation(flyweight, "");
    }
}

// 销毁文本渲染
void TextRendering_destroy(TextRendering* rendering) {
    FlyweightFactory_destroy(rendering->factory);
    free(rendering);
}

int main() {
    TextRendering* rendering = TextRendering_create();
    TextRendering_renderText(rendering, "Hello, World!");
    TextRendering_destroy(rendering);
    return 0;
}
```

### 游戏开发中的应用
在游戏开发中，大量的游戏对象（如树木、石头等）可能具有相同的外观和属性。通过享元模式，可以共享这些对象的公共部分，提高游戏性能。

```c
// 假设已经有上述享元模式的基本代码

// 游戏对象相关结构体
typedef struct GameObject GameObject;
struct GameObject {
    Flyweight* appearance;
    int x;
    int y;
};

// 创建游戏对象
GameObject* GameObject_create(FlyweightFactory* factory, const char* appearanceKey, int x, int y) {
    GameObject* object = (GameObject*)malloc(sizeof(GameObject));
    object->appearance = FlyweightFactory_getFlyweight(factory, appearanceKey);
    object->x = x;
    object->y = y;
    return object;
}

// 渲染游戏对象
void GameObject_render(GameObject* object) {
    char extrinsicState[100];
    sprintf(extrinsicState, "Position: (%d, %d)", object->x, object->y);
    object->appearance->operation(object->appearance, extrinsicState);
}

// 销毁游戏对象
void GameObject_destroy(GameObject* object) {
    free(object);
}

int main() {
    FlyweightFactory* factory = FlyweightFactory_create(10);
    GameObject* tree1 = GameObject_create(factory, "tree appearance", 10, 20);
    GameObject* tree2 = GameObject_create(factory, "tree appearance", 30, 40);

    GameObject_render(tree1);
    GameObject_render(tree2);

    GameObject_destroy(tree1);
    GameObject_destroy(tree2);
    FlyweightFactory_destroy(factory);
    return 0;
}
```

## 最佳实践
### 确定可共享的状态
在应用享元模式之前，需要仔细分析对象的状态，确定哪些状态是可共享的内部状态，哪些是需要外部提供的外部状态。只有那些不会因上下文变化而改变的状态才适合作为内部状态进行共享。

### 管理享元对象的生命周期
享元对象的生命周期管理非常重要。确保在不再需要享元对象时，能够正确地释放它们所占用的资源，避免内存泄漏。可以通过在享元工厂中添加相应的销毁函数来管理享元对象的生命周期。

## 小结
享元模式是一种强大的设计模式，它通过共享对象来减少内存消耗，提高系统性能。在C语言中，我们可以通过结构体和函数指针来实现享元模式。通过合理应用享元模式，可以有效优化资源利用，特别是在创建大量相似对象的场景中。希望本文能帮助读者更好地理解和运用C语言中的享元模式，在实际项目中提升代码的质量和性能。

以上就是关于C语言设计模式之享元模式的全部内容，如有不足之处，欢迎大家指出和交流。

---

希望这篇博客对你有所帮助。如果你还有其他需求，比如进一步完善示例代码、增加更多实践场景等，请随时告诉我。
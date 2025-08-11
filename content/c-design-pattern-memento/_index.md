---
title:  C语言设计模式之备忘录模式：保存与恢复对象状态的艺术
description:  简介在软件开发过程中，我们常常会遇到需要保存和恢复对象状态的情况。比如在游戏中，玩家可能需要随时保存游戏进度以便之后继续；文本编辑器中，用户可能希望撤销上一步操作恢复到之前的文本状态。备忘录模式（Memento Pattern）正是为解决这类问题而设计的一种设计模式。它提供了一种机制，允许在不破坏对象封装性的前提下，捕获并外部化对象的内部状态，以便在将来的某个时刻能够恢复到该状态。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发过程中，我们常常会遇到需要保存和恢复对象状态的情况。比如在游戏中，玩家可能需要随时保存游戏进度以便之后继续；文本编辑器中，用户可能希望撤销上一步操作恢复到之前的文本状态。备忘录模式（Memento Pattern）正是为解决这类问题而设计的一种设计模式。它提供了一种机制，允许在不破坏对象封装性的前提下，捕获并外部化对象的内部状态，以便在将来的某个时刻能够恢复到该状态。

## 目录
1. 备忘录模式基础概念
    - 定义与原理
    - 角色与职责
2. 使用方法
    - 创建备忘录类
    - 创建原发器类
    - 创建负责人类
    - 示例代码实现
3. 常见实践
    - 游戏进度保存
    - 文本编辑器撤销操作
4. 最佳实践
    - 合理使用备忘录
    - 避免过度保存状态
    - 与其他设计模式结合使用
5. 小结

## 备忘录模式基础概念
### 定义与原理
备忘录模式定义：在不破坏封装性的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。这样以后就可将该对象恢复到原先保存的状态。

原理上，备忘录模式通过三个主要角色来实现状态的保存与恢复：原发器（Originator）负责创建一个备忘录，用以记录当前时刻它的内部状态；备忘录（Memento）负责存储原发器对象的内部状态；负责人（Caretaker）负责保存备忘录，但不能对备忘录的内容进行操作或检查。

### 角色与职责
- **原发器（Originator）**：一个普通的业务对象，它知晓自身状态并能将状态保存到备忘录中，也能从备忘录中恢复状态。例如，游戏中的角色对象，它可以保存自己的位置、生命值等状态到备忘录，也能从备忘录中恢复这些状态。
- **备忘录（Memento）**：负责存储原发器的内部状态。它提供必要的接口来允许原发器访问自己保存的状态，但对其他对象隐藏这些状态细节。
- **负责人（Caretaker）**：负责管理备忘录，比如保存备忘录、获取备忘录等操作。它并不关心备忘录中所存储的具体状态内容，只负责备忘录的生命周期管理。

## 使用方法
### 创建备忘录类
备忘录类负责存储原发器的状态。在C语言中，我们可以通过结构体来实现。

```c
// 备忘录结构体
typedef struct Memento {
    int state; // 假设原发器的状态是一个整数
} Memento;

// 创建备忘录
Memento* createMemento(int state) {
    Memento* memento = (Memento*)malloc(sizeof(Memento));
    memento->state = state;
    return memento;
}

// 获取备忘录中的状态
int getStateFromMemento(Memento* memento) {
    return memento->state;
}

// 释放备忘录内存
void freeMemento(Memento* memento) {
    free(memento);
}
```

### 创建原发器类
原发器类需要能够创建备忘录来保存自己的状态，也能从备忘录中恢复状态。

```c
// 原发器结构体
typedef struct Originator {
    int state; // 原发器的当前状态
} Originator;

// 创建原发器
Originator* createOriginator(int initialState) {
    Originator* originator = (Originator*)malloc(sizeof(Originator));
    originator->state = initialState;
    return originator;
}

// 创建备忘录
Memento* createMementoFromOriginator(Originator* originator) {
    return createMemento(originator->state);
}

// 从备忘录恢复状态
void restoreStateFromMemento(Originator* originator, Memento* memento) {
    originator->state = getStateFromMemento(memento);
}

// 释放原发器内存
void freeOriginator(Originator* originator) {
    free(originator);
}
```

### 创建负责人类
负责人类负责管理备忘录，主要操作是保存和获取备忘录。

```c
// 负责人结构体
typedef struct Caretaker {
    Memento* memento;
} Caretaker;

// 创建负责人
Caretaker* createCaretaker() {
    Caretaker* caretaker = (Caretaker*)malloc(sizeof(Caretaker));
    caretaker->memento = NULL;
    return caretaker;
}

// 保存备忘录
void saveMemento(Caretaker* caretaker, Memento* memento) {
    if (caretaker->memento!= NULL) {
        freeMemento(caretaker->memento);
    }
    caretaker->memento = memento;
}

// 获取备忘录
Memento* getMemento(Caretaker* caretaker) {
    return caretaker->memento;
}

// 释放负责人内存
void freeCaretaker(Caretaker* caretaker) {
    if (caretaker->memento!= NULL) {
        freeMemento(caretaker->memento);
    }
    free(caretaker);
}
```

### 示例代码实现
下面是一个完整的示例代码，展示如何使用备忘录模式。

```c
#include <stdio.h>

// 上述备忘录类、原发器类、负责人类的代码

int main() {
    // 创建原发器并设置初始状态
    Originator* originator = createOriginator(10);
    printf("原发器初始状态: %d\n", originator->state);

    // 创建负责人
    Caretaker* caretaker = createCaretaker();

    // 保存原发器状态到备忘录
    Memento* memento = createMementoFromOriginator(originator);
    saveMemento(caretaker, memento);

    // 修改原发器状态
    originator->state = 20;
    printf("原发器修改后的状态: %d\n", originator->state);

    // 从备忘录恢复原发器状态
    Memento* retrievedMemento = getMemento(caretaker);
    restoreStateFromMemento(originator, retrievedMemento);
    printf("原发器恢复后的状态: %d\n", originator->state);

    // 释放内存
    freeMemento(retrievedMemento);
    freeCaretaker(caretaker);
    freeOriginator(originator);

    return 0;
}
```

## 常见实践
### 游戏进度保存
在游戏开发中，备忘录模式常用于保存游戏进度。例如，游戏中的角色对象作为原发器，其位置、等级、装备等状态可以被保存到备忘录中。负责人可以是游戏的存档系统，负责管理这些备忘录。当玩家需要保存进度时，原发器创建备忘录并交给负责人保存；当玩家加载进度时，负责人获取备忘录并让原发器恢复状态。

### 文本编辑器撤销操作
文本编辑器中，每一次的编辑操作都会改变文本的状态。可以将文本对象视为原发器，每次编辑前的文本状态保存到备忘录中。负责人负责管理这些备忘录。当用户点击撤销按钮时，从负责人获取相应的备忘录并恢复文本到之前的状态。

## 最佳实践
### 合理使用备忘录
备忘录模式虽然强大，但不应该滥用。只有在真正需要保存和恢复对象状态的场景下使用，避免为了使用模式而使用模式。例如，如果对象状态很少发生变化或者不需要恢复到之前的状态，就没有必要使用备忘录模式。

### 避免过度保存状态
保存状态需要占用内存空间，如果频繁保存状态或者保存过多不必要的状态，可能会导致内存消耗过大。因此，需要根据实际需求合理控制保存状态的频率和内容。

### 与其他设计模式结合使用
备忘录模式可以与其他设计模式结合使用以发挥更大的作用。例如，与命令模式结合，可以更好地实现撤销和重做操作；与单例模式结合，可以方便地管理全局的状态保存与恢复。

## 小结
备忘录模式为我们提供了一种在不破坏对象封装性的情况下保存和恢复对象状态的有效方法。通过原发器、备忘录和负责人这三个角色的协同工作，能够轻松实现各种需要状态管理的场景。在实际应用中，我们需要理解其基础概念，掌握正确的使用方法，并遵循最佳实践原则，以确保代码的高效性和可维护性。希望通过本文的介绍，读者能够深入理解并在C语言项目中灵活运用备忘录模式。
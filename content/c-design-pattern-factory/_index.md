---
title:  C语言设计模式之工厂模式
description:  简介在软件开发过程中，代码的可维护性、可扩展性以及可复用性是至关重要的。设计模式作为解决软件开发中反复出现问题的通用解决方案，能够帮助开发者更好地组织和架构代码。工厂模式是一种创建型设计模式，它提供了一种创建对象的方式，将对象的创建和使用分离，使得代码的依赖关系更加清晰，提高了代码的可维护性和可扩展性。本文将详细介绍C语言中工厂模式的基础概念、使用方法、常见实践以及最佳实践，帮助读者深入理解并在实际项目中高效使用该模式。
date: 2025-01-16
categories: [c]
last_modified_at: 2025-04-05 
layout: post
cascade:
  - type: docs
---


## 简介
在软件开发过程中，代码的可维护性、可扩展性以及可复用性是至关重要的。设计模式作为解决软件开发中反复出现问题的通用解决方案，能够帮助开发者更好地组织和架构代码。工厂模式是一种创建型设计模式，它提供了一种创建对象的方式，将对象的创建和使用分离，使得代码的依赖关系更加清晰，提高了代码的可维护性和可扩展性。本文将详细介绍C语言中工厂模式的基础概念、使用方法、常见实践以及最佳实践，帮助读者深入理解并在实际项目中高效使用该模式。

## 目录
1. 工厂模式基础概念
2. 工厂模式使用方法
3. 工厂模式常见实践
4. 工厂模式最佳实践
5. 小结

## 工厂模式基础概念
工厂模式是一种创建对象的设计模式，它定义了一个创建对象的接口（在C语言中通常是函数），让子类（或其他模块）决定实例化哪个类（或创建哪种类型的对象）。工厂模式的核心思想是将对象的创建逻辑封装在一个单独的函数或模块中，而不是在客户端代码中直接实例化对象，这样可以降低代码的耦合度，提高代码的可维护性和可扩展性。

工厂模式通常包含以下几个角色：
- **工厂类（Factory）**：负责创建对象的类，它提供了一个创建对象的接口（函数）。
- **产品类（Product）**：工厂类创建的对象的抽象类或基类，定义了产品的公共接口。
- **具体产品类（Concrete Product）**：继承自产品类，实现了产品类定义的接口，是工厂类实际创建的对象。

## 工厂模式使用方法
在C语言中实现工厂模式，我们可以通过函数指针和结构体来模拟面向对象编程中的类和对象。下面是一个简单的示例，展示如何使用工厂模式创建不同类型的图形对象（以圆形和矩形为例）。

### 定义产品类
首先，我们定义一个图形的抽象结构体，作为所有具体图形的基类。

```c
#include <stdio.h>
#include <stdlib.h>

// 定义图形结构体（产品类）
typedef struct Shape {
    void (*draw)(void);
} Shape;
```

### 定义具体产品类
然后，我们定义圆形和矩形的具体结构体，并实现它们的绘制函数。

```c
// 定义圆形结构体（具体产品类）
typedef struct Circle {
    Shape shape;
    int radius;
} Circle;

// 圆形绘制函数
void drawCircle(void) {
    printf("绘制圆形\n");
}

// 创建圆形对象的函数
Circle* createCircle(int radius) {
    Circle* circle = (Circle*)malloc(sizeof(Circle));
    circle->radius = radius;
    circle->shape.draw = drawCircle;
    return circle;
}

// 定义矩形结构体（具体产品类）
typedef struct Rectangle {
    Shape shape;
    int width;
    int height;
} Rectangle;

// 矩形绘制函数
void drawRectangle(void) {
    printf("绘制矩形\n");
}

// 创建矩形对象的函数
Rectangle* createRectangle(int width, int height) {
    Rectangle* rectangle = (Rectangle*)malloc(sizeof(Rectangle));
    rectangle->width = width;
    rectangle->height = height;
    rectangle->shape.draw = drawRectangle;
    return rectangle;
}
```

### 定义工厂类
接下来，我们定义一个工厂函数，根据传入的参数创建不同类型的图形对象。

```c
// 工厂函数
Shape* createShape(int shapeType) {
    switch (shapeType) {
        case 1:
            return (Shape*)createCircle(5);
        case 2:
            return (Shape*)createRectangle(10, 5);
        default:
            return NULL;
    }
}
```

### 使用工厂模式
最后，我们在主函数中使用工厂模式创建并绘制图形对象。

```c
int main() {
    Shape* shape1 = createShape(1);
    if (shape1) {
        shape1->draw();
        free(shape1);
    }

    Shape* shape2 = createShape(2);
    if (shape2) {
        shape2->draw();
        free(shape2);
    }

    return 0;
}
```

### 代码说明
1. **产品类**：`Shape`结构体定义了一个抽象的图形对象，包含一个函数指针`draw`用于绘制图形。
2. **具体产品类**：`Circle`和`Rectangle`结构体分别表示圆形和矩形，它们继承自`Shape`结构体，并实现了各自的绘制函数。
3. **工厂类**：`createShape`函数是工厂函数，根据传入的参数`shapeType`决定创建哪种类型的图形对象。
4. **使用工厂模式**：在`main`函数中，通过调用`createShape`函数创建不同类型的图形对象，并调用它们的`draw`函数进行绘制。

## 工厂模式常见实践
### 配置文件驱动的对象创建
在实际项目中，我们可以通过读取配置文件来决定创建哪些对象。例如，配置文件中可以指定要创建的图形类型（圆形或矩形）以及相关参数（半径、宽度、高度等）。

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 定义图形结构体（产品类）
typedef struct Shape {
    void (*draw)(void);
} Shape;

// 定义圆形结构体（具体产品类）
typedef struct Circle {
    Shape shape;
    int radius;
} Circle;

// 圆形绘制函数
void drawCircle(void) {
    printf("绘制圆形\n");
}

// 创建圆形对象的函数
Circle* createCircle(int radius) {
    Circle* circle = (Circle*)malloc(sizeof(Circle));
    circle->radius = radius;
    circle->shape.draw = drawCircle;
    return circle;
}

// 定义矩形结构体（具体产品类）
typedef struct Rectangle {
    Shape shape;
    int width;
    int height;
} Rectangle;

// 矩形绘制函数
void drawRectangle(void) {
    printf("绘制矩形\n");
}

// 创建矩形对象的函数
Rectangle* createRectangle(int width, int height) {
    Rectangle* rectangle = (Rectangle*)malloc(sizeof(Rectangle));
    rectangle->width = width;
    rectangle->height = height;
    rectangle->shape.draw = drawRectangle;
    return rectangle;
}

// 工厂函数
Shape* createShape(const char* shapeType) {
    if (strcmp(shapeType, "circle") == 0) {
        return (Shape*)createCircle(5);
    } else if (strcmp(shapeType, "rectangle") == 0) {
        return (Shape*)createRectangle(10, 5);
    }
    return NULL;
}

int main() {
    char config[100];
    FILE* configFile = fopen("config.txt", "r");
    if (configFile) {
        while (fgets(config, sizeof(config), configFile)) {
            // 去除换行符
            config[strcspn(config, "\n")] = '\0';
            Shape* shape = createShape(config);
            if (shape) {
                shape->draw();
                free(shape);
            }
        }
        fclose(configFile);
    }

    return 0;
}
```

### 动态链接库实现的对象创建
在一些大型项目中，我们可以将不同类型对象的创建逻辑封装在动态链接库中，通过动态加载链接库来创建对象。这样可以实现代码的模块化和动态扩展。

#### 动态链接库代码（以圆形为例）
```c
// circle.c
#include <stdio.h>
#include <stdlib.h>

// 定义圆形结构体
typedef struct Circle {
    void (*draw)(void);
    int radius;
} Circle;

// 圆形绘制函数
void drawCircle(void) {
    printf("绘制圆形\n");
}

// 创建圆形对象的函数，导出为动态链接库函数
Circle* createCircle(int radius) {
    Circle* circle = (Circle*)malloc(sizeof(Circle));
    circle->radius = radius;
    circle->draw = drawCircle;
    return circle;
}
```

#### 编译动态链接库（以Linux为例）
```sh
gcc -shared -o libcircle.so -fPIC circle.c
```

#### 主程序代码
```c
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

// 定义图形结构体
typedef struct Shape {
    void (*draw)(void);
} Shape;

int main() {
    void* handle = dlopen("./libcircle.so", RTLD_LAZY);
    if (!handle) {
        fprintf(stderr, "%s\n", dlerror());
        return 1;
    }

    // 解析动态链接库中的函数
    Shape* (*createCircle)(int) = (Shape* (*)(int))dlsym(handle, "createCircle");
    if (!createCircle) {
        fprintf(stderr, "%s\n", dlerror());
        dlclose(handle);
        return 1;
    }

    Shape* shape = createCircle(5);
    if (shape) {
        shape->draw();
        free(shape);
    }

    dlclose(handle);
    return 0;
}
```

## 工厂模式最佳实践
### 单一职责原则
工厂类应该只负责对象的创建，而不应该包含与对象创建无关的逻辑。这样可以保证工厂类的职责单一，提高代码的可维护性和可测试性。

### 依赖注入
在使用工厂模式时，可以通过依赖注入的方式将工厂对象传递给需要创建对象的类或函数。这样可以使代码更加灵活，便于单元测试和替换不同的工厂实现。

### 错误处理
在工厂函数中，应该对可能出现的错误进行适当的处理，例如内存分配失败、参数无效等情况。可以通过返回错误码或`NULL`指针来表示错误，并在调用端进行相应的处理。

### 代码复用
尽量复用已有的工厂类和产品类，避免重复编写相似的代码。可以通过继承、组合等方式来实现代码的复用，提高代码的可维护性和可扩展性。

## 小结
工厂模式是一种强大的创建型设计模式，它通过将对象的创建和使用分离，提高了代码的可维护性、可扩展性和可复用性。在C语言中，我们可以通过函数指针和结构体来实现工厂模式。通过本文介绍的基础概念、使用方法、常见实践以及最佳实践，希望读者能够深入理解并在实际项目中灵活运用工厂模式，编写出更加健壮、可维护的代码。

希望这篇博客对您理解和使用C语言设计模式中的工厂模式有所帮助。如果您有任何疑问或建议，欢迎在评论区留言。
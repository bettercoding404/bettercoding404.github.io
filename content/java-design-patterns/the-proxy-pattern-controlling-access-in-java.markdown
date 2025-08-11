---
title: "The Proxy Pattern: Controlling Access in Java"
description: "
In the world of software design patterns, the Proxy Pattern is a powerful and versatile tool, especially when it comes to controlling access to an object. In Java, the Proxy Pattern can be used to create a surrogate or placeholder for another object, providing a level of indirection that can be used to control access, add additional functionality, or optimize performance. This blog post will delve into the fundamental concepts of the Proxy Pattern in Java, explore its usage methods, common practices, and best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Fundamental Concepts of the Proxy Pattern](#fundamental-concepts-of-the-proxy-pattern)
2. [Usage Methods in Java](#usage-methods-in-java)
3. [Common Practices](#common-practices)
4. [Best Practices](#best-practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Fundamental Concepts of the Proxy Pattern
The Proxy Pattern is a structural design pattern that allows you to provide a substitute or placeholder for another object. A proxy controls access to the original object, allowing you to perform something either before or after the request gets through to the original object.

There are several types of proxies, including:
- **Remote Proxy**: Acts as a local representative for an object that resides in a different address space. For example, in a distributed system, a remote proxy can be used to access a service running on a different server.
- **Virtual Proxy**: Creates expensive objects on demand. For instance, if you have an image that is very large and takes a long time to load, a virtual proxy can be used to defer the loading of the image until it is actually needed.
- **Protection Proxy**: Controls access to the real subject based on access rights. For example, you might have a proxy that only allows authenticated users to access a certain resource.

## Usage Methods in Java
In Java, there are two main ways to implement the Proxy Pattern: static proxies and dynamic proxies.

### Static Proxy
A static proxy is a proxy class that is created at compile time. Here is a simple example:

```java
// Subject interface
interface Image {
    void display();
}

// RealSubject class
class RealImage implements Image {
    private String fileName;

    public RealImage(String fileName) {
        this.fileName = fileName;
        loadFromDisk(fileName);
    }

    @Override
    public void display() {
        System.out.println("Displaying " + fileName);
    }

    private void loadFromDisk(String fileName) {
        System.out.println("Loading " + fileName);
    }
}

// Proxy class
class ProxyImage implements Image {
    private RealImage realImage;
    private String fileName;

    public ProxyImage(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void display() {
        if (realImage == null) {
            realImage = new RealImage(fileName);
        }
        realImage.display();
    }
}

// Main class to test the proxy
public class StaticProxyExample {
    public static void main(String[] args) {
        Image image = new ProxyImage("test.jpg");

        // Image will be loaded from disk
        image.display();
        System.out.println("");

        // Image will not be loaded from disk again
        image.display();
    }
}
```

In this example, the `ProxyImage` class acts as a proxy for the `RealImage` class. It defers the creation of the `RealImage` object until the `display` method is called.

### Dynamic Proxy
A dynamic proxy is a proxy class that is created at runtime. Java provides the `java.lang.reflect.Proxy` class and the `java.lang.reflect.InvocationHandler` interface to create dynamic proxies. Here is an example:

```java
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

// Subject interface
interface Calculator {
    int add(int a, int b);
}

// RealSubject class
class RealCalculator implements Calculator {
    @Override
    public int add(int a, int b) {
        return a + b;
    }
}

// InvocationHandler implementation
class CalculatorProxyHandler implements InvocationHandler {
    private Object target;

    public CalculatorProxyHandler(Object target) {
        this.target = target;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("Before method call");
        Object result = method.invoke(target, args);
        System.out.println("After method call");
        return result;
    }
}

// Main class to test the dynamic proxy
public class DynamicProxyExample {
    public static void main(String[] args) {
        Calculator realCalculator = new RealCalculator();
        CalculatorProxyHandler handler = new CalculatorProxyHandler(realCalculator);

        Calculator proxyCalculator = (Calculator) Proxy.newProxyInstance(
                Calculator.class.getClassLoader(),
                new Class<?>[]{Calculator.class},
                handler
        );

        int result = proxyCalculator.add(2, 3);
        System.out.println("Result: " + result);
    }
}
```

In this example, the `CalculatorProxyHandler` class implements the `InvocationHandler` interface. The `invoke` method is called every time a method on the proxy object is invoked.

## Common Practices
- **Access Control**: Use a protection proxy to control access to sensitive resources. For example, you can create a proxy that checks if a user is authenticated before allowing access to a particular method.
- **Lazy Loading**: Use a virtual proxy to defer the creation of expensive objects until they are actually needed. This can improve the performance of your application, especially if the objects are large or time-consuming to create.
- **Remote Access**: Use a remote proxy to access services running on a different server. This can simplify the communication between different parts of a distributed system.

## Best Practices
- **Keep the Proxy Simple**: The proxy should only focus on its main responsibility, which is to control access or add additional functionality. Avoid adding too much logic to the proxy class.
- **Use Interfaces**: When implementing the Proxy Pattern, use interfaces to define the contract between the proxy and the real subject. This makes the code more flexible and easier to maintain.
- **Handle Exceptions Properly**: In the `invoke` method of a dynamic proxy, make sure to handle exceptions properly. Otherwise, the exceptions can propagate up and cause unexpected behavior.

## Conclusion
The Proxy Pattern is a powerful design pattern that can be used to control access to an object, add additional functionality, or optimize performance. In Java, you can implement the Proxy Pattern using static proxies or dynamic proxies. By understanding the fundamental concepts, usage methods, common practices, and best practices of the Proxy Pattern, you can write more flexible and maintainable code.

## References
- Gamma, E., Helm, R., Johnson, R., & Vlissides, J. (1994). *Design Patterns: Elements of Reusable Object-Oriented Software*. Addison-Wesley.
- Oracle Java Documentation: [java.lang.reflect.Proxy](https://docs.oracle.com/javase/8/docs/api/java/lang/reflect/Proxy.html)
- Oracle Java Documentation: [java.lang.reflect.InvocationHandler](https://docs.oracle.com/javase/8/docs/api/java/lang/reflect/InvocationHandler.html)
---
title: "Real - world Examples of Java Design Patterns"
description: "
Design patterns are reusable solutions to common problems that occur in software design. In Java, design patterns play a crucial role in creating robust, maintainable, and scalable applications. They provide a way to structure code in a more organized manner, making it easier to understand, modify, and extend. This blog will explore real - world examples of some popular Java design patterns, including their fundamental concepts, usage methods, common practices, and best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Singleton Pattern](#singleton-pattern)
2. [Factory Pattern](#factory-pattern)
3. [Observer Pattern](#observer-pattern)
4. [Decorator Pattern](#decorator-pattern)
5. [Conclusion](#conclusion)
6. [References](#references)


## Singleton Pattern

### Fundamental Concept
The Singleton pattern ensures that a class has only one instance and provides a global point of access to it. This is useful when you need to control access to a shared resource, such as a database connection or a configuration manager.

### Usage Method
To implement the Singleton pattern in Java, you typically create a private constructor to prevent external instantiation and a public static method to provide access to the single instance.

### Code Example
```java
public class Singleton {
    private static Singleton instance;

    private Singleton() {
        // Private constructor to prevent external instantiation
    }

    public static Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }
        return instance;
    }
}
```

### Common Practice
In a multi - threaded environment, the above implementation is not thread - safe. A common practice is to use the double - checked locking mechanism or an enum to ensure thread - safety.

```java
public class ThreadSafeSingleton {
    private static volatile ThreadSafeSingleton instance;

    private ThreadSafeSingleton() {
    }

    public static ThreadSafeSingleton getInstance() {
        if (instance == null) {
            synchronized (ThreadSafeSingleton.class) {
                if (instance == null) {
                    instance = new ThreadSafeSingleton();
                }
            }
        }
        return instance;
    }
}
```

### Best Practice
Using an enum is considered the best practice for implementing a Singleton in Java as it provides implicit thread - safety and protection against serialization and reflection attacks.

```java
public enum EnumSingleton {
    INSTANCE;

    public void doSomething() {
        System.out.println("Doing something...");
    }
}
```


## Factory Pattern

### Fundamental Concept
The Factory pattern provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created. It is useful when you need to decouple the object creation logic from the client code.

### Usage Method
You create a factory class that has a method responsible for creating objects based on certain conditions.

### Code Example
```java
// Interface
interface Shape {
    void draw();
}

// Concrete classes
class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a circle");
    }
}

class Square implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a square");
    }
}

// Factory class
class ShapeFactory {
    public Shape getShape(String shapeType) {
        if (shapeType == null) {
            return null;
        }
        if (shapeType.equalsIgnoreCase("CIRCLE")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("SQUARE")) {
            return new Square();
        }
        return null;
    }
}
```

### Common Practice
The factory method can be made static for simplicity, so you don't need to create an instance of the factory class to use it.

```java
class StaticShapeFactory {
    public static Shape getShape(String shapeType) {
        if (shapeType == null) {
            return null;
        }
        if (shapeType.equalsIgnoreCase("CIRCLE")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("SQUARE")) {
            return new Square();
        }
        return null;
    }
}
```

### Best Practice
Use dependency injection to make the factory more flexible. For example, you can pass in a configuration object to the factory method to determine which objects to create.


## Observer Pattern

### Fundamental Concept
The Observer pattern defines a one - to - many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically. It is commonly used in event handling systems.

### Usage Method
You have a subject (the object that changes state) and observers (the objects that are notified of the change). The subject maintains a list of observers and provides methods to register, unregister, and notify them.

### Code Example
```java
import java.util.ArrayList;
import java.util.List;

// Observer interface
interface Observer {
    void update(String message);
}

// Subject interface
interface Subject {
    void registerObserver(Observer observer);
    void unregisterObserver(Observer observer);
    void notifyObservers(String message);
}

// Concrete subject
class MessagePublisher implements Subject {
    private List<Observer> observers = new ArrayList<>();

    @Override
    public void registerObserver(Observer observer) {
        observers.add(observer);
    }

    @Override
    public void unregisterObserver(Observer observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObservers(String message) {
        for (Observer observer : observers) {
            observer.update(message);
        }
    }

    public void createMessage(String message) {
        notifyObservers(message);
    }
}

// Concrete observer
class MessageSubscriber implements Observer {
    private String name;

    public MessageSubscriber(String name) {
        this.name = name;
    }

    @Override
    public void update(String message) {
        System.out.println(name + " received message: " + message);
    }
}
```

### Common Practice
In Java, the `java.util.Observable` class and `java.util.Observer` interface were originally provided for implementing the Observer pattern. However, they have some limitations and are now considered legacy. It is more common to implement the pattern from scratch as shown above.

### Best Practice
Use a thread - safe data structure to store the observers if the pattern is used in a multi - threaded environment. Also, consider using weak references to avoid memory leaks if the observers have a shorter lifespan than the subject.


## Decorator Pattern

### Fundamental Concept
The Decorator pattern allows you to attach additional responsibilities to an object dynamically. It provides a flexible alternative to subclassing for extending functionality.

### Usage Method
You have a base component interface, concrete component classes, and decorator classes that implement the same interface and wrap the base component.

### Code Example
```java
// Component interface
interface Coffee {
    double getCost();
    String getDescription();
}

// Concrete component
class SimpleCoffee implements Coffee {
    @Override
    public double getCost() {
        return 1.0;
    }

    @Override
    public String getDescription() {
        return "Simple coffee";
    }
}

// Decorator abstract class
abstract class CoffeeDecorator implements Coffee {
    protected Coffee coffee;

    public CoffeeDecorator(Coffee coffee) {
        this.coffee = coffee;
    }

    @Override
    public double getCost() {
        return coffee.getCost();
    }

    @Override
    public String getDescription() {
        return coffee.getDescription();
    }
}

// Concrete decorator
class MilkDecorator extends CoffeeDecorator {
    public MilkDecorator(Coffee coffee) {
        super(coffee);
    }

    @Override
    public double getCost() {
        return super.getCost() + 0.5;
    }

    @Override
    public String getDescription() {
        return super.getDescription() + ", with milk";
    }
}
```

### Common Practice
Use composition instead of inheritance to add functionality. This allows you to combine multiple decorators easily.

### Best Practice
Keep the decorator classes as lightweight as possible and focus on adding a single responsibility. This makes the code more maintainable and easier to understand.


## Conclusion
Design patterns are essential tools for Java developers. They help in writing more organized, maintainable, and scalable code. By understanding real - world examples of design patterns such as the Singleton, Factory, Observer, and Decorator patterns, developers can make better design decisions and solve common problems more effectively. Each pattern has its own use cases, and choosing the right pattern for the right situation is crucial for the success of a software project.

## References
- Gamma, E., Helm, R., Johnson, R., & Vlissides, J. (1994). Design Patterns: Elements of Reusable Object - Oriented Software. Addison - Wesley.
- Oracle Java Documentation. https://docs.oracle.com/javase/8/docs/api/
- Baeldung. https://www.baeldung.com/ 
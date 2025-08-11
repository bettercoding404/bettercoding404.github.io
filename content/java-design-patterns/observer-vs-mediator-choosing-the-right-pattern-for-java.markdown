---
title: "Observer vs Mediator: Choosing the Right Pattern for Java"
description: "
In the realm of Java programming, design patterns play a crucial role in creating scalable, maintainable, and efficient software. Two well - known behavioral design patterns are the Observer and the Mediator patterns. While both patterns deal with the interaction between different components of a system, they have distinct use - cases and implementation details. This blog will explore the fundamental concepts, usage methods, common practices, and best practices of these two patterns, enabling Java developers to make informed decisions when choosing the appropriate pattern for their projects.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Fundamental Concepts](#fundamental - concepts)
    - [Observer Pattern](#observer - pattern)
    - [Mediator Pattern](#mediator - pattern)
2. [Usage Methods](#usage - methods)
    - [Implementing the Observer Pattern in Java](#implementing - the - observer - pattern - in - java)
    - [Implementing the Mediator Pattern in Java](#implementing - the - mediator - pattern - in - java)
3. [Common Practices](#common - practices)
    - [When to Use the Observer Pattern](#when - to - use - the - observer - pattern)
    - [When to Use the Mediator Pattern](#when - to - use - the - mediator - pattern)
4. [Best Practices](#best - practices)
    - [Observer Pattern Best Practices](#observer - pattern - best - practices)
    - [Mediator Pattern Best Practices](#mediator - pattern - best - practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Fundamental Concepts

### Observer Pattern
The Observer pattern is a one - to - many dependency relationship between objects. When one object (the subject) changes its state, all its dependents (observers) are notified and updated automatically. This pattern is useful in scenarios where a change in one object's state needs to trigger updates in multiple other objects. For example, in a stock market application, when the price of a stock (the subject) changes, all the interested parties (observers) such as investors and brokers need to be notified.

### Mediator Pattern
The Mediator pattern defines an object that encapsulates how a set of objects interact. It centralizes the communication between objects, reducing the direct dependencies between them. Instead of objects communicating directly with each other, they communicate through the mediator. This pattern is beneficial when there are complex interactions between multiple objects in a system. For instance, in an air traffic control system, airplanes do not communicate directly with each other but through the air traffic controller (the mediator).

## Usage Methods

### Implementing the Observer Pattern in Java
```java
import java.util.ArrayList;
import java.util.List;

// Subject interface
interface Subject {
    void registerObserver(Observer observer);
    void removeObserver(Observer observer);
    void notifyObservers();
}

// Observer interface
interface Observer {
    void update();
}

// Concrete subject
class Stock implements Subject {
    private double price;
    private List<Observer> observers = new ArrayList<>();

    public Stock(double price) {
        this.price = price;
    }

    public void setPrice(double price) {
        this.price = price;
        notifyObservers();
    }

    @Override
    public void registerObserver(Observer observer) {
        observers.add(observer);
    }

    @Override
    public void removeObserver(Observer observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update();
        }
    }
}

// Concrete observer
class Investor implements Observer {
    private Subject stock;

    public Investor(Subject stock) {
        this.stock = stock;
        stock.registerObserver(this);
    }

    @Override
    public void update() {
        System.out.println("Investor: Stock price has changed.");
    }
}


public class ObserverExample {
    public static void main(String[] args) {
        Stock stock = new Stock(100.0);
        Investor investor = new Investor(stock);
        stock.setPrice(105.0);
    }
}
```

### Implementing the Mediator Pattern in Java
```java
// Mediator interface
interface Mediator {
    void sendMessage(String message, Colleague colleague);
}

// Colleague interface
interface Colleague {
    void receiveMessage(String message);
}

// Concrete mediator
class ChatMediator implements Mediator {
    private List<Colleague> colleagues = new ArrayList<>();

    public void addColleague(Colleague colleague) {
        colleagues.add(colleague);
    }

    @Override
    public void sendMessage(String message, Colleague colleague) {
        for (Colleague c : colleagues) {
            if (c != colleague) {
                c.receiveMessage(message);
            }
        }
    }
}

// Concrete colleague
class ChatUser implements Colleague {
    private String name;
    private Mediator mediator;

    public ChatUser(String name, Mediator mediator) {
        this.name = name;
        this.mediator = mediator;
    }

    public void send(String message) {
        System.out.println(name + " sends: " + message);
        mediator.sendMessage(message, this);
    }

    @Override
    public void receiveMessage(String message) {
        System.out.println(name + " receives: " + message);
    }
}


public class MediatorExample {
    public static void main(String[] args) {
        ChatMediator mediator = new ChatMediator();
        ChatUser user1 = new ChatUser("Alice", mediator);
        ChatUser user2 = new ChatUser("Bob", mediator);
        mediator.addColleague(user1);
        mediator.addColleague(user2);

        user1.send("Hello, Bob!");
    }
}
```

## Common Practices

### When to Use the Observer Pattern
- When a change in one object's state needs to be broadcast to multiple other objects without tightly coupling them.
- In event - driven systems where events (state changes) trigger actions in multiple components. For example, GUI applications where a button click (state change) can trigger multiple event handlers.

### When to Use the Mediator Pattern
- When there are complex and many - to - many relationships between objects.
- To reduce the complexity of direct communication between objects and improve the maintainability of the system. For example, in a multi - player game where different game entities need to interact with each other in a coordinated way.

## Best Practices

### Observer Pattern Best Practices
- Keep the subject and observer interfaces simple to ensure loose coupling.
- Avoid circular dependencies between the subject and observers.
- Consider using Java's built - in `Observable` class and `Observer` interface (although they are deprecated in Java 9 onwards) or use a more modern approach like the above custom implementation.

### Mediator Pattern Best Practices
- Make the mediator responsible for complex interactions only. Simple interactions can be handled directly between objects.
- Keep the mediator class as small and focused as possible to avoid becoming a monolithic and hard - to - maintain component.
- Use an interface for the mediator to make the system more flexible and testable.

## Conclusion
Both the Observer and Mediator patterns are valuable tools in a Java developer's toolkit. The Observer pattern is ideal for scenarios where a single object's state change needs to trigger updates in multiple objects, providing a simple and effective way to achieve loose coupling. On the other hand, the Mediator pattern is suitable for managing complex interactions between multiple objects, centralizing communication and reducing direct dependencies. By understanding the fundamental concepts, usage methods, common practices, and best practices of these two patterns, developers can make the right choice for their specific application requirements, leading to more maintainable and scalable Java code.

## References
- Gamma, Erich, et al. *Design Patterns: Elements of Reusable Object - Oriented Software*. Addison - Wesley, 1994.
- Oracle Java Documentation. [https://docs.oracle.com/javase/](https://docs.oracle.com/javase/) 
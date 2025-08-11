---
title: "Mastering the Mediator Pattern in Java"
description: "
In the world of software design patterns, the Mediator Pattern is a behavioral pattern that promotes loose coupling between objects by centralizing their communication. Instead of having objects communicate directly with each other, they interact through a mediator object. This pattern simplifies the relationships between objects and makes the system more maintainable and scalable. In this blog post, we will explore the fundamental concepts of the Mediator Pattern in Java, its usage methods, common practices, and best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Fundamental Concepts](#fundamental-concepts)
2. [Usage Methods](#usage-methods)
3. [Common Practices](#common-practices)
4. [Best Practices](#best-practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Fundamental Concepts
The Mediator Pattern consists of three main components:
- **Mediator**: This is the central object that manages the communication between other objects. It defines an interface for communicating with colleagues.
- **Colleague**: These are the objects that need to communicate with each other. Instead of communicating directly, they send requests to the mediator.
- **Concrete Mediator**: This is the implementation of the mediator interface. It coordinates the communication between colleagues.
- **Concrete Colleague**: These are the implementations of the colleague objects. They interact with the mediator to send and receive messages.

The main idea behind the Mediator Pattern is to reduce the direct dependencies between objects. By using a mediator, the objects can be more independent and easier to maintain.

## Usage Methods

### Step 1: Define the Mediator Interface
```java
// Mediator interface
interface ChatMediator {
    void sendMessage(String message, User user);
    void addUser(User user);
}
```

### Step 2: Define the Colleague Interface
```java
// Colleague interface
interface User {
    void receiveMessage(String message);
    void sendMessage(String message);
}
```

### Step 3: Implement the Concrete Mediator
```java
import java.util.ArrayList;
import java.util.List;

// Concrete Mediator
class ChatMediatorImpl implements ChatMediator {
    private List<User> users;

    public ChatMediatorImpl() {
        this.users = new ArrayList<>();
    }

    @Override
    public void sendMessage(String message, User user) {
        for (User u : users) {
            if (u != user) {
                u.receiveMessage(message);
            }
        }
    }

    @Override
    public void addUser(User user) {
        this.users.add(user);
    }
}
```

### Step 4: Implement the Concrete Colleague
```java
// Concrete Colleague
class UserImpl implements User {
    private String name;
    private ChatMediator mediator;

    public UserImpl(String name, ChatMediator mediator) {
        this.name = name;
        this.mediator = mediator;
    }

    @Override
    public void receiveMessage(String message) {
        System.out.println(name + " received: " + message);
    }

    @Override
    public void sendMessage(String message) {
        System.out.println(name + " sent: " + message);
        mediator.sendMessage(message, this);
    }
}
```

### Step 5: Use the Mediator Pattern
```java
public class MediatorPatternExample {
    public static void main(String[] args) {
        ChatMediator mediator = new ChatMediatorImpl();

        User user1 = new UserImpl("Alice", mediator);
        User user2 = new UserImpl("Bob", mediator);
        User user3 = new UserImpl("Charlie", mediator);

        mediator.addUser(user1);
        mediator.addUser(user2);
        mediator.addUser(user3);

        user1.sendMessage("Hello, everyone!");
    }
}
```

In this example, we have a simple chat application. The `ChatMediator` acts as the mediator, and the `User` objects are the colleagues. When a user sends a message, it is sent to the mediator, and the mediator then distributes the message to all other users.

## Common Practices
- **Centralized Communication**: Use the mediator to centralize all communication between objects. This makes it easier to manage and understand the flow of information in the system.
- **Loose Coupling**: The Mediator Pattern helps to reduce the direct dependencies between objects. Colleagues only need to know about the mediator, not about other colleagues.
- **Event Handling**: The mediator can be used to handle events and notifications. For example, in a GUI application, the mediator can handle button clicks and update the relevant components.

## Best Practices
- **Keep the Mediator Simple**: The mediator should have a single responsibility. Avoid making it too complex by adding too many functions.
- **Use Interfaces**: Define interfaces for the mediator and colleagues. This makes the code more flexible and easier to test.
- **Limit the Number of Colleagues**: If there are too many colleagues, the mediator can become a bottleneck. Consider dividing the system into smaller subsystems with their own mediators.

## Conclusion
The Mediator Pattern is a powerful design pattern that can significantly improve the maintainability and scalability of your Java applications. By centralizing the communication between objects, it reduces the direct dependencies and makes the system more modular. In this blog post, we have explored the fundamental concepts, usage methods, common practices, and best practices of the Mediator Pattern in Java. By following these guidelines, you can effectively use the Mediator Pattern in your projects.

## References
- Gamma, Erich, et al. *Design Patterns: Elements of Reusable Object - Oriented Software*. Addison - Wesley, 1994.
- "Head First Design Patterns" by Eric Freeman, Elisabeth Robson, Bert Bates, Kathy Sierra.
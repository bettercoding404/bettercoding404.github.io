---
title: "A Deep Dive into Behavioral Design Patterns in Java"
description: "
Behavioral design patterns are a crucial part of software development, especially in Java. These patterns focus on the interaction and responsibility sharing between objects, helping developers to create more flexible and maintainable code. By understanding and applying behavioral design patterns, Java programmers can solve common problems related to object communication, algorithms, and responsibility distribution. In this blog, we will explore some of the most important behavioral design patterns in Java, including their fundamental concepts, usage methods, common practices, and best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. Fundamental Concepts
2. Observer Pattern
3. Strategy Pattern
4. Template Method Pattern
5. Command Pattern
6. Iterator Pattern
7. Mediator Pattern
8. Best Practices
9. Conclusion
10. References

## Fundamental Concepts
Behavioral design patterns are concerned with how objects interact and communicate with each other. They address issues such as how to define algorithms, how to distribute responsibilities among objects, and how to manage the flow of control in a system. The main goal of these patterns is to make the code more modular, flexible, and easier to maintain.

### Key Characteristics
- **Object Interaction**: Focus on how objects collaborate to achieve a common goal.
- **Responsibility Distribution**: Allocate responsibilities to different objects in a way that is clear and efficient.
- **Flexibility**: Allow for easy modification and extension of the system's behavior.

## Observer Pattern

### Concept
The Observer pattern defines a one - to - many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.

### Usage Method
In Java, the Observer pattern can be implemented using the `java.util.Observer` and `java.util.Observable` classes (although the `Observable` class has some limitations and is considered deprecated in Java 9 and later). A better approach is to implement the pattern manually.

### Code Example
```java
import java.util.ArrayList;
import java.util.List;

// Observer interface
interface Observer {
    void update(int state);
}

// Subject class
class Subject {
    private int state;
    private List<Observer> observers = new ArrayList<>();

    public void attach(Observer observer) {
        observers.add(observer);
    }

    public void setState(int state) {
        this.state = state;
        notifyAllObservers();
    }

    private void notifyAllObservers() {
        for (Observer observer : observers) {
            observer.update(state);
        }
    }
}

// Concrete observer
class ConcreteObserver implements Observer {
    @Override
    public void update(int state) {
        System.out.println("Observer updated with state: " + state);
    }
}

// Main class to test the pattern
public class ObserverPatternExample {
    public static void main(String[] args) {
        Subject subject = new Subject();
        ConcreteObserver observer = new ConcreteObserver();
        subject.attach(observer);
        subject.setState(10);
    }
}
```

### Common Practice
This pattern is commonly used in event handling systems, where a change in one object (the subject) needs to trigger actions in multiple other objects (the observers).

## Strategy Pattern

### Concept
The Strategy pattern defines a family of algorithms, encapsulates each one, and makes them interchangeable. The pattern lets the algorithm vary independently from the clients that use it.

### Usage Method
In Java, the Strategy pattern can be implemented by creating an interface for the algorithm family and concrete classes that implement this interface.

### Code Example
```java
// Strategy interface
interface Strategy {
    int doOperation(int num1, int num2);
}

// Concrete strategies
class AddStrategy implements Strategy {
    @Override
    public int doOperation(int num1, int num2) {
        return num1 + num2;
    }
}

class SubtractStrategy implements Strategy {
    @Override
    public int doOperation(int num1, int num2) {
        return num1 - num2;
    }
}

// Context class
class Context {
    private Strategy strategy;

    public Context(Strategy strategy) {
        this.strategy = strategy;
    }

    public int executeStrategy(int num1, int num2) {
        return strategy.doOperation(num1, num2);
    }
}

// Main class to test the pattern
public class StrategyPatternExample {
    public static void main(String[] args) {
        Context context = new Context(new AddStrategy());
        System.out.println("10 + 5 = " + context.executeStrategy(10, 5));

        context = new Context(new SubtractStrategy());
        System.out.println("10 - 5 = " + context.executeStrategy(10, 5));
    }
}
```

### Common Practice
This pattern is useful in scenarios where different algorithms can be used to perform a specific task, such as sorting algorithms or encryption algorithms.

## Template Method Pattern

### Concept
The Template Method pattern defines the skeleton of an algorithm in a method, deferring some steps to subclasses. It lets subclasses redefine certain steps of an algorithm without changing the algorithm's structure.

### Usage Method
In Java, the Template Method pattern is implemented by creating an abstract class with a template method and abstract methods that will be implemented by subclasses.

### Code Example
```java
// Abstract class with template method
abstract class Game {
    abstract void initialize();
    abstract void startPlay();
    abstract void endPlay();

    // Template method
    public final void play() {
        initialize();
        startPlay();
        endPlay();
    }
}

// Concrete game classes
class Cricket extends Game {
    @Override
    void initialize() {
        System.out.println("Cricket game initialized.");
    }

    @Override
    void startPlay() {
        System.out.println("Cricket game started.");
    }

    @Override
    void endPlay() {
        System.out.println("Cricket game ended.");
    }
}

class Football extends Game {
    @Override
    void initialize() {
        System.out.println("Football game initialized.");
    }

    @Override
    void startPlay() {
        System.out.println("Football game started.");
    }

    @Override
    void endPlay() {
        System.out.println("Football game ended.");
    }
}

// Main class to test the pattern
public class TemplateMethodPatternExample {
    public static void main(String[] args) {
        Game game = new Cricket();
        game.play();

        game = new Football();
        game.play();
    }
}
```

### Common Practice
This pattern is often used in frameworks where the overall structure of an algorithm is fixed, but the specific implementation details can vary.

## Command Pattern

### Concept
The Command pattern encapsulates a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.

### Usage Method
In Java, the Command pattern can be implemented by creating a command interface and concrete command classes that implement this interface.

### Code Example
```java
// Command interface
interface Command {
    void execute();
}

// Receiver class
class Light {
    public void turnOn() {
        System.out.println("Light is on");
    }

    public void turnOff() {
        System.out.println("Light is off");
    }
}

// Concrete commands
class TurnOnCommand implements Command {
    private Light light;

    public TurnOnCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.turnOn();
    }
}

class TurnOffCommand implements Command {
    private Light light;

    public TurnOffCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.turnOff();
    }
}

// Invoker class
class RemoteControl {
    private Command command;

    public void setCommand(Command command) {
        this.command = command;
    }

    public void pressButton() {
        command.execute();
    }
}

// Main class to test the pattern
public class CommandPatternExample {
    public static void main(String[] args) {
        Light light = new Light();
        TurnOnCommand turnOnCommand = new TurnOnCommand(light);
        TurnOffCommand turnOffCommand = new TurnOffCommand(light);

        RemoteControl remoteControl = new RemoteControl();

        remoteControl.setCommand(turnOnCommand);
        remoteControl.pressButton();

        remoteControl.setCommand(turnOffCommand);
        remoteControl.pressButton();
    }
}
```

### Common Practice
This pattern is useful in scenarios where you need to decouple the sender of a request from the receiver, such as in GUI applications or multi - threaded systems.

## Iterator Pattern

### Concept
The Iterator pattern provides a way to access the elements of an aggregate object sequentially without exposing its underlying representation.

### Usage Method
In Java, the Iterator pattern is already built - in with the `java.util.Iterator` interface. You can implement your own iterators by creating classes that implement this interface.

### Code Example
```java
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

// Aggregate class
class MyCollection {
    private List<String> items = new ArrayList<>();

    public void addItem(String item) {
        items.add(item);
    }

    public Iterator<String> createIterator() {
        return items.iterator();
    }
}

// Main class to test the pattern
public class IteratorPatternExample {
    public static void main(String[] args) {
        MyCollection collection = new MyCollection();
        collection.addItem("Item 1");
        collection.addItem("Item 2");
        collection.addItem("Item 3");

        Iterator<String> iterator = collection.createIterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }
    }
}
```

### Common Practice
This pattern is used when you need to traverse the elements of a collection in a uniform way, regardless of the collection's internal structure.

## Mediator Pattern

### Concept
The Mediator pattern defines an object that encapsulates how a set of objects interact. It promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you vary their interaction independently.

### Usage Method
In Java, the Mediator pattern can be implemented by creating a mediator interface and concrete mediator classes that implement this interface.

### Code Example
```java
// Mediator interface
interface ChatMediator {
    void sendMessage(String message, User user);
    void addUser(User user);
}

// Concrete mediator
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

// Colleague interface
interface User {
    void sendMessage(String message);
    void receiveMessage(String message);
}

// Concrete colleague
class ChatUser implements User {
    private ChatMediator mediator;
    private String name;

    public ChatUser(ChatMediator mediator, String name) {
        this.mediator = mediator;
        this.name = name;
    }

    @Override
    public void sendMessage(String message) {
        System.out.println(this.name + " sends message: " + message);
        mediator.sendMessage(message, this);
    }

    @Override
    public void receiveMessage(String message) {
        System.out.println(this.name + " receives message: " + message);
    }
}

// Main class to test the pattern
public class MediatorPatternExample {
    public static void main(String[] args) {
        ChatMediator mediator = new ChatMediatorImpl();
        User user1 = new ChatUser(mediator, "User1");
        User user2 = new ChatUser(mediator, "User2");
        User user3 = new ChatUser(mediator, "User3");

        mediator.addUser(user1);
        mediator.addUser(user2);
        mediator.addUser(user3);

        user1.sendMessage("Hello, everyone!");
    }
}
```

### Common Practice
This pattern is useful in scenarios where there are complex interactions between multiple objects, such as in a chat application or a GUI form.

## Best Practices
- **Understand the Problem**: Before applying a behavioral design pattern, make sure you fully understand the problem you are trying to solve. Choose the pattern that best fits the requirements.
- **Keep it Simple**: Don't over - engineer your code by using unnecessary patterns. Only use patterns when they add real value to the system.
- **Follow Coding Standards**: Adhere to Java coding standards and naming conventions when implementing the patterns.
- **Test Thoroughly**: Write unit tests to ensure that the patterns are working correctly and that any changes to the code do not break the existing functionality.

## Conclusion
Behavioral design patterns in Java provide powerful tools for solving common problems related to object interaction and responsibility sharing. By understanding and applying these patterns, developers can create more flexible, modular, and maintainable code. Each pattern has its own unique characteristics and use cases, and choosing the right pattern for a given situation is crucial. The best practices discussed in this blog can help you make the most of these patterns and avoid common pitfalls.

## References
- Gamma, E., Helm, R., Johnson, R., & Vlissides, J. (1994). *Design Patterns: Elements of Reusable Object - Oriented Software*. Addison - Wesley Professional.
- Oracle Java Documentation: https://docs.oracle.com/javase/8/docs/api/ 
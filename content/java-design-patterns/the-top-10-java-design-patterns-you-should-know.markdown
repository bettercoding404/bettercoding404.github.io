---
title: "The Top 10 Java Design Patterns You Should Know"
description: "
Design patterns are reusable solutions to commonly occurring problems in software design. In Java, design patterns play a crucial role in creating maintainable, scalable, and efficient code. They provide a standardized way of approaching design problems, allowing developers to communicate more effectively and build better software systems. This blog will introduce you to the top 10 Java design patterns that every Java developer should know.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Singleton Pattern](#singleton-pattern)
2. [Factory Pattern](#factory-pattern)
3. [Abstract Factory Pattern](#abstract-factory-pattern)
4. [Builder Pattern](#builder-pattern)
5. [Prototype Pattern](#prototype-pattern)
6. [Adapter Pattern](#adapter-pattern)
7. [Bridge Pattern](#bridge-pattern)
8. [Composite Pattern](#composite-pattern)
9. [Decorator Pattern](#decorator-pattern)
10. [Facade Pattern](#facade-pattern)

## 1. Singleton Pattern
### Fundamental Concept
The Singleton pattern ensures that a class has only one instance and provides a global point of access to it. This is useful when you need to control access to a shared resource, such as a database connection or a configuration manager.

### Usage Method
The basic idea is to make the constructor private and provide a static method to get the single instance.

### Code Example
```java
public class Singleton {
    private static Singleton instance;

    private Singleton() {}

    public static Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }
        return instance;
    }
}
```

### Common Practice
In a multi - threaded environment, the above implementation is not thread - safe. A better approach is to use the double - checked locking mechanism or an enum.

```java
public class ThreadSafeSingleton {
    private static volatile ThreadSafeSingleton instance;

    private ThreadSafeSingleton() {}

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
Use an enum for the Singleton pattern as it is inherently thread - safe and provides protection against serialization and reflection attacks.
```java
public enum EnumSingleton {
    INSTANCE;

    public void doSomething() {
        System.out.println("Doing something...");
    }
}
```

## 2. Factory Pattern
### Fundamental Concept
The Factory pattern provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created. It encapsulates the object creation logic.

### Usage Method
Create a factory class with a method that returns objects of different types based on some input.

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

class Rectangle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a rectangle");
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
        } else if (shapeType.equalsIgnoreCase("RECTANGLE")) {
            return new Rectangle();
        }
        return null;
    }
}
```

### Common Practice
Use the factory pattern when you need to create objects based on some conditions or when the object creation process is complex.

### Best Practice
Separate the factory logic into a separate class to keep the main application code clean and focused on business logic.

## 3. Abstract Factory Pattern
### Fundamental Concept
The Abstract Factory pattern provides an interface for creating families of related or dependent objects without specifying their concrete classes. It is an extension of the Factory pattern.

### Usage Method
Create an abstract factory interface and concrete factory classes that implement this interface.

### Code Example
```java
// Abstract products
interface Color {
    void fill();
}

interface Shape {
    void draw();
}

// Concrete products
class Red implements Color {
    @Override
    public void fill() {
        System.out.println("Filling with red color");
    }
}

class Green implements Color {
    @Override
    public void fill() {
        System.out.println("Filling with green color");
    }
}

class Circle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a circle");
    }
}

class Rectangle implements Shape {
    @Override
    public void draw() {
        System.out.println("Drawing a rectangle");
    }
}

// Abstract factory
interface AbstractFactory {
    Color getColor(String color);
    Shape getShape(String shape);
}

// Concrete factory
class ShapeFactory implements AbstractFactory {
    @Override
    public Color getColor(String color) {
        return null;
    }

    @Override
    public Shape getShape(String shapeType) {
        if (shapeType == null) {
            return null;
        }
        if (shapeType.equalsIgnoreCase("CIRCLE")) {
            return new Circle();
        } else if (shapeType.equalsIgnoreCase("RECTANGLE")) {
            return new Rectangle();
        }
        return null;
    }
}

class ColorFactory implements AbstractFactory {
    @Override
    public Color getColor(String color) {
        if (color == null) {
            return null;
        }
        if (color.equalsIgnoreCase("RED")) {
            return new Red();
        } else if (color.equalsIgnoreCase("GREEN")) {
            return new Green();
        }
        return null;
    }

    @Override
    public Shape getShape(String shape) {
        return null;
    }
}

// Factory producer
class FactoryProducer {
    public static AbstractFactory getFactory(String choice) {
        if (choice.equalsIgnoreCase("SHAPE")) {
            return new ShapeFactory();
        } else if (choice.equalsIgnoreCase("COLOR")) {
            return new ColorFactory();
        }
        return null;
    }
}
```

### Common Practice
Use the Abstract Factory pattern when you need to create multiple related objects at once or when the object creation process is complex and involves multiple steps.

### Best Practice
Keep the factory classes small and focused on a single family of objects.

## 4. Builder Pattern
### Fundamental Concept
The Builder pattern separates the construction of a complex object from its representation so that the same construction process can create different representations.

### Usage Method
Create a builder class that has methods to set the different attributes of the complex object and a build method to create the object.

### Code Example
```java
// Complex object
class Computer {
    private String CPU;
    private String RAM;
    private String storage;

    private Computer(ComputerBuilder builder) {
        this.CPU = builder.CPU;
        this.RAM = builder.RAM;
        this.storage = builder.storage;
    }

    public static class ComputerBuilder {
        private String CPU;
        private String RAM;
        private String storage;

        public ComputerBuilder setCPU(String CPU) {
            this.CPU = CPU;
            return this;
        }

        public ComputerBuilder setRAM(String RAM) {
            this.RAM = RAM;
            return this;
        }

        public ComputerBuilder setStorage(String storage) {
            this.storage = storage;
            return this;
        }

        public Computer build() {
            return new Computer(this);
        }
    }

    @Override
    public String toString() {
        return "Computer [CPU=" + CPU + ", RAM=" + RAM + ", storage=" + storage + "]";
    }
}
```

### Common Practice
Use the Builder pattern when you have a complex object with many optional parameters or when the object creation process involves multiple steps.

### Best Practice
Use method chaining in the builder class to make the code more readable.

## 5. Prototype Pattern
### Fundamental Concept
The Prototype pattern allows you to create new objects by copying an existing object, known as the prototype, instead of creating new objects from scratch.

### Usage Method
Implement the `Cloneable` interface and override the `clone()` method.

### Code Example
```java
// Prototype interface
interface Prototype extends Cloneable {
    Prototype clone();
}

// Concrete prototype
class Employee implements Prototype {
    private String name;
    private int id;

    public Employee(String name, int id) {
        this.name = name;
        this.id = id;
    }

    @Override
    public Prototype clone() {
        try {
            return (Prototype) super.clone();
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public String toString() {
        return "Employee [name=" + name + ", id=" + id + "]";
    }
}
```

### Common Practice
Use the Prototype pattern when creating a new object is expensive in terms of time or resources, such as when initializing a large object graph.

### Best Practice
Make sure to handle the `CloneNotSupportedException` properly and consider using deep cloning if the object contains references to other objects.

## 6. Adapter Pattern
### Fundamental Concept
The Adapter pattern allows objects with incompatible interfaces to collaborate. It acts as a bridge between two incompatible interfaces.

### Usage Method
Create an adapter class that implements the target interface and wraps the adaptee object.

### Code Example
```java
// Target interface
interface MediaPlayer {
    void play(String audioType, String fileName);
}

// Adaptee interface
interface AdvancedMediaPlayer {
    void playVlc(String fileName);
    void playMp4(String fileName);
}

// Concrete adaptee
class VlcPlayer implements AdvancedMediaPlayer {
    @Override
    public void playVlc(String fileName) {
        System.out.println("Playing VLC file: " + fileName);
    }

    @Override
    public void playMp4(String fileName) {
        // Do nothing
    }
}

class Mp4Player implements AdvancedMediaPlayer {
    @Override
    public void playVlc(String fileName) {
        // Do nothing
    }

    @Override
    public void playMp4(String fileName) {
        System.out.println("Playing MP4 file: " + fileName);
    }
}

// Adapter class
class MediaAdapter implements MediaPlayer {
    private AdvancedMediaPlayer advancedMediaPlayer;

    public MediaAdapter(String audioType) {
        if (audioType.equalsIgnoreCase("VLC")) {
            advancedMediaPlayer = new VlcPlayer();
        } else if (audioType.equalsIgnoreCase("MP4")) {
            advancedMediaPlayer = new Mp4Player();
        }
    }

    @Override
    public void play(String audioType, String fileName) {
        if (audioType.equalsIgnoreCase("VLC")) {
            advancedMediaPlayer.playVlc(fileName);
        } else if (audioType.equalsIgnoreCase("MP4")) {
            advancedMediaPlayer.playMp4(fileName);
        }
    }
}

// Client class
class AudioPlayer implements MediaPlayer {
    private MediaAdapter mediaAdapter;

    @Override
    public void play(String audioType, String fileName) {
        if (audioType.equalsIgnoreCase("MP3")) {
            System.out.println("Playing MP3 file: " + fileName);
        } else if (audioType.equalsIgnoreCase("VLC") || audioType.equalsIgnoreCase("MP4")) {
            mediaAdapter = new MediaAdapter(audioType);
            mediaAdapter.play(audioType, fileName);
        } else {
            System.out.println("Invalid media type: " + audioType);
        }
    }
}
```

### Common Practice
Use the Adapter pattern when you need to use an existing class but its interface does not match the one you need.

### Best Practice
Keep the adapter class simple and focused on the conversion of the interfaces.

## 7. Bridge Pattern
### Fundamental Concept
The Bridge pattern decouples an abstraction from its implementation so that the two can vary independently.

### Usage Method
Create an abstraction class and an implementation interface. The abstraction class holds a reference to the implementation interface.

### Code Example
```java
// Implementation interface
interface Color {
    void applyColor();
}

// Concrete implementations
class RedColor implements Color {
    @Override
    public void applyColor() {
        System.out.println("Applying red color");
    }
}

class GreenColor implements Color {
    @Override
    public void applyColor() {
        System.out.println("Applying green color");
    }
}

// Abstraction class
abstract class Shape {
    protected Color color;

    protected Shape(Color color) {
        this.color = color;
    }

    abstract void draw();
}

// Refined abstraction
class Circle extends Shape {
    public Circle(Color color) {
        super(color);
    }

    @Override
    void draw() {
        System.out.print("Drawing a circle. ");
        color.applyColor();
    }
}

class Rectangle extends Shape {
    public Rectangle(Color color) {
        super(color);
    }

    @Override
    void draw() {
        System.out.print("Drawing a rectangle. ");
        color.applyColor();
    }
}
```

### Common Practice
Use the Bridge pattern when you have a hierarchy of classes that can vary in multiple dimensions.

### Best Practice
Keep the implementation classes small and focused on a single aspect of the functionality.

## 8. Composite Pattern
### Fundamental Concept
The Composite pattern allows you to compose objects into tree structures to represent part - whole hierarchies. It lets clients treat individual objects and compositions of objects uniformly.

### Usage Method
Create a component interface that is implemented by both leaf and composite classes. The composite class contains a list of components.

### Code Example
```java
// Component interface
interface Employee {
    void showDetails();
}

// Leaf class
class Developer implements Employee {
    private String name;

    public Developer(String name) {
        this.name = name;
    }

    @Override
    public void showDetails() {
        System.out.println("Developer: " + name);
    }
}

// Composite class
class Manager implements Employee {
    private String name;
    private java.util.List<Employee> employees = new java.util.ArrayList<>();

    public Manager(String name) {
        this.name = name;
    }

    public void addEmployee(Employee employee) {
        employees.add(employee);
    }

    @Override
    public void showDetails() {
        System.out.println("Manager: " + name);
        for (Employee employee : employees) {
            employee.showDetails();
        }
    }
}
```

### Common Practice
Use the Composite pattern when you need to represent a part - whole hierarchy, such as a file system or an organization chart.

### Best Practice
Provide methods in the composite class to add and remove components to manage the tree structure effectively.

## 9. Decorator Pattern
### Fundamental Concept
The Decorator pattern attaches additional responsibilities to an object dynamically. It provides a flexible alternative to subclassing for extending functionality.

### Usage Method
Create a component interface, a concrete component class, and a decorator abstract class that implements the component interface and holds a reference to the component.

### Code Example
```java
// Component interface
interface Beverage {
    String getDescription();
    double cost();
}

// Concrete component
class Espresso implements Beverage {
    @Override
    public String getDescription() {
        return "Espresso";
    }

    @Override
    public double cost() {
        return 1.99;
    }
}

// Decorator abstract class
abstract class CondimentDecorator implements Beverage {
    protected Beverage beverage;

    public CondimentDecorator(Beverage beverage) {
        this.beverage = beverage;
    }

    @Override
    public abstract String getDescription();
}

// Concrete decorator
class Mocha extends CondimentDecorator {
    public Mocha(Beverage beverage) {
        super(beverage);
    }

    @Override
    public String getDescription() {
        return beverage.getDescription() + ", Mocha";
    }

    @Override
    public double cost() {
        return beverage.cost() + 0.20;
    }
}
```

### Common Practice
Use the Decorator pattern when you need to add functionality to an object at runtime without affecting other objects of the same class.

### Best Practice
Keep the decorator classes small and focused on a single aspect of the additional functionality.

## 10. Facade Pattern
### Fundamental Concept
The Facade pattern provides a simplified interface to a complex system. It hides the complexity of the system and provides a single interface for the client to interact with.

### Usage Method
Create a facade class that provides a simple interface to the complex subsystem.

### Code Example
```java
// Subsystem classes
class CPU {
    public void start() {
        System.out.println("CPU started");
    }

    public void shutdown() {
        System.out.println("CPU shut down");
    }
}

class Memory {
    public void load() {
        System.out.println("Memory loaded");
    }

    public void unload() {
        System.out.println("Memory unloaded");
    }
}

class HardDrive {
    public void read() {
        System.out.println("Hard drive read");
    }

    public void write() {
        System.out.println("Hard drive written");
    }
}

// Facade class
class ComputerFacade {
    private CPU cpu;
    private Memory memory;
    private HardDrive hardDrive;

    public ComputerFacade() {
        this.cpu = new CPU();
        this.memory = new Memory();

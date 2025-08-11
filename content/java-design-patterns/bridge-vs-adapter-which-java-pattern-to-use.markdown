---
title: "Bridge vs Adapter: Which Java Pattern to Use?"
description: "
In the world of Java programming, design patterns play a crucial role in creating robust, maintainable, and scalable software. Two such patterns, the Bridge pattern and the Adapter pattern, are often used to solve different but related problems. Understanding the differences between these patterns and knowing when to use each one is essential for any Java developer. This blog post will explore the fundamental concepts of the Bridge and Adapter patterns, their usage methods, common practices, and best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Fundamental Concepts](#fundamental-concepts)
    - [Bridge Pattern](#bridge-pattern)
    - [Adapter Pattern](#adapter-pattern)
2. [Usage Methods](#usage-methods)
    - [Bridge Pattern Usage](#bridge-pattern-usage)
    - [Adapter Pattern Usage](#adapter-pattern-usage)
3. [Common Practices](#common-practices)
    - [Bridge Pattern Common Practices](#bridge-pattern-common-practices)
    - [Adapter Pattern Common Practices](#adapter-pattern-common-practices)
4. [Best Practices](#best-practices)
    - [When to Use Bridge Pattern](#when-to-use-bridge-pattern)
    - [When to Use Adapter Pattern](#when-to-use-adapter-pattern)
5. [Conclusion](#conclusion)
6. [References](#references)

## Fundamental Concepts

### Bridge Pattern
The Bridge pattern is a structural design pattern that decouples an abstraction from its implementation so that the two can vary independently. It involves creating two separate hierarchies: one for the abstraction and one for the implementation. The abstraction contains a reference to the implementation, allowing it to delegate some of its responsibilities to the implementation object.

### Adapter Pattern
The Adapter pattern is also a structural design pattern that allows objects with incompatible interfaces to collaborate. It acts as a bridge between two incompatible interfaces, converting the interface of one class into another interface that clients expect. The Adapter pattern lets classes work together that couldn't otherwise because of incompatible interfaces.

## Usage Methods

### Bridge Pattern Usage
Here is a simple Java code example to illustrate the Bridge pattern:

```java
// Implementor interface
interface Color {
    void applyColor();
}

// Concrete Implementor
class RedColor implements Color {
    @Override
    public void applyColor() {
        System.out.println("Applying red color");
    }
}

// Concrete Implementor
class BlueColor implements Color {
    @Override
    public void applyColor() {
        System.out.println("Applying blue color");
    }
}

// Abstraction
abstract class Shape {
    protected Color color;

    public Shape(Color color) {
        this.color = color;
    }

    abstract void draw();
}

// Refined Abstraction
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

// Refined Abstraction
class Square extends Shape {
    public Square(Color color) {
        super(color);
    }

    @Override
    void draw() {
        System.out.print("Drawing a square. ");
        color.applyColor();
    }
}

// Client code
public class BridgePatternExample {
    public static void main(String[] args) {
        Shape redCircle = new Circle(new RedColor());
        redCircle.draw();

        Shape blueSquare = new Square(new BlueColor());
        blueSquare.draw();
    }
}
```

In this example, the `Color` interface is the implementor, and the `RedColor` and `BlueColor` classes are concrete implementors. The `Shape` abstract class is the abstraction, and the `Circle` and `Square` classes are refined abstractions. The `Shape` class contains a reference to the `Color` object, allowing it to delegate the color application responsibility to the `Color` object.

### Adapter Pattern Usage
Here is a Java code example to illustrate the Adapter pattern:

```java
// Target interface
interface MediaPlayer {
    void play(String audioType, String fileName);
}

// Adaptee
class AdvancedMediaPlayer {
    public void playVlc(String fileName) {
        System.out.println("Playing vlc file. Name: " + fileName);
    }

    public void playMp4(String fileName) {
        System.out.println("Playing mp4 file. Name: " + fileName);
    }
}

// Adapter
class MediaAdapter implements MediaPlayer {
    private AdvancedMediaPlayer advancedMediaPlayer;

    public MediaAdapter(String audioType) {
        if (audioType.equalsIgnoreCase("vlc")) {
            advancedMediaPlayer = new AdvancedMediaPlayer();
        }
    }

    @Override
    public void play(String audioType, String fileName) {
        if (audioType.equalsIgnoreCase("vlc")) {
            advancedMediaPlayer.playVlc(fileName);
        }
    }
}

// Concrete Target
class AudioPlayer implements MediaPlayer {
    private MediaAdapter mediaAdapter;

    @Override
    public void play(String audioType, String fileName) {
        if (audioType.equalsIgnoreCase("mp3")) {
            System.out.println("Playing mp3 file. Name: " + fileName);
        } else if (audioType.equalsIgnoreCase("vlc")) {
            mediaAdapter = new MediaAdapter(audioType);
            mediaAdapter.play(audioType, fileName);
        } else {
            System.out.println("Invalid media type");
        }
    }
}

// Client code
public class AdapterPatternExample {
    public static void main(String[] args) {
        AudioPlayer audioPlayer = new AudioPlayer();
        audioPlayer.play("mp3", "song.mp3");
        audioPlayer.play("vlc", "video.vlc");
    }
}
```

In this example, the `MediaPlayer` interface is the target, the `AdvancedMediaPlayer` class is the adaptee, and the `MediaAdapter` class is the adapter. The `AudioPlayer` class uses the `MediaAdapter` to play VLC files, which it couldn't do directly because of the incompatible interfaces.

## Common Practices

### Bridge Pattern Common Practices
- **Separate Variations**: Use the Bridge pattern when you have two or more independent dimensions of variation in your system. For example, in the above shape and color example, the shape and color can vary independently.
- **Avoid Tight Coupling**: By separating the abstraction and implementation, the Bridge pattern helps to avoid tight coupling between different parts of the system, making the code more flexible and maintainable.

### Adapter Pattern Common Practices
- **Integrate Legacy Code**: The Adapter pattern is commonly used when integrating legacy code with new systems. It allows the new system to use the legacy code without modifying the legacy code's interface.
- **Third - Party Library Integration**: When using third - party libraries that have interfaces incompatible with your code, the Adapter pattern can be used to make the library work with your code.

## Best Practices

### When to Use Bridge Pattern
- **Multiple Hierarchies**: Use the Bridge pattern when you have multiple hierarchies that need to vary independently. For example, if you are developing a GUI library, you might have a hierarchy for different types of widgets (buttons, text fields, etc.) and a hierarchy for different rendering engines (OpenGL, DirectX, etc.).
- **Runtime Binding**: When you want to be able to change the implementation at runtime, the Bridge pattern is a good choice.

### When to Use Adapter Pattern
- **Interface Mismatch**: Use the Adapter pattern when you need to make an existing class work with another class whose interface it doesn't match.
- **Reuse Existing Classes**: When you want to reuse an existing class but its interface doesn't match the one you need, the Adapter pattern can be used to adapt the existing class to your needs.

## Conclusion
In summary, the Bridge pattern and the Adapter pattern are both important structural design patterns in Java. The Bridge pattern is used to decouple an abstraction from its implementation, allowing them to vary independently. On the other hand, the Adapter pattern is used to make incompatible interfaces work together. By understanding the fundamental concepts, usage methods, common practices, and best practices of these patterns, Java developers can make informed decisions about which pattern to use in different scenarios, leading to more robust and maintainable code.

## References
- Gamma, Erich, et al. *Design Patterns: Elements of Reusable Object - Oriented Software*. Addison - Wesley, 1994.
- GeeksforGeeks. "Bridge Design Pattern". [https://www.geeksforgeeks.org/bridge-design-pattern/](https://www.geeksforgeeks.org/bridge-design-pattern/)
- GeeksforGeeks. "Adapter Design Pattern". [https://www.geeksforgeeks.org/adapter-pattern/](https://www.geeksforgeeks.org/adapter-pattern/)
---
title: "Implementing the Template Method Pattern in Java"
description: "
In the world of software design patterns, the Template Method Pattern is a powerful and widely - used behavioral pattern. It provides a way to define the skeleton of an algorithm in a superclass and allow subclasses to provide specific implementations of certain steps of the algorithm. This pattern promotes code reuse and makes the code more maintainable by separating the general algorithm structure from its specific details. In Java, the Template Method Pattern is a great tool for developers to organize and structure their code effectively.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. Fundamental Concepts
2. Usage Methods
3. Common Practices
4. Best Practices
5. Code Examples
6. Conclusion
7. References

## Fundamental Concepts
The Template Method Pattern consists of two main components:

### Abstract Class
This is the core of the pattern. It contains the template method, which defines the overall structure of the algorithm. The template method calls a series of primitive operations, some of which are abstract and need to be implemented by subclasses. The abstract class may also have some concrete methods that provide default implementations for certain steps of the algorithm.

### Concrete Subclasses
These classes inherit from the abstract class and provide implementations for the abstract methods defined in the abstract class. They can also override the concrete methods in the abstract class if needed, but the overall flow of the algorithm is determined by the template method in the abstract class.

## Usage Methods
1. **Define the Abstract Class**: Start by creating an abstract class that contains the template method. The template method should call a sequence of methods, some of which can be abstract.
2. **Create Concrete Subclasses**: Subclass the abstract class and implement the abstract methods. These implementations will provide the specific details for the steps of the algorithm.
3. **Invoke the Template Method**: Create an instance of the concrete subclass and call the template method. The template method will then execute the algorithm with the specific implementations provided by the subclass.

## Common Practices
### Separation of Concerns
The Template Method Pattern helps in separating the general algorithm structure from its specific details. The abstract class holds the overall algorithm, while the subclasses handle the implementation of specific steps. This makes the code more modular and easier to understand and maintain.

### Code Reuse
By defining the common parts of the algorithm in the abstract class, we can reuse this code across multiple subclasses. This reduces code duplication and makes the codebase more efficient.

### Hook Methods
Hook methods are optional methods in the abstract class that subclasses can override. They provide a way to customize the behavior of the algorithm at certain points without changing the overall structure.

## Best Practices
### Keep the Template Method Simple
The template method should focus on defining the overall structure of the algorithm. It should not contain too many implementation details. This makes the code more readable and easier to modify.

### Use Final for the Template Method
Marking the template method as `final` prevents subclasses from overriding it. This ensures that the overall algorithm structure remains intact and is not accidentally modified.

### Provide Clear Documentation
Since the Template Method Pattern involves inheritance and abstract methods, it is important to provide clear documentation for both the abstract class and its subclasses. This helps other developers understand the purpose and usage of the pattern.

## Code Examples

### Abstract Class
```java
// Abstract class defining the template method
abstract class BeverageMaker {
    // Template method
    public final void prepareBeverage() {
        boilWater();
        brew();
        pourInCup();
        if (customerWantsCondiments()) {
            addCondiments();
        }
    }

    // Concrete method with default implementation
    private void boilWater() {
        System.out.println("Boiling water");
    }

    // Abstract method to be implemented by subclasses
    abstract void brew();

    // Concrete method with default implementation
    private void pourInCup() {
        System.out.println("Pouring into cup");
    }

    // Hook method
    boolean customerWantsCondiments() {
        return true;
    }

    // Abstract method to be implemented by subclasses
    abstract void addCondiments();
}
```

### Concrete Subclasses
```java
// Concrete subclass for making coffee
class CoffeeMaker extends BeverageMaker {
    @Override
    void brew() {
        System.out.println("Brewing coffee grounds");
    }

    @Override
    void addCondiments() {
        System.out.println("Adding sugar and milk");
    }

    @Override
    boolean customerWantsCondiments() {
        // Custom implementation for coffee
        return false;
    }
}

// Concrete subclass for making tea
class TeaMaker extends BeverageMaker {
    @Override
    void brew() {
        System.out.println("Steeping tea bag");
    }

    @Override
    void addCondiments() {
        System.out.println("Adding lemon");
    }
}
```

### Main Class to Test
```java
public class Main {
    public static void main(String[] args) {
        BeverageMaker coffeeMaker = new CoffeeMaker();
        coffeeMaker.prepareBeverage();

        System.out.println();

        BeverageMaker teaMaker = new TeaMaker();
        teaMaker.prepareBeverage();
    }
}
```

In this example, the `BeverageMaker` class is the abstract class that defines the template method `prepareBeverage()`. The `CoffeeMaker` and `TeaMaker` classes are concrete subclasses that provide specific implementations for the `brew()` and `addCondiments()` methods. The `customerWantsCondiments()` method is a hook method that allows subclasses to customize the behavior of the algorithm.

## Conclusion
The Template Method Pattern is a valuable design pattern in Java that offers several benefits such as code reuse, separation of concerns, and modularity. By following the best practices and using hook methods effectively, developers can create more maintainable and flexible code. Understanding and implementing this pattern can significantly improve the quality of Java applications.

## References
- Gamma, Erich, et al. *Design Patterns: Elements of Reusable Object - Oriented Software*. Addison - Wesley, 1994.
- Oracle Java Documentation: https://docs.oracle.com/javase/tutorial/index.html 
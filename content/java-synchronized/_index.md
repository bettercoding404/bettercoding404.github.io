---
layout: post
date: 2024-12-08
title: 深入理解 Java 中的 Synchronized 关键字
description: 本文将介绍 Java 中的 synchronized 关键字，以及如何使用它来确保线程安全。
tags: [Java]
cascade:
  - type: docs
---


在 Java 编程中，`synchronized` 关键字是实现线程同步的基础工具之一。在多线程编程环境中，多个线程可能试图同时访问某个共享资源，如果不加控制，就会导致数据不一致的问题。`synchronized` 提供了一种简便的方法来确保在同一时间，只有一个线程能够访问这些资源，从而避免并发问题。

### 什么是 Synchronized？

`synchronized` 是一种用于控制线程访问共享资源的锁机制。它可以应用于方法或代码块，确保在同一时刻，只有一个线程可以执行同步代码块。`synchronized` 保证了：

1. **互斥性**：在同一时刻，只有一个线程可以执行某个 synchronized 代码块。
2. **可见性**：一个线程在 lock/release 锁的情况下，变量的变化对于其他线程是可见的。

### Synchronized 的用法

`synchronized` 有两种主要用法：同步方法和同步块。

#### 1. 同步方法

同步方法是最简单的使用 `synchronized` 的方式。它通过 synchronized 关键字来锁定整个方法，使得每次只有一个线程可以执行该方法。

```java
public class SynchronizedExample {
    private int count = 0;

    public synchronized void incrementCount() {
        count++;
    }

    public int getCount() {
        return count;
    }
}
```

在以上代码中，`incrementCount` 方法是同步的。若多个线程尝试同时调用此方法，只有一个线程可以执行，其他线程会被阻塞，等待执行权。

#### 2. 同步块

同步块是另一种使用 `synchronized` 的方式，该方式允许你对代码中的某个特定部分进行同步，而不是整个方法。同步块提供了更灵活的控制，可以提高效率，尤其是在只需要同步某部分代码时。

```java
public class SynchronizedExample {
    private int count = 0;
    private final Object lock = new Object();

    public void incrementCount() {
        synchronized (lock) {
            count++;
        }
    }

    public int getCount() {
        return count;
    }
}
```

在这个示例中，`incrementCount` 方法中只有 `count++` 这一行代码是受到同步保护的，而不是整个方法。

### 对象锁 vs 类锁

在 Java 中，synchronized 可以针对不同的锁对象进行锁定：

- **对象锁**：通常用于实例方法或对象的特定部分，对应于“this”或某个特定对象锁。
- **类锁**：用于静态方法或类的一个特定部分，会锁定整个类，由 Class 类的对象作为锁。

```java
public class SynchronizedExample {
    private static int staticCount = 0;

    // 使用类锁，同步静态方法
    public static synchronized void incrementStaticCount() {
        staticCount++;
    }

    // 使用对象锁，同步实例方法
    public synchronized void incrementInstanceCount() {
        // some code
    }
}
```

### Synchronized 的限制

尽管 `synchronized` 可以有效地防止并发问题，但它也有一些限制：

1. **性能问题**：由于 synchronized 会导致线程进入阻塞状态，因此也会带来性能开销。
2. **死锁风险**：不当的锁管理可能导致死锁的问题，当两个线程相互等待对方释放锁时，会产生死锁。
3. **不灵活性**：相比于 Lock 接口，synchronized 提供的功能较少，如超时锁定、可中断锁请求等。

### 总结

`synchronized` 关键字是 Java 中多线程编程的重要工具之一，它通过提供简单的线程同步机制，帮助开发者保护共享资源免受线程干扰。然而，使用 `synchronized` 需要谨慎，以避免不必要的性能损失或死锁情况。在实际应用中，合理选择并发工具至关重要，如有需要，也可以考虑使用更高级的并发工具如 `java.util.concurrent` 包中的 ReentrantLock 和其他同步机制。
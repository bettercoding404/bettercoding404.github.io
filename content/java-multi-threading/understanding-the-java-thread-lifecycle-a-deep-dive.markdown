---
title: "Understanding the Java Thread Lifecycle: A Deep Dive"
description: "
In the world of Java programming, multithreading is a powerful concept that allows programs to perform multiple tasks concurrently. At the heart of multithreading lies the Java thread, and understanding its lifecycle is crucial for writing efficient and robust concurrent applications. This blog post will take a deep dive into the Java thread lifecycle, exploring its fundamental concepts, usage methods, common practices, and best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Fundamental Concepts of Java Thread Lifecycle](#fundamental-concepts-of-java-thread-lifecycle)
2. [Usage Methods](#usage-methods)
3. [Common Practices](#common-practices)
4. [Best Practices](#best-practices)
5. [Conclusion](#conclusion)
6. [References](#references)

## Fundamental Concepts of Java Thread Lifecycle
A Java thread goes through several states during its lifetime. The following are the main states in the Java thread lifecycle:

### 1. New
When a new `Thread` object is created using the `new` keyword, the thread is in the `New` state. At this point, the thread has been instantiated but has not yet started its execution.

```java
public class NewStateExample {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            System.out.println("Thread is running.");
        });
        // The thread is in the New state here
        System.out.println("Thread state: " + thread.getState());
    }
}
```

### 2. Runnable
Once the `start()` method is called on a `Thread` object, the thread moves to the `Runnable` state. A thread in the `Runnable` state is either running or ready to run. The Java Virtual Machine (JVM) decides when to actually execute the thread based on the system's scheduling algorithm.

```java
public class RunnableStateExample {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            System.out.println("Thread is running.");
        });
        thread.start();
        // The thread is in the Runnable state here
        System.out.println("Thread state: " + thread.getState());
    }
}
```

### 3. Blocked
A thread enters the `Blocked` state when it is trying to acquire a monitor lock (for example, when using `synchronized` blocks) and the lock is currently held by another thread. The thread will remain in the `Blocked` state until it can acquire the lock.

```java
public class BlockedStateExample {
    public static final Object lock = new Object();

    public static void main(String[] args) {
        Thread thread1 = new Thread(() -> {
            synchronized (lock) {
                try {
                    Thread.sleep(5000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });

        Thread thread2 = new Thread(() -> {
            synchronized (lock) {
                System.out.println("Thread 2 acquired the lock.");
            }
        });

        thread1.start();
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        thread2.start();
        // Thread 2 is likely to be in the Blocked state here
        System.out.println("Thread 2 state: " + thread2.getState());
    }
}
```

### 4. Waiting
A thread enters the `Waiting` state when it calls certain methods such as `Object.wait()`, `Thread.join()`, or `LockSupport.park()`. The thread will remain in the `Waiting` state until another thread notifies it (using `Object.notify()` or `Object.notifyAll()`) or the condition for which it is waiting is satisfied.

```java
public class WaitingStateExample {
    public static final Object lock = new Object();

    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            synchronized (lock) {
                try {
                    lock.wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });

        thread.start();
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // The thread is in the Waiting state here
        System.out.println("Thread state: " + thread.getState());
    }
}
```

### 5. Timed Waiting
A thread enters the `Timed Waiting` state when it calls methods like `Thread.sleep(long millis)`, `Object.wait(long timeout)`, `Thread.join(long millis)`, or `LockSupport.parkNanos(long nanos)` or `LockSupport.parkUntil(long deadline)`. The thread will remain in this state for a specified period of time and then resume execution.

```java
public class TimedWaitingStateExample {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        thread.start();
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // The thread is in the Timed Waiting state here
        System.out.println("Thread state: " + thread.getState());
    }
}
```

### 6. Terminated
A thread enters the `Terminated` state when its `run()` method completes its execution or when an uncaught exception is thrown in the `run()` method. Once a thread is in the `Terminated` state, it cannot be restarted.

```java
public class TerminatedStateExample {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            System.out.println("Thread is running.");
        });

        thread.start();
        try {
            thread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // The thread is in the Terminated state here
        System.out.println("Thread state: " + thread.getState());
    }
}
```

## Usage Methods
### Creating a Thread
There are two main ways to create a thread in Java:

#### 1. Extending the `Thread` class
```java
class MyThread extends Thread {
    @Override
    public void run() {
        System.out.println("MyThread is running.");
    }
}

public class ThreadCreationExtendExample {
    public static void main(String[] args) {
        MyThread thread = new MyThread();
        thread.start();
    }
}
```

#### 2. Implementing the `Runnable` interface
```java
class MyRunnable implements Runnable {
    @Override
    public void run() {
        System.out.println("MyRunnable is running.");
    }
}

public class ThreadCreationRunnableExample {
    public static void main(String[] args) {
        MyRunnable runnable = new MyRunnable();
        Thread thread = new Thread(runnable);
        thread.start();
    }
}
```

### Starting and Stopping a Thread
To start a thread, call the `start()` method. Once a thread is started, it cannot be started again. To stop a thread gracefully, you can use a boolean flag to control the execution of the `run()` method.

```java
class ControlledThread implements Runnable {
    private volatile boolean running = true;

    @Override
    public void run() {
        while (running) {
            System.out.println("Thread is running.");
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println("Thread stopped.");
    }

    public void stop() {
        running = false;
    }
}

public class StartStopThreadExample {
    public static void main(String[] args) {
        ControlledThread controlledThread = new ControlledThread();
        Thread thread = new Thread(controlledThread);
        thread.start();

        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        controlledThread.stop();
    }
}
```

## Common Practices
### Synchronization
When multiple threads access shared resources, synchronization is necessary to prevent race conditions. You can use `synchronized` blocks or methods to ensure that only one thread can access the shared resource at a time.

```java
class Counter {
    private int count = 0;

    public synchronized void increment() {
        count++;
    }

    public synchronized int getCount() {
        return count;
    }
}

public class SynchronizationExample {
    public static void main(String[] args) throws InterruptedException {
        Counter counter = new Counter();

        Thread thread1 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });

        Thread thread2 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });

        thread1.start();
        thread2.start();

        thread1.join();
        thread2.join();

        System.out.println("Final count: " + counter.getCount());
    }
}
```

### Thread Pooling
Creating and destroying threads can be expensive. Thread pooling allows you to reuse a fixed number of threads to execute multiple tasks. Java provides the `ExecutorService` interface and its implementations for thread pooling.

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ThreadPoolExample {
    public static void main(String[] args) {
        ExecutorService executorService = Executors.newFixedThreadPool(2);

        executorService.submit(() -> {
            System.out.println("Task 1 is running.");
        });

        executorService.submit(() -> {
            System.out.println("Task 2 is running.");
        });

        executorService.shutdown();
    }
}
```

## Best Practices
### Use `volatile` for Shared Variables
When multiple threads access a shared variable, use the `volatile` keyword to ensure that changes made by one thread are immediately visible to other threads.

```java
class SharedVariable {
    private volatile boolean flag = false;

    public void setFlag() {
        flag = true;
    }

    public boolean getFlag() {
        return flag;
    }
}

public class VolatileExample {
    public static void main(String[] args) {
        SharedVariable sharedVariable = new SharedVariable();

        Thread writerThread = new Thread(() -> {
            sharedVariable.setFlag();
        });

        Thread readerThread = new Thread(() -> {
            while (!sharedVariable.getFlag()) {
                // Wait for the flag to be set
            }
            System.out.println("Flag is set.");
        });

        readerThread.start();
        writerThread.start();
    }
}
```

### Avoid Using `Thread.stop()`
The `Thread.stop()` method is deprecated because it can leave the shared resources in an inconsistent state. Instead, use a boolean flag to control the execution of the thread.

### Handle Exceptions Properly
When a thread throws an uncaught exception, it can cause the thread to terminate abruptly. Always handle exceptions properly in the `run()` method to ensure the stability of the application.

```java
public class ExceptionHandlingExample {
    public static void main(String[] args) {
        Thread thread = new Thread(() -> {
            try {
                int result = 1 / 0;
            } catch (ArithmeticException e) {
                System.out.println("Caught exception: " + e.getMessage());
            }
        });

        thread.start();
    }
}
```

## Conclusion
Understanding the Java thread lifecycle is essential for writing efficient and robust concurrent applications. By mastering the different states of a thread and the usage methods, common practices, and best practices, you can avoid common pitfalls such as race conditions and deadlocks. Remember to use synchronization, thread pooling, and proper exception handling to ensure the stability and performance of your multithreaded applications.

## References
- Oracle Java Documentation: https://docs.oracle.com/javase/8/docs/api/java/lang/Thread.html
- "Effective Java" by Joshua Bloch
- "Java Concurrency in Practice" by Brian Goetz et al.
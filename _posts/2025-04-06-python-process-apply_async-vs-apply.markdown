---
title: "Python Process: apply_async vs apply"
description: "在 Python 的多进程编程中，`multiprocessing` 模块为我们提供了强大的工具来利用多核处理器的优势。其中，`apply_async` 和 `apply` 是 `multiprocessing.Pool` 类中两个用于在进程池中执行函数的方法。理解这两个方法的区别以及何时使用它们，对于编写高效、稳定的多进程代码至关重要。本文将深入探讨这两个方法的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 的多进程编程中，`multiprocessing` 模块为我们提供了强大的工具来利用多核处理器的优势。其中，`apply_async` 和 `apply` 是 `multiprocessing.Pool` 类中两个用于在进程池中执行函数的方法。理解这两个方法的区别以及何时使用它们，对于编写高效、稳定的多进程代码至关重要。本文将深入探讨这两个方法的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **apply_async**
    - **apply**
3. **常见实践**
    - **使用 apply_async 实现异步任务**
    - **使用 apply 实现同步任务**
4. **最佳实践**
    - **何时选择 apply_async**
    - **何时选择 apply**
5. **小结**
6. **参考资料**

## 基础概念
### `apply_async`
`apply_async` 方法是异步调用的。这意味着当你调用这个方法时，主进程不会等待被调用的函数执行完毕，而是继续执行后续的代码。被调用的函数会在进程池中异步执行，并且可以通过返回的 `AsyncResult` 对象来获取函数的执行结果。这种异步特性使得在处理多个任务时，主进程可以在任务执行的同时进行其他操作，提高了整体的执行效率。

### `apply`
`apply` 方法是同步调用的。当你调用这个方法时，主进程会阻塞，直到被调用的函数执行完毕并返回结果。这意味着在函数执行期间，主进程无法执行其他代码。虽然这种同步方式在某些情况下可能会降低整体的执行效率，但它在需要确保任务按顺序执行或者需要立即获取任务结果的场景下非常有用。

## 使用方法
### `apply_async`
```python
import multiprocessing


def square(x):
    return x * x


if __name__ == '__main__':
    pool = multiprocessing.Pool(processes=4)
    result = pool.apply_async(square, (5,))
    pool.close()
    pool.join()
    print(result.get())
```
在这个示例中：
1. 我们定义了一个简单的函数 `square`，用于计算一个数的平方。
2. 创建了一个包含 4 个进程的进程池 `pool`。
3. 使用 `apply_async` 方法将 `square` 函数应用到参数 `(5,)` 上，并返回一个 `AsyncResult` 对象 `result`。
4. 调用 `pool.close()` 方法关闭进程池，不再接受新的任务。
5. 调用 `pool.join()` 方法等待所有任务完成。
6. 最后通过 `result.get()` 获取函数的执行结果并打印。

### `apply`
```python
import multiprocessing


def square(x):
    return x * x


if __name__ == '__main__':
    pool = multiprocessing.Pool(processes=4)
    result = pool.apply(square, (5,))
    pool.close()
    pool.join()
    print(result)
```
这个示例与 `apply_async` 的示例类似，只是使用了 `apply` 方法。在调用 `apply` 方法时，主进程会阻塞，直到 `square` 函数执行完毕并返回结果，所以不需要通过 `AsyncResult` 对象来获取结果。

## 常见实践
### 使用 `apply_async` 实现异步任务
```python
import multiprocessing


def task(num):
    import time
    time.sleep(1)
    return num * num


if __name__ == '__main__':
    numbers = [1, 2, 3, 4, 5]
    pool = multiprocessing.Pool(processes=3)
    results = []
    for num in numbers:
        result = pool.apply_async(task, (num,))
        results.append(result)
    pool.close()
    pool.join()
    for res in results:
        print(res.get())
```
在这个示例中，我们定义了一个 `task` 函数，它会睡眠 1 秒来模拟一个耗时任务。我们创建了一个包含 3 个进程的进程池，并将 `task` 函数异步应用到 `numbers` 列表中的每个元素上。主进程在提交所有任务后，通过 `pool.close()` 和 `pool.join()` 等待所有任务完成，最后获取并打印每个任务的结果。

### 使用 `apply` 实现同步任务
```python
import multiprocessing


def task(num):
    import time
    time.sleep(1)
    return num * num


if __name__ == '__main__':
    numbers = [1, 2, 3, 4, 5]
    pool = multiprocessing.Pool(processes=3)
    results = []
    for num in numbers:
        result = pool.apply(task, (num,))
        results.append(result)
    pool.close()
    pool.join()
    for res in results:
        print(res)
```
这个示例与上一个类似，只是使用了 `apply` 方法。由于 `apply` 是同步调用，主进程会在每个任务执行完毕后才继续执行下一个任务，所以不需要通过 `AsyncResult` 对象来获取结果。

## 最佳实践
### 何时选择 `apply_async`
- **当任务耗时较长且相互独立时**：如果你的任务需要花费大量时间来执行，并且这些任务之间没有依赖关系，使用 `apply_async` 可以让主进程在任务执行的同时继续执行其他操作，提高整体的执行效率。例如，进行大量的数据计算或者网络请求操作。
- **需要提高并发性能时**：通过异步调用，可以同时提交多个任务到进程池中，充分利用多核处理器的优势，提高系统的并发处理能力。

### 何时选择 `apply`
- **当任务执行时间较短且需要按顺序获取结果时**：如果每个任务的执行时间很短，并且你需要确保任务按顺序执行并立即获取结果，`apply` 方法是一个不错的选择。例如，对一系列数据进行简单的验证操作。
- **当需要确保任务执行顺序时**：由于 `apply` 是同步调用，主进程会阻塞直到当前任务完成，所以可以保证任务按照调用的顺序依次执行。

## 小结
在 Python 的多进程编程中，`apply_async` 和 `apply` 是两个重要的方法，它们各自适用于不同的场景。`apply_async` 适用于需要异步执行任务以提高并发性能和整体效率的情况，而 `apply` 则适用于需要同步执行任务并确保任务顺序和立即获取结果的场景。通过合理选择这两个方法，可以编写出高效、稳定的多进程代码。

## 参考资料
- [Python 官方文档 - multiprocessing](https://docs.python.org/3/library/multiprocessing.html){: rel="nofollow"}
- [Real Python - Multiprocessing in Python](https://realpython.com/python-multiprocessing/){: rel="nofollow"}
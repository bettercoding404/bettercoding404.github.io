---
title: "Python 中的优先队列（PriorityQueue）：深入解析与实践"
description: "在编程中，我们经常会遇到需要按照某种优先级来处理元素的场景。优先队列（PriorityQueue）就是为解决这类问题而设计的数据结构。在 Python 中，`PriorityQueue` 模块提供了实现优先队列的工具。它允许我们根据元素的优先级对其进行排序并处理，优先级高的元素先出队。这在许多领域，如任务调度、图算法（如 Dijkstra 算法）等方面都有广泛应用。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在编程中，我们经常会遇到需要按照某种优先级来处理元素的场景。优先队列（PriorityQueue）就是为解决这类问题而设计的数据结构。在 Python 中，`PriorityQueue` 模块提供了实现优先队列的工具。它允许我们根据元素的优先级对其进行排序并处理，优先级高的元素先出队。这在许多领域，如任务调度、图算法（如 Dijkstra 算法）等方面都有广泛应用。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 创建优先队列
    - 添加元素
    - 移除并获取元素
    - 获取队列大小
3. 常见实践
    - 简单任务调度
    - 实现 Dijkstra 算法中的优先队列
4. 最佳实践
    - 自定义优先级规则
    - 高效内存管理
    - 多线程安全使用
5. 小结
6. 参考资料

## 基础概念
优先队列是一种特殊的队列，与普通队列“先进先出（FIFO）”的原则不同，优先队列按照元素的优先级进行出队操作。优先级高的元素先出队，优先级相同的元素按照入队顺序出队。在 Python 中，`PriorityQueue` 模块基于堆数据结构实现，堆是一种完全二叉树，它的每个父节点的值都小于或等于其子节点的值（最小堆）。这使得获取优先级最高（最小堆中值最小）的元素操作的时间复杂度为 $O(1)$，而插入和删除操作的时间复杂度为 $O(\log n)$，其中 $n$ 是队列中的元素个数。

## 使用方法

### 创建优先队列
要使用 `PriorityQueue`，首先需要导入 `queue` 模块（Python 3 中）。然后可以通过实例化 `PriorityQueue` 类来创建一个优先队列对象。

```python
import queue

# 创建一个优先队列
pq = queue.PriorityQueue()
```

### 添加元素
使用 `put()` 方法向优先队列中添加元素。`put()` 方法接受一个元素作为参数，该元素可以是任何可比较的对象。在最小堆中，较小的值具有较高的优先级。

```python
# 向优先队列中添加元素
pq.put(3)
pq.put(1)
pq.put(2)
```

### 移除并获取元素
使用 `get()` 方法从优先队列中移除并返回优先级最高的元素。

```python
# 从优先队列中获取元素
print(pq.get())  # 输出 1
print(pq.get())  # 输出 2
print(pq.get())  # 输出 3
```

### 获取队列大小
可以使用 `qsize()` 方法获取优先队列中当前元素的个数。

```python
# 获取队列大小
print(pq.qsize())  # 输出 0
```

## 常见实践

### 简单任务调度
假设我们有一系列任务，每个任务都有一个优先级。可以使用优先队列来调度这些任务，使得优先级高的任务先执行。

```python
import queue


def task_scheduler():
    task_queue = queue.PriorityQueue()
    # 添加任务，任务格式为 (优先级, 任务描述)
    task_queue.put((2, "任务 B"))
    task_queue.put((1, "任务 A"))
    task_queue.put((3, "任务 C"))

    while not task_queue.empty():
        priority, task = task_queue.get()
        print(f"执行任务: {task}，优先级: {priority}")


if __name__ == "__main__":
    task_scheduler()
```

### 实现 Dijkstra 算法中的优先队列
Dijkstra 算法用于在加权有向图中找到从一个源节点到其他所有节点的最短路径。优先队列在该算法中用于存储节点及其到源节点的距离，距离小的节点优先被处理。

```python
import queue


def dijkstra(graph, start):
    distances = {node: float('inf') for node in graph}
    distances[start] = 0
    pq = queue.PriorityQueue()
    pq.put((0, start))

    while not pq.empty():
        current_distance, current_node = pq.get()

        if current_distance > distances[current_node]:
            continue

        for neighbor, weight in graph[current_node].items():
            distance = current_distance + weight

            if distance < distances[neighbor]:
                distances[neighbor] = distance
                pq.put((distance, neighbor))

    return distances


# 示例图
graph = {
    'A': {'B': 1, 'C': 4},
    'B': {'A': 1, 'C': 2, 'D': 5},
    'C': {'A': 4, 'B': 2, 'D': 1},
    'D': {'B': 5, 'C': 1}
}

start_node = 'A'
print(dijkstra(graph, start_node))
```

## 最佳实践

### 自定义优先级规则
默认情况下，`PriorityQueue` 使用元素的自然顺序作为优先级。但在实际应用中，我们可能需要自定义优先级规则。可以通过将元素包装成元组的方式来实现，元组的第一个元素作为优先级。

```python
import queue


class Task:
    def __init__(self, priority, description):
        self.priority = priority
        self.description = description

    def __lt__(self, other):
        return self.priority < other.priority


task_queue = queue.PriorityQueue()
task1 = Task(2, "任务 B")
task2 = Task(1, "任务 A")
task3 = Task(3, "任务 C")

task_queue.put(task1)
task_queue.put(task2)
task_queue.put(task3)

while not task_queue.empty():
    task = task_queue.get()
    print(f"执行任务: {task.description}，优先级: {task.priority}")
```

### 高效内存管理
在处理大量数据时，优先队列可能会占用大量内存。可以定期清理不再需要的元素，或者使用生成器来动态生成元素，而不是一次性将所有元素放入队列中。

```python
import queue


def generate_elements():
    for i in range(10):
        yield i


pq = queue.PriorityQueue()
for element in generate_elements():
    pq.put(element)
    if pq.qsize() > 5:
        pq.get()  # 清理元素

while not pq.empty():
    print(pq.get())
```

### 多线程安全使用
`PriorityQueue` 是线程安全的，在多线程环境中可以直接使用。但在高并发场景下，需要注意性能问题。可以考虑使用 `threading.Lock` 来进一步控制对队列的访问。

```python
import queue
import threading


def worker(pq):
    while True:
        item = pq.get()
        if item is None:
            break
        print(f"处理任务: {item}")
        pq.task_done()


pq = queue.PriorityQueue()
threads = []
num_threads = 3

for _ in range(num_threads):
    t = threading.Thread(target=worker, args=(pq,))
    t.start()
    threads.append(t)

for task in range(10):
    pq.put(task)

for _ in range(num_threads):
    pq.put(None)

for t in threads:
    t.join()
```

## 小结
优先队列（`PriorityQueue`）在 Python 中是一个强大的数据结构，它为我们处理需要按照优先级排序的元素提供了便利。通过本文，我们了解了优先队列的基础概念、使用方法、常见实践以及最佳实践。在实际应用中，我们可以根据具体需求灵活运用优先队列，提高程序的效率和可读性。

## 参考资料
- 《Python 数据结构与算法分析》
- 《Effective Python》

希望这篇博客能帮助你更好地理解和使用 Python 中的优先队列。如果你有任何问题或建议，欢迎在评论区留言。
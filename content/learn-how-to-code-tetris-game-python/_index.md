---
title: "用 Python 编写俄罗斯方块游戏：从入门到实践"
description: "在这篇技术博客中，我们将深入探讨如何使用 Python 编写俄罗斯方块游戏。俄罗斯方块作为一款经典的街机游戏，具有简单而又极具吸引力的玩法。通过编写这个游戏，你不仅能提升 Python 编程技能，还能深入理解游戏开发中的各种概念，如图形界面设计、游戏逻辑实现等。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在这篇技术博客中，我们将深入探讨如何使用 Python 编写俄罗斯方块游戏。俄罗斯方块作为一款经典的街机游戏，具有简单而又极具吸引力的玩法。通过编写这个游戏，你不仅能提升 Python 编程技能，还能深入理解游戏开发中的各种概念，如图形界面设计、游戏逻辑实现等。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 环境搭建
    - 基本模块介绍
3. 常见实践
    - 方块的表示与生成
    - 游戏界面绘制
    - 方块的移动与旋转
    - 碰撞检测
4. 最佳实践
    - 代码优化
    - 用户交互设计
    - 游戏性能提升
5. 代码示例
6. 小结
7. 参考资料

## 基础概念
### 俄罗斯方块游戏机制
俄罗斯方块由不同形状的方块（Tetromino）组成，这些方块从游戏界面顶部掉落，玩家可以控制方块的左右移动和旋转，使其在底部堆叠形成完整的一行或多行，消除这些行可以得分并使上方的方块下落填补空间。

### Python 相关概念
在编写俄罗斯方块游戏时，我们主要会用到以下 Python 概念：
- **数据结构**：如列表（List）用于存储方块的形状和位置信息。
- **面向对象编程（OOP）**：通过定义类来管理游戏中的不同元素，如方块类、游戏界面类等，提高代码的可维护性和可扩展性。
- **图形库**：常用的有 Pygame，它提供了丰富的功能来创建图形界面、处理用户输入、播放音效等。

## 使用方法
### 环境搭建
首先，确保你已经安装了 Python。如果没有，可以从[Python 官方网站](https://www.python.org/downloads/)下载并安装。

接下来，安装 Pygame 库。在命令行中输入以下命令：
```bash
pip install pygame
```

### 基本模块介绍
- **Pygame**：是我们编写俄罗斯方块游戏的核心库。它包含多个模块，如 `pygame.display` 用于创建和管理游戏窗口，`pygame.event` 用于处理用户输入事件（如按键按下），`pygame.time` 用于控制游戏的帧率等。

## 常见实践
### 方块的表示与生成
我们可以用二维列表来表示每个方块的形状。例如，经典的 “I” 型方块可以表示为：
```python
I_BLOCK = [
    [0, 1, 0, 0],
    [0, 1, 0, 0],
    [0, 1, 0, 0],
    [0, 1, 0, 0]
]
```
生成方块时，可以随机选择一种形状并在游戏界面顶部的初始位置创建。

### 游戏界面绘制
使用 Pygame 的 `display` 模块创建一个窗口，并设置其大小和标题。然后，使用 `draw` 方法绘制方块、游戏边框、得分显示等元素。
```python
import pygame

pygame.init()

WIDTH, HEIGHT = 800, 600
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Tetris")

while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            quit()

    screen.fill((0, 0, 0))  # 填充背景色
    # 绘制其他元素
    pygame.display.flip()
```

### 方块的移动与旋转
通过监听用户的按键事件（如左右箭头键控制左右移动，上箭头键控制旋转）来改变方块的位置和形状。在代码中，可以定义相应的函数来处理这些操作。
```python
def move_left(block):
    # 实现方块向左移动的逻辑
    pass

def move_right(block):
    # 实现方块向右移动的逻辑
    pass

def rotate(block):
    # 实现方块旋转的逻辑
    pass
```

### 碰撞检测
检测方块是否与游戏界面底部、左右边框或其他已放置的方块发生碰撞。如果发生碰撞，方块应停止移动并进行相应处理（如检查是否有可消除的行）。
```python
def check_collision(block, board):
    # 检查碰撞逻辑
    pass
```

## 最佳实践
### 代码优化
- 使用函数和类来组织代码，避免代码冗余。例如，将绘制方块、处理碰撞等功能封装到相应的函数或类方法中。
- 减少不必要的计算。比如，在碰撞检测时，可以只检查方块周围可能发生碰撞的区域，而不是整个方块。

### 用户交互设计
- 提供清晰的游戏提示和反馈，如得分显示、下一个方块预览等。
- 处理用户输入时，确保响应灵敏，避免出现延迟。

### 游戏性能提升
- 控制游戏的帧率，使用 `pygame.time.Clock` 来确保游戏在不同性能的设备上运行流畅。
```python
clock = pygame.time.Clock()
while True:
    clock.tick(30)  # 控制帧率为 30 帧每秒
    # 游戏主循环代码
```

## 代码示例
以下是一个简化的俄罗斯方块游戏示例代码：
```python
import pygame
import random

# 初始化 Pygame
pygame.init()

# 游戏窗口尺寸
WIDTH, HEIGHT = 800, 600
GRID_SIZE = 30
GRID_WIDTH = WIDTH // GRID_SIZE
GRID_HEIGHT = HEIGHT // GRID_SIZE

# 颜色定义
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
CYAN = (0, 255, 255)

# 方块形状
SHAPES = [
    [[1, 1, 1, 1]],
    [[1, 1], [1, 1]],
    [[1, 1, 0], [0, 1, 1]],
    [[0, 1, 1], [1, 1, 0]],
    [[1, 1, 1], [0, 1, 0]],
    [[1, 1, 1], [1, 0, 0]],
    [[1, 1, 1], [0, 0, 1]]
]

# 创建游戏窗口
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Tetris")

def draw_grid():
    for x in range(0, WIDTH, GRID_SIZE):
        pygame.draw.line(screen, WHITE, (x, 0), (x, HEIGHT))
    for y in range(0, HEIGHT, GRID_SIZE):
        pygame.draw.line(screen, WHITE, (0, y), (WIDTH, y))

def draw_block(block, x, y, color):
    for i in range(len(block)):
        for j in range(len(block[i])):
            if block[i][j]:
                pygame.draw.rect(screen, color, (x + j * GRID_SIZE, y + i * GRID_SIZE, GRID_SIZE, GRID_SIZE))

def new_block():
    shape = random.choice(SHAPES)
    return shape

def main():
    running = True
    current_block = new_block()
    block_x = GRID_WIDTH // 2 - len(current_block[0]) // 2
    block_y = 0

    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        keys = pygame.key.get_pressed()
        if keys[pygame.K_LEFT]:
            block_x -= 1
        elif keys[pygame.K_RIGHT]:
            block_x += 1
        elif keys[pygame.K_DOWN]:
            block_y += 1

        screen.fill(BLACK)
        draw_grid()
        draw_block(current_block, block_x * GRID_SIZE, block_y * GRID_SIZE, CYAN)
        pygame.display.flip()

    pygame.quit()

if __name__ == "__main__":
    main()
```

## 小结
通过本文，我们学习了使用 Python 编写俄罗斯方块游戏的基础概念、使用方法、常见实践以及最佳实践。从环境搭建到游戏各个功能的实现，我们逐步构建了一个简单的俄罗斯方块游戏。希望这些内容能帮助你更好地理解 Python 编程和游戏开发，你可以根据自己的需求进一步完善和扩展这个游戏。

## 参考资料
- [Pygame 官方文档](https://www.pygame.org/docs/)
- 《Python 游戏开发实战》
- 各类在线编程教程和论坛，如 Stack Overflow、CSDN 等。
---
title: "Python Scatter 绘图：从基础到最佳实践"
description: "在数据可视化的领域中，散点图（Scatter Plot）是一种强大且常用的工具，它可以展示两个变量之间的关系。Python 作为数据科学和可视化的首选编程语言，提供了多种绘制散点图的方法。本文将深入探讨 Python 中 `scatter` 相关的概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握并灵活运用这一可视化技巧。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在数据可视化的领域中，散点图（Scatter Plot）是一种强大且常用的工具，它可以展示两个变量之间的关系。Python 作为数据科学和可视化的首选编程语言，提供了多种绘制散点图的方法。本文将深入探讨 Python 中 `scatter` 相关的概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握并灵活运用这一可视化技巧。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 Matplotlib 绘制散点图
    - 使用 Seaborn 绘制散点图
3. 常见实践
    - 简单散点图绘制
    - 带颜色和大小区分的散点图
    - 多组数据散点图
4. 最佳实践
    - 数据预处理
    - 合理设置坐标轴和标题
    - 颜色映射选择
    - 添加图例
5. 小结
6. 参考资料

## 基础概念
散点图是一种以直角坐标系中，用点的分布来展示两个变量之间关系的图表。其中一个变量在 x 轴上表示，另一个变量在 y 轴上表示。每个点的位置由这两个变量的值决定。通过观察散点的分布，可以发现变量之间是否存在某种趋势（如线性、非线性）、是否有异常值等。

## 使用方法
### 使用 Matplotlib 绘制散点图
Matplotlib 是 Python 中最常用的绘图库之一，提供了 `scatter` 函数用于绘制散点图。

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成一些示例数据
x = np.random.rand(50)
y = np.random.rand(50)

# 绘制散点图
plt.scatter(x, y)

# 添加标题和标签
plt.title('Simple Scatter Plot')
plt.xlabel('X-axis')
plt.ylabel('Y-axis')

# 显示图形
plt.show()
```

### 使用 Seaborn 绘制散点图
Seaborn 是基于 Matplotlib 的高级绘图库，提供了更美观、更丰富的绘图样式。

```python
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

# 生成示例数据
data = pd.DataFrame({
    'x': np.random.rand(50),
    'y': np.random.rand(50)
})

# 绘制散点图
sns.scatterplot(x='x', y='y', data=data)

# 添加标题
plt.title('Seaborn Scatter Plot')

# 显示图形
plt.show()
```

## 常见实践
### 简单散点图绘制
上述代码已经展示了简单散点图的绘制方法，通过 `scatter` 函数传入 x 和 y 坐标数据即可。

### 带颜色和大小区分的散点图
可以通过指定颜色和大小参数，为散点图添加更多信息。

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成示例数据
x = np.random.rand(50)
y = np.random.rand(50)
colors = np.random.rand(50)
sizes = 100 * np.random.rand(50)

# 绘制带颜色和大小区分的散点图
plt.scatter(x, y, c=colors, s=sizes)

# 添加颜色条
plt.colorbar()

# 添加标题和标签
plt.title('Scatter Plot with Color and Size')
plt.xlabel('X-axis')
plt.ylabel('Y-axis')

# 显示图形
plt.show()
```

### 多组数据散点图
当需要在同一图表中展示多组数据时，可以多次调用 `scatter` 函数。

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成示例数据
x1 = np.random.rand(30)
y1 = np.random.rand(30)
x2 = np.random.rand(30)
y2 = np.random.rand(30)

# 绘制第一组数据
plt.scatter(x1, y1, label='Group 1')

# 绘制第二组数据
plt.scatter(x2, y2, label='Group 2')

# 添加标题和标签
plt.title('Multiple Scatter Plots')
plt.xlabel('X-axis')
plt.ylabel('Y-axis')

# 添加图例
plt.legend()

# 显示图形
plt.show()
```

## 最佳实践
### 数据预处理
在绘制散点图之前，需要对数据进行预处理，确保数据的准确性和一致性。例如，处理缺失值、异常值等。

```python
import pandas as pd

# 读取数据
data = pd.read_csv('data.csv')

# 处理缺失值
data = data.dropna()

# 处理异常值
data = data[(data['x'] > data['x'].quantile(0.01)) & (data['x'] < data['x'].quantile(0.99))]
data = data[(data['y'] > data['y'].quantile(0.01)) & (data['y'] < data['y'].quantile(0.99))]
```

### 合理设置坐标轴和标题
清晰的坐标轴标签和标题可以帮助读者更好地理解图表内容。

```python
import matplotlib.pyplot as plt

# 绘制散点图
plt.scatter(x, y)

# 设置坐标轴范围
plt.xlim(0, 1)
plt.ylim(0, 1)

# 添加标题和标签
plt.title('Customized Scatter Plot')
plt.xlabel('Custom X-axis')
plt.ylabel('Custom Y-axis')

# 显示图形
plt.show()
```

### 颜色映射选择
选择合适的颜色映射可以增强图表的可读性。例如，对于表示数值大小的颜色，可以使用 `viridis` 等颜色映射。

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成示例数据
x = np.random.rand(50)
y = np.random.rand(50)
values = np.random.rand(50)

# 绘制带颜色映射的散点图
plt.scatter(x, y, c=values, cmap='viridis')

# 添加颜色条
plt.colorbar()

# 添加标题和标签
plt.title('Scatter Plot with Viridis Colormap')
plt.xlabel('X-axis')
plt.ylabel('Y-axis')

# 显示图形
plt.show()
```

### 添加图例
当图表中有多组数据或不同属性的点时，添加图例可以帮助读者区分。

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成示例数据
x1 = np.random.rand(30)
y1 = np.random.rand(30)
x2 = np.random.rand(30)
y2 = np.random.rand(30)

# 绘制第一组数据
plt.scatter(x1, y1, label='Group 1')

# 绘制第二组数据
plt.scatter(x2, y2, label='Group 2')

# 添加标题和标签
plt.title('Scatter Plot with Legend')
plt.xlabel('X-axis')
plt.ylabel('Y-axis')

# 添加图例
plt.legend()

# 显示图形
plt.show()
```

## 小结
通过本文的介绍，我们了解了 Python 中 `scatter` 散点图的基础概念、使用方法、常见实践以及最佳实践。掌握这些知识，读者可以根据自己的数据特点和需求，灵活运用散点图进行数据可视化，从而更好地理解数据和发现数据中的规律。

## 参考资料
- 《Python 数据可视化实战》
 
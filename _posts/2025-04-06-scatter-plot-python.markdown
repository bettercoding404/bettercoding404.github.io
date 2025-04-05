---
title: "Python 散点图（Scatter Plot）：从基础到实践"
description: "在数据可视化领域，散点图是一种强大且常用的工具。它通过在二维平面上绘制点来展示两个变量之间的关系，能让我们直观地观察到数据点的分布模式、相关性等信息。Python 作为数据科学和可视化的主流编程语言，提供了多种绘制散点图的方法和库。本文将深入探讨如何使用 Python 创建和定制散点图，帮助读者掌握这一重要的数据可视化技巧。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在数据可视化领域，散点图是一种强大且常用的工具。它通过在二维平面上绘制点来展示两个变量之间的关系，能让我们直观地观察到数据点的分布模式、相关性等信息。Python 作为数据科学和可视化的主流编程语言，提供了多种绘制散点图的方法和库。本文将深入探讨如何使用 Python 创建和定制散点图，帮助读者掌握这一重要的数据可视化技巧。

<!-- more -->
## 目录
1. 散点图基础概念
2. 使用方法
    - Matplotlib 库绘制散点图
    - Seaborn 库绘制散点图
3. 常见实践
    - 颜色映射
    - 点的大小调整
    - 添加标签和标题
4. 最佳实践
    - 数据预处理
    - 选择合适的样式
    - 多图对比
5. 小结
6. 参考资料

## 散点图基础概念
散点图（Scatter Plot）是一种以直角坐标系两个变量分别作为横轴和纵轴，用坐标点的形式展示数据分布的图形。每个点代表数据集中的一个观测值，其位置由变量的值决定。通过观察散点图，我们可以：
- **判断变量之间的相关性**：如果点呈现出从左下角到右上角的趋势，可能表示正相关；从左上角到右下角的趋势则可能表示负相关。如果点分布较为分散，没有明显趋势，则可能表示变量之间相关性较弱。
- **发现异常值**：远离大部分数据点的孤立点可能是异常值，需要进一步分析。

## 使用方法

### Matplotlib 库绘制散点图
Matplotlib 是 Python 中最常用的绘图库之一，提供了丰富的绘图函数。以下是使用 Matplotlib 绘制简单散点图的示例：

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成一些示例数据
x = np.random.randn(100)
y = np.random.randn(100)

# 绘制散点图
plt.scatter(x, y)

# 显示图形
plt.show()
```

在上述代码中：
- `np.random.randn(100)` 生成 100 个服从标准正态分布的随机数，分别作为 `x` 和 `y` 轴的数据。
- `plt.scatter(x, y)` 调用 `scatter` 函数绘制散点图，其中 `x` 是横坐标数据，`y` 是纵坐标数据。
- `plt.show()` 显示绘制的图形。

### Seaborn 库绘制散点图
Seaborn 是基于 Matplotlib 的高级可视化库，提供了更美观、简洁的绘图风格。以下是使用 Seaborn 绘制散点图的示例：

```python
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

# 生成示例数据
data = pd.DataFrame({
    'x': np.random.randn(100),
    'y': np.random.randn(100)
})

# 绘制散点图
sns.scatterplot(data=data, x='x', y='y')

# 显示图形
plt.show()
```

在上述代码中：
- `pd.DataFrame` 创建一个包含 `x` 和 `y` 列的 DataFrame。
- `sns.scatterplot` 函数用于绘制散点图，通过 `data` 参数指定数据来源，`x` 和 `y` 参数指定列名。

## 常见实践

### 颜色映射
我们可以根据第三个变量来为散点图的点设置颜色，以展示更多信息。以下是使用 Matplotlib 实现颜色映射的示例：

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成示例数据
x = np.random.randn(100)
y = np.random.randn(100)
z = np.random.randint(0, 100, 100)  # 用于颜色映射的第三个变量

# 绘制散点图，根据 z 进行颜色映射
plt.scatter(x, y, c=z, cmap='viridis')

# 添加颜色条
plt.colorbar()

# 显示图形
plt.show()
```

在上述代码中：
- `c=z` 表示根据 `z` 变量的值来为点设置颜色。
- `cmap='viridis'` 指定颜色映射方案，这里使用的是 `viridis` 颜色映射。
- `plt.colorbar()` 添加颜色条，用于说明颜色与 `z` 值的对应关系。

### 点的大小调整
同样，我们可以根据第四个变量来调整点的大小。以下是使用 Seaborn 实现点大小调整的示例：

```python
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

# 生成示例数据
data = pd.DataFrame({
    'x': np.random.randn(100),
    'y': np.random.randn(100),
    'z': np.random.randint(0, 100, 100),  # 用于颜色映射的变量
  'size': np.random.randint(10, 100, 100)  # 用于调整点大小的变量
})

# 绘制散点图，根据 z 进行颜色映射，根据 size 调整点大小
sns.scatterplot(data=data, x='x', y='y', hue='z', size='size')

# 显示图形
plt.show()
```

在上述代码中：
- `hue='z'` 根据 `z` 变量进行颜色映射。
- `size='size'` 根据 `size` 变量调整点的大小。

### 添加标签和标题
为散点图添加标签和标题可以使图形更具可读性。以下是使用 Matplotlib 添加标签和标题的示例：

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成示例数据
x = np.random.randn(100)
y = np.random.randn(100)

# 绘制散点图
plt.scatter(x, y)

# 添加标签和标题
plt.xlabel('X 轴标签')
plt.ylabel('Y 轴标签')
plt.title('散点图示例')

# 显示图形
plt.show()
```

## 最佳实践

### 数据预处理
在绘制散点图之前，对数据进行预处理是非常重要的。这包括处理缺失值、异常值等。例如，我们可以使用以下方法处理缺失值：

```python
import pandas as pd

# 假设 data 是包含缺失值的 DataFrame
data = pd.read_csv('data.csv')

# 去除包含缺失值的行
data = data.dropna()
```

### 选择合适的样式
根据数据的特点和需求选择合适的绘图样式。例如，如果数据具有明显的分组特征，可以使用不同的颜色或形状来区分不同组的点。Seaborn 提供了丰富的主题和样式设置选项，可以轻松实现美观的可视化。

```python
import seaborn as sns
import matplotlib.pyplot as plt

# 设置 Seaborn 主题
sns.set_theme(style="whitegrid")

# 生成示例数据
data = pd.DataFrame({
    'x': np.random.randn(100),
    'y': np.random.randn(100),
    'group': np.random.choice(['A', 'B'], 100)
})

# 绘制散点图，根据 group 分组设置颜色
sns.scatterplot(data=data, x='x', y='y', hue='group')

# 显示图形
plt.show()
```

### 多图对比
当需要比较多组数据之间的关系时，可以绘制多个散点图进行对比。例如，我们可以使用 Matplotlib 的子图功能来实现这一点：

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成多组示例数据
x1 = np.random.randn(100)
y1 = np.random.randn(100)
x2 = np.random.randn(100)
y2 = np.random.randn(100)

# 创建子图
fig, axes = plt.subplots(1, 2, figsize=(10, 5))

# 在第一个子图绘制第一组数据
axes[0].scatter(x1, y1)
axes[0].set_title('第一组数据')

# 在第二个子图绘制第二组数据
axes[1].scatter(x2, y2)
axes[1].set_title('第二组数据')

# 显示图形
plt.show()
```

## 小结
本文详细介绍了 Python 中散点图的基础概念、使用 Matplotlib 和 Seaborn 库绘制散点图的方法，以及常见实践和最佳实践。通过掌握这些知识，读者可以根据自己的数据特点和需求，创建出美观、富有信息的散点图，从而更好地理解和分析数据。

## 参考资料
- Python 数据可视化实战书籍：如《Python 数据可视化实战（第 2 版）》 
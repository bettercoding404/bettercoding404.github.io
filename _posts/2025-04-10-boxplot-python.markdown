---
title: "Boxplot 在 Python 中的应用指南"
description: "在数据探索和可视化的领域中，箱线图（Boxplot）是一种强大且常用的工具。它能够直观地展示数据的分布情况，包括数据的中位数、四分位数、异常值等重要信息。Python 作为数据科学领域广泛使用的编程语言，提供了多种绘制箱线图的方法和库。本文将深入探讨如何在 Python 中使用箱线图，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握并有效运用这一可视化工具。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在数据探索和可视化的领域中，箱线图（Boxplot）是一种强大且常用的工具。它能够直观地展示数据的分布情况，包括数据的中位数、四分位数、异常值等重要信息。Python 作为数据科学领域广泛使用的编程语言，提供了多种绘制箱线图的方法和库。本文将深入探讨如何在 Python 中使用箱线图，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握并有效运用这一可视化工具。

<!-- more -->
## 目录
1. Boxplot 基础概念
2. Python 中绘制 Boxplot 的常用库
3. 使用方法与代码示例
    - 使用 Matplotlib 绘制箱线图
    - 使用 Seaborn 绘制箱线图
4. 常见实践
    - 多组数据的箱线图比较
    - 定制箱线图外观
5. 最佳实践
    - 结合其他图表类型
    - 处理大规模数据
6. 小结
7. 参考资料

## Boxplot 基础概念
箱线图，也称为盒须图，由一个箱子和两条 whisker（须）组成。箱子的上下边界分别是数据的上四分位数（Q3）和下四分位数（Q1），箱子中间的线代表中位数（Q2）。 whisker 则延伸到数据的最小值和最大值，但在存在异常值的情况下， whisker 会延伸到距离箱子边缘 1.5 倍四分位距（IQR = Q3 - Q1）的位置，超出这个范围的数据点被视为异常值，通常用单独的点来表示。

箱线图的优点在于它对数据的分布和离散程度提供了直观的可视化展示，同时能够有效地识别异常值，帮助我们快速了解数据的整体特征。

## Python 中绘制 Boxplot 的常用库
在 Python 中，有两个主要的库用于绘制箱线图：Matplotlib 和 Seaborn。

- **Matplotlib**：Python 中最基础的绘图库，提供了丰富的绘图函数和高度可定制的绘图接口。虽然 API 相对底层，但能够满足各种复杂的绘图需求。
- **Seaborn**：基于 Matplotlib 构建的高级可视化库，它提供了更美观、更易用的绘图函数，尤其擅长绘制统计图表，对数据的可视化呈现具有更好的默认样式。

## 使用方法与代码示例

### 使用 Matplotlib 绘制箱线图
Matplotlib 的 `boxplot()` 函数可以用于绘制箱线图。以下是一个简单的示例：

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成一些随机数据
data = np.random.normal(size=100)

# 绘制箱线图
plt.boxplot(data)

# 添加标题和标签
plt.title('Boxplot Example using Matplotlib')
plt.xlabel('Data')
plt.ylabel('Value')

# 显示图形
plt.show()
```

在上述代码中，我们首先导入了 `matplotlib.pyplot` 和 `numpy` 库。然后使用 `np.random.normal()` 生成了 100 个服从正态分布的随机数据点。接着，调用 `plt.boxplot()` 函数绘制箱线图，并使用 `plt.title()`、`plt.xlabel()` 和 `plt.ylabel()` 为图形添加标题和标签。最后，通过 `plt.show()` 显示绘制的箱线图。

### 使用 Seaborn 绘制箱线图
Seaborn 的 `boxplot()` 函数提供了更简洁和美观的绘图方式。以下是示例代码：

```python
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

# 生成一些随机数据
data = np.random.normal(size=100)

# 绘制箱线图
sns.boxplot(data=data)

# 添加标题和标签
plt.title('Boxplot Example using Seaborn')
plt.xlabel('Data')
plt.ylabel('Value')

# 显示图形
plt.show()
```

在这个例子中，我们导入了 `seaborn` 库，并使用 `sns.boxplot()` 函数绘制箱线图。与 Matplotlib 相比，Seaborn 的代码更为简洁，且默认样式更加美观。同样，我们使用 `plt.title()`、`plt.xlabel()` 和 `plt.ylabel()` 为图形添加标题和标签，最后通过 `plt.show()` 显示图形。

## 常见实践

### 多组数据的箱线图比较
在实际数据分析中，我们经常需要比较多组数据的分布情况。可以将多组数据放在一个列表中，然后传递给箱线图绘制函数。以下是使用 Matplotlib 和 Seaborn 绘制多组数据箱线图的示例：

```python
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# 生成多组随机数据
data1 = np.random.normal(size=100)
data2 = np.random.normal(loc=2, size=100)
data3 = np.random.normal(loc=-2, size=100)

data_list = [data1, data2, data3]

# 使用 Matplotlib 绘制多组数据箱线图
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.boxplot(data_list)
plt.title('Multiple Boxplots using Matplotlib')
plt.xlabel('Group')
plt.ylabel('Value')

# 使用 Seaborn 绘制多组数据箱线图
plt.subplot(1, 2, 2)
sns.boxplot(data=data_list)
plt.title('Multiple Boxplots using Seaborn')
plt.xlabel('Group')
plt.ylabel('Value')

plt.tight_layout()
plt.show()
```

在上述代码中，我们生成了三组不同的随机数据，并将它们存储在一个列表 `data_list` 中。然后，使用 Matplotlib 和 Seaborn 分别绘制多组数据的箱线图，并将两个图形显示在同一窗口中进行对比。

### 定制箱线图外观
Matplotlib 和 Seaborn 都提供了丰富的参数来定制箱线图的外观。例如，可以改变箱子的颜色、线条的样式、异常值的标记等。以下是使用 Matplotlib 定制箱线图外观的示例：

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成随机数据
data = np.random.normal(size=100)

# 定制箱线图外观
boxprops = dict(linestyle='-', linewidth=1, color='b')
flierprops = dict(marker='o', markerfacecolor='r', markersize=5)
medianprops = dict(linestyle='--', linewidth=1, color='k')

plt.boxplot(data, boxprops=boxprops, flierprops=flierprops, medianprops=medianprops)

# 添加标题和标签
plt.title('Customized Boxplot using Matplotlib')
plt.xlabel('Data')
plt.ylabel('Value')

# 显示图形
plt.show()
```

在这个示例中，我们使用 `boxprops`、`flierprops` 和 `medianprops` 分别设置了箱子、异常值和中位数线的属性。通过调整这些参数，可以根据需求定制箱线图的外观。

## 最佳实践

### 结合其他图表类型
为了更全面地了解数据，通常将箱线图与其他图表类型结合使用。例如，可以将箱线图与直方图或散点图放在一起，以更直观地展示数据的分布和特征。以下是将箱线图与直方图结合的示例：

```python
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# 生成随机数据
data = np.random.normal(size=100)

# 创建一个包含两个子图的图形
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 5))

# 在第一个子图中绘制箱线图
sns.boxplot(data=data, ax=ax1)
ax1.set_title('Boxplot')
ax1.set_xlabel('Data')
ax1.set_ylabel('Value')

# 在第二个子图中绘制直方图
sns.histplot(data=data, kde=True, ax=ax2)
ax2.set_title('Histogram')
ax2.set_xlabel('Value')
ax2.set_ylabel('Frequency')

plt.tight_layout()
plt.show()
```

在上述代码中，我们使用 `plt.subplots()` 创建了一个包含两个子图的图形。在第一个子图中绘制箱线图，在第二个子图中绘制直方图，并使用 `sns.histplot()` 函数添加了核密度估计曲线（KDE）。通过这种方式，可以从不同角度观察数据的分布情况。

### 处理大规模数据
当处理大规模数据时，直接绘制箱线图可能会导致性能问题。一种有效的方法是对数据进行抽样，然后绘制箱线图。以下是使用 `numpy` 进行简单随机抽样的示例：

```python
import matplotlib.pyplot as plt
import numpy as np

# 生成大规模随机数据
data = np.random.normal(size=10000)

# 进行随机抽样
sampled_data = np.random.choice(data, size=1000)

# 绘制箱线图
plt.boxplot(sampled_data)

# 添加标题和标签
plt.title('Boxplot of Sampled Data')
plt.xlabel('Data')
plt.ylabel('Value')

# 显示图形
plt.show()
```

在这个示例中，我们首先生成了包含 10000 个数据点的大规模数据集。然后，使用 `np.random.choice()` 从原始数据中随机抽取 1000 个数据点作为样本，并绘制箱线图。通过抽样，可以在不损失太多信息的情况下提高绘图效率。

## 小结
本文详细介绍了箱线图的基础概念，以及在 Python 中使用 Matplotlib 和 Seaborn 绘制箱线图的方法。我们通过代码示例展示了如何绘制单组和多组数据的箱线图，以及如何定制箱线图的外观。此外，还探讨了一些常见实践和最佳实践，包括将箱线图与其他图表类型结合使用，以及处理大规模数据的方法。通过掌握这些知识和技巧，读者能够在数据分析和可视化工作中更加有效地运用箱线图，深入了解数据的特征和分布情况。

## 参考资料
- 《Python 数据科学手册》（*Python Data Science Handbook*）
- 《利用 Python 进行数据分析》（*Python for Data Analysis*）
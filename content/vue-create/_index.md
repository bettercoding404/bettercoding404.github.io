---
layout: post
date: 2024-12-14
title:  使用 Vue CLI 创建 Vue 项目
description: 在现代前端开发中，Vue.js 是一个非常流行的框架。为了帮助开发者快速创建和管理 Vue 项目，Vue 团队提供了一个强大的命令行工具——Vue CLI。本文将介绍如何使用 Vue CLI 创建一个新的 Vue 项目，并探讨一些重要的配置选项。
tags: [vue]
cascade:
  - type: docs
---


在现代前端开发中，Vue.js 是一个非常流行的框架。为了帮助开发者快速创建和管理 Vue 项目，Vue 团队提供了一个强大的命令行工具——Vue CLI。本文将介绍如何使用 Vue CLI 创建一个新的 Vue 项目，并探讨一些重要的配置选项。

## 什么是 Vue CLI？

Vue CLI 是一个官方提供的标准化工具，用于快速搭建 Vue.js 项目的开发环境。它不仅支持项目的创建，还提供了即插即用的插件系统、强大的命令行工具、单元测试集成以及持续集成支持等。

## 安装 Vue CLI

在创建 Vue 项目之前，您需要确保已经安装了 Node.js 和 npm（或 yarn）。接下来，通过以下命令全局安装 Vue CLI：

```bash
npm install -g @vue/cli
```

或者使用 yarn：

```bash
yarn global add @vue/cli
```

安装完成后，可以通过以下命令确认 Vue CLI 是否安装成功：

```bash
vue --version
```

如果成功，您将看到已安装的 Vue CLI 的版本号。

## 创建 Vue 项目

安装完成后，您可以使用 `vue create` 命令来创建一个新的 Vue 项目。假设我们要创建一个名为 `my-vue-app` 的项目，可以执行以下命令：

```bash
vue create my-vue-app
```

执行该命令后，Vue CLI 会提示您选择项目的预设配置。

### 选择预设

Vue CLI 提供了两种预设方式：

1. **默认预设**：包括 Babel 和 ESLint 支持，适用于大多数项目。
2. **手动选择特性**：如果您需要更细致的控制，可以选择手动配置。

如果选择手动配置，系统会让您选择需要的特性，例如 TypeScript、Router、Vuex、CSS 预处理器、Linting、单元测试和 E2E 测试等。

### 保存预设

在完成手动配置后，您还可以选择将该配置保存为自定义预设，以便在未来的项目中重用。

## 项目目录结构

创建完成后，Vue CLI 会生成一个标准的项目目录结构：

```
my-vue-app/
├── node_modules/
├── public/
│   ├── favicon.ico
│   └── index.html
├── src/
│   ├── assets/
│   ├── components/
│   ├── views/
│   ├── App.vue
│   ├── main.js
├── .gitignore
├── babel.config.js
├── package.json
├── README.md
└── yarn.lock
```

### 主要文件介绍

- **`public/`**：包含静态文件，`index.html` 是应用的入口 HTML 文件。
- **`src/`**：包含源码，主要开发工作将在这里进行。
- **`src/main.js`**：入口 JavaScript 文件，用于初始化 Vue 应用。
- **`src/App.vue`**：根组件。
- **`package.json`**：项目配置文件，定义依赖和各种脚本命令。

## 运行开发服务器

进入项目目录后，可以通过以下命令启动开发服务器：

```bash
cd my-vue-app
npm run serve
```

命令执行后，Vue CLI 会启动一个本地开发服务器，并在终端中提供访问 URL（默认为 `http://localhost:8080/`）。您可以在浏览器中打开该 URL，查看项目的运行效果。

## 总结

使用 Vue CLI，创建和管理 Vue 项目变得非常简单。它提供了强大的配置选项和插件系统，能够满足不同项目的需求。希望本文能帮助您更好地使用 Vue CLI 创建高效、现代化的 Vue.js 应用。如需进一步了解，可以查阅官方文档了解更高级的功能和配置。
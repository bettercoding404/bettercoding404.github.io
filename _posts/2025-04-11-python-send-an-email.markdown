---
title: "Python发送邮件：从入门到实践"
description: "在自动化任务、通知系统以及与用户交互的过程中，发送邮件是一项非常实用的功能。Python作为一门功能强大且简洁易用的编程语言，提供了丰富的库来实现发送邮件的功能。本文将深入探讨Python发送邮件的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一重要技能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在自动化任务、通知系统以及与用户交互的过程中，发送邮件是一项非常实用的功能。Python作为一门功能强大且简洁易用的编程语言，提供了丰富的库来实现发送邮件的功能。本文将深入探讨Python发送邮件的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一重要技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `smtplib` 库
    - 使用 `yagmail` 库
3. 常见实践
    - 发送纯文本邮件
    - 发送带附件的邮件
    - 发送HTML格式邮件
4. 最佳实践
    - 安全处理邮件密码
    - 错误处理与日志记录
    - 邮件内容的格式化与优化
5. 小结
6. 参考资料

## 基础概念
### 邮件协议
- **SMTP（Simple Mail Transfer Protocol）**：简单邮件传输协议，用于发送邮件。大多数邮件服务器都支持SMTP协议。Python的 `smtplib` 库就是基于SMTP协议来实现邮件发送功能的。
- **IMAP（Internet Message Access Protocol）**：互联网消息访问协议，用于接收邮件。它允许用户在服务器上管理邮件，如查看邮件列表、下载邮件等。
- **POP3（Post Office Protocol version 3）**：邮局协议版本3，也是用于接收邮件。与IMAP不同，POP3通常会将邮件下载到本地客户端，然后从服务器上删除。

### 邮件服务器
邮件服务器是处理邮件发送和接收的核心组件。常见的邮件服务器有 Gmail、QQ邮箱、163邮箱等。不同的邮件服务器可能有不同的配置要求和限制，在使用Python发送邮件时，需要了解目标邮件服务器的相关信息，如SMTP服务器地址、端口号等。

## 使用方法

### 使用 `smtplib` 库
`smtplib` 是Python标准库的一部分，提供了简单的SMTP客户端会话对象，用于发送邮件。以下是一个基本的示例：

```python
import smtplib
from email.mime.text import MIMEText

# 邮件内容
msg = MIMEText('这是一封测试邮件', 'plain', 'utf-8')

# 发件人、收件人、主题
msg['From'] = 'your_email@example.com'
msg['To'] ='recipient_email@example.com'
msg['Subject'] = '测试邮件'

# 连接SMTP服务器并发送邮件
try:
    server = smtplib.SMTP('smtp.example.com', 587)  # 替换为实际的SMTP服务器地址和端口
    server.starttls()
    server.login('your_email@example.com', 'your_password')  # 替换为实际的邮箱账号和密码
    server.sendmail('your_email@example.com','recipient_email@example.com', msg.as_string())
    server.quit()
    print('邮件发送成功')
except Exception as e:
    print(f'邮件发送失败: {e}')
```

### 使用 `yagmail` 库
`yagmail` 是一个基于 `smtplib` 和 `email` 库的第三方库，提供了更简洁的邮件发送接口。首先需要安装 `yagmail`：
```bash
pip install yagmail
```

以下是使用 `yagmail` 发送邮件的示例：

```python
import yagmail

# 连接邮箱
yag = yagmail.SMTP('your_email@example.com', 'your_password')  # 替换为实际的邮箱账号和密码

# 发送邮件
try:
    yag.send(to='recipient_email@example.com', subject='测试邮件', contents='这是一封测试邮件')
    print('邮件发送成功')
except Exception as e:
    print(f'邮件发送失败: {e}')
```

## 常见实践

### 发送纯文本邮件
上述示例中已经展示了如何发送纯文本邮件。在使用 `smtplib` 时，通过 `MIMEText` 类创建邮件内容对象，并指定 `'plain'` 作为内容类型。使用 `yagmail` 时，直接将纯文本内容作为 `contents` 参数传入。

### 发送带附件的邮件
使用 `smtplib` 发送带附件的邮件：

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

# 创建邮件对象
msg = MIMEMultipart()
msg['From'] = 'your_email@example.com'
msg['To'] ='recipient_email@example.com'
msg['Subject'] = '带附件的测试邮件'

# 邮件正文
body = '这是一封带附件的测试邮件'
msg.attach(MIMEText(body, 'plain', 'utf-8'))

# 添加附件
attachment_path = 'path/to/your/file.pdf'  # 替换为实际的附件路径
with open(attachment_path, 'rb') as file:
    part = MIMEApplication(file.read(), Name='your_file.pdf')  # 替换为实际的附件文件名
    part['Content-Disposition'] = f'attachment; filename="{attachment_path.split("/")[-1]}"'
    msg.attach(part)

# 连接SMTP服务器并发送邮件
try:
    server = smtplib.SMTP('smtp.example.com', 587)
    server.starttls()
    server.login('your_email@example.com', 'your_password')
    server.sendmail('your_email@example.com','recipient_email@example.com', msg.as_string())
    server.quit()
    print('邮件发送成功')
except Exception as e:
    print(f'邮件发送失败: {e}')
```

使用 `yagmail` 发送带附件的邮件：

```python
import yagmail

yag = yagmail.SMTP('your_email@example.com', 'your_password')

attachment_path = 'path/to/your/file.pdf'  # 替换为实际的附件路径
try:
    yag.send(to='recipient_email@example.com', subject='带附件的测试邮件', contents='这是一封带附件的测试邮件', attachments=attachment_path)
    print('邮件发送成功')
except Exception as e:
    print(f'邮件发送失败: {e}')
```

### 发送HTML格式邮件
使用 `smtplib` 发送HTML格式邮件：

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# 创建邮件对象
msg = MIMEMultipart()
msg['From'] = 'your_email@example.com'
msg['To'] ='recipient_email@example.com'
msg['Subject'] = 'HTML格式测试邮件'

# HTML内容
html = """
<html>
  <body>
    <h1>这是一封HTML格式的邮件</h1>
    <p>欢迎使用Python发送HTML邮件！</p>
  </body>
</html>
"""
msg.attach(MIMEText(html, 'html', 'utf-8'))

# 连接SMTP服务器并发送邮件
try:
    server = smtplib.SMTP('smtp.example.com', 587)
    server.starttls()
    server.login('your_email@example.com', 'your_password')
    server.sendmail('your_email@example.com','recipient_email@example.com', msg.as_string())
    server.quit()
    print('邮件发送成功')
except Exception as e:
    print(f'邮件发送失败: {e}')
```

使用 `yagmail` 发送HTML格式邮件：

```python
import yagmail

yag = yagmail.SMTP('your_email@example.com', 'your_password')

html = """
<html>
  <body>
    <h1>这是一封HTML格式的邮件</h1>
    <p>欢迎使用Python发送HTML邮件！</p>
  </body>
</html>
"""
try:
    yag.send(to='recipient_email@example.com', subject='HTML格式测试邮件', contents=html)
    print('邮件发送成功')
except Exception as e:
    print(f'邮件发送失败: {e}')
```

## 最佳实践

### 安全处理邮件密码
- **环境变量**：不要在代码中硬编码邮件密码，而是使用环境变量来存储密码。在Linux或MacOS系统中，可以在终端中设置环境变量：
```bash
export EMAIL_PASSWORD='your_password'
```
在Python代码中读取环境变量：
```python
import os

password = os.getenv('EMAIL_PASSWORD')
```

- **配置文件**：也可以将密码存储在配置文件中，如 `config.ini`，并使用 `configparser` 库来读取配置文件。

### 错误处理与日志记录
在发送邮件时，可能会遇到各种错误，如网络问题、认证失败等。因此，需要进行适当的错误处理，并记录日志以便排查问题。可以使用Python的 `logging` 库来记录日志：

```python
import smtplib
import logging
from email.mime.text import MIMEText

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 邮件内容
msg = MIMEText('这是一封测试邮件', 'plain', 'utf-8')
msg['From'] = 'your_email@example.com'
msg['To'] ='recipient_email@example.com'
msg['Subject'] = '测试邮件'

# 连接SMTP服务器并发送邮件
try:
    server = smtplib.SMTP('smtp.example.com', 587)
    server.starttls()
    server.login('your_email@example.com', 'your_password')
    server.sendmail('your_email@example.com','recipient_email@example.com', msg.as_string())
    server.quit()
    logging.info('邮件发送成功')
except Exception as e:
    logging.error(f'邮件发送失败: {e}')
```

### 邮件内容的格式化与优化
- **使用模板引擎**：对于复杂的邮件内容，可以使用模板引擎，如 `Jinja2`，来生成邮件内容。这样可以将邮件内容的逻辑和样式分离，提高代码的可维护性。
- **邮件内容优化**：确保邮件内容简洁明了，避免包含过多的敏感信息。同时，注意邮件的格式和排版，使其易于阅读。

## 小结
本文详细介绍了Python发送邮件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。通过学习这些内容，读者可以掌握如何使用Python的 `smtplib` 和 `yagmail` 库发送各种类型的邮件，并在实际应用中遵循最佳实践，提高邮件发送的安全性和可靠性。希望本文能帮助读者在项目中高效地实现邮件发送功能。

## 参考资料
- [Python官方文档 - smtplib](https://docs.python.org/3/library/smtplib.html){: rel="nofollow"}
- [yagmail官方文档](https://yagmail.readthedocs.io/en/latest/){: rel="nofollow"}
- [Python邮件发送教程](https://www.runoob.com/python3/python3-email.html){: rel="nofollow"}
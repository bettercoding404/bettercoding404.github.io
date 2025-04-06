---
title: "Python发送邮件：从入门到最佳实践"
description: "在自动化任务、通知系统以及数据报告等场景中，通过Python发送邮件是一项非常实用的技能。Python提供了多个库来实现邮件发送功能，其中`smtplib`和`email`库是标准库中的重要组成部分，它们能够帮助我们轻松构建和发送各种类型的邮件。本文将详细介绍Python发送邮件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在自动化任务、通知系统以及数据报告等场景中，通过Python发送邮件是一项非常实用的技能。Python提供了多个库来实现邮件发送功能，其中`smtplib`和`email`库是标准库中的重要组成部分，它们能够帮助我们轻松构建和发送各种类型的邮件。本文将详细介绍Python发送邮件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。

<!-- more -->
## 目录
1. **基础概念**
    - **SMTP协议**
    - **邮件结构**
2. **使用方法**
    - **简单文本邮件发送**
    - **带附件的邮件发送**
    - **HTML格式邮件发送**
3. **常见实践**
    - **使用第三方邮件服务提供商**
    - **自动化定时发送邮件**
4. **最佳实践**
    - **安全设置**
    - **错误处理与日志记录**
    - **邮件内容优化**
5. **小结**
6. **参考资料**

## 基础概念
### SMTP协议
SMTP（Simple Mail Transfer Protocol）即简单邮件传输协议，它是用于在互联网上传输邮件的标准协议。SMTP协议规定了邮件发送方和接收方之间如何进行通信，包括建立连接、发送邮件内容以及关闭连接等过程。Python的`smtplib`库就是基于SMTP协议来实现邮件发送功能的。

### 邮件结构
一封完整的邮件通常包含以下几个部分：
- **邮件头部（Headers）**：包含邮件的元数据，如发件人、收件人、主题等信息。
- **邮件正文（Body）**：邮件的实际内容，可以是纯文本、HTML格式或者包含附件。
- **邮件尾部（Footer）**：通常包含一些额外的信息，如签名等。

## 使用方法
### 简单文本邮件发送
以下是使用`smtplib`和`email`库发送简单文本邮件的示例代码：

```python
import smtplib
from email.mime.text import MIMEText

# 邮件发送方和接收方信息
sender_email = "your_email@example.com"
receiver_email = "recipient_email@example.com"
password = "your_email_password"

# 创建邮件内容
message = MIMEText("这是一封简单的文本邮件。", "plain", "utf-8")
message["Subject"] = "简单文本邮件测试"
message["From"] = sender_email
message["To"] = receiver_email

# 连接到SMTP服务器并发送邮件
with smtplib.SMTP("smtp.example.com", 587) as server:
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
```

### 带附件的邮件发送
要发送带附件的邮件，需要使用`email.mime.multipart`和`email.mime.application`模块。以下是示例代码：

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

# 邮件发送方和接收方信息
sender_email = "your_email@example.com"
receiver_email = "recipient_email@example.com"
password = "your_email_password"

# 创建邮件对象
message = MIMEMultipart()
message["Subject"] = "带附件的邮件测试"
message["From"] = sender_email
message["To"] = receiver_email

# 添加邮件正文
message.attach(MIMEText("这是一封带附件的邮件。", "plain", "utf-8"))

# 添加附件
with open("attachment.pdf", "rb") as file:
    part = MIMEApplication(file.read(), Name="attachment.pdf")
    part['Content-Disposition'] = f'attachment; filename="attachment.pdf"'
    message.attach(part)

# 连接到SMTP服务器并发送邮件
with smtplib.SMTP("smtp.example.com", 587) as server:
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
```

### HTML格式邮件发送
发送HTML格式的邮件，只需将邮件正文的类型设置为`html`即可。以下是示例代码：

```python
import smtplib
from email.mime.text import MIMEText

# 邮件发送方和接收方信息
sender_email = "your_email@example.com"
receiver_email = "recipient_email@example.com"
password = "your_email_password"

# HTML内容
html = """
<html>
  <body>
    <h1>这是一封HTML格式的邮件</h1>
    <p>欢迎使用Python发送HTML邮件！</p>
  </body>
</html>
"""

# 创建邮件内容
message = MIMEText(html, "html", "utf-8")
message["Subject"] = "HTML格式邮件测试"
message["From"] = sender_email
message["To"] = receiver_email

# 连接到SMTP服务器并发送邮件
with smtplib.SMTP("smtp.example.com", 587) as server:
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
```

## 常见实践
### 使用第三方邮件服务提供商
许多第三方邮件服务提供商，如Gmail、QQ邮箱等，都提供了SMTP服务。以Gmail为例，需要在Gmail账户中开启“允许安全性较低的应用访问”选项（注意安全风险），然后使用以下配置发送邮件：

```python
import smtplib
from email.mime.text import MIMEText

sender_email = "your_gmail_account@gmail.com"
receiver_email = "recipient_email@example.com"
password = "your_gmail_password"

message = MIMEText("邮件内容", "plain", "utf-8")
message["Subject"] = "使用Gmail发送邮件"
message["From"] = sender_email
message["To"] = receiver_email

with smtplib.SMTP("smtp.gmail.com", 587) as server:
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
```

### 自动化定时发送邮件
可以使用`schedule`库来实现自动化定时发送邮件。以下是一个简单的示例，每天早上9点发送邮件：

```python
import schedule
import time
import smtplib
from email.mime.text import MIMEText

def send_daily_email():
    sender_email = "your_email@example.com"
    receiver_email = "recipient_email@example.com"
    password = "your_email_password"

    message = MIMEText("这是每天定时发送的邮件。", "plain", "utf-8")
    message["Subject"] = "每日定时邮件"
    message["From"] = sender_email
    message["To"] = receiver_email

    with smtplib.SMTP("smtp.example.com", 587) as server:
        server.starttls()
        server.login(sender_email, password)
        server.sendmail(sender_email, receiver_email, message.as_string())

schedule.every().day.at("09:00").do(send_daily_email)

while True:
    schedule.run_pending()
    time.sleep(1)
```

## 最佳实践
### 安全设置
- **使用SSL/TLS加密**：在连接SMTP服务器时，始终使用`starttls()`方法来启用TLS加密，确保邮件传输过程中的数据安全。
- **保护密码**：不要将密码硬编码在代码中，建议使用环境变量或者配置文件来存储密码信息。

### 错误处理与日志记录
在发送邮件过程中，可能会遇到各种错误，如网络问题、认证失败等。因此，需要添加适当的错误处理代码，并记录日志以便排查问题。以下是一个简单的错误处理示例：

```python
import smtplib
from email.mime.text import MIMEText
import logging

logging.basicConfig(level=logging.INFO)

sender_email = "your_email@example.com"
receiver_email = "recipient_email@example.com"
password = "your_email_password"

message = MIMEText("邮件内容", "plain", "utf-8")
message["Subject"] = "邮件主题"
message["From"] = sender_email
message["To"] = receiver_email

try:
    with smtplib.SMTP("smtp.example.com", 587) as server:
        server.starttls()
        server.login(sender_email, password)
        server.sendmail(sender_email, receiver_email, message.as_string())
    logging.info("邮件发送成功")
except smtplib.SMTPException as e:
    logging.error(f"邮件发送失败: {e}")
```

### 邮件内容优化
- **简洁明了**：邮件主题和正文应简洁明了，避免使用过于复杂的语言和格式。
- **个性化**：根据收件人的信息，对邮件内容进行个性化定制，提高邮件的可读性和相关性。

## 小结
通过本文，我们深入了解了Python发送邮件的基础概念、使用方法、常见实践以及最佳实践。掌握这些知识后，读者可以根据实际需求，灵活运用Python实现各种邮件发送功能，无论是简单的文本邮件、带附件的邮件还是HTML格式的邮件，都能轻松应对。同时，遵循最佳实践原则，可以提高邮件发送的安全性、稳定性和可读性。

## 参考资料
- [Python官方文档 - smtplib](https://docs.python.org/3/library/smtplib.html){: rel="nofollow"}
- [Python官方文档 - email](https://docs.python.org/3/library/email.html){: rel="nofollow"}
- [schedule库官方文档](https://schedule.readthedocs.io/en/stable/){: rel="nofollow"}
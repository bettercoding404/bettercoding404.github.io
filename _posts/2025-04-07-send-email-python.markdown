---
title: "使用Python发送邮件：从基础到最佳实践"
description: "在现代编程和自动化任务中，使用Python发送邮件是一项非常实用的技能。无论是用于通知系统、发送报告，还是进行用户交互，Python提供了简单而强大的库来实现邮件发送功能。本文将深入探讨如何使用Python发送邮件，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在现代编程和自动化任务中，使用Python发送邮件是一项非常实用的技能。无论是用于通知系统、发送报告，还是进行用户交互，Python提供了简单而强大的库来实现邮件发送功能。本文将深入探讨如何使用Python发送邮件，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用`smtplib`库发送简单邮件**
    - **发送带附件的邮件**
3. **常见实践**
    - **自动化邮件发送**
    - **根据条件发送邮件**
4. **最佳实践**
    - **安全问题**
    - **邮件内容格式化**
5. **小结**
6. **参考资料**

## 基础概念
在Python中，发送邮件主要依赖于`smtplib`库（SMTP客户端库）和`email`库（用于构建邮件内容）。

- **SMTP（Simple Mail Transfer Protocol）**：它是一种用于传输邮件的标准协议。`smtplib`库允许我们通过Python与SMTP服务器进行交互，从而发送邮件。
- **`email`库**：这个库提供了丰富的类和函数，用于创建、解析和操作邮件内容。我们可以使用它来设置邮件的主题、发件人、收件人、正文以及附件等。

## 使用方法

### 使用`smtplib`库发送简单邮件
下面是一个简单的示例，展示如何使用`smtplib`库发送纯文本邮件：

```python
import smtplib
from email.mime.text import MIMEText

# 邮件内容
msg = MIMEText('这是一封测试邮件的正文内容')
msg['Subject'] = '测试邮件主题'
msg['From'] ='sender_email@example.com'
msg['To'] ='recipient_email@example.com'

# 连接到SMTP服务器
server = smtplib.SMTP('smtp.example.com', 587)  # 替换为实际的SMTP服务器和端口
server.starttls()  # 启动TLS加密
server.login('sender_email@example.com', 'password')  # 登录SMTP服务器

# 发送邮件
server.sendmail('sender_email@example.com','recipient_email@example.com', msg.as_string())

# 关闭连接
server.quit()
```

### 发送带附件的邮件
要发送带附件的邮件，我们需要使用`email.mime.multipart`和`email.mime.application`模块。以下是示例代码：

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

# 创建邮件对象
msg = MIMEMultipart()
msg['Subject'] = '带附件的测试邮件'
msg['From'] ='sender_email@example.com'
msg['To'] ='recipient_email@example.com'

# 添加正文
msg.attach(MIMEText('这是带附件邮件的正文内容'))

# 添加附件
with open('attachment.txt', 'rb') as file:
    part = MIMEApplication(file.read(), Name='attachment.txt')
    part['Content-Disposition'] = f'attachment; filename="attachment.txt"'
    msg.attach(part)

# 连接到SMTP服务器
server = smtplib.SMTP('smtp.example.com', 587)
server.starttls()
server.login('sender_email@example.com', 'password')

# 发送邮件
server.sendmail('sender_email@example.com','recipient_email@example.com', msg.as_string())

# 关闭连接
server.quit()
```

## 常见实践

### 自动化邮件发送
可以将邮件发送功能集成到定时任务中，实现自动化发送。例如，使用`schedule`库结合`smtplib`：

```python
import smtplib
import schedule
import time
from email.mime.text import MIMEText

def send_daily_email():
    msg = MIMEText('这是每天定时发送的邮件内容')
    msg['Subject'] = '每日定时邮件'
    msg['From'] ='sender_email@example.com'
    msg['To'] ='recipient_email@example.com'

    server = smtplib.SMTP('smtp.example.com', 587)
    server.starttls()
    server.login('sender_email@example.com', 'password')
    server.sendmail('sender_email@example.com','recipient_email@example.com', msg.as_string())
    server.quit()

# 每天早上9点发送邮件
schedule.every().day.at("09:00").do(send_daily_email)

while True:
    schedule.run_pending()
    time.sleep(1)
```

### 根据条件发送邮件
根据程序的运行结果或某些条件来决定是否发送邮件。例如，在一个数据分析脚本中，如果数据出现异常，可以发送邮件通知：

```python
import smtplib
from email.mime.text import MIMEText

data = [1, 2, 3, 4, 5]  # 示例数据
if max(data) > 10:  # 假设数据最大值超过10为异常
    msg = MIMEText('数据出现异常，最大值超过了10')
    msg['Subject'] = '数据异常通知'
    msg['From'] ='sender_email@example.com'
    msg['To'] ='recipient_email@example.com'

    server = smtplib.SMTP('smtp.example.com', 587)
    server.starttls()
    server.login('sender_email@example.com', 'password')
    server.sendmail('sender_email@example.com','recipient_email@example.com', msg.as_string())
    server.quit()
```

## 最佳实践

### 安全问题
- **使用TLS/SSL加密**：始终使用TLS或SSL加密连接到SMTP服务器，以保护邮件传输过程中的敏感信息。
- **避免硬编码密码**：不要在代码中直接硬编码SMTP服务器的登录密码。可以使用环境变量或配置文件来存储密码。例如：

```python
import os
password = os.environ.get('SMTP_PASSWORD')
```

### 邮件内容格式化
- **使用HTML格式**：如果需要发送富文本邮件，可以使用HTML格式。例如：

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

msg = MIMEMultipart()
msg['Subject'] = 'HTML格式邮件'
msg['From'] ='sender_email@example.com'
msg['To'] ='recipient_email@example.com'

html = """
<html>
  <body>
    <h1>这是一个HTML格式的邮件</h1>
    <p>这是邮件正文内容。</p>
  </body>
</html>
"""

msg.attach(MIMEText(html, 'html'))

# 连接到SMTP服务器并发送邮件
server = smtplib.SMTP('smtp.example.com', 587)
server.starttls()
server.login('sender_email@example.com', 'password')
server.sendmail('sender_email@example.com','recipient_email@example.com', msg.as_string())
server.quit()
```

## 小结
通过本文，我们学习了使用Python发送邮件的基础概念、使用方法、常见实践以及最佳实践。`smtplib`和`email`库为我们提供了强大而灵活的工具，能够满足各种邮件发送需求。在实际应用中，我们需要注意安全问题，并合理设计邮件内容格式，以确保邮件的有效发送和良好的用户体验。

## 参考资料
- [Python官方文档 - smtplib](https://docs.python.org/3/library/smtplib.html){: rel="nofollow"}
- [Python官方文档 - email](https://docs.python.org/3/library/email.html){: rel="nofollow"}
- [Real Python - Sending Emails in Python](https://realpython.com/python-send-email/){: rel="nofollow"}
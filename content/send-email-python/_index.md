---
title: "使用Python发送邮件：从基础到最佳实践"
description: "在自动化任务、通知系统以及与用户沟通等场景中，发送邮件是一项常见且实用的功能。Python作为一种功能强大且易于上手的编程语言，提供了丰富的库来实现邮件发送功能。本文将详细介绍使用Python发送邮件的基础概念、使用方法、常见实践以及最佳实践，帮助读者快速掌握并在实际项目中高效运用。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在自动化任务、通知系统以及与用户沟通等场景中，发送邮件是一项常见且实用的功能。Python作为一种功能强大且易于上手的编程语言，提供了丰富的库来实现邮件发送功能。本文将详细介绍使用Python发送邮件的基础概念、使用方法、常见实践以及最佳实践，帮助读者快速掌握并在实际项目中高效运用。

<!-- more -->
## 目录
1. **基础概念**
    - 邮件协议
    - Python邮件库
2. **使用方法**
    - 简单文本邮件发送
    - 带附件邮件发送
3. **常见实践**
    - 自动化定时发送邮件
    - 根据条件发送邮件
4. **最佳实践**
    - 安全问题与解决方案
    - 邮件内容格式化
5. **小结**
6. **参考资料**

## 基础概念
### 邮件协议
- **SMTP（Simple Mail Transfer Protocol）**：用于发送邮件的标准协议。大多数邮件服务器都支持SMTP协议来接收外部发送的邮件。
- **IMAP（Internet Message Access Protocol）**：用于从邮件服务器获取邮件的协议，允许用户在服务器上管理邮件文件夹、搜索邮件等。
- **POP3（Post Office Protocol version 3）**：也是用于从邮件服务器接收邮件的协议，但与IMAP不同，POP3通常会将邮件下载到本地客户端并从服务器删除（默认设置）。

### Python邮件库
- **smtplib**：Python标准库中用于发送邮件的模块，提供了简单的SMTP客户端接口，用于与SMTP服务器进行通信。
- **email**：同样是Python标准库中的模块，用于构建和解析邮件内容，包括邮件头、正文、附件等。

## 使用方法
### 简单文本邮件发送
以下是使用`smtplib`和`email`模块发送简单文本邮件的示例：

```python
import smtplib
from email.mime.text import MIMEText

# 邮件内容
msg = MIMEText('这是一封测试邮件的正文内容')

# 发件人、收件人、主题
msg['Subject'] = '测试邮件主题'
msg['From'] = 'your_email@example.com'
msg['To'] ='recipient_email@example.com'

# 连接SMTP服务器并发送邮件
server = smtplib.SMTP('smtp.example.com', 587)  # 替换为实际的SMTP服务器和端口
server.starttls()
server.login('your_email@example.com', 'your_password')
server.sendmail('your_email@example.com','recipient_email@example.com', msg.as_string())
server.quit()
```

### 带附件邮件发送
发送带附件的邮件稍微复杂一些，需要使用`email.mime.multipart`和`email.mime.application`模块：

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

# 创建一个带附件的邮件实例
msg = MIMEMultipart()
msg['Subject'] = '带附件的测试邮件'
msg['From'] = 'your_email@example.com'
msg['To'] ='recipient_email@example.com'

# 邮件正文
body = MIMEText('这是带附件邮件的正文内容')
msg.attach(body)

# 附件路径
attachment_path = 'path/to/your/file.pdf'
with open(attachment_path, "rb") as attachment:
    part = MIMEApplication(attachment.read(), Name='file.pdf')
    part['Content-Disposition'] = f'attachment; filename="file.pdf"'
    msg.attach(part)

# 连接SMTP服务器并发送邮件
server = smtplib.SMTP('smtp.example.com', 587)
server.starttls()
server.login('your_email@example.com', 'your_password')
server.sendmail('your_email@example.com','recipient_email@example.com', msg.as_string())
server.quit()
```

## 常见实践
### 自动化定时发送邮件
使用`schedule`库可以实现定时发送邮件：

```python
import smtplib
from email.mime.text import MIMEText
import schedule
import time

def send_daily_email():
    msg = MIMEText('这是每日定时发送的邮件内容')
    msg['Subject'] = '每日定时邮件'
    msg['From'] = 'your_email@example.com'
    msg['To'] ='recipient_email@example.com'

    server = smtplib.SMTP('smtp.example.com', 587)
    server.starttls()
    server.login('your_email@example.com', 'your_password')
    server.sendmail('your_email@example.com','recipient_email@example.com', msg.as_string())
    server.quit()

# 每天早上8点发送邮件
schedule.every().day.at("08:00").do(send_daily_email)

while True:
    schedule.run_pending()
    time.sleep(1)
```

### 根据条件发送邮件
例如，根据某个文件是否存在来决定是否发送邮件：

```python
import os
import smtplib
from email.mime.text import MIMEText

def check_and_send_email():
    file_path = 'path/to/file.txt'
    if os.path.exists(file_path):
        msg = MIMEText('指定文件已存在')
        msg['Subject'] = '文件存在通知'
        msg['From'] = 'your_email@example.com'
        msg['To'] ='recipient_email@example.com'

        server = smtplib.SMTP('smtp.example.com', 587)
        server.starttls()
        server.login('your_email@example.com', 'your_password')
        server.sendmail('your_email@example.com','recipient_email@example.com', msg.as_string())
        server.quit()

check_and_send_email()
```

## 最佳实践
### 安全问题与解决方案
- **密码管理**：避免在代码中硬编码密码，可使用环境变量或配置文件来存储敏感信息。
- **加密连接**：使用`starttls()`方法建立安全的TLS连接，或者直接使用SSL连接（`smtplib.SMTP_SSL`）。

### 邮件内容格式化
- **HTML格式邮件**：使用`MIMEText`的`html`类型来发送带有HTML格式的邮件，使邮件内容更加丰富和美观。
- **正确设置字符编码**：确保邮件内容的字符编码正确，避免出现乱码问题，通常使用`utf-8`编码。

## 小结
通过本文，我们了解了使用Python发送邮件的基础概念，包括邮件协议和常用的Python邮件库。掌握了简单文本邮件和带附件邮件的发送方法，以及在自动化定时发送和根据条件发送邮件等常见实践场景中的应用。同时，我们还探讨了发送邮件过程中的最佳实践，如安全问题处理和邮件内容格式化。希望这些知识能够帮助读者在实际项目中更加高效、安全地使用Python发送邮件。

## 参考资料
- [Python官方文档 - smtplib](https://docs.python.org/3/library/smtplib.html)
- [Python官方文档 - email](https://docs.python.org/3/library/email.html)
- [schedule库官方文档](https://schedule.readthedocs.io/en/stable/)
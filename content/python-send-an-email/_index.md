---
title: "Python发送邮件：从入门到实践"
description: "在自动化任务、通知系统以及各种业务逻辑处理中，通过Python发送邮件是一项非常实用的技能。Python提供了多个库来实现邮件发送功能，其中`smtplib`和`email`库是标准库中的常用选择。本文将详细介绍如何使用Python发送邮件，涵盖基础概念、使用方法、常见实践及最佳实践，帮助你轻松掌握这一重要技能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在自动化任务、通知系统以及各种业务逻辑处理中，通过Python发送邮件是一项非常实用的技能。Python提供了多个库来实现邮件发送功能，其中`smtplib`和`email`库是标准库中的常用选择。本文将详细介绍如何使用Python发送邮件，涵盖基础概念、使用方法、常见实践及最佳实践，帮助你轻松掌握这一重要技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **简单文本邮件**
    - **带附件邮件**
3. **常见实践**
    - **发送HTML格式邮件**
    - **使用第三方邮件服务**
4. **最佳实践**
    - **错误处理与日志记录**
    - **安全考量**
5. **小结**
6. **参考资料**

## 基础概念
### SMTP协议
SMTP（Simple Mail Transfer Protocol）即简单邮件传输协议，它是用于在互联网上传输电子邮件的标准协议。Python的`smtplib`库就是基于SMTP协议来实现邮件发送功能的。在发送邮件时，需要连接到邮件服务器的SMTP端口（常见的有25、587、465等），并遵循SMTP的命令和响应规则。

### 邮件组件
一封完整的邮件通常包含以下几个部分：
- **发件人（From）**：邮件的发送者地址。
- **收件人（To）**：邮件的接收者地址。
- **主题（Subject）**：邮件的主题内容，用于简要描述邮件的主要内容。
- **正文（Body）**：邮件的具体内容，可以是纯文本、HTML格式或其他格式。
- **附件（Attachment）**：可附加的文件，如文档、图片、表格等。

## 使用方法

### 简单文本邮件
下面是使用Python发送简单文本邮件的示例代码：

```python
import smtplib
from email.mime.text import MIMEText

# 发件人邮箱
sender_email = "your_email@example.com"
# 收件人邮箱
receiver_email = "recipient_email@example.com"
# 邮箱密码（注意：如果是使用第三方邮箱，可能需要开启授权码登录）
password = "your_email_password"

# 创建邮件内容
message = MIMEText('这是一封简单的文本邮件。', 'plain', 'utf-8')
message['Subject'] = '简单文本邮件测试'
message['From'] = sender_email
message['To'] = receiver_email

# 连接到SMTP服务器并发送邮件
try:
    server = smtplib.SMTP('smtp.example.com', 587)  # 替换为你的SMTP服务器地址和端口
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
    print("邮件发送成功！")
except smtplib.SMTPException as e:
    print(f"发送邮件时出错: {e}")
finally:
    server.quit()
```

### 带附件邮件
发送带附件的邮件，需要使用`email.mime.multipart`和`email.mime.application`模块。以下是示例代码：

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

# 发件人邮箱
sender_email = "your_email@example.com"
# 收件人邮箱
receiver_email = "recipient_email@example.com"
# 邮箱密码
password = "your_email_password"

# 创建邮件对象
message = MIMEMultipart()
message['Subject'] = '带附件的邮件测试'
message['From'] = sender_email
message['To'] = receiver_email

# 添加邮件正文
body = '这是一封带附件的邮件。'
message.attach(MIMEText(body, 'plain', 'utf-8'))

# 添加附件
attachment_path = 'path/to/your/file.pdf'  # 替换为附件文件路径
with open(attachment_path, "rb") as attachment:
    part = MIMEApplication(attachment.read(), Name='file.pdf')  # 自定义附件文件名
    part['Content-Disposition'] = f'attachment; filename="{attachment_path.split("/")[-1]}"'
    message.attach(part)

# 连接到SMTP服务器并发送邮件
try:
    server = smtplib.SMTP('smtp.example.com', 587)  # 替换为你的SMTP服务器地址和端口
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
    print("邮件发送成功！")
except smtplib.SMTPException as e:
    print(f"发送邮件时出错: {e}")
finally:
    server.quit()
```

## 常见实践

### 发送HTML格式邮件
有时候需要发送包含HTML格式的邮件，以展示更丰富的内容。以下是示例代码：

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# 发件人邮箱
sender_email = "your_email@example.com"
# 收件人邮箱
receiver_email = "recipient_email@example.com"
# 邮箱密码
password = "your_email_password"

# 创建邮件对象
message = MIMEMultipart()
message['Subject'] = 'HTML格式邮件测试'
message['From'] = sender_email
message['To'] = receiver_email

# HTML内容
html = """
<html>
    <body>
        <h1>这是一封HTML格式的邮件</h1>
        <p>欢迎使用Python发送HTML邮件！</p>
    </body>
</html>
"""

# 添加HTML格式的正文
message.attach(MIMEText(html, 'html', 'utf-8'))

# 连接到SMTP服务器并发送邮件
try:
    server = smtplib.SMTP('smtp.example.com', 587)  # 替换为你的SMTP服务器地址和端口
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
    print("邮件发送成功！")
except smtplib.SMTPException as e:
    print(f"发送邮件时出错: {e}")
finally:
    server.quit()
```

### 使用第三方邮件服务
许多第三方邮件服务提供商（如Gmail、QQ邮箱等）提供了SMTP服务，可以方便地用于发送邮件。以Gmail为例，需要注意的是，由于安全原因，Gmail可能需要开启“允许安全性较低的应用”选项（此选项可能存在一定风险），或者使用OAuth 2.0进行身份验证。

```python
import smtplib
from email.mime.text import MIMEText

# 发件人邮箱
sender_email = "your_gmail_account@gmail.com"
# 收件人邮箱
receiver_email = "recipient_email@example.com"
# Gmail密码或授权码
password = "your_gmail_password_or_app_password"

# 创建邮件内容
message = MIMEText('这是一封使用Gmail发送的邮件。', 'plain', 'utf-8')
message['Subject'] = '使用Gmail发送邮件测试'
message['From'] = sender_email
message['To'] = receiver_email

# 连接到Gmail的SMTP服务器并发送邮件
try:
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
    print("邮件发送成功！")
except smtplib.SMTPException as e:
    print(f"发送邮件时出错: {e}")
finally:
    server.quit()
```

## 最佳实践

### 错误处理与日志记录
在发送邮件过程中，可能会遇到各种错误，如网络问题、认证失败等。为了提高程序的健壮性，需要进行适当的错误处理，并记录日志以便排查问题。

```python
import smtplib
import logging
from email.mime.text import MIMEText

# 配置日志记录
logging.basicConfig(filename='email_sending.log', level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')

# 发件人邮箱
sender_email = "your_email@example.com"
# 收件人邮箱
receiver_email = "recipient_email@example.com"
# 邮箱密码
password = "your_email_password"

# 创建邮件内容
message = MIMEText('这是一封带错误处理和日志记录的邮件。', 'plain', 'utf-8')
message['Subject'] = '邮件发送测试'
message['From'] = sender_email
message['To'] = receiver_email

# 连接到SMTP服务器并发送邮件
try:
    server = smtplib.SMTP('smtp.example.com', 587)
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
    logging.info("邮件发送成功！")
except smtplib.SMTPException as e:
    logging.error(f"发送邮件时出错: {e}")
finally:
    server.quit()
```

### 安全考量
- **密码管理**：避免将密码硬编码在代码中，可以使用环境变量或配置文件来存储密码。
- **加密连接**：尽量使用SSL/TLS加密连接到SMTP服务器，以确保邮件传输过程中的数据安全。
- **认证方式**：对于第三方邮件服务，考虑使用更安全的认证方式，如OAuth 2.0。

## 小结
通过本文的介绍，你已经了解了Python发送邮件的基础概念、使用方法、常见实践及最佳实践。掌握这些知识后，你可以根据实际需求，灵活运用Python发送各种类型的邮件，为自动化任务和通知系统等应用场景提供有力支持。在实际应用中，要注意安全问题和错误处理，以确保邮件发送的可靠性和稳定性。

## 参考资料
- [Python官方文档 - smtplib](https://docs.python.org/3/library/smtplib.html)
- [Python官方文档 - email](https://docs.python.org/3/library/email.html)
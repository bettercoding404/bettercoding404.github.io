---
title: "使用Python发送邮件：从基础到最佳实践"
description: "在现代编程应用中，通过代码发送邮件是一项非常实用的功能。Python作为一种功能强大且简洁易用的编程语言，提供了丰富的库来实现发送邮件的操作。无论是用于通知系统、自动化报告，还是与用户进行交互，掌握在Python中发送邮件的技术都能为开发者带来极大的便利。本文将深入探讨在Python中发送邮件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在现代编程应用中，通过代码发送邮件是一项非常实用的功能。Python作为一种功能强大且简洁易用的编程语言，提供了丰富的库来实现发送邮件的操作。无论是用于通知系统、自动化报告，还是与用户进行交互，掌握在Python中发送邮件的技术都能为开发者带来极大的便利。本文将深入探讨在Python中发送邮件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技术。

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
    - **错误处理与日志记录**
5. **小结**
6. **参考资料**

## 基础概念
在Python中发送邮件主要借助`smtplib`库（Simple Mail Transfer Protocol Library），它提供了一个简单的接口来与SMTP服务器进行通信。SMTP是一种用于传输电子邮件的标准协议，它负责将邮件从发送者的邮件服务器传输到接收者的邮件服务器。另外，`email`库用于构建邮件内容，包括邮件头、正文、附件等部分。

## 使用方法
### 使用`smtplib`库发送简单邮件
以下是一个使用`smtplib`库发送简单文本邮件的基本示例：

```python
import smtplib
from email.mime.text import MIMEText

# 邮件内容
msg = MIMEText('这是一封测试邮件的正文内容。', 'plain', 'utf-8')

# 发件人、收件人、邮件主题
msg['Subject'] = '测试邮件'
msg['From'] ='sender@example.com'
msg['To'] ='recipient@example.com'

# 连接SMTP服务器并发送邮件
try:
    # 连接到SMTP服务器，这里以Gmail为例
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login('sender@example.com', 'password')
    server.sendmail('sender@example.com','recipient@example.com', msg.as_string())
    server.quit()
    print('邮件发送成功')
except Exception as e:
    print(f'邮件发送失败: {e}')
```

### 发送带附件的邮件
要发送带附件的邮件，需要使用`email.mime.multipart`和`email.mime.application`模块。以下是示例代码：

```python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication

# 创建一个带附件的邮件实例
msg = MIMEMultipart()
msg['Subject'] = '带附件的测试邮件'
msg['From'] ='sender@example.com'
msg['To'] ='recipient@example.com'

# 邮件正文
body = '这是带附件邮件的正文内容。'
msg.attach(MIMEText(body, 'plain', 'utf-8'))

# 添加附件
with open('attachment.txt', 'rb') as file:
    part = MIMEApplication(file.read(), Name='attachment.txt')
    part['Content-Disposition'] = f'attachment; filename="attachment.txt"'
    msg.attach(part)

# 连接并发送邮件
try:
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login('sender@example.com', 'password')
    server.sendmail('sender@example.com','recipient@example.com', msg.as_string())
    server.quit()
    print('邮件发送成功')
except Exception as e:
    print(f'邮件发送失败: {e}')
```

## 常见实践
### 自动化邮件发送
在实际应用中，常常需要根据一定的时间间隔或事件触发自动发送邮件。可以使用`schedule`库来实现定时任务，结合上述发送邮件的代码实现自动化邮件发送。

```python
import schedule
import time
import smtplib
from email.mime.text import MIMEText

def send_daily_email():
    msg = MIMEText('这是每天定时发送的邮件内容。', 'plain', 'utf-8')
    msg['Subject'] = '每日定时邮件'
    msg['From'] ='sender@example.com'
    msg['To'] ='recipient@example.com'

    try:
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login('sender@example.com', 'password')
        server.sendmail('sender@example.com','recipient@example.com', msg.as_string())
        server.quit()
        print('每日邮件发送成功')
    except Exception as e:
        print(f'每日邮件发送失败: {e}')

# 每天早上8点发送邮件
schedule.every().day.at("08:00").do(send_daily_email)

while True:
    schedule.run_pending()
    time.sleep(1)
```

### 根据条件发送邮件
根据程序运行的结果或某些特定条件来决定是否发送邮件也是常见的需求。例如，当某个任务执行失败时发送通知邮件。

```python
import smtplib
from email.mime.text import MIMEText

def check_and_send_email(task_result):
    if not task_result:
        msg = MIMEText('任务执行失败，请检查相关情况。', 'plain', 'utf-8')
        msg['Subject'] = '任务失败通知'
        msg['From'] ='sender@example.com'
        msg['To'] ='recipient@example.com'

        try:
            server = smtplib.SMTP('smtp.gmail.com', 587)
            server.starttls()
            server.login('sender@example.com', 'password')
            server.sendmail('sender@example.com','recipient@example.com', msg.as_string())
            server.quit()
            print('任务失败邮件发送成功')
        except Exception as e:
            print(f'任务失败邮件发送失败: {e}')

# 模拟任务结果
task_result = False
check_and_send_email(task_result)
```

## 最佳实践
### 安全问题
- **使用加密连接**：始终使用`starttls()`方法或直接使用SSL连接（如`smtplib.SMSSL`）来加密与SMTP服务器的通信，防止邮件内容和登录信息被窃取。
- **环境变量存储密码**：不要在代码中硬编码邮件账户的密码，而是将密码存储在环境变量中，在运行时读取。例如：
```python
import os
password = os.environ.get('EMAIL_PASSWORD')
```

### 邮件内容格式化
- **使用HTML格式**：如果需要发送更丰富的邮件内容，可以使用HTML格式。将`MIMEText`的第二个参数设置为`html`，并编写HTML代码作为邮件正文。
```python
html = """
<html>
  <body>
    <p>这是一封HTML格式的邮件。</p>
    <a href="https://example.com">点击链接</a>
  </body>
</html>
"""
msg = MIMEText(html, 'html', 'utf-8')
```

### 错误处理与日志记录
- **详细的错误处理**：在发送邮件时，要捕获各种可能的异常，并提供详细的错误信息，以便于调试。
- **日志记录**：使用Python的`logging`库记录邮件发送的过程和结果，包括成功和失败的情况，方便后续排查问题。
```python
import logging

logging.basicConfig(filename='email_sending.log', level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')

try:
    # 发送邮件代码
    logging.info('邮件发送成功')
except Exception as e:
    logging.error(f'邮件发送失败: {e}')
```

## 小结
本文详细介绍了在Python中发送邮件的相关知识，从基础概念入手，讲解了使用`smtplib`和`email`库发送简单邮件和带附件邮件的方法。接着通过常见实践展示了自动化邮件发送和根据条件发送邮件的应用场景。最后，阐述了在实际应用中需要注意的最佳实践，包括安全问题、邮件内容格式化以及错误处理与日志记录。通过学习这些内容，读者能够全面掌握在Python中发送邮件的技术，并在自己的项目中灵活运用。

## 参考资料
- [Python官方文档 - smtplib](https://docs.python.org/3/library/smtplib.html){: rel="nofollow"}
- [Python官方文档 - email](https://docs.python.org/3/library/email.html){: rel="nofollow"}
- [schedule库文档](https://schedule.readthedocs.io/en/stable/){: rel="nofollow"}
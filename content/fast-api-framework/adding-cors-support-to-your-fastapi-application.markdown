---
title: "Adding CORS Support to Your FastAPI Application"
description: "
In modern web development, applications often need to communicate with servers across different origins. Cross - Origin Resource Sharing (CORS) is a mechanism that allows restricted resources on a web page to be requested from another domain outside the domain from which the first resource was served. FastAPI, a modern, fast (high-performance) web framework for building APIs with Python, provides straightforward ways to add CORS support. This blog post will guide you through the fundamental concepts, usage methods, common practices, and best practices of adding CORS support to your FastAPI application.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [What is CORS?](#what-is-cors)
2. [Why Do You Need CORS in FastAPI?](#why-do-you-need-cors-in-fastapi)
3. [Adding CORS Support to a FastAPI Application](#adding-cors-support-to-a-fastapi-application)
    - [Installation](#installation)
    - [Basic Example](#basic-example)
4. [Common Practices](#common-practices)
    - [Configuring Allowed Origins](#configuring-allowed-origins)
    - [Handling HTTP Methods and Headers](#handling-http-methods-and-headers)
5. [Best Practices](#best-practices)
    - [Security Considerations](#security-considerations)
    - [Testing CORS Configuration](#testing-cors-configuration)
6. [Conclusion](#conclusion)
7. [References](#references)

## What is CORS?
Cross - Origin Resource Sharing (CORS) is an HTTP - header based mechanism that allows a server to indicate any origins (domain, scheme, or port) other than its own from which a browser should permit loading resources. When a browser makes a cross - origin request (a request to a different origin than the one serving the current page), it enforces the same - origin policy by default, which restricts such requests for security reasons. CORS provides a way to relax these restrictions in a controlled manner.

## Why Do You Need CORS in FastAPI?
If you are building a FastAPI application that serves as an API and is consumed by a front - end application running on a different domain, browser security mechanisms will block the requests unless CORS is properly configured. For example, if your FastAPI API is running on `http://api.example.com` and your front - end is on `http://app.example.com`, without CORS support, the browser will prevent the front - end from making requests to the API.

## Adding CORS Support to a FastAPI Application

### Installation
First, make sure you have FastAPI and Uvicorn (a server for running FastAPI applications) installed. If not, you can install them using `pip`:
```bash
pip install fastapi uvicorn
```

### Basic Example
Here is a simple example of adding CORS support to a FastAPI application:
```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# List of allowed origins
origins = [
    "http://localhost:3000",  # Example: a local React app
]

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def read_root():
    return {"Hello": "World"}
```
To run the application, save the above code in a file named `main.py` and run the following command in the terminal:
```bash
uvicorn main:app --reload
```

## Common Practices

### Configuring Allowed Origins
The `allow_origins` parameter in the `CORSMiddleware` is a list of origins that are allowed to make cross - origin requests to your FastAPI application. You should be as specific as possible when defining the allowed origins. For example, instead of using `["*"]` (which allows all origins), you can list only the domains that your application expects to receive requests from:
```python
origins = [
    "http://example.com",
    "https://example.com",
    "http://subdomain.example.com"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    # Other parameters...
)
```

### Handling HTTP Methods and Headers
The `allow_methods` parameter specifies which HTTP methods are allowed in cross - origin requests. You can list specific methods like `["GET", "POST", "PUT", "DELETE"]` or use `"*"` to allow all methods. Similarly, the `allow_headers` parameter defines which headers are allowed in cross - origin requests. You can use `"*"` to allow all headers, but in a production environment, it's better to list only the necessary headers:
```python
app.add_middleware(
    CORSMiddleware,
    # Other parameters...
    allow_methods=["GET", "POST"],
    allow_headers=["Content-Type", "Authorization"]
)
```

## Best Practices

### Security Considerations
- **Limit Allowed Origins**: As mentioned earlier, avoid using `["*"]` for `allow_origins` in production. This can expose your API to potential security risks, such as cross - site scripting (XSS) attacks.
- **Use HTTPS**: Always use HTTPS for both your API and front - end applications. This helps to protect the data transmitted between the client and the server and is a best practice for overall web security.
- **Restrict Headers and Methods**: Only allow the necessary HTTP methods and headers. For example, if your API only uses `GET` and `POST` requests, don't allow other methods like `PUT` or `DELETE` unless they are actually needed.

### Testing CORS Configuration
- **Use Browser Developer Tools**: You can use the browser's developer tools (such as Chrome DevTools) to check if CORS requests are working correctly. Look for CORS - related error messages in the console.
- **Automated Testing**: Write automated tests for your API endpoints to ensure that CORS is configured correctly. You can use testing frameworks like `pytest` to send cross - origin requests and verify the responses.

## Conclusion
Adding CORS support to your FastAPI application is essential when you need to allow cross - origin requests. By following the concepts, usage methods, common practices, and best practices outlined in this blog post, you can ensure that your API is accessible to the intended front - end applications while maintaining a high level of security. Remember to be specific with your CORS configuration, test thoroughly, and follow web security best practices.

## References
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [MDN Web Docs - Cross - Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
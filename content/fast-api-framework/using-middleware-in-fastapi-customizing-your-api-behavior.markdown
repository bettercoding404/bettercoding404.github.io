---
title: "Using Middleware in FastAPI: Customizing Your API Behavior"
description: "
FastAPI is a modern, fast (high-performance), web framework for building APIs with Python 3.7+ based on standard Python type hints. One of the powerful features that FastAPI offers is middleware. Middleware allows you to perform operations on requests before they reach the route handlers and on responses before they are sent back to the client. This gives you the ability to customize and enhance the behavior of your API in a flexible and modular way. In this blog post, we will explore the fundamental concepts, usage methods, common practices, and best practices of using middleware in FastAPI.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Fundamental Concepts of Middleware in FastAPI](#fundamental-concepts-of-middleware-in-fastapi)
2. [Usage Methods of Middleware in FastAPI](#usage-methods-of-middleware-in-fastapi)
3. [Common Practices with Middleware](#common-practices-with-middleware)
4. [Best Practices for Using Middleware in FastAPI](#best-practices-for-using-middleware-in-fastapi)
5. [Conclusion](#conclusion)
6. [References](#references)

## Fundamental Concepts of Middleware in FastAPI
### What is Middleware?
Middleware is a piece of code that sits between the client and the route handlers in your application. It can intercept requests and responses at various stages of the request - response cycle. In FastAPI, middleware can be used for tasks such as authentication, logging, error handling, and modifying request or response headers.

### How Middleware Works in FastAPI
FastAPI uses the `ASGI` (Asynchronous Server Gateway Interface) standard. Middleware in FastAPI is an ASGI application. When a request comes in, it passes through all the middleware in the order they are defined. Each middleware can perform operations on the request, call the next middleware in the chain, and then perform operations on the response before sending it back to the client.

## Usage Methods of Middleware in FastAPI
### Using Built - in Middleware
FastAPI provides some built - in middleware that you can use out of the box. For example, the `CORSMiddleware` is used to handle Cross - Origin Resource Sharing (CORS).

Here is an example of using `CORSMiddleware`:
```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# List of origins that are allowed to make cross - origin requests
origins = [
    "http://localhost",
    "http://localhost:8080",
]

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
In this example, we first import the `CORSMiddleware` from `fastapi.middleware.cors`. Then we define a list of allowed origins. Finally, we add the `CORSMiddleware` to our FastAPI application using the `add_middleware` method.

### Creating Custom Middleware
You can also create your own custom middleware. Here is an example of a simple custom middleware that logs the request method and URL:
```python
from fastapi import FastAPI, Request
import logging

app = FastAPI()

# Configure logging
logging.basicConfig(level=logging.INFO)


@app.middleware("http")
async def log_requests(request: Request, call_next):
    logging.info(f"Request received: {request.method} {request.url}")
    response = await call_next(request)
    return response


@app.get("/")
def read_root():
    return {"Hello": "World"}

```
In this example, we define a function `log_requests` decorated with `@app.middleware("http")`. This function takes a `Request` object and a `call_next` function as parameters. The `call_next` function is used to call the next middleware or the route handler. We log the request method and URL before calling `call_next` and then return the response.

## Common Practices with Middleware
### Authentication Middleware
One of the most common uses of middleware is for authentication. You can create a middleware that checks if the request contains a valid authentication token.

```python
from fastapi import FastAPI, Request, HTTPException

app = FastAPI()


@app.middleware("http")
async def authenticate(request: Request, call_next):
    token = request.headers.get("Authorization")
    if not token or token != "Bearer valid_token":
        raise HTTPException(status_code=401, detail="Unauthorized")
    response = await call_next(request)
    return response


@app.get("/protected")
def protected_route():
    return {"message": "This is a protected route"}

```
In this example, the middleware checks if the `Authorization` header is present and if it contains a valid token. If not, it raises a `401 Unauthorized` error.

### Logging Middleware
As shown in the previous example, logging middleware can be used to log information about requests and responses. This can be useful for debugging and monitoring purposes.

### Error Handling Middleware
You can create a middleware to handle errors globally in your application.

```python
from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import JSONResponse

app = FastAPI()


@app.middleware("http")
async def error_handling(request: Request, call_next):
    try:
        response = await call_next(request)
        return response
    except HTTPException as e:
        return JSONResponse(status_code=e.status_code, content={"detail": e.detail})
    except Exception as e:
        return JSONResponse(status_code=500, content={"detail": "Internal Server Error"})


@app.get("/error")
def raise_error():
    raise ValueError("This is a sample error")

```
In this example, the middleware catches all exceptions that occur during the request - response cycle. If it is an `HTTPException`, it returns a JSON response with the appropriate status code and detail. Otherwise, it returns a `500 Internal Server Error` response.

## Best Practices for Using Middleware in FastAPI
### Keep Middleware Simple and Focused
Each middleware should have a single responsibility. For example, an authentication middleware should only handle authentication, and a logging middleware should only handle logging. This makes your code more modular and easier to maintain.

### Use Asynchronous Middleware
Since FastAPI is an asynchronous framework, using asynchronous middleware can improve the performance of your application. Make sure to use `async` and `await` appropriately in your middleware functions.

### Order of Middleware Matters
The order in which you add middleware to your application matters. Middleware is executed in the order they are added. For example, if you have an authentication middleware and a logging middleware, you may want to add the authentication middleware first so that you don't log requests that are not authenticated.

## Conclusion
Middleware in FastAPI is a powerful feature that allows you to customize and enhance the behavior of your API. By using built - in middleware and creating your own custom middleware, you can perform tasks such as authentication, logging, and error handling in a modular and efficient way. Following the best practices, such as keeping middleware simple, using asynchronous code, and paying attention to the order of middleware, will help you build robust and high - performance APIs.

## References
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [ASGI Documentation](https://asgi.readthedocs.io/en/latest/)
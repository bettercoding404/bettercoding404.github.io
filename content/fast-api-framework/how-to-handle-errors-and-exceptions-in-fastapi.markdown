---
title: "How to Handle Errors and Exceptions in FastAPI"
description: "
FastAPI is a modern, fast (high-performance), web framework for building APIs with Python 3.7+ based on standard Python type hints. When developing applications, errors and exceptions are inevitable. Proper error and exception handling is crucial for providing a good user experience and ensuring the stability of the application. In this blog, we will explore how to handle errors and exceptions in FastAPI, covering fundamental concepts, usage methods, common practices, and best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. Fundamental Concepts
2. Usage Methods
    - Using `HTTPException`
    - Custom Exception Handlers
3. Common Practices
    - Error Logging
    - Returning Consistent Error Responses
4. Best Practices
    - Centralized Error Handling
    - Error Handling for Third - Party Services
5. Conclusion
6. References

## Fundamental Concepts
In FastAPI, errors and exceptions can be classified into two main types:
- **HTTP Exceptions**: These are exceptions that are related to HTTP status codes. For example, a `404 Not Found` error when a requested resource does not exist, or a `401 Unauthorized` error when a user tries to access a protected resource without proper authentication.
- **Python Exceptions**: These are general Python exceptions such as `ValueError`, `TypeError`, etc. that can occur during the execution of your application code.

When an exception occurs in FastAPI, it needs to be handled in a way that returns an appropriate HTTP response to the client.

## Usage Methods

### Using `HTTPException`
FastAPI provides a built - in `HTTPException` class that can be used to raise HTTP errors easily. Here is a simple example:

```python
from fastapi import FastAPI, HTTPException

app = FastAPI()

items = {"foo": "The Foo Wrestlers"}


@app.get("/items/{item_id}")
async def read_item(item_id: str):
    if item_id not in items:
        raise HTTPException(status_code=404, detail="Item not found")
    return {"item": items[item_id]}

```

In this example, if the requested `item_id` is not in the `items` dictionary, a `404` HTTP exception is raised with a custom error message.

### Custom Exception Handlers
You can also define custom exception handlers to handle specific types of exceptions. Here is an example of handling a custom `ValueError`:

```python
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse

app = FastAPI()


class CustomValueError(ValueError):
    pass


@app.exception_handler(CustomValueError)
async def custom_value_error_handler(request: Request, exc: CustomValueError):
    return JSONResponse(
        status_code=400,
        content={"message": f"Custom Value Error: {str(exc)}"}
    )


@app.get("/trigger_error")
async def trigger_error():
    raise CustomValueError("This is a custom value error")

```

In this code, we define a custom `ValueError` class `CustomValueError` and a custom exception handler `custom_value_error_handler`. When the `trigger_error` endpoint is called, it raises a `CustomValueError`, and the custom exception handler returns a JSON response with a `400` status code.

## Common Practices

### Error Logging
Logging errors is an important practice to help with debugging and monitoring. You can use the built - in Python `logging` module to log errors. Here is an example:

```python
import logging
from fastapi import FastAPI, HTTPException

app = FastAPI()

logging.basicConfig(level=logging.ERROR)


@app.get("/error_logging_example")
async def error_logging_example():
    try:
        result = 1 / 0
        return result
    except ZeroDivisionError as e:
        logging.error(f"Zero division error: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")

```

In this example, when a `ZeroDivisionError` occurs, the error is logged, and a `500` HTTP exception is raised.

### Returning Consistent Error Responses
It is a good practice to return consistent error responses to the client. For example, you can define a standard error response structure:

```python
from fastapi import FastAPI, HTTPException

app = FastAPI()


def get_error_response(status_code: int, message: str):
    return {
        "status": "error",
        "status_code": status_code,
        "message": message
    }


@app.get("/consistent_error_example")
async def consistent_error_example():
    try:
        result = 1 / 0
        return result
    except ZeroDivisionError:
        status_code = 500
        message = "Internal server error"
        return get_error_response(status_code, message)

```

## Best Practices

### Centralized Error Handling
Instead of handling errors in each individual route, you can implement centralized error handling. This makes the code more maintainable. Here is an example:

```python
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
import logging

app = FastAPI()

logging.basicConfig(level=logging.ERROR)


@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logging.error(f"Global exception: {exc}")
    return JSONResponse(
        status_code=500,
        content={"status": "error", "status_code": 500, "message": "Internal server error"}
    )


@app.get("/centralized_error_example")
async def centralized_error_example():
    result = 1 / 0
    return result

```

In this code, the `global_exception_handler` catches all unhandled exceptions and returns a consistent error response.

### Error Handling for Third - Party Services
When using third - party services, it is important to handle errors gracefully. For example, if you are making an HTTP request to a third - party API:

```python
import requests
from fastapi import FastAPI, HTTPException

app = FastAPI()


@app.get("/third_party_api_example")
async def third_party_api_example():
    try:
        response = requests.get("https://nonexistentapi.com")
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        raise HTTPException(status_code=503, detail=f"Third - party API error: {str(e)}")

```

## Conclusion
Proper error and exception handling in FastAPI is essential for building robust and user - friendly applications. By understanding the fundamental concepts, using the built - in `HTTPException` class, defining custom exception handlers, following common practices like error logging and consistent error responses, and implementing best practices such as centralized error handling and handling third - party service errors, you can ensure that your application can handle errors gracefully and provide useful feedback to the users.

## References
- FastAPI official documentation: https://fastapi.tiangolo.com/
- Python official documentation: https://docs.python.org/3/
- Requests library documentation: https://requests.readthedocs.io/en/latest/
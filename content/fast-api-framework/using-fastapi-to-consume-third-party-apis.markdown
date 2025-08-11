---
title: "Using FastAPI to Consume Third Party APIs"
description: "
In the modern software development landscape, integrating with third - party APIs has become a common practice. Third - party APIs provide a wealth of functionality, such as accessing social media data, weather information, payment gateways, etc. FastAPI is a modern, fast (high - performance) web framework for building APIs with Python. It leverages Python's type hints to provide automatic data validation, serialization, and documentation. In this blog, we will explore how to use FastAPI to consume third - party APIs effectively.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. Fundamental Concepts
2. Prerequisites
3. Setting up a FastAPI Project
4. Making API Calls in FastAPI
5. Handling Responses
6. Error Handling
7. Common Practices
8. Best Practices
9. Conclusion
10. References

## 1. Fundamental Concepts

### What is an API?
An API (Application Programming Interface) is a set of rules and protocols that allows different software applications to communicate with each other. Third - party APIs are APIs provided by external organizations or services. For example, the Twitter API allows developers to access Twitter data and perform actions like posting tweets or retrieving user information.

### What is FastAPI?
FastAPI is a web framework for building APIs in Python. It is built on top of Starlette for the web parts and Pydantic for data handling. FastAPI uses Python type hints to validate input data, serialize output data, and generate interactive API documentation.

### Why use FastAPI to consume third - party APIs?
- **High Performance**: FastAPI is designed to be extremely fast, which is crucial when making multiple API calls.
- **Type - Based Validation**: It uses Python type hints for data validation, making it easier to handle and validate the data received from third - party APIs.
- **Automatic Documentation**: FastAPI automatically generates interactive API documentation, which is useful for both developers and consumers of the API.

## 2. Prerequisites
- **Python**: You need to have Python 3.7 or higher installed on your system.
- **FastAPI and Uvicorn**: Install them using `pip install fastapi uvicorn`.
- **Requests Library**: This library is used to make HTTP requests to third - party APIs. Install it using `pip install requests`.

## 3. Setting up a FastAPI Project

Create a new Python file, for example, `main.py`.

```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


```

To run the FastAPI application, use the following command in the terminal:

```bash
uvicorn main:app --reload
```

Now you can access the API at `http://127.0.0.1:8000`.

## 4. Making API Calls in FastAPI

Let's assume we want to consume the JSONPlaceholder API, which provides fake data for testing and prototyping.

```python
from fastapi import FastAPI
import requests

app = FastAPI()


@app.get("/posts")
def get_posts():
    url = "https://jsonplaceholder.typicode.com/posts"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json()
    return {"error": "Failed to fetch data"}


```

In this example, we define a route `/posts` in our FastAPI application. When a user accesses this route, the application makes a GET request to the JSONPlaceholder API's `/posts` endpoint. If the request is successful (status code 200), it returns the JSON data from the response. Otherwise, it returns an error message.

## 5. Handling Responses

The `requests` library provides several methods to handle responses.

```python
from fastapi import FastAPI
import requests

app = FastAPI()


@app.get("/posts/{post_id}")
def get_post(post_id: int):
    url = f"https://jsonplaceholder.typicode.com/posts/{post_id}"
    response = requests.get(url)
    if response.status_code == 200:
        post = response.json()
        return {
            "id": post["id"],
            "title": post["title"],
            "body": post["body"]
        }
    elif response.status_code == 404:
        return {"error": "Post not found"}
    return {"error": "An unexpected error occurred"}


```

In this example, we are getting a single post by its ID. We handle different status codes: if the post is found (status code 200), we return the relevant information. If the post is not found (status code 404), we return an appropriate error message.

## 6. Error Handling

When consuming third - party APIs, errors can occur due to various reasons such as network issues, invalid API keys, or rate limits.

```python
from fastapi import FastAPI
import requests

app = FastAPI()


@app.get("/external_api")
def call_external_api():
    try:
        url = "https://example.com/api"
        response = requests.get(url)
        response.raise_for_status()  # Raise an exception for 4xx and 5xx status codes
        return response.json()
    except requests.exceptions.HTTPError as http_err:
        return {"error": f"HTTP error occurred: {http_err}"}
    except requests.exceptions.RequestException as req_err:
        return {"error": f"Request error occurred: {req_err}"}


```

In this code, we use `try - except` blocks to catch different types of errors. `requests.exceptions.HTTPError` is used to handle HTTP errors, and `requests.exceptions.RequestException` is a more general exception for other request - related errors.

## 7. Common Practices

### Caching
If the data from the third - party API doesn't change frequently, you can implement caching to reduce the number of API calls. You can use libraries like `cachetools` in Python.

```python
import requests
from cachetools import TTLCache

cache = TTLCache(maxsize=100, ttl=3600)


def get_cached_api_data(url):
    if url in cache:
        return cache[url]
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        cache[url] = data
        return data
    return None


```

### Rate Limiting
Some third - party APIs have rate limits. You need to implement rate - limiting in your application to avoid getting blocked. You can use libraries like `ratelimit` in Python.

```python
from ratelimit import limits, sleep_and_retry

CALLS = 15
PERIOD = 60


@sleep_and_retry
@limits(calls=CALLS, period=PERIOD)
def call_api(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response.json()
    return None


```

## 8. Best Practices

### Use Asynchronous Programming
FastAPI supports asynchronous programming. When making multiple API calls, using asynchronous programming can significantly improve performance.

```python
from fastapi import FastAPI
import asyncio
import aiohttp

app = FastAPI()


async def fetch(session, url):
    async with session.get(url) as response:
        if response.status == 200:
            return await response.json()
        return None


@app.get("/async_posts")
async def get_async_posts():
    url = "https://jsonplaceholder.typicode.com/posts"
    async with aiohttp.ClientSession() as session:
        tasks = [fetch(session, url)]
        results = await asyncio.gather(*tasks)
        return results


```

### Secure API Keys
If the third - party API requires an API key, make sure to store it securely. You can use environment variables to store sensitive information.

```python
import os
import requests

api_key = os.getenv("API_KEY")
url = f"https://example.com/api?api_key={api_key}"
response = requests.get(url)


```

## 9. Conclusion
Using FastAPI to consume third - party APIs is a powerful and efficient way to integrate external services into your applications. FastAPI's high performance, type - based validation, and automatic documentation make it a great choice for building API - consuming applications. By following the common and best practices, such as caching, rate - limiting, asynchronous programming, and secure key management, you can build robust and reliable applications.

## 10. References
- FastAPI Documentation: https://fastapi.tiangolo.com/
- Requests Library Documentation: https://docs.python - requests.org/en/latest/
- JSONPlaceholder API: https://jsonplaceholder.typicode.com/
---
title: "FastAPI Development with Docker: A Complete Guide"
description: "
FastAPI is a modern, fast (high-performance) web framework for building APIs with Python based on standard Python type hints. Docker, on the other hand, is a platform that enables developers to build, deploy, and run applications inside containers. Combining FastAPI with Docker provides a powerful and efficient way to develop, test, and deploy web applications. This guide will take you through the entire process of developing a FastAPI application with Docker, from basic concepts to best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Fundamental Concepts](#fundamental-concepts)
    - [What is FastAPI?](#what-is-fastapi)
    - [What is Docker?](#what-is-docker)
    - [Why Combine FastAPI and Docker?](#why-combine-fastapi-and-docker)
2. [Setting Up a FastAPI Application](#setting-up-a-fastapi-application)
    - [Installing Dependencies](#installing-dependencies)
    - [Creating a Basic FastAPI App](#creating-a-basic-fastapi-app)
3. [Dockerizing the FastAPI Application](#dockerizing-the-fastapi-application)
    - [Writing a Dockerfile](#writing-a-dockerfile)
    - [Building the Docker Image](#building-the-docker-image)
    - [Running the Docker Container](#running-the-docker-container)
4. [Common Practices](#common-practices)
    - [Managing Environment Variables](#managing-environment-variables)
    - [Volume Mounting for Development](#volume-mounting-for-development)
5. [Best Practices](#best-practices)
    - [Optimizing Docker Images](#optimizing-docker-images)
    - [Security Considerations](#security-considerations)
6. [Conclusion](#conclusion)
7. [References](#references)

## Fundamental Concepts

### What is FastAPI?
FastAPI is a web framework for building APIs in Python. It leverages Python's type hints to provide automatic data validation, serialization, and documentation generation. FastAPI is built on top of Starlette for the web handling and Pydantic for data validation. It offers high performance, easy development, and great developer experience.

### What is Docker?
Docker is an open - source platform that uses containerization technology. Containers are lightweight, isolated environments that package an application and all its dependencies together. Docker allows developers to build, ship, and run applications consistently across different environments.

### Why Combine FastAPI and Docker?
- **Portability**: Docker ensures that the FastAPI application can run the same way on different machines, whether it's a developer's local machine, a testing server, or a production environment.
- **Isolation**: Each FastAPI application can be run in its own container, preventing conflicts between different applications and their dependencies.
- **Scalability**: Docker makes it easy to scale the FastAPI application by running multiple containers of the same application.

## Setting Up a FastAPI Application

### Installing Dependencies
First, create a virtual environment and activate it. Then, install FastAPI and Uvicorn (a lightning - fast ASGI server for Python).
```bash
python -m venv myenv
source myenv/bin/activate  # For Linux/Mac
.\myenv\Scripts\activate  # For Windows
pip install fastapi uvicorn
```

### Creating a Basic FastAPI App
Create a file named `main.py` with the following code:
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

```
To run the application, use the following command:
```bash
uvicorn main:app --reload
```
Now you can access the application at `http://127.0.0.1:8000`.

## Dockerizing the FastAPI Application

### Writing a Dockerfile
Create a file named `Dockerfile` in the root directory of your project.
```Dockerfile
# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org fastapi uvicorn

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

```

### Building the Docker Image
Run the following command in the terminal to build the Docker image:
```bash
docker build -t fastapi-docker .
```
The `-t` flag tags the image with the name `fastapi - docker`, and the `.` at the end indicates that the build context is the current directory.

### Running the Docker Container
After the image is built, run the container using the following command:
```bash
docker run -p 8000:8000 fastapi-docker
```
The `-p` flag maps the port 8000 on the host machine to the port 8000 in the container. Now you can access the FastAPI application at `http://127.0.0.1:8000` as before.

## Common Practices

### Managing Environment Variables
In a real - world scenario, you may need to manage different environment variables for different environments. You can pass environment variables to the Docker container using the `-e` flag.
```bash
docker run -p 8000:8000 -e ENVIRONMENT=production fastapi-docker
```
In your FastAPI application, you can access these environment variables using the `os` module:
```python
import os
from fastapi import FastAPI

app = FastAPI()

environment = os.getenv("ENVIRONMENT", "development")

@app.get("/")
def read_root():
    return {"Environment": environment}

```

### Volume Mounting for Development
During development, you may want to make changes to your code and see the changes reflected in the running container immediately. You can use volume mounting to achieve this.
```bash
docker run -p 8000:8000 -v $(pwd):/app fastapi-docker
```
The `-v` flag mounts the current directory (`$(pwd)` on Linux/Mac) to the `/app` directory in the container.

## Best Practices

### Optimizing Docker Images
- **Use Multi - Stage Builds**: Multi - stage builds allow you to create a smaller final image by separating the build environment from the runtime environment.
```Dockerfile
# Build stage
FROM python:3.9-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Runtime stage
FROM python:3.9-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

```
- **Minimize Layers**: Each line in the Dockerfile creates a new layer. Try to combine multiple commands into a single `RUN` statement to reduce the number of layers.

### Security Considerations
- **Use Official Base Images**: Always use official Docker images as the base for your containers. They are regularly updated and more secure.
- **Limit Container Privileges**: Run the container with the minimum necessary privileges. Avoid running the container as the root user.

## Conclusion
Combining FastAPI and Docker provides a powerful and efficient way to develop, test, and deploy web applications. By following the steps and best practices outlined in this guide, you can build a highly portable, scalable, and secure FastAPI application using Docker. Whether you are a beginner or an experienced developer, this combination will help you streamline your development process and ensure the success of your projects.

## References
- FastAPI Documentation: https://fastapi.tiangolo.com/
- Docker Documentation: https://docs.docker.com/
- Python Official Documentation: https://docs.python.org/3/
---
title: "Python FastAPI：构建高效 API 的利器"
description: "在当今的软件开发领域，构建快速、高效且易于维护的 API 至关重要。Python 的 FastAPI 框架应运而生，它基于 Python 的类型提示功能，能够快速地开发 API，同时保证高性能和代码的可读性。本文将深入探讨 FastAPI 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一强大的框架。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在当今的软件开发领域，构建快速、高效且易于维护的 API 至关重要。Python 的 FastAPI 框架应运而生，它基于 Python 的类型提示功能，能够快速地开发 API，同时保证高性能和代码的可读性。本文将深入探讨 FastAPI 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一强大的框架。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 安装 FastAPI
    - 第一个 FastAPI 应用
    - 路径参数与查询参数
    - 请求体与响应体
3. 常见实践
    - 数据库交互
    - 认证与授权
    - 错误处理
4. 最佳实践
    - 代码结构优化
    - 性能优化
    - 测试策略
5. 小结
6. 参考资料

## 基础概念
FastAPI 是一个基于 Python 的现代、快速（高性能）的 Web 框架，用于构建 API。它基于 Python 3.6+ 的类型提示功能，利用 Pydantic 库进行数据验证和解析。这使得代码更加清晰、易读，并且能够在开发过程中捕获更多的错误。FastAPI 使用异步编程（`async`/`await`）来提高性能，并且兼容 Uvicorn 等高性能的 ASGI 服务器。

## 使用方法
### 安装 FastAPI
首先，确保你已经安装了 Python 3.6 或更高版本。然后使用 `pip` 安装 FastAPI 和 Uvicorn（一个 ASGI 服务器）：
```bash
pip install fastapi uvicorn
```

### 第一个 FastAPI 应用
创建一个新的 Python 文件，例如 `main.py`，编写以下代码：
```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}
```
在终端中运行这个应用：
```bash
uvicorn main:app --reload
```
这里 `main` 是文件名，`app` 是 FastAPI 应用实例。`--reload` 选项让服务器在代码更改时自动重新加载。

### 路径参数与查询参数
路径参数可以在路径中定义，例如：
```python
@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```
查询参数则在 URL 中以键值对形式出现：
```python
@app.get("/items/")
async def read_item(q: str = None):
    if q:
        return {"q": q}
    return {"message": "No query parameter"}
```

### 请求体与响应体
使用 Pydantic 模型定义请求体：
```python
from pydantic import BaseModel


class Item(BaseModel):
    name: str
    price: float


@app.post("/items/")
async def create_item(item: Item):
    return item
```
响应体也可以使用 Pydantic 模型进行定义，以确保输出的格式正确。

## 常见实践
### 数据库交互
可以使用 SQLAlchemy 等库与数据库进行交互。例如，连接 SQLite 数据库并查询数据：
```python
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

engine = create_engine("sqlite:///./test.db")
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


class Item(Base):
    __tablename__ = "items"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    price = Column(Integer)


@app.get("/db-items/")
async def read_db_items():
    db = SessionLocal()
    try:
        items = db.query(Item).all()
        return items
    finally:
        db.close()
```

### 认证与授权
使用 `python-jose` 和 `passlib` 等库实现 JWT 认证：
```python
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from passlib.context import CryptContext

SECRET_KEY = "your-secret-key"
ALGORITHM = "HS256"
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password):
    return pwd_context.hash(password)


async def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Could not validate credentials",
                headers={"WWW-Authenticate": "Bearer"},
            )
        return username
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )


@app.get("/protected/")
async def protected_route(current_user: str = Depends(get_current_user)):
    return {"message": f"Hello, {current_user}"}
```

### 错误处理
自定义异常处理：
```python
from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse


class CustomException(Exception):
    def __init__(self, message: str):
        self.message = message


@app.exception_handler(CustomException)
async def custom_exception_handler(request, exc):
    return JSONResponse(
        status_code=400,
        content={"message": exc.message}
    )


@app.get("/custom-error/")
async def custom_error():
    raise CustomException("This is a custom error")
```

## 最佳实践
### 代码结构优化
将应用逻辑拆分成多个模块，例如路由、数据库操作、模型定义等。创建一个 `routers` 目录，每个路由模块放在其中，这样可以提高代码的可维护性和可扩展性。

### 性能优化
使用异步编程来充分利用 CPU 和 I/O 资源。在处理 I/O 密集型任务时，如数据库查询和网络请求，使用 `async`/`await` 可以显著提高性能。同时，合理使用缓存机制，减少重复计算和数据库查询。

### 测试策略
编写单元测试和集成测试，使用 `pytest` 等测试框架。对于 API 端点，可以使用 `TestClient` 来模拟 HTTP 请求并验证响应。例如：
```python
from fastapi.testclient import TestClient

client = TestClient(app)


def test_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}
```

## 小结
FastAPI 是一个功能强大的 Python 框架，它在构建 API 方面具有诸多优势，包括高性能、清晰的代码结构以及丰富的功能。通过掌握其基础概念、使用方法、常见实践和最佳实践，开发者能够快速构建出可靠、高效的 API 服务。

## 参考资料
- [FastAPI 官方文档](https://fastapi.tiangolo.com/){: rel="nofollow"}
- [Pydantic 官方文档](https://pydantic-docs.helpmanual.io/){: rel="nofollow"}
- [Uvicorn 官方文档](https://www.uvicorn.org/){: rel="nofollow"}
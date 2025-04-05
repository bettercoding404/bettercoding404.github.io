---
title: "Python FastAPI：高效构建 API 的利器"
description: "在当今的软件开发领域，API 的开发至关重要。Python 作为一种广泛应用的编程语言，拥有众多用于构建 API 的框架，FastAPI 便是其中一颗耀眼的明星。FastAPI 基于 Python 的类型提示功能，以其高效、简洁和强大的特性，使得 API 开发变得更加轻松和快速。本文将深入探讨 FastAPI 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一框架，提升 API 开发的效率与质量。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在当今的软件开发领域，API 的开发至关重要。Python 作为一种广泛应用的编程语言，拥有众多用于构建 API 的框架，FastAPI 便是其中一颗耀眼的明星。FastAPI 基于 Python 的类型提示功能，以其高效、简洁和强大的特性，使得 API 开发变得更加轻松和快速。本文将深入探讨 FastAPI 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一框架，提升 API 开发的效率与质量。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是 FastAPI
    - 为什么选择 FastAPI
2. **使用方法**
    - 安装 FastAPI
    - 快速入门示例
    - 路径操作
    - 请求体与响应体
    - 路径参数与查询参数
3. **常见实践**
    - 数据库连接与操作
    - 身份验证与授权
    - 日志记录
4. **最佳实践**
    - 项目结构设计
    - 错误处理
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
### 什么是 FastAPI
FastAPI 是一个用于构建 API 的现代、快速（高性能）的 Python 框架，基于 Python 的类型提示功能构建。它使用 `pydantic` 库进行数据验证和解析，利用 `starlette` 框架提供底层的 ASGI（Asynchronous Server Gateway Interface）支持，旨在提供高效且直观的 API 开发体验。

### 为什么选择 FastAPI
- **高性能**：得益于 ASGI 异步编程模型和高效的数据验证，FastAPI 能够处理大量并发请求，性能表现卓越。
- **简洁易用**：语法简洁，易于学习和上手，开发者可以快速构建出功能完备的 API。
- **类型提示**：基于 Python 的类型提示，增强了代码的可读性和可维护性，减少潜在的错误。
- **丰富的插件生态**：有众多的插件和工具可用于扩展功能，如数据库连接、身份验证等。

## 使用方法
### 安装 FastAPI
首先，确保你已经安装了 Python 3.7 或更高版本。然后使用 `pip` 安装 FastAPI 和 `uvicorn`（一个 ASGI 服务器，用于运行 FastAPI 应用）：
```bash
pip install fastapi uvicorn
```

### 快速入门示例
创建一个简单的 FastAPI 应用：
```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


```
保存为 `main.py`，然后在命令行中运行：
```bash
uvicorn main:app --reload
```
这里 `main` 是文件名，`app` 是 FastAPI 应用实例。`--reload` 选项让服务器在代码更改时自动重新加载，方便开发调试。

### 路径操作
路径操作是 FastAPI 中定义 API 端点的方式。使用装饰器如 `@app.get`、`@app.post`、`@app.put`、`@app.delete` 等来定义不同 HTTP 方法的端点。
```python
@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id}
```
在这个例子中，`/items/{item_id}` 是路径，`item_id` 是路径参数，类型为整数。

### 请求体与响应体
请求体用于接收客户端发送的数据，响应体则是 API 返回给客户端的数据。使用 `pydantic` 模型来定义请求体和响应体。
```python
from pydantic import BaseModel


class Item(BaseModel):
    name: str
    price: float


@app.post("/items/")
def create_item(item: Item):
    return item
```
这里 `Item` 是一个 `pydantic` 模型，定义了请求体的结构。`create_item` 函数接收一个 `Item` 类型的请求体，并将其作为响应体返回。

### 路径参数与查询参数
路径参数是 URL 路径中的一部分，而查询参数是 URL 中问号后面的键值对。
```python
@app.get("/items/")
def read_items(skip: int = 0, limit: int = 10):
    return {"skip": skip, "limit": limit}
```
在这个例子中，`skip` 和 `limit` 是查询参数，有默认值 0 和 10。

## 常见实践
### 数据库连接与操作
使用 `SQLAlchemy` 进行数据库连接和操作：
```python
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

engine = create_engine("sqlite:///./test.db")
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()


class Item(Base):
    __tablename__ = "items"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    price = Column(Integer)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.post("/items/")
def create_item(item: Item, db: Session = Depends(get_db)):
    db_item = Item(name=item.name, price=item.price)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item
```

### 身份验证与授权
使用 `python-jose` 和 `passlib` 进行 JWT（JSON Web Token）身份验证：
```python
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from passlib.context import CryptContext

SECRET_KEY = "your-secret-key"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password):
    return pwd_context.hash(password)


def create_access_token(data: dict):
    to_encode = data.copy()
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
        return username
    except JWTError:
        raise credentials_exception


@app.get("/protected/")
def protected_route(current_user: str = Depends(get_current_user)):
    return {"message": f"Hello, {current_user}"}
```

### 日志记录
使用 `logging` 模块进行日志记录：
```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@app.get("/")
def read_root():
    logger.info("Received a request at root endpoint")
    return {"Hello": "World"}
```

## 最佳实践
### 项目结构设计
推荐的项目结构如下：
```
project/
    ├── app/
    │   ├── __init__.py
    │   ├── main.py
    │   ├── models/
    │   │   ├── __init__.py
    │   │   └── item.py
    │   ├── schemas/
    │   │   ├── __init__.py
    │   │   └── item.py
    │   ├── routers/
    │   │   ├── __init__.py
    │   │   └── item.py
    │   ├── database.py
    │   └── config.py
    ├── tests/
    │   ├── __init__.py
    │   └── test_item.py
    ├── requirements.txt
    └── README.md
```
这样的结构使得代码组织清晰，易于维护和扩展。

### 错误处理
使用 FastAPI 的 `HTTPException` 和自定义异常处理：
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
def custom_error():
    raise CustomException("This is a custom error")
```

### 性能优化
- 使用异步编程：充分利用 FastAPI 的异步特性，提高应用的并发处理能力。
- 缓存数据：对于频繁访问的数据，可以使用缓存机制（如 Redis）来减少数据库查询次数。
- 优化数据库查询：使用合适的索引和数据库查询优化策略，提高数据库操作的效率。

## 小结
本文全面介绍了 Python FastAPI 框架，涵盖了基础概念、使用方法、常见实践和最佳实践。通过学习这些内容，读者能够快速上手 FastAPI 开发，构建高效、可靠且易于维护的 API。FastAPI 的强大功能和简洁设计使其成为 API 开发领域的优秀选择，希望读者能在实际项目中充分发挥其优势。

## 参考资料
- [FastAPI 官方文档](https://fastapi.tiangolo.com/){: rel="nofollow"}
- [《FastAPI - Modern, fast web APIs with Python》](https://www.oreilly.com/library/view/fastapi-modern-fast/9781098139929/){: rel="nofollow"}
- [《Python Web Development with FastAPI》](https://www.packtpub.com/product/python-web-development-with-fastapi/9781801072314){: rel="nofollow"}
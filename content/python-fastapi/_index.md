---
title: "Python FastAPI：构建高效 API 的利器"
description: "在当今的软件开发领域，API（Application Programming Interface）的开发至关重要。FastAPI 作为基于 Python 的一个现代、快速（高性能）的 Web 框架，专为构建 API 而设计。它利用 Python 的类型提示功能，结合强大的依赖注入系统和高性能的异步编程能力，能够让开发者快速且高效地创建健壮的 API。本文将深入探讨 FastAPI 的基础概念、使用方法、常见实践以及最佳实践，帮助你全面掌握并在项目中灵活运用 FastAPI。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在当今的软件开发领域，API（Application Programming Interface）的开发至关重要。FastAPI 作为基于 Python 的一个现代、快速（高性能）的 Web 框架，专为构建 API 而设计。它利用 Python 的类型提示功能，结合强大的依赖注入系统和高性能的异步编程能力，能够让开发者快速且高效地创建健壮的 API。本文将深入探讨 FastAPI 的基础概念、使用方法、常见实践以及最佳实践，帮助你全面掌握并在项目中灵活运用 FastAPI。

<!-- more -->
## 目录
1. **基础概念**
    - **什么是 FastAPI**
    - **主要特性**
2. **使用方法**
    - **安装 FastAPI**
    - **创建第一个 FastAPI 应用**
    - **路径操作**
    - **请求体与响应体**
    - **参数校验**
3. **常见实践**
    - **数据库连接与操作**
    - **处理文件上传**
    - **认证与授权**
4. **最佳实践**
    - **项目结构设计**
    - **日志记录与错误处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
### 什么是 FastAPI
FastAPI 是基于 Python 的 Web 框架，它基于 Python 3.6+ 并使用类型提示来提高代码的可读性和可维护性。它基于 Starlette 框架构建，提供了高性能的异步 I/O 支持，非常适合处理高并发的 API 应用场景。

### 主要特性
- **高效性能**：得益于异步编程和高性能的底层框架，能够快速处理大量请求。
- **类型提示**：利用 Python 的类型提示功能，使代码更清晰，减少错误，同时有助于 IDE 提供更好的代码补全和检查。
- **依赖注入**：强大的依赖注入系统，方便管理组件之间的依赖关系，提高代码的可测试性和可维护性。
- **自动生成文档**：基于 OpenAPI 规范自动生成交互式 API 文档，方便开发者和测试人员使用。

## 使用方法
### 安装 FastAPI
首先，确保你已经安装了 Python 环境。然后，可以使用 `pip` 安装 FastAPI 和 `uvicorn`（一个 ASGI 服务器，用于运行 FastAPI 应用）：
```bash
pip install fastapi uvicorn
```

### 创建第一个 FastAPI 应用
创建一个新的 Python 文件，例如 `main.py`，编写以下代码：
```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)

```
在上述代码中：
1. 导入 `FastAPI` 类并创建一个实例 `app`。
2. 使用 `@app.get("/")` 装饰器定义一个路径操作，当客户端发送 GET 请求到根路径 `"/"` 时，会执行 `read_root` 函数，并返回一个包含 `"Hello": "World"` 的 JSON 响应。
3. 最后使用 `uvicorn.run` 启动应用，监听在 `0.0.0.0:8000` 地址上。

### 路径操作
路径操作是 FastAPI 中定义 API 端点的核心方式。除了 `@app.get`，还有 `@app.post`、`@app.put`、`@app.delete` 等用于不同的 HTTP 方法。

例如，定义一个接受 POST 请求的路径操作：
```python
from fastapi import FastAPI

app = FastAPI()


@app.post("/items/")
def create_item(item: dict):
    return item


```
这个路径操作 `"/items/"` 接受一个 JSON 格式的请求体，并将其作为字典返回。

### 请求体与响应体
请求体是客户端发送到服务器的数据，响应体则是服务器返回给客户端的数据。在 FastAPI 中，可以使用 Pydantic 模型来定义请求体和响应体的结构。

定义一个 Pydantic 模型用于请求体：
```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Item(BaseModel):
    name: str
    price: float


@app.post("/items/")
def create_item(item: Item):
    return item


```
在上述代码中，`Item` 类继承自 `BaseModel`，定义了 `name` 和 `price` 两个字段。`create_item` 函数的参数 `item` 是 `Item` 类型，FastAPI 会自动验证请求体是否符合 `Item` 模型的结构。

### 参数校验
FastAPI 利用 Pydantic 进行参数校验。可以在路径参数、查询参数等定义中添加类型和校验规则。

例如，定义带有路径参数和查询参数的路径操作：
```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    if q:
        return {"item_id": item_id, "q": q}
    return {"item_id": item_id}


```
在这个例子中，`item_id` 是路径参数，类型为 `int`；`q` 是查询参数，类型为 `str`，并且是可选的（默认值为 `None`）。

## 常见实践
### 数据库连接与操作
使用 `SQLAlchemy` 与 FastAPI 集成进行数据库操作。首先安装 `SQLAlchemy`：
```bash
pip install sqlalchemy
```
示例代码如下：
```python
from fastapi import FastAPI
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

app = FastAPI()

# 数据库连接
SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"
engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


class Item(Base):
    __tablename__ = "items"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    price = Column(Integer)


Base.metadata.create_all(bind=engine)


@app.post("/items/")
def create_item(item: Item):
    db = SessionLocal()
    try:
        db.add(item)
        db.commit()
        db.refresh(item)
        return item
    finally:
        db.close()


```
在这个例子中，创建了一个 SQLite 数据库，并定义了一个 `Item` 表。`create_item` 函数用于将一个新的 `Item` 记录插入到数据库中。

### 处理文件上传
FastAPI 可以很方便地处理文件上传。示例代码如下：
```python
from fastapi import FastAPI, File, UploadFile

app = FastAPI()


@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile = File(...)):
    contents = await file.read()
    file_size = len(contents)
    return {"filename": file.filename, "file_size": file_size}


```
这个路径操作接受一个上传的文件，并返回文件名和文件大小。

### 认证与授权
使用 `fastapi.security` 模块实现认证与授权。例如，使用 JWT（JSON Web Token）进行认证：
```bash
pip install python-jose[cryptography] passlib[bcrypt]
```
示例代码：
```python
from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from passlib.context import CryptContext

app = FastAPI()

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


@app.post("/token")
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    # 这里应该从数据库中查询用户信息并验证密码
    if form_data.username == "test" and verify_password(form_data.password, get_password_hash("test")):
        access_token = create_access_token(data={"sub": form_data.username})
        return {"access_token": access_token, "token_type": "bearer"}
    else:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )


@app.get("/protected/")
async def protected_route(current_user: str = Depends(get_current_user)):
    return {"message": f"Hello, {current_user}"}


```
在这个示例中，实现了用户登录获取 JWT 令牌，并在受保护的路由中验证令牌的功能。

## 最佳实践
### 项目结构设计
推荐的项目结构如下：
```
project/
    ├── app/
    │   ├── __init__.py
    │   ├── main.py
    │   ├── routers/
    │   │   ├── __init__.py
    │   │   ├── items.py
    │   │   └── users.py
    │   ├── models/
    │   │   ├── __init__.py
    │   │   └── item.py
    │   ├── schemas/
    │   │   ├── __init__.py
    │   │   └── item.py
    │   └── database.py
    ├── tests/
    │   ├── __init__.py
    │   ├── test_items.py
    │   └── test_users.py
    ├── requirements.txt
    └── README.md
```
这种结构将路由、模型、序列化器等功能模块分开，便于维护和扩展。

### 日志记录与错误处理
使用 Python 的 `logging` 模块进行日志记录，并在 FastAPI 中全局处理异常。示例代码：
```python
import logging
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse

app = FastAPI()

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.error(f"An error occurred: {exc}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={"message": "An internal server error occurred"}
    )


```
在这个例子中，定义了一个全局异常处理器，捕获所有未处理的异常并记录日志，返回统一的错误响应。

### 性能优化
- **异步编程**：充分利用 FastAPI 的异步特性，将 I/O 密集型操作（如数据库查询、文件读取等）改为异步操作，提高应用的并发处理能力。
- **缓存**：对于频繁访问且数据变化不大的 API 端点，可以使用缓存机制（如 Redis）来减少数据库查询次数，提高响应速度。
- **代码优化**：编写高效的 Python 代码，避免不必要的计算和循环，使用合适的数据结构和算法。

## 小结
本文详细介绍了 Python FastAPI 的基础概念、使用方法、常见实践以及最佳实践。通过学习这些内容，你已经掌握了使用 FastAPI 构建高效 API 的核心技能。FastAPI 不仅能够帮助你快速开发 API，还能保证应用的高性能和可维护性。在实际项目中，结合具体需求灵活运用这些知识，将能够开发出高质量的 API 服务。

## 参考资料
- [FastAPI 官方文档](https://fastapi.tiangolo.com/)
- [FastAPI 教程](https://www.uvicorn.org/)
- [Pydantic 官方文档](https://pydantic-docs.helpmanual.io/)
- [SQLAlchemy 官方文档](https://www.sqlalchemy.org/)
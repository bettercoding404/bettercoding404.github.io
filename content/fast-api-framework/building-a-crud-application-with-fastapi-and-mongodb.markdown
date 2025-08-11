---
title: "Building a CRUD Application with FastAPI and MongoDB"
description: "
In the world of web development, creating a CRUD (Create, Read, Update, Delete) application is a fundamental task. CRUD operations are the backbone of most database - driven applications, allowing users to manage data effectively. FastAPI is a modern, fast (high-performance), web framework for building APIs with Python based on standard Python type hints. MongoDB, on the other hand, is a popular NoSQL database that provides high performance, high availability, and automatic scaling.  Combining FastAPI and MongoDB can lead to the creation of efficient, scalable, and easy - to - maintain CRUD applications. In this blog, we will explore the process of building a CRUD application using FastAPI and MongoDB, covering fundamental concepts, usage methods, common practices, and best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. Prerequisites
2. Setting up the Project
3. Connecting to MongoDB
4. Defining Data Models
5. Implementing CRUD Operations
    - Create Operation
    - Read Operations
    - Update Operation
    - Delete Operation
6. Testing the CRUD Application
7. Best Practices
8. Conclusion
9. References

## Prerequisites
Before we start building the CRUD application, you need to have the following installed:
- Python 3.7 or higher
- MongoDB installed and running on your local machine or a remote server
- `fastapi` and `pymongo` libraries. You can install them using `pip install fastapi pymongo uvicorn` (uvicorn is a server for running FastAPI applications).

## Setting up the Project
1. Create a new directory for your project:
```bash
mkdir fastapi - mongodb - crud
cd fastapi - mongodb - crud
```
2. Create a virtual environment (optional but recommended):
```bash
python -m venv venv
source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
```
3. Create a new Python file, for example, `main.py`.

## Connecting to MongoDB
First, we need to establish a connection to the MongoDB database. Here is the code to connect to a local MongoDB instance:
```python
from pymongo import MongoClient

# Connect to the MongoDB server
client = MongoClient('mongodb://localhost:27017/')

# Select a database
db = client['fastapi_mongodb_crud']

# Select a collection
collection = db['items']
```
In the above code, we first create a `MongoClient` instance to connect to the local MongoDB server running on port 27017. Then we select a database named `fastapi_mongodb_crud` and a collection named `items`.

## Defining Data Models
We can use Pydantic to define data models for our application. Pydantic is a data validation library that works well with FastAPI.
```python
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    price: float
    is_offer: bool = None
```
The `Item` class represents the structure of the data we will store in the MongoDB collection.

## Implementing CRUD Operations

### Create Operation
The create operation is used to insert a new document into the MongoDB collection.
```python
from fastapi import FastAPI

app = FastAPI()

@app.post("/items/")
async def create_item(item: Item):
    item_dict = item.dict()
    result = collection.insert_one(item_dict)
    return {"message": "Item created successfully", "id": str(result.inserted_id)}
```
In the above code, we define a POST endpoint `/items/` that takes an `Item` object as input. We convert the `Item` object to a dictionary and insert it into the MongoDB collection using `insert_one`.

### Read Operations
We can implement two types of read operations: reading a single item and reading all items.

#### Read a Single Item
```python
@app.get("/items/{item_id}")
async def read_item(item_id: str):
    item = collection.find_one({"_id": ObjectId(item_id)})
    if item:
        item["_id"] = str(item["_id"])
        return item
    return {"message": "Item not found"}
```
Here, we define a GET endpoint `/items/{item_id}` that takes an item ID as a path parameter. We use `find_one` to search for the item in the collection.

#### Read All Items
```python
@app.get("/items/")
async def read_all_items():
    items = []
    for item in collection.find():
        item["_id"] = str(item["_id"])
        items.append(item)
    return items
```
This GET endpoint `/items/` retrieves all the items from the collection.

### Update Operation
The update operation is used to modify an existing document in the collection.
```python
from bson.objectid import ObjectId

@app.put("/items/{item_id}")
async def update_item(item_id: str, item: Item):
    result = collection.update_one(
        {"_id": ObjectId(item_id)},
        {"$set": item.dict()}
    )
    if result.modified_count > 0:
        return {"message": "Item updated successfully"}
    return {"message": "Item not found"}
```
In this PUT endpoint `/items/{item_id}`, we use `update_one` to update the document with the given ID.

### Delete Operation
The delete operation is used to remove a document from the collection.
```python
@app.delete("/items/{item_id}")
async def delete_item(item_id: str):
    result = collection.delete_one({"_id": ObjectId(item_id)})
    if result.deleted_count > 0:
        return {"message": "Item deleted successfully"}
    return {"message": "Item not found"}
```
This DELETE endpoint `/items/{item_id}` uses `delete_one` to remove the document with the given ID.

## Testing the CRUD Application
To test the application, start the FastAPI server using Uvicorn:
```bash
uvicorn main:app --reload
```
You can then use tools like Postman or cURL to send requests to the different endpoints and test the CRUD operations.

## Best Practices
- **Error Handling**: Implement proper error handling in your application to handle cases such as database connection failures, invalid input, etc.
- **Input Validation**: Use Pydantic for input validation to ensure that the data received by your application is in the correct format.
- **Security**: If your application is deployed in a production environment, make sure to secure your MongoDB instance by setting up authentication, authorization, and proper network security.
- **Logging**: Implement logging in your application to track important events and errors.

## Conclusion
In this blog, we have learned how to build a CRUD application using FastAPI and MongoDB. We covered the process of connecting to MongoDB, defining data models, implementing CRUD operations, and testing the application. By following the best practices, you can create a robust and efficient CRUD application that can handle data management tasks effectively.

## References
- FastAPI Documentation: https://fastapi.tiangolo.com/
- MongoDB Documentation: https://docs.mongodb.com/
- Pydantic Documentation: https://pydantic-docs.helpmanual.io/
---
title: "Creating Multipart Forms and File Uploads with FastAPI"
description: "
FastAPI is a modern, fast (high-performance), web framework for building APIs with Python based on standard Python type hints. One of the common requirements in web applications is handling form submissions, especially those involving file uploads. In this blog post, we'll explore how to create multipart forms and handle file uploads using FastAPI. Multipart forms are a way to send data that includes different types of content, such as text fields and files, in a single request. This is particularly useful when users need to submit both information and related files, like uploading a profile picture along with personal details.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Fundamental Concepts](#fundamental-concepts)
2. [Setting up a FastAPI Project](#setting-up-a-fastapi-project)
3. [Creating a Simple Multipart Form](#creating-a-simple-multipart-form)
4. [Handling File Uploads](#handling-file-uploads)
5. [Common Practices](#common-practices)
6. [Best Practices](#best-practices)
7. [Conclusion](#conclusion)
8. [References](#references)

## Fundamental Concepts
### Multipart Forms
A multipart form is a type of HTML form that allows you to send multiple parts of data in a single HTTP request. Each part can have its own content type, such as text/plain for text fields and image/jpeg for image files. The parts are separated by a boundary, which is specified in the request headers.

### File Uploads
File uploads involve sending a file from a client (usually a web browser) to a server. In the context of FastAPI, the server needs to receive the file, validate it, and potentially store it in a suitable location.

## Setting up a FastAPI Project
First, make sure you have Python installed on your system. Then, create a virtual environment and install FastAPI and Uvicorn (a server for running FastAPI applications).

```bash
# Create a virtual environment
python -m venv myenv

# Activate the virtual environment
# On Windows
myenv\Scripts\activate
# On Linux/Mac
source myenv/bin/activate

# Install FastAPI and Uvicorn
pip install fastapi uvicorn
```

## Creating a Simple Multipart Form
Let's start by creating a simple FastAPI application that can handle a multipart form with text fields.

```python
from fastapi import FastAPI, Form

app = FastAPI()

@app.post("/submit-form/")
async def submit_form(name: str = Form(...), age: int = Form(...)):
    return {"name": name, "age": age}
```

In this code:
- We import `FastAPI` and `Form` from the `fastapi` library.
- Create a FastAPI application instance.
- Define a POST endpoint `/submit-form/` that expects two form fields: `name` and `age`.
- The `Form(...)` indicates that these fields are required.

To run the application, use the following command:

```bash
uvicorn main:app --reload
```

You can test the form using a tool like `curl` or Postman. Here's an example using `curl`:

```bash
curl -X POST "http://127.0.0.1:8000/submit-form/" -H "Content-Type: multipart/form-data" -F "name=John" -F "age=30"
```

## Handling File Uploads
Now, let's see how to handle file uploads in FastAPI.

```python
from fastapi import FastAPI, File, UploadFile

app = FastAPI()

@app.post("/upload-file/")
async def upload_file(file: UploadFile = File(...)):
    contents = await file.read()
    # Here you can save the file to a specific location
    # For example, to save it in the current directory:
    with open(file.filename, "wb") as f:
        f.write(contents)
    return {"filename": file.filename}
```

In this code:
- We import `File` and `UploadFile` from the `fastapi` library.
- Define a POST endpoint `/upload-file/` that expects a single file upload.
- `UploadFile` is a class that represents an uploaded file. It has methods like `read()` to read the file contents.
- We read the file contents asynchronously and then save the file to the current directory.

To test the file upload using `curl`:

```bash
curl -X POST "http://127.0.0.1:8000/upload-file/" -H "Content-Type: multipart/form-data" -F "file=@path/to/your/file.txt"
```

## Common Practices
### Input Validation
Always validate the input received from forms and file uploads. For text fields, you can use Python's built-in validation or third - party libraries like `pydantic`. For file uploads, validate the file type, size, and other relevant properties.

```python
from fastapi import FastAPI, File, UploadFile
from fastapi.exceptions import HTTPException

app = FastAPI()

@app.post("/upload-validated-file/")
async def upload_validated_file(file: UploadFile = File(...)):
    if file.content_type not in ["image/jpeg", "image/png"]:
        raise HTTPException(status_code=400, detail="Invalid file type. Only JPEG and PNG are allowed.")
    contents = await file.read()
    # Save the file
    with open(file.filename, "wb") as f:
        f.write(contents)
    return {"filename": file.filename}
```

### Error Handling
Properly handle errors that may occur during form submissions or file uploads. Return meaningful error messages to the client.

## Best Practices
### Asynchronous Operations
Use asynchronous operations when reading or writing files, especially in a high - traffic application. This helps to avoid blocking the event loop and improves the overall performance of the application.

### Security
- Limit the size of uploaded files to prevent denial - of - service attacks.
- Sanitize file names to prevent malicious file names that could lead to security vulnerabilities.
- Store files in a secure location with appropriate access controls.

## Conclusion
In this blog post, we've covered the fundamental concepts of creating multipart forms and handling file uploads with FastAPI. We've seen how to set up a FastAPI project, create simple multipart forms, handle file uploads, and discussed common and best practices. By following these guidelines, you can build robust and secure web applications that can handle user input and file uploads effectively.

## References
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [MDN Web Docs - Multipart Forms](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/form#attr-enctype)
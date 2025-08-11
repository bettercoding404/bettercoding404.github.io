---
title: "FastAPI: Setting Up WebSockets for Realtime Communication"
description: "
In modern web development, real - time communication has become a crucial feature. Whether it's chat applications, live dashboards, or collaborative editing tools, the ability to send and receive data instantly between the client and the server is highly desirable. FastAPI, a modern, fast (high - performance) web framework for building APIs with Python, provides excellent support for WebSockets, which are a key technology for enabling real - time communication.  WebSockets offer a full - duplex communication channel over a single TCP connection. Unlike traditional HTTP requests, which are stateless and require a new connection for each request, WebSockets maintain a continuous connection, allowing both the client and the server to send data at any time. In this blog, we will explore how to set up WebSockets in FastAPI for real - time communication.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. Understanding WebSockets
2. Setting Up a Basic FastAPI Project
3. Implementing WebSockets in FastAPI
4. Common Practices
5. Best Practices
6. Conclusion
7. References

## 1. Understanding WebSockets
### What are WebSockets?
WebSockets are a communication protocol that provides a full - duplex, long - lived connection between a client and a server. It starts with an HTTP handshake and then upgrades to a WebSocket connection. Once the connection is established, both the client and the server can send data to each other without the need for repeated handshakes.

### Why Use WebSockets for Realtime Communication?
- **Low Latency**: Since the connection is persistent, there is no need to establish a new connection for each message, resulting in lower latency.
- **Full - Duplex Communication**: Both the client and the server can send and receive data simultaneously.
- **Efficiency**: Reduces the overhead associated with repeated HTTP requests.

## 2. Setting Up a Basic FastAPI Project
### Prerequisites
- Python 3.7 or higher
- `fastapi` and `uvicorn` installed. You can install them using `pip install fastapi uvicorn`.

### Basic Project Structure
Create a new Python file, for example, `main.py`:
```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


```

To run the application, use the following command in the terminal:
```bash
uvicorn main:app --reload
```
Now you can access the application at `http://127.0.0.1:8000`.

## 3. Implementing WebSockets in FastAPI
### Simple WebSocket Example
```python
from fastapi import FastAPI, WebSocket

app = FastAPI()


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        await websocket.send_text(f"Message text was: {data}")


```
In this example:
1. We define a WebSocket endpoint at `/ws`.
2. When a client connects to this endpoint, we accept the WebSocket connection using `await websocket.accept()`.
3. Inside the infinite loop, we receive text messages from the client using `await websocket.receive_text()` and then send a response back to the client.

### WebSocket Client Example
You can use JavaScript in the browser to connect to the WebSocket server:
```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF - 8">
    <title>WebSocket Client</title>
</head>

<body>
    <input type="text" id="messageInput" placeholder="Type a message">
    <button onclick="sendMessage()">Send</button>
    <div id="messages"></div>

    <script>
        const socket = new WebSocket('ws://127.0.0.1:8000/ws');

        socket.onmessage = function (event) {
            const messages = document.getElementById('messages');
            const newMessage = document.createElement('p');
            newMessage.textContent = event.data;
            messages.appendChild(newMessage);
        };

        function sendMessage() {
            const input = document.getElementById('messageInput');
            const message = input.value;
            socket.send(message);
            input.value = '';
        }
    </script>
</body>

</html>
```
This HTML file creates a simple WebSocket client. When the user types a message and clicks the "Send" button, the message is sent to the server, and the server's response is displayed on the page.

## 4. Common Practices
### Handling Connection Errors
In the WebSocket endpoint, it's important to handle connection errors gracefully. For example:
```python
@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            data = await websocket.receive_text()
            await websocket.send_text(f"Message text was: {data}")
    except Exception as e:
        print(f"WebSocket error: {e}")
    finally:
        await websocket.close()


```
This code catches any exceptions that occur during the WebSocket communication and closes the connection properly.

### Broadcasting Messages
In a chat application, you may want to broadcast messages to all connected clients. Here is an example:
```python
from fastapi import FastAPI, WebSocket
from typing import List

app = FastAPI()
connected_clients: List[WebSocket] = []


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    connected_clients.append(websocket)
    try:
        while True:
            data = await websocket.receive_text()
            for client in connected_clients:
                if client != websocket:
                    await client.send_text(f"New message: {data}")
    except Exception as e:
        print(f"WebSocket error: {e}")
    finally:
        connected_clients.remove(websocket)
        await websocket.close()


```
This code maintains a list of all connected clients. When a client sends a message, the message is broadcast to all other connected clients.

## 5. Best Practices
### Security
- **Origin Checking**: Validate the origin of the WebSocket connection to prevent cross - site scripting (XSS) attacks. You can use a middleware to check the `Origin` header.
- **Input Validation**: Validate the data received from the client to prevent injection attacks.

### Performance
- **Asynchronous Programming**: Use asynchronous programming techniques to handle multiple WebSocket connections efficiently. FastAPI is built on top of `asyncio`, so make sure to use `await` appropriately.
- **Rate Limiting**: Implement rate limiting to prevent abuse of the WebSocket service.

## Conclusion
FastAPI provides a simple and efficient way to set up WebSockets for real - time communication. By understanding the basic concepts, following common practices, and implementing best practices, you can build robust and scalable real - time applications. Whether it's a chat application, a live dashboard, or a collaborative tool, WebSockets in FastAPI can help you achieve seamless real - time communication between the client and the server.

## References
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [MDN Web Docs - WebSockets](https://developer.mozilla.org/en - US/docs/Web/API/WebSockets_API)
- [Python `asyncio` Documentation](https://docs.python.org/3/library/asyncio.html)
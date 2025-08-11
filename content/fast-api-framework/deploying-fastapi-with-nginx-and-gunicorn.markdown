---
title: "Deploying FastAPI with Nginx and Gunicorn"
description: "
FastAPI is a modern, fast (high-performance), web framework for building APIs with Python based on standard Python type hints. While FastAPI is great for development, when it comes to deploying it in a production environment, we need to ensure high performance, reliability, and security. This is where Nginx and Gunicorn come into play.  Gunicorn, short for Green Unicorn, is a Python WSGI HTTP Server for UNIX. It is designed to be lightweight and easy to use, and it can handle multiple requests concurrently. Nginx, on the other hand, is a high-performance web server, reverse proxy server, and email (IMAP/POP3) proxy server. By using Nginx as a reverse proxy in front of Gunicorn, we can offload tasks like static file serving, load balancing, and SSL termination, which helps in improving the overall performance and security of our FastAPI application.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. Prerequisites
2. Installing FastAPI, Gunicorn, and Nginx
3. Creating a Simple FastAPI Application
4. Running FastAPI with Gunicorn
5. Configuring Nginx as a Reverse Proxy
6. Common Practices
7. Best Practices
8. Conclusion
9. References

## Prerequisites
- A server running a Linux distribution (e.g., Ubuntu 20.04)
- Python 3.7 or higher installed on the server
- Root or sudo access to the server

## Installing FastAPI, Gunicorn, and Nginx

### Installing Python and Pip
First, make sure Python and Pip are installed on your server. On Ubuntu, you can use the following commands:
```bash
sudo apt update
sudo apt install python3 python3-pip
```

### Installing FastAPI and Gunicorn
Create a virtual environment and activate it:
```bash
python3 -m venv myenv
source myenv/bin/activate
```
Install FastAPI and Gunicorn:
```bash
pip install fastapi uvicorn gunicorn
```

### Installing Nginx
On Ubuntu, you can install Nginx using the following command:
```bash
sudo apt install nginx
```

## Creating a Simple FastAPI Application
Create a new Python file named `main.py` with the following code:
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}
```

## Running FastAPI with Gunicorn
You can start the FastAPI application with Gunicorn using the following command:
```bash
gunicorn -w 4 -k uvicorn.workers.UvicornWorker main:app -b 0.0.0.0:8000
```
- `-w 4`: This specifies the number of worker processes. In this case, we are using 4 worker processes.
- `-k uvicorn.workers.UvicornWorker`: This tells Gunicorn to use the Uvicorn worker class, which is optimized for FastAPI applications.
- `main:app`: This specifies the Python file (`main.py`) and the FastAPI application instance (`app`).
- `-b 0.0.0.0:8000`: This binds the application to all available network interfaces on port 8000.

## Configuring Nginx as a Reverse Proxy
Create a new Nginx configuration file for your FastAPI application:
```bash
sudo nano /etc/nginx/sites-available/fastapi
```
Add the following configuration to the file:
```nginx
server {
    listen 80;
    server_name your_domain_or_ip;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
- `listen 80`: This tells Nginx to listen on port 80.
- `server_name your_domain_or_ip`: Replace `your_domain_or_ip` with your actual domain name or server IP address.
- `proxy_pass http://127.0.0.1:8000`: This forwards all incoming requests to the Gunicorn server running on `127.0.0.1:8000`.

Create a symbolic link to enable the configuration:
```bash
sudo ln -s /etc/nginx/sites-available/fastapi /etc/nginx/sites-enabled/
```
Test the Nginx configuration:
```bash
sudo nginx -t
```
If the test is successful, restart Nginx:
```bash
sudo systemctl restart nginx
```

## Common Practices
- **Monitoring and Logging**: Set up monitoring tools like Prometheus and Grafana to monitor the performance of your FastAPI application, Gunicorn, and Nginx. Also, configure logging for all components to easily troubleshoot issues.
- **Scaling**: Adjust the number of Gunicorn worker processes based on the traffic and resource availability of your server. You can use tools like Supervisor or systemd to manage the Gunicorn process.
- **Security**: Keep your server, Nginx, Gunicorn, and FastAPI application up to date with the latest security patches. Use HTTPS by obtaining an SSL certificate from Let's Encrypt and configuring Nginx to use it.

## Best Practices
- **Use a Process Manager**: Use a process manager like systemd to manage the Gunicorn process. This ensures that the application restarts automatically in case of a crash. Here is an example systemd service file for Gunicorn:
```ini
[Unit]
Description=Gunicorn instance to serve FastAPI app
After=network.target

[Service]
User=your_user
Group=www-data
WorkingDirectory=/path/to/your/app
Environment="PATH=/path/to/your/venv/bin"
ExecStart=/path/to/your/venv/bin/gunicorn -w 4 -k uvicorn.workers.UvicornWorker main:app -b 0.0.0.0:8000

[Install]
WantedBy=multi-user.target
```
Save the file as `/etc/systemd/system/fastapi.service` and then run the following commands:
```bash
sudo systemctl daemon-reload
sudo systemctl start fastapi
sudo systemctl enable fastapi
```
- **Optimize Nginx Configuration**: Tune Nginx settings like `worker_connections`, `keepalive_timeout`, and `client_max_body_size` based on your application's requirements.
- **Use a Load Balancer**: If you have multiple servers running your FastAPI application, use a load balancer like Nginx or HAProxy to distribute the traffic evenly across the servers.

## Conclusion
Deploying FastAPI with Nginx and Gunicorn is a great way to ensure high performance, reliability, and security for your FastAPI applications in a production environment. By following the steps and best practices outlined in this blog, you can easily deploy and manage your FastAPI application. Remember to continuously monitor and optimize your setup to provide the best user experience.

## References
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Gunicorn Documentation](https://docs.gunicorn.org/en/stable/)
- [Nginx Documentation](https://nginx.org/en/docs/)
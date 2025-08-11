---
title: "Monitoring FastAPI Applications with Prometheus"
description: "
FastAPI is a modern, fast (high-performance) web framework for building APIs with Python based on standard Python type hints. As applications built with FastAPI grow in complexity and scale, it becomes crucial to monitor their performance to ensure they are running smoothly and efficiently. Prometheus is an open - source monitoring and alerting toolkit that has become a de facto standard in the cloud - native ecosystem. In this blog post, we will explore how to monitor FastAPI applications using Prometheus, covering fundamental concepts, usage methods, common practices, and best practices.
"
date: 2025-08-11
modified: 2025-08-11
---

## Table of Contents
1. [Fundamental Concepts](#fundamental-concepts)
2. [Setting up a FastAPI Application](#setting-up-a-fastapi-application)
3. [Integrating Prometheus with FastAPI](#integrating-prometheus-with-fastapi)
4. [Common Practices](#common-practices)
5. [Best Practices](#best-practices)
6. [Conclusion](#conclusion)
7. [References](#references)

## Fundamental Concepts

### Prometheus
Prometheus is a time - series database that collects and stores metrics in the form of key - value pairs over time. It uses a multi - dimensional data model where each time series is identified by a metric name and a set of key - value pairs called labels. Prometheus scrapes metrics from targets (such as our FastAPI application) at regular intervals using HTTP endpoints.

### Metrics in Prometheus
- **Counter**: A cumulative metric that represents a single monotonically increasing counter whose value can only increase or be reset to zero on restart. For example, the number of requests served by an API.
- **Gauge**: A metric that represents a single numerical value that can arbitrarily go up and down. For example, the current number of active connections.
- **Histogram**: A metric that samples observations (usually things like request durations or response sizes) and counts them in configurable buckets. It also provides a sum of all observed values.
- **Summary**: Similar to a histogram, a summary samples observations. It calculates configurable quantiles over a sliding time window.

### FastAPI
FastAPI is designed to be fast, reliable, and easy to develop with. It uses asynchronous programming and Pydantic for data validation. To monitor a FastAPI application, we need to expose the relevant metrics in a format that Prometheus can understand.

## Setting up a FastAPI Application

First, let's create a simple FastAPI application. Install the necessary packages:
```bash
pip install fastapi uvicorn
```

Here is a basic FastAPI application code:
```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


```

To run the application, use the following command:
```bash
uvicorn main:app --reload
```

## Integrating Prometheus with FastAPI

We will use the `prometheus - fastapi - instrumentator` library to integrate Prometheus with our FastAPI application. Install it using:
```bash
pip install prometheus-fastapi-instrumentator
```

Here is the updated code:
```python
from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


Instrumentator().instrument(app).expose(app)


```

Now, when you start the application using `uvicorn main:app --reload`, you can access the Prometheus metrics at the `/metrics` endpoint. For example, if your application is running at `http://localhost:8000`, you can access the metrics at `http://localhost:8000/metrics`.

## Common Practices

### Monitoring API Request Metrics
- **Request Count**: Use a counter metric to track the number of requests received by each API endpoint. This helps in understanding the popularity of different endpoints.
- **Request Duration**: Use a histogram or summary metric to measure the time taken to process each request. This can help in identifying slow - performing endpoints.

### Monitoring Application Health
- **Uptime**: Track the application's uptime using a gauge metric. This gives an idea of how long the application has been running without any issues.
- **Error Rate**: Count the number of requests that result in an error using a counter. This helps in detecting issues in the application.

## Best Practices

### Metric Naming and Labeling
- **Meaningful Names**: Use descriptive names for metrics. For example, instead of `req_count`, use `api_request_count`.
- **Consistent Labeling**: Use consistent labels across different metrics. For example, if you label requests by endpoint, use the same label name in all relevant metrics.

### Filtering and Aggregation
- **Filtering**: Use Prometheus queries to filter out unnecessary data. For example, if you want to analyze requests from a specific IP address, you can use label filtering.
- **Aggregation**: Aggregate metrics at different levels. For example, you can aggregate request counts by hour to get a better understanding of the traffic pattern.

### Alerting
- **Set Up Alerts**: Use Prometheus Alertmanager to set up alerts based on certain conditions. For example, if the error rate exceeds a certain threshold, send an alert.

## Conclusion
Monitoring FastAPI applications with Prometheus is essential for maintaining the performance and reliability of your APIs. By understanding the fundamental concepts, integrating Prometheus with FastAPI, following common practices, and implementing best practices, you can gain valuable insights into your application's behavior. This allows you to proactively identify and resolve issues before they impact your users.

## References
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [prometheus - fastapi - instrumentator GitHub Repository](https://github.com/trallnag/prometheus-fastapi-instrumentator)
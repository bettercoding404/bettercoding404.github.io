---
title: "用Python获取天气信息：从基础到最佳实践"
description: "在许多应用场景中，获取实时天气信息是非常有用的，比如出行规划、农业生产监控、气象研究等。Python作为一种功能强大且易于学习的编程语言，提供了多种方式来获取天气数据。本文将详细介绍如何使用Python获取天气信息，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在许多应用场景中，获取实时天气信息是非常有用的，比如出行规划、农业生产监控、气象研究等。Python作为一种功能强大且易于学习的编程语言，提供了多种方式来获取天气数据。本文将详细介绍如何使用Python获取天气信息，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 使用第三方库`requests`结合天气API
    - 使用`pyowm`库
    - 使用`weather-api`库
3. **常见实践**
    - 获取当前位置天气
    - 获取指定城市天气
    - 历史天气查询
4. **最佳实践**
    - 错误处理与异常处理
    - 数据缓存与优化
    - 与其他模块或应用集成
5. **小结**
6. **参考资料**

## 基础概念
要在Python中获取天气信息，关键在于与提供天气数据的API进行交互。API（Application Programming Interface）是一组用于开发软件的工具和协议，允许不同的软件组件或系统之间进行通信。天气API通常由气象数据提供商或相关机构提供，开发者可以通过发送HTTP请求到这些API端点，获取包含天气信息的响应数据。常见的天气API有OpenWeatherMap API、Weatherbit API等。这些API返回的数据格式通常为JSON（JavaScript Object Notation）或XML（eXtensible Markup Language），Python有相应的库来解析这些格式的数据。

## 使用方法

### 使用第三方库`requests`结合天气API
`requests`库是Python中用于发送HTTP请求的常用库。以下以OpenWeatherMap API为例：

1. 首先，安装`requests`库（如果尚未安装）：
```bash
pip install requests
```

2. 获取OpenWeatherMap API密钥：
   - 访问OpenWeatherMap网站，注册账号并获取API密钥。

3. 编写代码获取天气信息：
```python
import requests

def get_weather(city, api_key):
    base_url = "http://api.openweathermap.org/data/2.5/weather"
    params = {
        "q": city,
        "appid": api_key,
        "units": "metric"  # 使用公制单位
    }
    response = requests.get(base_url, params=params)
    if response.status_code == 200:
        data = response.json()
        weather_info = {
            "city": data["name"],
            "temperature": data["main"]["temp"],
            "humidity": data["main"]["humidity"],
            "description": data["weather"][0]["description"]
        }
        return weather_info
    else:
        print(f"Error: {response.status_code}")
        return None

# 替换为你的API密钥
api_key = "your_api_key"
city = "Beijing"
weather = get_weather(city, api_key)
if weather:
    print(f"Weather in {weather['city']}: {weather['description']}, Temperature: {weather['temperature']}°C, Humidity: {weather['humidity']}%")
```

### 使用`pyowm`库
`pyowm`是一个专门用于与OpenWeatherMap API交互的Python库，使用起来更加方便。

1. 安装`pyowm`库：
```bash
pip install pyowm
```

2. 编写代码获取天气信息：
```python
import pyowm

def get_weather_with_pyowm(city):
    owm = pyowm.OWM("your_api_key")
    mgr = owm.weather_manager()
    observation = mgr.weather_at_place(city)
    w = observation.weather
    weather_info = {
        "city": city,
        "temperature": w.temperature('celsius')['temp'],
        "humidity": w.humidity,
        "description": w.detailed_status
    }
    return weather_info

city = "Shanghai"
weather = get_weather_with_pyowm(city)
if weather:
    print(f"Weather in {weather['city']}: {weather['description']}, Temperature: {weather['temperature']}°C, Humidity: {weather['humidity']}%")
```

### 使用`weather-api`库
`weather-api`库提供了一种简单的方式来获取天气数据。

1. 安装`weather-api`库：
```bash
pip install weather-api
```

2. 编写代码获取天气信息：
```python
from weather_api import WeatherApi

def get_weather_with_weather_api(city):
    api = WeatherApi("your_api_key")
    weather_data = api.get_weather(city)
    weather_info = {
        "city": city,
        "temperature": weather_data['main']['temp'],
        "humidity": weather_data['main']['humidity'],
        "description": weather_data['weather'][0]['description']
    }
    return weather_info

city = "Guangzhou"
weather = get_weather_with_weather_api(city)
if weather:
    print(f"Weather in {weather['city']}: {weather['description']}, Temperature: {weather['temperature']}°C, Humidity: {weather['humidity']}%")
```

## 常见实践

### 获取当前位置天气
要获取当前位置天气，可以使用IP地址定位或设备的GPS信息。以下是使用IP地址定位结合`requests`库和IPAPI的示例：

1. 安装`requests`库（如果尚未安装）：
```bash
pip install requests
```

2. 编写代码获取当前位置天气：
```python
import requests

def get_ip_location():
    response = requests.get("http://ip-api.com/json")
    if response.status_code == 200:
        data = response.json()
        return data["city"]
    else:
        print(f"Error: {response.status_code}")
        return None

def get_weather(city, api_key):
    base_url = "http://api.openweathermap.org/data/2.5/weather"
    params = {
        "q": city,
        "appid": api_key,
        "units": "metric"
    }
    response = requests.get(base_url, params=params)
    if response.status_code == 200:
        data = response.json()
        weather_info = {
            "city": data["name"],
            "temperature": data["main"]["temp"],
            "humidity": data["main"]["humidity"],
            "description": data["weather"][0]["description"]
        }
        return weather_info
    else:
        print(f"Error: {response.status_code}")
        return None

api_key = "your_api_key"
city = get_ip_location()
if city:
    weather = get_weather(city, api_key)
    if weather:
        print(f"Weather in {weather['city']}: {weather['description']}, Temperature: {weather['temperature']}°C, Humidity: {weather['humidity']}%")
```

### 获取指定城市天气
获取指定城市天气相对简单，只需在上述代码中修改城市名称参数即可。例如：
```python
city = "New York"
weather = get_weather(city, api_key)
if weather:
    print(f"Weather in {weather['city']}: {weather['description']}, Temperature: {weather['temperature']}°C, Humidity: {weather['humidity']}%")
```

### 历史天气查询
有些天气API支持历史天气查询。以OpenWeatherMap API为例，需要使用`/onecall/timemachine`端点。

1. 编写代码查询历史天气：
```python
import requests
from datetime import datetime

def get_historical_weather(city, api_key, date_time):
    base_url = "https://api.openweathermap.org/data/2.5/onecall/timemachine"
    timestamp = int(datetime.timestamp(date_time))
    params = {
        "lat": 39.9042,  # 示例纬度
        "lon": 116.4074,  # 示例经度
        "dt": timestamp,
        "appid": api_key,
        "units": "metric"
    }
    response = requests.get(base_url, params=params)
    if response.status_code == 200:
        data = response.json()
        weather_info = {
            "city": city,
            "temperature": data["current"]["temp"],
            "humidity": data["current"]["humidity"],
            "description": data["current"]["weather"][0]["description"]
        }
        return weather_info
    else:
        print(f"Error: {response.status_code}")
        return None

api_key = "your_api_key"
city = "Beijing"
date_time = datetime(2023, 10, 1, 12, 0, 0)  # 示例日期时间
historical_weather = get_historical_weather(city, api_key, date_time)
if historical_weather:
    print(f"Historical Weather in {historical_weather['city']}: {historical_weather['description']}, Temperature: {historical_weather['temperature']}°C, Humidity: {historical_weather['humidity']}%")
```

## 最佳实践

### 错误处理与异常处理
在与天气API交互时，可能会遇到各种错误，如网络问题、API密钥无效、请求频率限制等。因此，进行适当的错误处理和异常处理非常重要。例如：
```python
import requests

def get_weather(city, api_key):
    base_url = "http://api.openweathermap.org/data/2.5/weather"
    params = {
        "q": city,
        "appid": api_key,
        "units": "metric"
    }
    try:
        response = requests.get(base_url, params=params)
        response.raise_for_status()  # 检查HTTP状态码
        data = response.json()
        weather_info = {
            "city": data["name"],
            "temperature": data["main"]["temp"],
            "humidity": data["main"]["humidity"],
            "description": data["weather"][0]["description"]
        }
        return weather_info
    except requests.RequestException as e:
        print(f"Network error: {e}")
    except KeyError as e:
        print(f"Data structure error: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")
    return None
```

### 数据缓存与优化
为了减少对API的请求次数，提高应用性能，可以对获取到的天气数据进行缓存。例如，可以使用`functools.lru_cache`（适用于短时间内频繁调用同一函数的场景）或使用文件系统、数据库进行持久化缓存。以下是使用`functools.lru_cache`的示例：
```python
import requests
from functools import lru_cache

@lru_cache(maxsize=128)
def get_weather(city, api_key):
    base_url = "http://api.openweathermap.org/data/2.5/weather"
    params = {
        "q": city,
        "appid": api_key,
        "units": "metric"
    }
    response = requests.get(base_url, params=params)
    if response.status_code == 200:
        data = response.json()
        weather_info = {
            "city": data["name"],
            "temperature": data["main"]["temp"],
            "humidity": data["main"]["humidity"],
            "description": data["weather"][0]["description"]
        }
        return weather_info
    else:
        print(f"Error: {response.status_code}")
        return None
```

### 与其他模块或应用集成
可以将天气获取功能与其他Python模块或应用集成。例如，将天气信息集成到一个Web应用中，或者与自动化脚本结合，根据天气情况执行不同的任务。以下是将天气信息集成到Flask Web应用的示例：
```python
from flask import Flask, jsonify
import requests

app = Flask(__name__)

def get_weather(city, api_key):
    base_url = "http://api.openweathermap.org/data/2.5/weather"
    params = {
        "q": city,
        "appid": api_key,
        "units": "metric"
    }
    response = requests.get(base_url, params=params)
    if response.status_code == 200:
        data = response.json()
        weather_info = {
            "city": data["name"],
            "temperature": data["main"]["temp"],
            "humidity": data["main"]["humidity"],
            "description": data["weather"][0]["description"]
        }
        return weather_info
    else:
        print(f"Error: {response.status_code}")
        return None

api_key = "your_api_key"

@app.route('/weather/<city>', methods=['GET'])
def weather(city):
    weather_data = get_weather(city, api_key)
    if weather_data:
        return jsonify(weather_data)
    else:
        return jsonify({"message": "Weather data not available"}), 404

if __name__ == '__main__':
    app.run(debug=True)
```

## 小结
通过本文，我们深入探讨了在Python中获取天气信息的多种方法，包括使用`requests`库结合天气API、`pyowm`库、`weather-api`库等。同时，介绍了常见实践，如获取当前位置天气、指定城市天气和历史天气查询。最佳实践部分涵盖了错误处理、数据缓存与优化以及与其他模块或应用集成的内容。希望这些知识能帮助读者在实际项目中高效地获取和利用天气数据。

## 参考资料
- [OpenWeatherMap API文档](https://openweathermap.org/api){: rel="nofollow"}
- [requests库文档](https://requests.readthedocs.io/en/latest/){: rel="nofollow"}
- [pyowm库文档](https://pyowm.readthedocs.io/en/latest/){: rel="nofollow"}
- [weather-api库文档](https://pypi.org/project/weather-api/){: rel="nofollow"}
---
title: "用 Python 获取天气信息"
description: "在许多应用场景中，获取实时天气信息是非常有用的，比如出行规划、户外活动安排等。Python 作为一种功能强大且灵活的编程语言，提供了多种方式来获取天气数据。本文将深入探讨如何使用 Python 获取天气信息，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助你轻松掌握这一实用技能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在许多应用场景中，获取实时天气信息是非常有用的，比如出行规划、户外活动安排等。Python 作为一种功能强大且灵活的编程语言，提供了多种方式来获取天气数据。本文将深入探讨如何使用 Python 获取天气信息，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助你轻松掌握这一实用技能。

<!-- more -->
## 目录
1. **基础概念**
    - **天气数据来源**
    - **API 的作用**
2. **使用方法**
    - **使用第三方库 `requests` 结合天气 API**
    - **使用 `pyowm` 库**
3. **常见实践**
    - **获取当前位置天气**
    - **获取指定城市天气**
4. **最佳实践**
    - **错误处理与异常处理**
    - **缓存机制**
5. **小结**
6. **参考资料**

## 基础概念
### 天气数据来源
要获取天气信息，首先需要了解数据的来源。常见的天气数据提供商有 OpenWeatherMap、Weatherbit、AccuWeather 等。这些提供商通过气象站、卫星等多种手段收集全球各地的天气数据，并通过 API（Application Programming Interface）将数据提供给开发者使用。

### API 的作用
API 就像是一组接口，允许开发者通过特定的请求格式从数据提供商那里获取所需的数据。不同的天气 API 有不同的功能和使用规则，但通常都可以根据城市名称、经纬度等参数来获取相应位置的天气信息。使用 API 时，一般需要在数据提供商的网站上注册获取 API 密钥（API Key），这是访问数据的凭证。

## 使用方法
### 使用第三方库 `requests` 结合天气 API
`requests` 是 Python 中一个常用的用于发送 HTTP 请求的库。我们可以使用它来向天气 API 发送请求并获取响应数据。以 OpenWeatherMap API 为例：

1. **安装 `requests` 库**
如果你还没有安装 `requests` 库，可以使用以下命令进行安装：
```bash
pip install requests
```

2. **获取 API 密钥**
在 OpenWeatherMap 网站上注册账号，然后在个人页面中获取 API 密钥。

3. **编写代码**
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
        print(f"请求失败，状态码: {response.status_code}")

# 替换为你的 API 密钥
api_key = "your_api_key"
city = "Beijing"
weather = get_weather(city, api_key)
if weather:
    print(f"城市: {weather['city']}")
    print(f"温度: {weather['temperature']}°C")
    print(f"湿度: {weather['humidity']}%")
    print(f"天气描述: {weather['description']}")
```

### 使用 `pyowm` 库
`pyowm` 是一个专门用于与 OpenWeatherMap API 交互的 Python 库，它提供了更简单、面向对象的方式来获取天气信息。

1. **安装 `pyowm` 库**
```bash
pip install pyowm
```

2. **编写代码**
```python
from pyowm import OWM

def get_weather_with_pyowm(city, api_key):
    owm = OWM(api_key)
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

# 替换为你的 API 密钥
api_key = "your_api_key"
city = "Shanghai"
weather = get_weather_with_pyowm(city, api_key)
if weather:
    print(f"城市: {weather['city']}")
    print(f"温度: {weather['temperature']}°C")
    print(f"湿度: {weather['humidity']}%")
    print(f"天气描述: {weather['description']}")
```

## 常见实践
### 获取当前位置天气
要获取当前位置的天气，需要先获取设备的地理位置信息。可以使用 `geopy` 库结合 IP 地址或其他定位服务来获取当前位置的经纬度，然后将经纬度作为参数传递给天气 API。

1. **安装 `geopy` 库**
```bash
pip install geopy
```

2. **获取当前位置经纬度（示例使用 IP 地址定位）**
```python
from geopy.geocoders import Nominatim
import requests

def get_current_location():
    try:
        response = requests.get('https://api64.ipify.org?format=json')
        ip_address = response.json()["ip"]
        geolocator = Nominatim(user_agent="geoapiExercises")
        location = geolocator.geocode(ip_address)
        if location:
            return location.latitude, location.longitude
        else:
            print("无法获取当前位置")
    except Exception as e:
        print(f"获取位置时发生错误: {e}")

latitude, longitude = get_current_location()
```

3. **结合天气 API 获取当前位置天气**
以 OpenWeatherMap API 为例，修改之前的 `get_weather` 函数，支持通过经纬度获取天气：
```python
import requests

def get_weather_by_lat_lon(latitude, longitude, api_key):
    base_url = "http://api.openweathermap.org/data/2.5/weather"
    params = {
        "lat": latitude,
        "lon": longitude,
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
        print(f"请求失败，状态码: {response.status_code}")

# 替换为你的 API 密钥
api_key = "your_api_key"
weather = get_weather_by_lat_lon(latitude, longitude, api_key)
if weather:
    print(f"城市: {weather['city']}")
    print(f"温度: {weather['temperature']}°C")
    print(f"湿度: {weather['humidity']}%")
    print(f"天气描述: {weather['description']}")
```

### 获取指定城市天气
这是最常见的需求，前面的代码示例中已经展示了如何通过城市名称获取天气信息。只需要将城市名称作为参数传递给相应的获取天气函数即可。

## 最佳实践
### 错误处理与异常处理
在与 API 进行交互时，可能会遇到各种错误，如网络问题、API 密钥无效、请求频率过高被限制等。因此，需要进行全面的错误处理和异常处理。

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
        response.raise_for_status()  # 检查请求是否成功
        data = response.json()
        weather_info = {
            "city": data["name"],
            "temperature": data["main"]["temp"],
            "humidity": data["main"]["humidity"],
            "description": data["weather"][0]["description"]
        }
        return weather_info
    except requests.RequestException as e:
        print(f"请求过程中发生错误: {e}")
    except KeyError as e:
        print(f"解析响应数据时发生错误: {e}")
    except Exception as e:
        print(f"发生其他错误: {e}")

# 替换为你的 API 密钥
api_key = "your_api_key"
city = "Guangzhou"
weather = get_weather(city, api_key)
if weather:
    print(f"城市: {weather['city']}")
    print(f"温度: {weather['temperature']}°C")
    print(f"湿度: {weather['humidity']}%")
    print(f"天气描述: {weather['description']}")
```

### 缓存机制
如果频繁请求天气 API，可能会超出 API 的使用限制，同时也会消耗不必要的网络资源。可以使用缓存机制来存储已经获取到的天气信息，在一定时间内再次请求相同数据时，直接从缓存中获取。

```python
import requests
import time

weather_cache = {}

def get_weather(city, api_key, cache_expiry=3600):  # 缓存有效期 1 小时
    if city in weather_cache and time.time() - weather_cache[city]['timestamp'] < cache_expiry:
        return weather_cache[city]['data']

    base_url = "http://api.openweathermap.org/data/2.5/weather"
    params = {
        "q": city,
        "appid": api_key,
        "units": "metric"
    }
    try:
        response = requests.get(base_url, params=params)
        response.raise_for_status()
        data = response.json()
        weather_info = {
            "city": data["name"],
            "temperature": data["main"]["temp"],
            "humidity": data["main"]["humidity"],
            "description": data["weather"][0]["description"]
        }
        weather_cache[city] = {'data': weather_info, 'timestamp': time.time()}
        return weather_info
    except requests.RequestException as e:
        print(f"请求过程中发生错误: {e}")
    except KeyError as e:
        print(f"解析响应数据时发生错误: {e}")
    except Exception as e:
        print(f"发生其他错误: {e}")

# 替换为你的 API 密钥
api_key = "your_api_key"
city = "Shenzhen"
weather = get_weather(city, api_key)
if weather:
    print(f"城市: {weather['city']}")
    print(f"温度: {weather['temperature']}°C")
    print(f"湿度: {weather['humidity']}%")
    print(f"天气描述: {weather['description']}")
```

## 小结
通过本文的介绍，你已经了解了如何使用 Python 获取天气信息，包括基础概念、不同的使用方法、常见实践以及最佳实践。选择合适的天气 API 和库，并结合良好的错误处理和缓存机制，可以帮助你高效、稳定地获取天气数据，并应用到各种实际项目中。

## 参考资料
- [OpenWeatherMap API 文档](https://openweathermap.org/api)
- [pyowm 官方文档](https://pyowm.readthedocs.io/en/latest/)
- [requests 官方文档](https://requests.readthedocs.io/en/latest/)
- [geopy 官方文档](https://geopy.readthedocs.io/en/latest/)
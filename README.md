# ⛅ Weather News (실시간 위치 기반 날씨 앱)
* 사용된 API : Openweather API(날씨 데이터를 실시간으로 받을 수 있는 OpenAPI) - (https://openweathermap.org/)<br><br><br><br><br>
## 프로젝트 소개
* Weather News는 날씨API를 활용하여 실시간으로 내가 있는 지역의 다양한 날씨 정보들을 얻을 수 있는 애플리케이션입니다.<br><br>
## 1. 개발 환경 및 기술 스택
![image](https://github.com/user-attachments/assets/a639c7ff-5790-402d-ac26-734a52d9faba)
AndroidStudio
<div align="center"><h3>✨Tech Stack✨</h3></div>
<div align="center">
<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=Dart&logoColor=black">
<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=black">
</div><br><br>

## 2. 상세 기능 소개
### [메인UI]
- 좌측 사이드바
  - 메인 화면으로 돌아오는 Home탭과 Setting탭
<br>

| 사이드바 |
|-----------|
|<img src="https://github.com/user-attachments/assets/c87dde43-3593-47a4-b21f-fe6dd2f0b9aa" alt="Image" width="300" />|

<br>

- 메인 화면
  - 아래로 스크롤 하면 새로고침 되면서 위치정보과 날씨정보를 업데이트 한다.

| 메인화면 업데이트 |
|-----------|
|<img src="https://github.com/user-attachments/assets/32a104a2-2847-4502-9e35-340889cb0bcc" alt="Image" width="300" />|

<br>

- ![image](https://github.com/user-attachments/assets/a9788d54-73e6-4009-969e-8eeaae1fd57e)
우측 상단의 아이콘을 누르면 위치 정보가 정상적으로 불러와지는지 확인할 수 있다.
  - Geolocator 플러그인을 사용해 위치 정보를 가져온다

| 위치 업데이트 |
|-----------|
|<img src="https://github.com/user-attachments/assets/bfa6b611-990e-4e8b-960a-c39948b7e890" alt="Image" width="300" />|

<br>

- 불러온 데이터에 따라 테마가 변경된다.
  - 기온이 일정 기온 이하면 차가운 테마로 변경되고 이상이면 따뜻한 테마로 변경된다.
- Title Section : 제목
- Temp Section : 위치 및 온도
- Icon Section : 날씨 아이콘
- Image Section : 중앙 배경
- More Information Section : 상세 정보

| 일정 기온 이상일 때 테마 | 일정 기온 이하일 때 테마|
|--------------------------|--------------------------|
|<img src="https://github.com/user-attachments/assets/b2f77e5a-b9c9-4c99-8758-32a9beaec371" alt="Image" width="300" />|<img src="https://github.com/user-attachments/assets/c0c15f26-b7d7-4ebe-96a2-0f36394c4355" alt="Image" width="300" />|

<br><br>

## 3. API 데이터 분류
### 위치, 날씨, 중요 데이터, 바람, 비, 구름, ... , 도시, 데이터 상태

```javascript
{
  "coord": {
    "lon": 10.99,
    "lat": 44.34
  },
  "weather": [
    {
      "id": 501,
      "main": "Rain",
      "description": "moderate rain",
      "icon": "10d"
    }
  ],
```
```javascript
"base": "stations",
  "main": {
    "temp": 298.48,
    "feels_like": 298.74,
    "temp_min": 297.56,
    "temp_max": 300.05,
    "pressure": 1015,
    "humidity": 64,
    "sea_level": 1015,
    "grnd_level": 933
  },
```
```javascript
"visibility": 10000,
  "wind": {
    "speed": 0.62,
    "deg": 349,
    "gust": 1.18
  },
  "rain": {
    "1h": 3.16
  },
  "clouds": {
    "all": 100
  },
```
```javascript
 "dt": 1661870592,
  "sys": {
    "type": 2,
    "id": 2075663,
    "country": "IT",
    "sunrise": 1661834187,
    "sunset": 1661882248
  },
  "timezone": 7200,
  "id": 3163858,
  "name": "Zocca",
  "cod": 200
}
```

<br>

## 4. 개선 목표
- 스플래쉬 화면 오류 개선하

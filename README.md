# ⛅ WeatherNews - (실시간 위치 기반 날씨 앱)
* 사용된 API : Openweather API(날씨 데이터를 실시간으로 받을 수 있는 OpenAPI) - (https://openweathermap.org/)<br>

## 개요 (Overview)

이 애플리케이션은 OpenWeatherMap API와 GPS 위치 정보를 활용하여 사용자의 현재 위치 기반 실시간 날씨 정보를 제공하는 모바일 애플리케이션이다. 온도에 따라 동적으로 변화하는 UI와 상세한 기상 정보를 직관적인 인터페이스로 제공한다.

## 앱 스크린샷
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

## 주요 기능 (Features)

* GPS 기반 현재 위치 자동 감지 및 날씨 정보 조회
* 실시간 온도, 습도, 풍속, 가시성 등 상세 기상 정보 표시
* 온도에 따른 동적 UI 색상 변경 (21°C 기준 Cool/Warm 테마)
* Pull-to-refresh를 통한 날씨 정보 실시간 업데이트
* 일출/일몰 시간 정보 제공
* 최고/최저 온도 표시
* 사이드 드로워 메뉴를 통한 네비게이션
* 네이티브 스플래시 화면 구현

## 기술 스택 및 주요 의존성 (Tech Stack & Key Dependencies)

### Framework & Language
* **Flutter SDK:** 3.4.3 이상
* **Dart SDK:** 3.4.3 이상

### 상태 관리 (State Management)
* StatefulWidget을 활용한 기본 상태 관리
* setState()를 통한 UI 업데이트

### 라우팅 (Routing)
* Flutter 기본 Navigator 사용

### 주요 패키지 (Key Packages)

#### 네트워킹 및 API
* `http: ^0.13.4` - OpenWeatherMap API 통신
* `intl: ^0.17.0` - 날짜 및 시간 포맷팅

#### 위치 및 권한
* `geolocator: ^8.2.1` - GPS 위치 정보 획득
* `permission_handler: ^10.0.0` - 위치 권한 관리

#### UI/UX
* `flutter_native_splash: ^2.4.1` - 네이티브 스플래시 화면
* `pull_to_refresh: ^1.6.1` - Pull-to-refresh 기능
* `font_awesome_flutter: ^10.1.0` - 아이콘 폰트

#### 로컬 저장소
* `shared_preferences: ^2.0.15` - 간단한 데이터 저장
* `sqflite: ^2.0.2+1` - SQLite 데이터베이스
* `provider: ^6.0.2` - 상태 관리 (향후 확장용)

#### 기타
* `image_picker: ^0.8.5+3` - 이미지 선택 기능
* `cupertino_icons: ^1.0.6` - iOS 스타일 아이콘

### 아키텍처 (Architecture)
* 단순한 2-Layer 구조 (Presentation Layer)
* FutureBuilder를 활용한 비동기 데이터 처리
* OpenWeatherMap API를 직접 호출하는 구조

## 프로젝트 설정 및 실행 방법 (Project Setup & How to Run)

### 필수 조건 (Prerequisites)
* Flutter SDK 3.4.3 이상
* Dart SDK 3.4.3 이상
* Android Studio / VS Code (Flutter 플러그인 설치)
* OpenWeatherMap API 키 (https://openweathermap.org/api 에서 발급)

### 설치 및 실행

1. **레포지토리 클론**
   ```bash
   git clone [레포지토리 주소]
   ```

2. **프로젝트 폴더로 이동**
   ```bash
   cd final_project_flutter
   ```

3. **의존성 패키지 설치**
   ```bash
   flutter pub get
   ```

4. **OpenWeatherMap API 키 설정**
   * `lib/HomePage.dart` 파일을 열고 다음 라인을 수정:
   ```dart
   String appid = 'appid=YOUR_API_KEY_HERE&';
   ```

5. **스플래시 화면 생성**
   ```bash
   flutter pub run flutter_native_splash:create
   ```

6. **앱 실행**
   ```bash
   flutter run
   ```

### 플랫폼별 추가 설정

#### Android
* 최소 SDK 버전: Flutter 기본값
* 위치 권한이 AndroidManifest.xml에 이미 추가됨

#### iOS
* iOS 12.0 이상
* Info.plist에 위치 권한 설명 추가 필요 (NSLocationWhenInUseUsageDescription)

## 프로젝트 구조 (Project Structure)

```
lib/
├── main.dart          # 앱 진입점, 스플래시 화면 초기화
└── HomePage.dart      # 메인 날씨 화면 및 비즈니스 로직

android/               # Android 플랫폼별 설정
├── app/
│   └── src/main/
│       ├── AndroidManifest.xml  # 위치 권한 설정
│       └── res/                  # 스플래시 화면 리소스

ios/                   # iOS 플랫폼별 설정
├── Runner/
│   ├── Info.plist     # 앱 권한 및 설정
│   └── Assets.xcassets/  # 앱 아이콘 및 스플래시 이미지

images/                # 앱 내 이미지 리소스
├── hotImg.png        # 따뜻한 날씨 배경 이미지
├── coldImg.png       # 추운 날씨 배경 이미지
└── splash_screen.png # 스플래시 화면 이미지
```

## API 정보

이 애플리케이션은 OpenWeatherMap API를 사용한다:
* API 엔드포인트: `http://api.openweathermap.org/data/2.5/weather`
* 필요한 파라미터: 위도(lat), 경도(lon), API 키(appid)
* 응답 형식: JSON
* 단위: Metric (섭씨 온도)

## 주요 기능 상세

### 위치 권한 관리
* Geolocator 패키지를 통한 위치 권한 요청
* 권한 상태에 따른 GPS 아이콘 표시 (활성/비활성)

### 날씨 데이터 표시
* 현재 온도 및 체감 온도
* 최고/최저 온도
* 습도, 가시성, 풍속, 풍향
* 일출/일몰 시간
* 날씨 아이콘 (OpenWeatherMap 제공)

### UI/UX 특징
* 온도 기반 테마 변경 (21°C 기준)
  * Cool Theme: 파란색 계열 (#53ABCC)
  * Warm Theme: 주황색 계열 (#FCCB7F)
* Pull-to-refresh로 데이터 새로고침
* 마지막 업데이트 시간 표시



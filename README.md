# 이상청 앱 - 날씨를 간단하게 체크 할 수 있는 어플리케이션

https://github.com/baka9131/QuickWeatherApp/assets/93738662/87dad208-8edd-4146-b590-2c32243e2cb4

+ 현재 자신의 위치를 통해 현재 날씨를 빠르고 간단하게 확인 할 수 있는 앱 입니다.

<br>

## 기능 상세 명세

> ### 사용된 패키지
>
> 1. geolocator: ^10.1.0 / 사용자의 현재 위도와 경도 추적 목적
> 2. geocoding / 위도와 경도를 통해 사용자의 도로명 주소 판별 목적
> 3. lottie / Lottie 이미지 아이콘 사용 목적
> 4. http / 기상청 날씨 API를 가져오기 위한 목적
> 5. fluttertoast / 오류 메세지를 띄우기 위한 목적
> 6. collection / 리스트에있는 값을 가져올때 NULL값 반환을 위한 목적
> 7. flutter_launcher_icons / 앱 아이콘을 생성하기 위한 목적 (실제로는 수동으로 적용)

<br>

> ### 기능 구현에 필요한 사용자 요청 부분
>
> 1. 사용자의 위치정보 ACCESS권한 요청
>
>    ```dart
>    // AOS 권한 획득
>    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
>    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
>      
>    // IOS 권한 획득
>    <key>NSLocationWhenInUseUsageDescription</key>
>    <string>사용자의 앱을 사용할시 위치정보 권한을 획득합니다.</string>
>    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
>    <string>사용자의 앱을 사용할시 항상 위치정보 권한을 획득합니다.</string>
>    ```

<br>

> ### 기능에 대한 간략 설명
>
> 1. 사용자의 위치정보를 기반으로 주소를 가져 옵니다.
>    1. <img width="251" alt="image" src="https://github.com/baka9131/QuickWeatherApp/assets/93738662/43c63e2d-6b07-4a4f-93a9-c06a50db7438">
>
> 2. 현재시간을 기준으로 아래 값을 가져 옵니다.
>
>    1. (날씨 아이콘) / 현재 온도 / 날씨 상황
>
>    2. (습도) / (풍향) / (풍속)
>
>    3. <img width="250" alt="image" src="https://github.com/baka9131/QuickWeatherApp/assets/93738662/91bcf6fa-73db-4142-bbbc-4e8f9a5500ce">
>
> 3. 현재 시간 + 1 이후의 3일치 날씨의 정보를 ListView형태로 보여줍니다.
>    1. <img width="253" alt="image" src="https://github.com/baka9131/QuickWeatherApp/assets/93738662/707c0c25-ee73-421e-bc0e-36113b523ee2">
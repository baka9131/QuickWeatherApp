import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:simple_weather_app/const/custom_box.dart';
import 'package:simple_weather_app/const/data.dart';
import 'package:simple_weather_app/data/service.dart';
import '../data/transfer.dart';
import '../provider/providers.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return customedBox(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(Provider.of<UserAddress>(context).address),
          /* 위치정보를 받아오는 버튼 */
          IconButton(
            onPressed: () {
              _determinePosition().then(
                (position) {
                  WeatherMapXY xy = changelaluMap(position['longitude'] ?? 0.0, position['latitude'] ?? 0.0);
                  x = xy.x;
                  y = xy.y;
                  log('x좌표 : $x / y좌표 : $y');

                  _getAddressFromLatLng(context, position['latitude'], position['longitude']);
                  Services().getInfo(context).then(
                    (value) {
                      Provider.of<WeatherList>(context, listen: false).setWeatherList(value);
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.gps_fixed_rounded),
          ),
        ],
      ),
    );
  }
}

/* 위치정보 좌표값을 가져오는 함수 [Geolocation] */
Future<Map<String, double>> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  // 사용자의 위치값을 Provider 상태관리를 이용하여 저장
  // Provider.of<UserLocation>(context, listen: false).setLocation(position.longitude, position.latitude);
  return {'longitude': position.longitude, 'latitude': position.latitude};
}

/* 좌표값을 주소값으로 바꿔주는 함수 [Geocoding] */
void _getAddressFromLatLng(context, latitude, longitude) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

  if (placemarks.isNotEmpty) {
    // Country (국가): 주소가 속한 국가의 이름입니다. 예를 들어, "미국", "한국"과 같이 주소가 위치한 국가를 나타냅니다.
    // Administrative Area (행정 구역): 주소가 속한 주 또는 지방의 이름입니다. 미국의 경우, '캘리포니아 주', '뉴욕 주' 등이 이에 해당합니다. 다른 나라에서는 해당 나라의 행정 구역에 따라 다를 수 있습니다.
    // Subadministrative Area (하위 행정 구역): 주소가 속한 보다 작은 행정 구역의 이름입니다. 일반적으로 카운티 또는 구를 의미할 수 있습니다.
    // Locality (지역/도시): 주소가 속한 도시 또는 마을의 이름입니다. 예를 들어, '서울', '뉴욕시' 등이 여기에 해당합니다.
    // SubLocality (하위 지역/도시): 주소 내의 더 작은 구역이나 동네를 나타냅니다. 큰 도시 내의 특정 지역이나 구역을 지칭할 수 있습니다.
    // Thoroughfare (도로명): 주소의 도로명을 나타냅니다. 예를 들어, '5번가', '역삼로' 등이 여기에 해당합니다.
    // SubThoroughfare (하위 도로명): 도로명 내에서 더 세분화된 구역이나 번지 수를 나타냅니다. 예를 들어, 도로명에 해당하는 번지나 빌딩 번호 등이 이에 속합니다.
    // Postal Code (우편번호): 주소의 지리적 위치를 식별하는 데 사용되는 숫자 또는 문자의 조합입니다. 특정 지역 또는 배송 구역을 나타내는 데 사용됩니다.

    Placemark place = placemarks[0];

    // Set을 통해 주소명 중복값 제거 (NUll 체크를 하지 않으면 공백도 같이 문자열에 추가되기에 반드시 체크해야함)
    List<String?> addressParts = {
      place.administrativeArea,
      place.subAdministrativeArea,
      place.locality,
      place.subLocality,
      place.thoroughfare,
    }.where((s) => s != null && s.isNotEmpty).toList();
    String formattedAddress = addressParts.join(' ');

    Provider.of<UserAddress>(context, listen: false).setAddress(formattedAddress);
  } else {
    Provider.of<UserAddress>(context, listen: false).setAddress("주소값을 불러오지 못했습니다.");
  }
}

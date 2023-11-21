import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/const/data.dart';
import 'package:simple_weather_app/data/weather.dart';

class Services {
  static String url = 'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$serviceKey&pageNo=1&numOfRows=1000&dataType=JSON&base_date=$formattedDate&base_time=0200&nx=$x&ny=$y';
  // static String url = 'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$serviceKey&pageNo=1&numOfRows=1000&dataType=JSON&base_date=20231120&base_time=0200&nx=$x&ny=$y';

  /* 서버에 API 호출 요청 */
  Future<List<Item>> getInfo(context) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = await json.decode(response.body);
        List<Item> items = WeatherJson.fromJson(data).response.body.items.item;
        return items;
      } else {
        Fluttertoast.showToast(msg: '데이터 불러오기 실패. 잠시 후 다시 시도해 주세요.');
        return <Item>[];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '데이터 불러오기 실패. 잠시 후 다시 시도해 주세요.');
      return <Item>[];
    }
  }
}

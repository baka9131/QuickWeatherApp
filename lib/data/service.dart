import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:simple_weather_app/data/weather.dart';

class Services {
  int x;
  int y;
  Services({required this.x, required this.y});

  String apiKey = dotenv.env['SERVICE_KEY'] ?? '';
  
  String formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());

  String getUrl(String formattedDate, int x, int y) {
    return 'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$apiKey&pageNo=1&numOfRows=1000&dataType=JSON&base_date=$formattedDate&base_time=0200&nx=$x&ny=$y';
  }

  /* 서버에 API 호출 요청 */
  Future<List<Item>> getInfo(context) async {
    try {
      final response = await http.get(Uri.parse(getUrl(formattedDate, x, y)));

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

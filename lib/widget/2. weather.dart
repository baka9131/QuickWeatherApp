import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_weather_app/const/custom_box.dart';
import 'package:simple_weather_app/const/font.dart';
import 'package:simple_weather_app/const/lottie.dart';
import 'package:simple_weather_app/data/weather.dart';
import 'package:simple_weather_app/provider/providers.dart';

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return customedBox(child(context));
  }

  Widget child(context) {
    List<Item> weatherList = Provider.of<WeatherList>(context).weatherList;
    // 현재 시간에 해당하는 fcstTime 포맷 가져오기
    String currentDate = DateFormat('yyyyMMdd').format(DateTime.now());
    String currentTime = DateFormat('HH00').format(DateTime.now());

    // 현재 시간과 날짜에 해당하는 아이템들 필터링
    List<Item> filteredItems = weatherList.where((item) => item.fcstTime == currentTime && item.fcstDate == currentDate).toList();
    // 조건을 만족하는 요소가 없을 경우 null이 반환되어 StateError가 발생하지 않음 (패키지 콜렉션 사용)
    Item? ptyItem = filteredItems.firstWhereOrNull((item) => item.category == Category.PTY);
    Item? skyItem = filteredItems.firstWhereOrNull((item) => item.category == Category.SKY);

    log('${ptyItem?.fcstDate}');
    log('${ptyItem?.fcstTime}');
    log('${ptyItem?.fcstValue}');
    log('${skyItem?.fcstValue}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (filteredItems.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.orange.shade100,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset('assets/imgs/logo_mark.png', width: 25, height: 25),
                      // const SizedBox(width: 10),
                      Text('기상청 제공'),
                    ],
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Text(filteredItems.isNotEmpty ? '기준시간 ${filteredItems[0].fcstDate} / ${filteredItems[0].fcstTime}' : ''),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            renderWeatherImage(ptyItem, skyItem) ?? const Text(''),
            for (var item in filteredItems)
              Text(
                item.category == Category.TMP ? '${item.fcstValue}°C / ' : '',
                style: boldText,
              ),
            weatherState(ptyItem, skyItem) ?? const Text(''),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var item in filteredItems) ...[
              Text(item.category == Category.REH ? '습도 ' : '', style: lightnomalText),
              Text(item.category == Category.REH ? '${item.fcstValue}%' : '', style: boldText.copyWith(fontSize: 16)),
            ],
            const SizedBox(width: 10),
            for (var item in filteredItems) ...[
              Text(item.category == Category.VEC ? '풍향 ' : '', style: lightnomalText),
              Text(item.category == Category.VEC ? '${item.fcstValue} deg' : '', style: boldText.copyWith(fontSize: 16)),
            ],
            const SizedBox(width: 10),
            for (var item in filteredItems) ...[
              Text(item.category == Category.WSD ? '풍속 ' : '', style: lightnomalText),
              Text(item.category == Category.WSD ? '${item.fcstValue} m/s' : '', style: boldText.copyWith(fontSize: 16)),
            ],
          ],
        ),
      ],
    );
  }

  LottieBuilder? renderWeatherImage(Item? pty, Item? sky) {
    if (pty?.fcstValue == '0') {
      if (sky?.fcstValue == '1') {
        // 맑음
        return lottieSunny;
      } else if (sky?.fcstValue == '3') {
        // 구름 많음
        return lottieCloudy;
      } else if (sky?.fcstValue == '4') {
        // 흐림
        return lottieManyCloud;
      } else {
        return null;
      }
    } else {
      if (pty?.fcstValue == '1') {
        // 비
        return lottieRainning;
      } else if (pty?.fcstValue == '2') {
        // 비/눈
        return lottieRainAndSnowing;
      } else if (pty?.fcstValue == '3') {
        // 눈
        return lottieSnowing;
      } else if (pty?.fcstValue == '4') {
        // 소나기
        return lottieHeavyRain;
      } else {
        return null;
      }
    }
  }

  Text? weatherState(Item? pty, Item? sky) {
    if (pty?.fcstValue == '0') {
      if (sky?.fcstValue == '1') {
        // 맑음
        return Text('맑음', style: boldText);
      } else if (sky?.fcstValue == '3') {
        // 구름 많음
        return Text('구름 많음', style: boldText);
      } else if (sky?.fcstValue == '4') {
        // 흐림
        return Text('흐림', style: boldText);
      } else {
        return null;
      }
    } else {
      if (pty?.fcstValue == '1') {
        // 비
        return Text('비', style: boldText);
      } else if (pty?.fcstValue == '2') {
        // 비/눈
        return Text('비/눈', style: boldText);
      } else if (pty?.fcstValue == '3') {
        // 눈
        return Text('눈', style: boldText);
      } else if (pty?.fcstValue == '4') {
        // 소나기
        return Text('소나기', style: boldText);
      } else {
        return null;
      }
    }
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../const/custom_box.dart';
import '../const/font.dart';
import '../const/lottie.dart';
import '../data/weather.dart';
import '../provider/providers.dart';

class OtherDaysWeather extends StatelessWidget {
  const OtherDaysWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return customedBox(
      _child(context),
    );
  }

  Widget _child(context) {
    String currentDate = DateFormat('yyyyMMdd').format(DateTime.now());
    int currentTime = int.parse(DateFormat('HH').format(DateTime.now().add(const Duration(hours: 1))));
    // log('+1 시간값 : $currentTime');
    // Base_time : 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300 (1일 8회)

    // TMP, SKY, PTY 씩 3개씩 계속 출력
    List<Item> filteredItems = Provider.of<WeatherList>(context)
        .weatherList
        .where((item) =>
            ((int.parse(item.fcstTime.substring(0, 2)) >= currentTime && item.fcstDate == currentDate) || (item.fcstDate != currentDate)) &&
            (item.category == Category.TMP || item.category == Category.SKY || item.category == Category.PTY || item.category == Category.POP || item.category == Category.PCP))
        .toList();
    for (Item i in filteredItems) {
      log('카테고리 : ${i.category}\n기준 날짜 : ${i.fcstDate}\n기준 시간 : ${i.fcstTime}\n데이터 값 : ${i.fcstValue}\nX좌표 : ${i.nx}\nY좌표 : ${i.ny}\n');
    }

    return SizedBox(
      height: 215,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: filteredItems.length,
        itemBuilder: (context, index) => Column(
          children: [
            renderWeatherImage(filteredItems, index) ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget? renderWeatherImage(List<Item> items, index) {
    // PTY의 값이 0일 경우 (비가 안올 경우 케이스)
    if (items[index].category == Category.PTY && items[index].fcstValue == '0') {
      // 맑음
      if (items[index - 1].fcstValue == '1') {
        if (18 <= int.parse(items[index - 1].fcstTime.toString().substring(0, 2)) || int.parse(items[index - 1].fcstTime.toString().substring(0, 2)) <= 7) {
          return renderContainer(items[index - 2], items[index - 1], lottieNight, items[index + 1], items[index + 2]); // tmp, sky
        }
        return renderContainer(items[index - 2], items[index - 1], lottieSunny, items[index + 1], items[index + 2]); // tmp, sky
      }
      // 구름 많음
      else if (items[index - 1].fcstValue == '3') {
        return renderContainer(items[index - 2], items[index - 1], lottieCloudy, items[index + 1], items[index + 2]); // tmp, sky
      }
      // 흐림
      else if (items[index - 1].fcstValue == '4') {
        return renderContainer(items[index - 2], items[index - 1], lottieManyCloud, items[index + 1], items[index + 2]); // tmp, sky
      }
    } else if (items[index].category == Category.PTY && items[index].fcstValue != '0') {
      // 비
      if (items[index].fcstValue == '1') {
        return renderContainer(items[index - 2], items[index - 1], lottieRainning, items[index + 1], items[index + 2]); // tmp, sky
      }
      // 비/눈
      else if (items[index].fcstValue == '2') {
        return renderContainer(items[index - 2], items[index - 1], lottieRainAndSnowing, items[index + 1], items[index + 2]); // tmp, sky
      } // 눈
      else if (items[index].fcstValue == '3') {
        return renderContainer(items[index - 2], items[index - 1], lottieSnowing, items[index + 1], items[index + 2]); // tmp, sky
      } else if (items[index].fcstValue == '4') {
        return renderContainer(items[index - 2], items[index - 1], lottieHeavyRain, items[index + 1], items[index + 2]); // tmp, sky
      }
    }
    return null;
  }
}

Widget renderContainer(Item tmpItem, Item dataAndTimeItem, weatherLottie, Item pop, Item pcp) {
  return Container(
    decoration: dataAndTimeItem.fcstTime.substring(0, 2) == '00'
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.black,
              width: 3.0,
            ),
          )
        : null,
    child: Column(
      children: [
        Text('${tmpItem.fcstValue}°C', style: boldText),
        const SizedBox(height: 6.0),
        Text('${dataAndTimeItem.fcstTime.substring(0, 2)}시'),
        weatherLottie,
        Text('${dataAndTimeItem.fcstDate.substring(4, 6)}/${dataAndTimeItem.fcstDate.substring(6)}'),
        const SizedBox(height: 6.0),
        pop.fcstValue != '0' ? Text('강수확률 ${pop.fcstValue}%') : const Text(''),
        pcp.fcstValue != '강수없음' ? Text('강수량 ${pcp.fcstValue}') : const Text(''),
      ],
    ),
  );
}

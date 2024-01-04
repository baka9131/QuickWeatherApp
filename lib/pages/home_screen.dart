import 'package:flutter/material.dart';
import 'package:simple_weather_app/widget/1.%20my_location.dart';
import 'package:simple_weather_app/widget/3.%20other_days_weather.dart';
import 'package:simple_weather_app/widget/4.%20policy.dart';

import '../widget/2. weather.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '이상청 날씨누리',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.yellow[200],
          // Drawer 버튼 아이콘 색상 변경을 위해 아래 코드 추가
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        // 아직 미완성
        // drawer: Drawer(
        //   surfaceTintColor: Colors.black,
        //   shadowColor: Colors.black,
        //   child: ListView(
        //     children: const [
        //       SizedBox(
        //         height: 80,
        //         child: DrawerHeader(
        //           decoration: BoxDecoration(
        //             color: Colors.black,
        //           ),
        //           child: Text(
        //             '추가 기능',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 24,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MyLocation(),
              const SizedBox(height: 25),
              const Weather(),
              const SizedBox(height: 25),
              const OtherDaysWeather(),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Policy())),
                child: const Text(
                  '개인정보 방침',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

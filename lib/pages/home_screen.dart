import 'package:flutter/material.dart';
import 'package:simple_weather_app/widget/1.%20my_location.dart';
import 'package:simple_weather_app/widget/3.%20other_days_weather.dart';
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
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: [
                MyLocation(),
                SizedBox(height: 25),
                Weather(),
                SizedBox(height: 25),
                OtherDaysWeather(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:simple_weather_app/provider/providers.dart';
import 'pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "key.env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserLocation()),
        ChangeNotifierProvider(create: (context) => UserAddress()),
        ChangeNotifierProvider(create: (context) => WeatherList()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

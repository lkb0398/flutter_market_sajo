import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/view/login_page.dart';
import 'package:flutter_market_sajo/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market Sajo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: SplashScreen(), // 스플레시 페이지
      routes: {'/login': (context) => LoginPage()}, // Route 로 로그인 페이지로 이동
    );
  }
}

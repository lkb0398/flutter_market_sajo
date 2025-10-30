import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/view/pages/splash_page.dart';

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
      // 라우트 사용 코드
      // routes: {'/login': (context) => LoginPage()},
    );
  }
}

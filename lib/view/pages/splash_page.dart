import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/view/pages/login_page.dart';

// 스플래시 페이지
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // 일정 시간 후
    Future.delayed(Duration(seconds: 2), () {
      // 로그인 화면으로 이동
      // 라우트 사용 코드 : Navigator.pushReplacementNamed(context, '/login');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/splash.webp")),
    );
  }
}

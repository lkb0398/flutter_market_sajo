import 'package:flutter/material.dart';

// 타이틀 이미지 위젯
class TitleImage extends StatelessWidget {
  const TitleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/logo.webp", height: 200);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/view/title_image.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void authentication() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TitleImage()),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text("아아디"),
            TextField(
              decoration: InputDecoration(
                hintText: "아이디를 입력해주세요.",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text("아아디"),
            TextField(
              decoration: InputDecoration(
                hintText: "비밀번호를 입력해주세요.",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder(), ),
              child: Text("로그인"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/login_info.dart';
import 'package:flutter_market_sajo/view/home_page.dart';
import 'package:flutter_market_sajo/view/text_input_box.dart';
import 'package:flutter_market_sajo/view/title_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // 사용자 입력값 받기 (TextField)
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TitleImage()),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 아이디 입력
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text("아이디"),
                TextInputBox(
                  maxLines: 1,
                  controller: idController,
                  hintText: "admin",
                ),
              ],
            ),
            SizedBox(height: 20),
            // 비밀번호 입력
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text("비밀번호"),
                TextInputBox(
                  maxLines: 1,
                  controller: pwController,
                  hintText: "sajo1004",
                ),
              ],
            ),
            SizedBox(height: 50),
            // 등록하기
            GestureDetector(
              onTap: () {
                // 예외 처리
                if (idController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "아이디를 입력하세요",
                    gravity: ToastGravity.CENTER,
                  );
                } else if (idController.text != LoginInfo().id) {
                  Fluttertoast.showToast(
                    msg: "잘못된 아이디입니다",
                    gravity: ToastGravity.CENTER,
                  );
                } else if (pwController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "비밀번호를 입력하세요",
                    gravity: ToastGravity.CENTER,
                  );
                } else if (pwController.text != LoginInfo().pw) {
                  Fluttertoast.showToast(
                    msg: "잘못된 비밀번호입니다",
                    gravity: ToastGravity.CENTER,
                  );
                } else {
                  // 정상 입력 시
                  Fluttertoast.showToast(
                    msg: "로그인에 성공했습니다",
                    gravity: ToastGravity.CENTER,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Color(0xFFA70E0E),
                child: Center(child: Text("로그인")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

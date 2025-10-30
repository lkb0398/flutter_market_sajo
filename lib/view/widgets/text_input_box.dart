import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/theme.dart';

// 텍스트 입력창 위젯
class TextInputBox extends StatelessWidget {
  const TextInputBox({
    super.key,
    required this.maxLines,
    required this.controller,
    this.hintText = "",
  });

  final int maxLines;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      maxLines: maxLines,
      cursorColor: cRed,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cRed, width: 2),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
      ),
    );
  }
}

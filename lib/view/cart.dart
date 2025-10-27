import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF242424),
        title: Image.asset("assets/images/logo.webp", height: 200),
      ),
      body: Expanded(
        child: ListView.builder(itemBuilder: (context, index) => Column()),
      ),
    );
  }
}

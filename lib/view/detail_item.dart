import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/title_image.dart';
import 'package:intl/intl.dart';

class DetailItem extends StatefulWidget {
  const DetailItem({super.key, required this.itemModel});
  final ItemModel itemModel;
  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF242424),
        title: TitleImage(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Image(
                      image: widget.itemModel.image.image,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '상품명: ${widget.itemModel.productName}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '상품 가격: ${NumberFormat("#,###").format(widget.itemModel.price)}원',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              const Text("상품 설명", style: TextStyle(fontSize: 20)),
              Text(
                widget.itemModel.description,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 70,
          color: const Color(0xFF242424),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (number > 1) number--;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA70E0E),
                ),
                child: const Icon(Icons.remove, size: 20),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                color: Color(0xFFA70E0E),
                child: Text(
                  '$number',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (number < 99) number++;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA70E0E),
                  minimumSize: const Size(40, 40),
                ),
                child: const Icon(Icons.add, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AutoSizeText(
                      '총 가격',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      '${NumberFormat("#,###").format(widget.itemModel.price * number)} 원',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('장바구니에 담겼습니다.'),
                      content: Text(
                        '총 ${NumberFormat("#,###").format(widget.itemModel.price * number)}원을 장바구니에 담으시겠습니까?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('더 구경하기'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('장바구니 보기'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA70E0E),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  '장바구니',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

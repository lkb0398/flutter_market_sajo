import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_market_sajo/model/item_model.dart';

// 상품 상세 화면
// 홈에서 상품을 클릭하면 디테일 화면으로 이동
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.item});
  final ItemModel item;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late int qty;

// 처음 수량은 1로 설정되어 있음
  @override
  void initState() {
    super.initState();
    qty = widget.item.productCount ?? 1;
  }
// 정수 가격을 콤마 붙인 문자열로 변환
  String _formatWon(int value) {
    final s = value.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      int idxFromLeft = i;
      int remain = (s.length - idxFromLeft) % 3;
      buf.write(s[i]);
      final posFromRight = s.length - i - 1;
      if (posFromRight % 3 == 0 && i != s.length - 1) buf.write(',');
    }
    return '$buf원';
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          "assets/images/logo.webp",
          height: 40,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF242424),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 대표 이미지
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2F6BFF), width: 3),
              ),
              clipBehavior: Clip.antiAlias,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: item.image, // ItemModel이 Image를 보관하므로 그대로 사용
              ),
            ),
            const SizedBox(height: 16),
            // 제목과 가격
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.productName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  _formatWon(item.price),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1),
            const SizedBox(height: 12),

            // 빈 정보 박스(예시와 동일한 레이아웃 유지용)
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
            ),
            const SizedBox(height: 16),

            // 설명 라벨
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '상품 내용',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 8),

            // 설명 박스
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.description,
                style: const TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 80), // 하단바와 간격
          ],
        ),
      ),

      // 하단 조작 바
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: const Color(0xFF242424),
          child: Row(
            children: [
              // 수량 조절
              Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFB44336),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() => qty = qty > 1 ? qty - 1 : 1);
                      },
                      icon: const Icon(Icons.remove),
                      constraints: const BoxConstraints(minWidth: 36),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(
                      width: 36,
                      child: Center(
                        child: Text(
                          '$qty',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() => qty += 1);
                      },
                      icon: const Icon(Icons.add),
                      constraints: const BoxConstraints(minWidth: 36),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // 장바구니
              SizedBox(
                height: 44,
                width: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    item.productCount = qty;
                    item.cart = true;
                    Fluttertoast.showToast(msg: '장바구니에 담았습니다');
                    // 장바구니 페이지가 없으므로 현재는 토스트만
                  },
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
              const SizedBox(width: 16),

              // 구매하기
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB44336),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      item.productCount = qty;
                      Fluttertoast.showToast(msg: '구매하기 진행');
                    },
                    child: const Text(
                      '구매하기',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

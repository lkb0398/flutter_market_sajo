import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';

class DetailItem extends StatefulWidget {
  const DetailItem({super.key, required this.itemModel});
  final ItemModel itemModel;
  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Title")),
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
                widget.itemModel.productName,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 16),
              Text('${widget.itemModel.price}', style: TextStyle(fontSize: 15)),
              SizedBox(height: 16),
              Text(
                widget.itemModel.description,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Color(0xFFA70E0E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(children: [
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

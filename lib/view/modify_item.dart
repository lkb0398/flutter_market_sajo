import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/text_input_box.dart';
import 'package:flutter_market_sajo/view/title_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

// 상품 수정 페이지
class ModifyItem extends StatefulWidget {
  const ModifyItem({super.key, required this.itemModel});

  final ItemModel itemModel;

  @override
  State<ModifyItem> createState() => _ModifyItemState();
}

class _ModifyItemState extends State<ModifyItem> {
  // 사용자 입력값 받기 (TextField)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? image;

  @override
  void initState() {
    super.initState();
    // 기존 상품 정보 불러오기
    nameController.text = widget.itemModel.productName;
    priceController.text = widget.itemModel.price.toString();
    descriptionController.text = widget.itemModel.description;
  }

  // 상품 가격 입력 범위 설정
  int numberSizeCheck(int number) {
    if (number > 1000000000) {
      return -1;
    }
    return number;
  }

  // 이미지 선택 함수
  void selectImage() {
    ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((pickedFile) {
          if (pickedFile != null) {
            setState(() => image = File(pickedFile.path));
          } else {
            Fluttertoast.showToast(msg: "이미지 선택 취소");
          }
        })
        .catchError((err) {
          Fluttertoast.showToast(msg: "이미지 선택 중 오류 발생: $err");
        });
  }

  // 수정 반영 함수
  void updateItem() {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "상품 이름을 입력하세요", gravity: ToastGravity.CENTER);
    } else if (priceController.text.isEmpty) {
      Fluttertoast.showToast(msg: "상품 가격을 입력하세요", gravity: ToastGravity.CENTER);
    } else if (int.tryParse(priceController.text) == null) {
      Fluttertoast.showToast(
        msg: "상품 가격은 숫자로 입력해야 합니다",
        gravity: ToastGravity.CENTER,
      );
    } else if (numberSizeCheck(int.parse(priceController.text)) < 0) {
      Fluttertoast.showToast(
        msg: "최대가격은 0~10억까지 입력가능합니다.",
        gravity: ToastGravity.CENTER,
      );
    } else if (descriptionController.text.isEmpty) {
      Fluttertoast.showToast(msg: "상품 설명을 입력하세요", gravity: ToastGravity.CENTER);
    } else {
      // itemModel에 직접 수정 반영
      widget.itemModel.productName = nameController.text;
      widget.itemModel.price = int.parse(priceController.text);
      widget.itemModel.description = descriptionController.text;
      if (image != null) {
        widget.itemModel.image = Image.file(image!, height: 100);
      }
      Fluttertoast.showToast(msg: "상품이 수정되었습니다", gravity: ToastGravity.CENTER);
      Navigator.pop(context, widget.itemModel); // 수정된 데이터 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TitleImage()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              // 상품 이미지 선택 영역
              GestureDetector(
                onTap: selectImage,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      width: double.infinity,
                      color: const Color(0xFF242424),
                      child: image != null
                          ? Image.file(image!, fit: BoxFit.cover)
                          : widget.itemModel.image,
                    ),
                  ),
                ),
              ),
              // 상품 이름 입력
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('상품 이름', style: TextStyle(fontSize: 15)),
                  Expanded(
                    child: TextInputBox(
                      maxLines: 1,
                      controller: nameController,
                    ),
                  ),
                ],
              ),
              // 상품 가격 입력
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('상품 가격', style: TextStyle(fontSize: 15)),
                  Expanded(
                    child: TextInputBox(
                      maxLines: 1,
                      controller: priceController,
                    ),
                  ),
                  const Text('원', style: TextStyle(fontSize: 15)),
                ],
              ),
              // 상품 설명 입력
              const Text('상품 설명', style: TextStyle(fontSize: 15)),
              TextInputBox(maxLines: 7, controller: descriptionController),
            ],
          ),
        ),
      ),
      // 수정하기 버튼
      bottomNavigationBar: GestureDetector(
        onTap: updateItem,
        child: Container(
          height: 70,
          width: double.infinity,
          color: const Color(0xFFA70E0E),
          child: Image.asset('assets/images/modify.webp', fit: BoxFit.contain),
        ),
      ),
    );
  }
}

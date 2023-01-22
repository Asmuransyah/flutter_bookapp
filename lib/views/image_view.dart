// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bookapp/colors.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.warna1,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: Image.network(imageUrl),
          ),
        ],
      ),
    );
  }
}

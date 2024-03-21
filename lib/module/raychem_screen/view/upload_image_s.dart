import 'dart:io';

import 'package:ecart/_util/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadImage extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const UploadImage({
    super.key,
    required this.imagePath,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF244078).withOpacity(0.12),
              spreadRadius: 2.0,
              blurRadius: 2.0,
              offset: const Offset(2.0, 2.0)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text("Jointer Photo"),
              const Spacer(),
              GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset(Asset.editIcon),
              )
            ],
          ),
          const SizedBox(height: 8),
          imagePath.isNotEmpty
              ? ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.file(
                    File(imagePath),
                    height: 96,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  Asset.img1,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                )
        ],
      ),
    );
  }
}

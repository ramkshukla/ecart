import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ecart/_util/assets_constants.dart';
import 'package:ecart/_util/common_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  late CameraController controller;
  String imagePth = "";
  @override
  void initState() {
    initalizerCamera();
    super.initState();
  }

  void initalizerCamera() async {
    final camera = await availableCameras();
    cameraController = CameraController(camera.last, ResolutionPreset.medium);
  }

  takeImage() async {
    await cameraController.initialize();
    final XFile image = await cameraController.takePicture();
    setState(() {
      imagePth = image.path;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                      onTap: () {
                        setState(() {
                          takeImage();
                        });
                      },
                      child: SvgPicture.asset(Asset.editIcon),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                imagePth.isNotEmpty
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: Image.file(
                          File(imagePth),
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
          ),
        ],
      ),
    );
  }
}

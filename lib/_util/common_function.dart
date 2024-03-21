import 'package:camera/camera.dart';
import 'package:ecart/_util/assets_constants.dart';
import 'package:ecart/module/raychem_screen/view/raychem_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  void get logIt {
    if (kDebugMode) {
      print(this);
    }
  }
}

late CameraController cameraController;

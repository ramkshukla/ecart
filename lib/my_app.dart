import 'package:ecart/module/raychem_screen/view/raychem_landing.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: RayChemLanding(),
      // home: ECartLanding(),
      // home: Tut(),
      // home: UploadImage(),
    );
  }
}

import 'dart:ui';

import 'package:ecart/_util/assets_constants.dart';
import 'package:ecart/module/raychem_screen/view/raychem_model.dart';

class CommonFunction {
  List<RayChemModel> getData() {
    List<String> icons = [Asset.icon1, Asset.icon2, Asset.icon3, Asset.icon4];
    List<String> task1 = ["25 Task", "25 Task", "25 Task", "25 Task"];
    Map<int, String> task2 = {
      0: "Ongoing",
      1: "On Hold",
      2: "Completed",
      3: "Approved"
    };
    List<Color> color = const [
      Color(0xFFA48C98),
      Color(0xFFE37B78),
      Color(0xFF9EB983),
      Color(0xFFE1AE86)
    ];
    List<RayChemModel> item = List.generate(
      4,
      (index) =>
          RayChemModel(icon: icons, task1: task1, task2: task2, bgColor: color),
    );
    return item;
  }
}

import 'package:ecart/_util/assets_constants.dart';
import 'package:ecart/_util/common_function.dart';
import 'package:ecart/module/raychem_screen/controller/raychem_bloc.dart';
import 'package:ecart/module/raychem_screen/controller/raychem_event.dart';
import 'package:ecart/module/raychem_screen/controller/raychem_state.dart';
import 'package:ecart/module/raychem_screen/view/common_function.dart';
import 'package:ecart/module/raychem_screen/view/raychem_model.dart';
import 'package:ecart/module/raychem_screen/view/upload_image_s.dart';
// import 'package:ecart/module/raychem_screen/view/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RayChemLanding extends StatelessWidget {
  const RayChemLanding({super.key});
  @override
  Widget build(BuildContext context) {
    List<RayChemModel> data = CommonFunction().getData();
    "Data: ${data[0].icon[0]}".logIt;

    return BlocProvider(
      create: (context) => RayChemBloc(),
      child: BlocBuilder<RayChemBloc, RayChemState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 4,
              surfaceTintColor: Colors.white,
              shadowColor: const Color(0xFF244078).withOpacity(0.12),
              leading: Image.asset(Asset.logo),
              leadingWidth: 88,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                const SizedBox(width: 16)
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 29),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return taskCard(
                      data[index].icon[index],
                      data[index].task1[index],
                      data[index].task2[index]!,
                      data[index].bgColor[index],
                    );
                  },
                ),
                const SizedBox(height: 22),
                UploadImage(
                  imagePath: state.imagePath,
                  onTap: () {
                    context.read<RayChemBloc>().add(UploadImageEvent());
                  },
                ),
                // UploadImage(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Choose a task",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          height: 1.5,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(Asset.filter),
                      const SizedBox(width: 4),
                      const Text(
                        "Filters",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            height: 1.5),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (ctx, index) {
                      return taskDetailsCard(
                        context,
                        data[index].task2[index]!,
                        data[index].icon[index],
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget taskCard(String icon, String task1, String task2, Color color) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
      ),
      Stack(
        children: [
          Image.asset(Asset.topShadow),
          Positioned(
            top: 10,
            left: 16,
            child: Image.asset(icon),
          ),
        ],
      ),
      Positioned(
        top: 10,
        right: 12,
        child: Image.asset(Asset.arrow, height: 20, width: 20),
      ),
      Positioned(
        right: 0,
        bottom: 0,
        child: Image.asset(Asset.bottomShadow),
      ),
      Positioned(
          bottom: 8,
          left: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task1,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              Text(
                task2,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ],
          ))
    ],
  );
}

Widget taskDetailsCard(BuildContext context, String task, String icon) {
  "Icon: $icon".logIt;
  return Container(
    margin: const EdgeInsets.only(left: 16, top: 16, bottom: 8, right: 16),
    padding: const EdgeInsets.only(top: 12, left: 20, right: 10, bottom: 11),
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      border: Border(
        left: BorderSide(color: Colors.red, width: 10),
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 5, left: 4, bottom: 4, right: 5),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: const Color(0xFF1D1E47).withOpacity(0.4)),
              child: Image.asset(Asset.taskDetailImg1),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task Title",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: Color(0xFF1D1E47),
                  ),
                ),
                Text(
                  "Task Type",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Color(0xFF1D1E47),
              ),
              child: Image.asset(Asset.arrow),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Image.asset(Asset.location),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                "903 A wing Green tower, Gilbert Hill, Andheri West Mumbai",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Color(0xFF464646),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Image.asset(Asset.calender),
            const SizedBox(width: 8),
            const Text(
              "Jan 21st, 2024",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Color(0xFF464646),
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              "4 Hours",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Color(0xFF464646),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
      
        Visibility(
          child: Row(
            children: [
              Image.asset(
                icon,
                color: const Color(0xFFE37B78),
              ),
              const SizedBox(width: 8),
              Text(
                task,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFFE37B78),
                ),
              )
            ],
          ),
        )
      
      ],
    ),
  );
}

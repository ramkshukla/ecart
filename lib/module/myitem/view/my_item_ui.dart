import 'package:ecart/_util/common_function.dart';
import 'package:ecart/module/myitem/controller/my_item_bloc.dart';
import 'package:ecart/module/myitem/controller/my_item_event.dart';
import 'package:ecart/module/myitem/controller/my_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MyItemUI extends StatelessWidget {
  const MyItemUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyItemBloc()..add(GetUserDataEvent()),
      child: BlocBuilder<MyItemBloc, MyItemState>(builder: (context, state) {
        "State ${state.data}".logIt;
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Items"),
          ),
          body: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.blue[50],
            child: state.isFetching || state.isDeleting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Text(
                          'My Items',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            "Image: ${state.data[index].image}".logIt;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    state.data[index].image,
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(state.data[index].itemName),
                                  Text(state.data[index].id.toString()),
                                  InkWell(
                                    onTap: () {
                                      context.read<MyItemBloc>().add(
                                          DeleteMyCartItem(
                                              id: state.data[index].id));

                                      Get.snackbar(
                                        maxWidth: 380,
                                        backgroundColor: Colors.green,
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        "Your item ${state.data[index].itemName} has been removed",
                                        "Item removed successfully",
                                      );
                                    },
                                    child: Container(
                                      height: 28,
                                      width: 28,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: const Icon(Icons.remove),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40)
                    ],
                  ),
          ),
        );
      }),
    );
  }
}

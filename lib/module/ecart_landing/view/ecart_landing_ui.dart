import 'dart:async';

import 'package:ecart/_util/assets_constants.dart';
import 'package:ecart/_util/common_function.dart';
import 'package:ecart/module/ecart_landing/controller/ecart_landing_bloc.dart';
import 'package:ecart/module/ecart_landing/controller/ecart_landing_event.dart';
import 'package:ecart/module/myitem/view/my_item_ui.dart';
import 'package:ecart/module/phone_auth/view/phone_auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/ecart_landing_state.dart';

class WatchItem {
  int? id;
  String? images;
  String? name;
  int? price;

  WatchItem({
    this.id,
    this.images,
    this.name,
    this.price,
  });
}

class ECartLanding extends StatefulWidget {
  final String? firebaseToken;
  const ECartLanding({
    super.key,
    this.firebaseToken = "",
  });

  @override
  State<ECartLanding> createState() => _ECartLandingState();
}

class _ECartLandingState extends State<ECartLanding> {
  int _currentPage = 0;
  Timer? _timer;
  PageController controller = PageController(initialPage: 0);
  List<String> image = [
    Asset.img1,
    Asset.img2,
    Asset.img3,
    Asset.img4,
  ];
  List<WatchItem> watchData = [
    WatchItem(id: 1, images: Asset.watch1, name: "Andy 3", price: 867),
    WatchItem(id: 2, images: Asset.watch2, name: "Aragon 4", price: 890),
    WatchItem(id: 3, images: Asset.watch3, name: "Bob 5", price: 569),
    WatchItem(id: 4, images: Asset.watch4, name: "Barbara 6", price: 399),
    WatchItem(id: 5, images: Asset.watch5, name: "Candy 7", price: 239),
    WatchItem(id: 6, images: Asset.watch6, name: "Colin 8", price: 560),
  ];

  List<String> data = [];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (_currentPage < 2) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        controller.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
      },
    );
  }

  // Future<void> createUserDocument(String image) async {
  //   CollectionReference users = firebaseFirestore!.collection("myitem");

  //   Map<String, String> userData = {
  //     "images": image,
  //     // "email": "john.doe@example.com",
  //   };

  //   await users.doc().set(userData);

  //   const SnackBar(content: Text("Successfully Saved"));
  // }

  // Future<void> addItem(int id, String itemName, String image) async {}

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    "${widget.firebaseToken}".logIt;
    return BlocProvider(
      create: (context) => ECartLandingBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(140),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyItemUI(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart),
                      ),
                      // const SizedBox(width: 40),
                      Visibility(
                        // visible: widget.firebaseToken!.isNotEmpty,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PhoneAuthUI(),
                              ),
                            );
                          },
                          child: const Text("Login"),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "Search for Products, Brands and More ",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        )),
                  )
                ],
              ),
            ),
          ),
          body: BlocBuilder<ECartLandingBloc, ECartLandingState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 180,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: image.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Image.asset(
                              image[index],
                              fit: BoxFit.cover,
                            ));
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: watchData
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    e.images ?? "",
                                    height: 100,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(e.name!),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () async {
                                          context.read<ECartLandingBloc>().add(
                                                AddItem(
                                                  id: e.id!,
                                                  image: e.images!,
                                                  itemName: e.name!,
                                                ),
                                              );
                                        },
                                        child: Container(
                                          height: 20,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text("₹ ${e.price.toString()}"),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

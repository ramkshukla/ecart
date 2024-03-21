import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;

  const MyAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.blue[500],
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          Expanded(
            child: Center(
              child: Text(title),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NoSearchWidget extends StatelessWidget {
  const NoSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Icon(Icons.manage_search, size: 100)),
        ],
      ),
    );
  }
}

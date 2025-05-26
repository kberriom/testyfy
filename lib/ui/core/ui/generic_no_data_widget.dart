import 'package:flutter/material.dart';
import 'package:testyfy/utils/localization_utils.dart';

class GenericNoDataWidget extends StatelessWidget {
  const GenericNoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.music_off, size: 100),
            Text(context.localizations.genericNoData, style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}

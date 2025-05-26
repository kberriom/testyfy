import 'package:flutter/material.dart';
import 'package:testyfy/utils/localization_utils.dart';

class GenericErrorWidget extends StatelessWidget {
  const GenericErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 100),
            Text(context.localizations.genericError, style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}

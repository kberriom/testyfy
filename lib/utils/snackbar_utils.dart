import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

extension ShowSnackBar on GlobalKey<ScaffoldMessengerState> {
  void showTextSnackBar(String content) {
    final snackBar = SnackBar(content: Text(content));
    currentState
      ?..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}

extension GetWidgetRefSnackBar on WidgetRef {
  void showTextSnackBar(String content) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      rootScaffoldMessengerKey.showTextSnackBar(content);
    });
  }
}

extension GetRefSnackBar on Ref {
  void showTextSnackBar(String content) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      rootScaffoldMessengerKey.showTextSnackBar(content);
    });
  }
}

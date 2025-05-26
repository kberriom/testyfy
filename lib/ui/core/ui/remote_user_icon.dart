import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testyfy/ui/core/ui/remote_user_icon_viewmodel.dart';

class RemoteUserIcon extends ConsumerWidget {
  const RemoteUserIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageValue = ref.watch(remoteUserIconViewmodelProvider);
    return imageValue.when(
      data: (imageUrl) {
        if (imageUrl == null) {
          return const Icon(Icons.account_circle_sharp);
        }
        return ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
          child: AspectRatio(aspectRatio: 1 / 1, child: Image.network(imageUrl, fit: BoxFit.cover)),
        );
      },
      error: (_, __) => const Icon(Icons.account_circle_sharp),
      loading: () => const Icon(Icons.account_circle_sharp),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testyfy/ui/core/ui/generic_error_widget.dart';
import 'package:testyfy/ui/core/ui/generic_no_data_widget.dart';
import 'package:testyfy/ui/recommendations/view_model/recommendations_viewmodel.dart';

import '../core/ui/track_display_widget.dart';

class RecommendationsScreen extends ConsumerWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultList = ref.watch(recommendationsViewmodelProvider);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(recommendationsViewmodelProvider.future),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: resultList.when(
            data: (tracks) {
              if (tracks.items == null || tracks.items!.isEmpty) {
                return const GenericNoDataWidget();
              }
              final list = tracks.items!.toList(growable: false);
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index <= list.length - 1) {
                    return TrackDisplayWidget(track: list[index]);
                  }
                  return null;
                },
                padding: EdgeInsetsGeometry.only(top: 16),
              );
            },
            error: (error, stackTrace) => const GenericErrorWidget(),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testyfy/data/services/auth_service.dart';
import 'package:testyfy/ui/core/ui/remote_user_icon.dart';
import 'package:testyfy/utils/localization_utils.dart';

class ScaffoldNavigation extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldNavigation({super.key, required this.navigationShell});

  void _goBranch(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.star_border),
              selectedIcon: const Icon(Icons.star),
              label: context.localizations.recommendationsAppbarLabel,
            ),
            NavigationDestination(
              icon: const Icon(Icons.search),
              selectedIcon: const Icon(Icons.search),
              label: context.localizations.searchBarHintHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.music_note_outlined),
              selectedIcon: const Icon(Icons.music_note),
              label: context.localizations.libraryAppbarLabel,
            ),
          ],
          onDestinationSelected: (index) => _goBranch(index),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/logo.png'),
              invertColors: Theme.of(context).brightness == Brightness.dark,
            ),
          ),
        ),
      ),
      leadingWidth: 61,
      actions: [
        MenuAnchor(
          menuChildren: [
            MenuItemButton(
              onPressed:
                  () => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return LicensePage(applicationLegalese: "Copyright 2025, Keneth Berrio.");
                    },
                  ),
              child: Text(context.localizations.aboutPageButton),
            ),
            const SignOffMenuItemButton(),
          ],
          builder: (context, controller, child) {
            return IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: RemoteUserIcon(),
              iconSize: 32,
            );
          },
        ),
      ],
    );
  }
}


class SignOffMenuItemButton extends ConsumerWidget {
  const SignOffMenuItemButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuItemButton(
      closeOnActivate: false,
      onPressed: () async => await ref.read(authServiceProvider.notifier).signOff(),
      child: Text(context.localizations.signOff),
    );
  }
}

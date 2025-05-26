import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testyfy/l10n/app_localizations.dart';
import 'package:testyfy/routing/go_router_config.dart';
import 'package:testyfy/ui/core/themes/theme_mode_provider.dart';
import 'package:testyfy/utils/provider_utils.dart';
import 'package:testyfy/utils/snackbar_utils.dart';

void main() {
  runApp(ProviderScope(observers: [ProviderLogger()], child: const Testyfy()));
}

class Testyfy extends ConsumerWidget {
  const Testyfy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Testyfy',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      supportedLocales: [Locale('es'), Locale('en')],
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent, brightness: Brightness.light),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent, brightness: Brightness.dark),
      ),
      themeMode: ref.watch(currentThemeModeProvider),
      routerConfig: ref.watch(goRouterInstanceProvider),
    );
  }
}

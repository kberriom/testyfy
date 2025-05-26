import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testyfy/routing/go_router_routes.dart';
import 'package:testyfy/ui/login/view_model/login_viewmodel.dart';
import 'package:testyfy/utils/localization_utils.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginViewModelProvider, (previous, next) {
      next.whenData((mustRedirect) {
        if (mustRedirect) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.go(GoRouterRoutes.recommendationPage.routeName);
          });
        }
      });
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/logo.png'),
                  invertColors: Theme.of(context).brightness == Brightness.dark,
                ),
              ),
            ),
            FilledButton(
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xff1ED760))),
              onPressed: () => ref.read(loginViewModelProvider.notifier).startAuth(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: const Image(
                      image: AssetImage('assets/Spotify_Primary_Logo_RGB_White.png'),
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Text(context.localizations.loginButtonSpotify),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

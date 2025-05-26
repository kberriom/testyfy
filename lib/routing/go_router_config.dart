import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:testyfy/routing/go_router_routes.dart';
import 'package:testyfy/ui/core/ui/scaffold_navigation.dart';
import 'package:testyfy/ui/library/library_screen.dart';
import 'package:testyfy/ui/login/login_screen.dart';
import 'package:testyfy/ui/login/spotify_auth_deeplink_receiver.dart';
import 'package:testyfy/ui/recommendations/recommendations_screen.dart';
import 'package:testyfy/ui/search/search_screen.dart';

part 'go_router_config.g.dart';

@Riverpod(keepAlive: true)
class GoRouterInstance extends _$GoRouterInstance {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: GoRouterRoutes.loginScreen.routeName,
      routes: [
        GoRoute(
          path: GoRouterRoutes.loginScreen.routeName,
          name: GoRouterRoutes.loginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'result',
              builder: (context, state) => const SpotifyAuthDeeplinkReceiver(),
            ),
          ],
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldNavigation(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: GoRouterRoutes.recommendationPage.routeName,
                  name: GoRouterRoutes.recommendationPage.routeName,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    key: ValueKey(GoRouterRoutes.recommendationPage),
                    child: RecommendationsScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: GoRouterRoutes.searchPage.routeName,
                  name: GoRouterRoutes.searchPage.routeName,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    key: ValueKey(GoRouterRoutes.searchPage),
                    child: SearchScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: GoRouterRoutes.libraryPage.routeName,
                  name: GoRouterRoutes.libraryPage.routeName,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    key: ValueKey(GoRouterRoutes.libraryPage),
                    child: LibraryScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _fadeTransition(Object _, Animation<double> animation, Object __, Widget child) {
    return FadeTransition(
      opacity: CurveTween(curve: Curves.easeOutCubic).animate(animation),
      child: child,
    );
  }
}

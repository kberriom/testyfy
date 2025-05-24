import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:testyfy/routing/go_router_routes.dart';
import 'package:testyfy/ui/login/login_screen.dart';

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
      ],
    );
  }
}

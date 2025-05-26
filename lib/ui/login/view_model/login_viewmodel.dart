import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:testyfy/domain/models/bearer_token.dart';
import 'package:testyfy/data/services/auth_service.dart';

part 'login_viewmodel.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  bool canStartAuth = true;

  @override
  Future<bool> build() async {
    final BearerToken? bearerToken = await ref.watch(authServiceProvider.future);
    bool isValidToken = bearerToken != null;
    canStartAuth = !isValidToken;
    return isValidToken;
  }

  void startAuth() {
    if (canStartAuth) {
      ref.read(authServiceProvider.notifier).startAuth();
    }
  }
}

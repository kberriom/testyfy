import 'package:flutter/foundation.dart' show debugPrint, kReleaseMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didAddProvider(
      ProviderBase<Object?> provider,
      Object? value,
      ProviderContainer container,
      ) {
    _printIfDebugMode('Provider $provider was initialized with value = $value');
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider,
      ProviderContainer container,
      ) {
    _printIfDebugMode('Provider $provider was disposed');
  }

  @override
  void didUpdateProvider(
      ProviderBase<Object?> provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    _printIfDebugMode('\x1B[33mProvider $provider updated value FROM $previousValue TO $newValue\x1B[0m');
  }

  @override
  void providerDidFail(
      ProviderBase<Object?> provider,
      Object error,
      StackTrace stackTrace,
      ProviderContainer container,
      ) {
    _printIfDebugMode('\x1B[31mProvider $provider ERROR $error at $stackTrace\x1B[0m');
  }

  static void _printIfDebugMode(String content) {
    if (!kReleaseMode) {
      debugPrint(content);
    }
  }
}
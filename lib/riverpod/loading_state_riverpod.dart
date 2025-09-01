import 'package:flutter_riverpod/flutter_riverpod.dart';

final isUserOnlineProvider = StateProvider<bool>((ref) => false);

final isLoadingProvider = StateNotifierProvider<LoadingStateProvider, bool>((ref) {
  return LoadingStateProvider();
});

class LoadingStateProvider extends StateNotifier<bool> {
  LoadingStateProvider() : super(false);

  void loadingTrue() {
    state = true;
  }

  void update(bool val) {
    state = val;
  }

  void loadingFalse() {
    state = false;
  }
}

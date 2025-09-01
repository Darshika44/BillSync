import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomBarIndexProvider = StateNotifierProvider<BottomBarIndex, int>((ref) {
  return BottomBarIndex();
});

class BottomBarIndex extends StateNotifier<int> {
  BottomBarIndex() : super(0);

  void update(int val) {
    state = val;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedNavigationIndexProvider = StateProvider<int>((ref) => 0);

class LayoutViewModel {
  final Ref ref;

  LayoutViewModel(this.ref);

  int get selectedIndex => ref.read(selectedNavigationIndexProvider);

  void selectNavigationItem(int index) {
    ref.read(selectedNavigationIndexProvider.notifier).state = index;
  }
}

final layoutViewModelProvider = Provider<LayoutViewModel>((ref) {
  return LayoutViewModel(ref);
});

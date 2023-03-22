import 'package:flutter_riverpod/flutter_riverpod.dart';

final myHomePageControllerProvider = NotifierProvider.autoDispose
    .family<MyHomePageController, int, int>(MyHomePageController.new);

class MyHomePageController extends AutoDisposeFamilyNotifier<int, int> {
  @override
  int build(int arg) {
    return arg;
  }

  void incrementCounter() {
    state++;
  }
}

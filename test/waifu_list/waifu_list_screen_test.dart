import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu/ui/waifu_list/waifu_list_screen.dart';
import 'package:waifu/ui/waifu_list/waifu_list_wm.dart';

void main() {
  const waifuListScreen = WaifuListScreen();
  final waifuListWm = WaifuListWidgetModelMock();

  setUp(() {
    when(() => waifuListWm.category).thenAnswer((_) => ValueNotifier('waifu'));
    when(() => waifuListWm.categoriesExpanded)
        .thenAnswer((_) => EntityStateNotifier.value(false));
    when(() => waifuListWm.images)
        .thenAnswer((_) => EntityStateNotifier.value([]));
  });

  testGoldens('Waifu list screen golden test empty', (tester) async {
    await tester.pumpWidgetBuilder(waifuListScreen.build(waifuListWm));
    await multiScreenGolden(tester, 'waifu_list_screen');
  });

  testGoldens('Waifu list screen golden test empty', (tester) async {
    when(() => waifuListWm.images)
        .thenAnswer((_) => EntityStateNotifier.value(getWaifuList()));

    await tester.pumpWidgetBuilder(waifuListScreen.build(waifuListWm));
    await multiScreenGolden(tester, 'waifu_list_screen');
  });
}

class WaifuListWidgetModelMock extends Mock implements IWaifuListWidgetModel {}

const _mockWaifu = AssetImage('assets/images/placeholder.jpeg');

getWaifuList() {
  return List.generate(5, (index) => _mockWaifu);
}

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/ui/random_waifu/random_waifu_screen.dart';
import 'package:waifu/ui/random_waifu/random_waifu_wm.dart';

void main() {
  const randomWaifuScreen = RandomWaifuScreen();
  final randomWaifuWm = RandomWaifuWidgetModelMock();

  setUp(() {
    when(() => randomWaifuWm.image).thenAnswer((_) => ValueNotifier(null));

    when(() => randomWaifuWm.imageState)
        .thenAnswer((_) => EntityStateNotifier());
  });

  testGoldens('Random waifu screen golden test empty', (tester) async {
    await tester.pumpWidgetBuilder(randomWaifuScreen.build(randomWaifuWm));
    await multiScreenGolden(tester, 'random_waifu_screen');
  });

  /// not working
  testGoldens(
    'Random waifu screen golden test data',
    (tester) async {
      when(() => randomWaifuWm.image)
          .thenAnswer((_) => ValueNotifier(_mockWaifu));

      when(() => randomWaifuWm.imageState)
          .thenAnswer((_) => EntityStateNotifier.value(_mockWaifu));

      await tester.pumpWidgetBuilder(randomWaifuScreen.build(randomWaifuWm));
      await multiScreenGolden(tester, 'random_waifu_screen_data');
    },
  );

  /// not working
  testGoldens(
    'Random waifu screen golden test error',
    (tester) async {
      when(() => randomWaifuWm.imageState).thenAnswer(
          (_) => EntityStateNotifier.value(_mockWaifu)..error(Exception()));

      await tester.pumpWidgetBuilder(randomWaifuScreen.build(randomWaifuWm));
      await multiScreenGolden(tester, 'random_waifu_screen_error');
    },
  );
}

class RandomWaifuWidgetModelMock extends Mock
    implements IRandomWaifuWidgetModel {}

const _mockWaifu = AssetImage('assets/images/placeholder.jpeg');

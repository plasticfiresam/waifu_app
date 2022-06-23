import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/ui/waifu_detailed/waifu_detailed_screen.dart';
import 'package:waifu/ui/waifu_detailed/waifu_detailed_wm.dart';

void main() {
  const detailedWaifuScreen = WaifuDetailedScreen();
  final detailedWaifuWm = WaifuDetailedWidgetModelMock();

  testGoldens('Detailed waifu screen golden test empty', (tester) async {
    await tester.pumpWidgetBuilder(detailedWaifuScreen.build(detailedWaifuWm));
    await multiScreenGolden(tester, 'detailed_waifu_screen');
  });

  testGoldens(
    'Random waifu screen golden test data',
    (tester) async {
      when(() => detailedWaifuWm.image).thenAnswer((_) => _mockWaifu);

      await tester
          .pumpWidgetBuilder(detailedWaifuScreen.build(detailedWaifuWm));
      await multiScreenGolden(tester, 'detailed_waifu_screen_data');
    },
  );
}

class WaifuDetailedWidgetModelMock extends Mock
    implements IWaifuDetailedWidgetModel {}

const _mockWaifu = AssetImage('assets/images/placeholder.jpeg');

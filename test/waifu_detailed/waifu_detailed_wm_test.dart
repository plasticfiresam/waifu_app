import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/ui/waifu_detailed/waifu_detailed_wm.dart';

void main() {
  group('WaifuDetailedWidgetModel test', () {
    final getIt = GetIt.instance;
    getIt.registerSingleton<AppModel>(AppModel());
    test('default factory test', () {
      expect(
        () => defaultWaifuDetailedWidgetModelFactory(BuildContextMock()),
        returnsNormally,
      );
    });
  });
}

class BuildContextMock extends Mock implements BuildContext {}

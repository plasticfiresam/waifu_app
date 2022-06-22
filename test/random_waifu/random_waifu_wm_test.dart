import 'package:elementary_test/elementary_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/service/context_helper.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';
import 'package:waifu/ui/random_waifu/random_waifu_model.dart';
import 'package:waifu/ui/random_waifu/random_waifu_screen.dart';
import 'package:waifu/ui/random_waifu/random_waifu_wm.dart';

void main() {
  group('RandomWaifuWidgetModel test', () {
    final waifuServiceMock = WaifuServiceMock();
    final getIt = GetIt.instance;
    getIt
      ..registerSingleton<WaifuService>(waifuServiceMock)
      ..registerSingleton<AppModel>(AppModel());

    late RandomWaifuModelMock modelData;

    test('default factory test', () {
      expect(
        () => defaultRandomWaifuWidgetModelFactory(BuildContextMock()),
        returnsNormally,
      );
    });

    RandomWaifuWidgetModel setupWm() {
      modelData = RandomWaifuModelMock();

      when(() => waifuServiceMock.getRandomWaifuImage(WaifuType.sfw, 'waifu'))
          .thenAnswer((_) => Future.value(mockImage));

      when(() => modelData.image).thenReturn(ValueNotifier(mockImage));

      when(() => modelData.loadRandomWaifu()).thenAnswer((_) => Future.value());

      return RandomWaifuWidgetModel(modelData, ContextHelperMock());
    }

    testWidgetModel<RandomWaifuWidgetModel, RandomWaifuScreen>(
      'onRefresh call loadRandomWaifu',
      setupWm,
      (wm, tester, context) {
        wm.onRefresh();

        verify(() => modelData.loadRandomWaifu());
      },
    );
  });
}

class ContextHelperMock extends Mock implements ContextHelper {}

class BuildContextMock extends Mock implements BuildContext {}

class RandomWaifuModelMock extends Mock implements RandomWaifuModel {}

class WaifuServiceMock extends Mock implements WaifuService {}

const mockImage = WaifuImage("https://i.waifu.pics/L~qlLcJ.jpg");

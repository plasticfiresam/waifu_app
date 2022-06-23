import 'package:elementary_test/elementary_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/service/context_helper.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/navigation_helper.dart';
import 'package:waifu/service/waifu_service.dart';
import 'package:waifu/ui/waifu_list/waifu_list_model.dart';
import 'package:waifu/ui/waifu_list/waifu_list_screen.dart';
import 'package:waifu/ui/waifu_list/waifu_list_wm.dart';

void main() {
  final getIt = GetIt.instance;

  getIt
    ..registerSingleton<WaifuService>(WaifuServiceMock())
    ..registerSingleton<AppModel>(AppModel())
    ..registerSingleton<NavigationHelper>(NavigationHelperMock());

  group('WaifuListWidgetModel creation', () {
    test('default factory test', () {
      expect(
        () => createWaifuListWM(BuildContextMock()),
        returnsNormally,
      );
    });
  });

  group('WaifuListWidgetModel test', () {
    late WaifuListModel modelData;
    late NavigationHelperMock navigationHelperMock;

    WaifuListWidgetModel setupWm() {
      modelData = WaifuListModelMock();
      navigationHelperMock = NavigationHelperMock();

      when(() => modelData.images).thenReturn(ValueNotifier([]));
      when(() => modelData.fetchWaifuImages())
          .thenAnswer((_) => Future.value());

      /// for any() usage in navigation mock
      registerFallbackValue(MaterialPageRoute<void>(builder: (_) {
        return const Center();
      }));

      return WaifuListWidgetModel(
        modelData,
        navigationHelperMock,
      );
    }

    testWidgetModel<WaifuListWidgetModel, WaifuListScreen>(
      'wm`s onChangeCategory calling model`s onChangeCategory and refreshing list',
      setupWm,
      (wm, tester, context) {
        tester.init();

        wm.onChangeCategory('waifu');

        verify(() => modelData.onChangeCategory('waifu'));
      },
    );

    testWidgetModel<WaifuListWidgetModel, WaifuListScreen>(
      'wm`s onChangeType calling model`s onChangeType',
      setupWm,
      (wm, tester, context) {
        tester.init();

        wm.onChangeType(WaifuType.nsfw);

        verify(() => modelData.onChangeType(WaifuType.nsfw));
      },
    );

    testWidgetModel<WaifuListWidgetModel, WaifuListScreen>(
      'wm`s fetchWaifuList calling model`s fetchWaifuImages',
      setupWm,
      (wm, tester, context) {
        tester.init();

        wm.fetchWaifuList();

        verify(modelData.fetchWaifuImages);
      },
    );

    testWidgetModel<WaifuListWidgetModel, WaifuListScreen>(
      'ScrollController initialized',
      setupWm,
      (wm, tester, context) {
        tester.init();

        expect(wm.scrollController, isNotNull);
      },
    );

    testWidgetModel<WaifuListWidgetModel, WaifuListScreen>(
      'StickyHeaderController initialized',
      setupWm,
      (wm, tester, context) {
        tester.init();

        expect(wm.stickyHeaderController, isNotNull);
      },
    );

    testWidgetModel<WaifuListWidgetModel, WaifuListScreen>(
      'onToggleCategoriesPanel changes panel state',
      setupWm,
      (wm, tester, context) {
        tester.init();
        wm.onToggleCategoriesPanel();
        expect(wm.categoriesExpanded.value?.data, equals(true));

        wm.onToggleCategoriesPanel();
        expect(wm.categoriesExpanded.value?.data, equals(false));
      },
    );

    testWidgetModel<WaifuListWidgetModel, WaifuListScreen>(
      'onOpenRandom opens new page',
      setupWm,
      (wm, tester, context) {
        tester.init();
        wm.onOpenRandom();

        verify(() => navigationHelperMock.push(context, any()));
      },
    );

    testWidgetModel<WaifuListWidgetModel, WaifuListScreen>(
      'openDetails calls model`s selectWaifu() and opens new page',
      setupWm,
      (wm, tester, context) {
        tester.init();
        wm.openDetails(_mockWaifu);

        verify(() => modelData.selectWaifu(_mockWaifu));
        verify(() => navigationHelperMock.push(context, any()));
      },
    );
  });
}

class BuildContextMock extends Mock implements BuildContext {}

class ContextHelperMock extends Mock implements ContextHelper {}

class NavigationHelperMock extends Mock implements NavigationHelper {}

class WaifuListModelMock extends Mock implements WaifuListModel {}

class WaifuServiceMock extends Mock implements WaifuService {}

const _mockWaifu = WaifuImage('https://i.waifu.pics/G8JK8lu.png');

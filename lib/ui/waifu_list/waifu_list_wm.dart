import 'dart:async';

import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/main.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/navigation_helper.dart';
import 'package:waifu/service/waifu_service.dart';
import 'package:waifu/ui/random_waifu/random_waifu_screen.dart';
import 'package:waifu/ui/waifu_detailed/waifu_detailed_screen.dart';
import 'package:waifu/ui/waifu_list/waifu_list_model.dart';
import 'package:waifu/ui/waifu_list/waifu_list_screen.dart';

abstract class IWaifuListWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<WaifuImage>?>> get images;
  Completer<void>? get refreshCompleter;

  ValueNotifier<WaifuType> get type;
  ValueNotifier<String> get category;

  ListenableState<EntityState<bool>> get categoriesExpanded;

  void onChangeType(WaifuType type);
  void onChangeCategory(String category);
  void onToggleCategoriesPanel();
  void onOpenRandom();
  void openDetails(WaifuImage waifu);
  void refreshList();
}

WaifuListWidgetModel createWaifuListWM(BuildContext _) => WaifuListWidgetModel(
      WaifuListModel(
        getIt.get<AppModel>(),
        getIt.get<WaifuService>(),
      ),
      getIt.get<NavigationHelper>(),
    );

class WaifuListWidgetModel extends WidgetModel<WaifuListScreen, WaifuListModel>
    implements IWaifuListWidgetModel {
  final EntityStateNotifier<List<WaifuImage>> _images =
      EntityStateNotifier.value([]);

  final EntityStateNotifier<bool> _categoriesExpanded =
      EntityStateNotifier.value(false);
  @override
  ListenableState<EntityState<bool>> get categoriesExpanded =>
      _categoriesExpanded;

  final NavigationHelper _navigationHelper;

  Completer<void>? _refreshCompleter;
  @override
  Completer<void>? get refreshCompleter => _refreshCompleter;

  @override
  ListenableState<EntityState<List<WaifuImage>?>> get images => _images;
  @override
  ValueNotifier<WaifuType> get type => model.type;
  @override
  ValueNotifier<String> get category => model.category;

  WaifuListWidgetModel(
    WaifuListModel model,
    this._navigationHelper,
  ) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    fetchWaifuList();
  }

  @override
  void onChangeCategory(String newCategory) {
    model.onChangeCategory(newCategory);

    fetchWaifuList(savePrevious: false);
  }

  @override
  void onChangeType(WaifuType newType) {
    model.onChangeType(newType);

    fetchWaifuList();
  }

  Future<void> fetchWaifuList({bool savePrevious = true}) async {
    _images.accept(EntityState(
      data: savePrevious ? _images.value?.data : null,
      isLoading: true,
    ));

    await model.fetchWaifuImages();

    _images.content(model.images.value);
  }

  @override
  void onErrorHandle(Object error) {
    if (error is DioError) {
      _images.error(error, _images.value?.data);
    }
  }

  @override
  void refreshList() async {
    if (_refreshCompleter?.isCompleted ?? true) {
      _refreshCompleter = Completer<void>();
    }
    await fetchWaifuList();
    _refreshCompleter?.complete();
  }

  @override
  void onToggleCategoriesPanel() {
    _categoriesExpanded.accept(
      EntityState(data: !(_categoriesExpanded.value?.data ?? false)),
    );
  }

  @override
  void onOpenRandom() {
    _navigationHelper.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RandomWaifuScreen(),
      ),
    );
  }

  @override
  void openDetails(WaifuImage waifu) {
    model.selectWaifu(waifu);

    _navigationHelper.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WaifuDetailedScreen(),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:waifu/main.dart';
import 'package:waifu/service/waifu_service.dart';
import 'waifu_tinder_model.dart';
import 'waifu_tinder_screen.dart';

abstract class IWaifuTinderWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<ImageProvider>>> get images;
  SwipableStackController get stackController;

  void onDismiss(int index);
  void onSave(int index);
}

WaifuTinderWidgetModel defaultWaifuTinderWidgetModelFactory(
    BuildContext context) {
  return WaifuTinderWidgetModel(
    WaifuTinderModel(
      getIt.get<WaifuService>(),
    ),
  );
}

/// Default widget model for WaifuTinderWidget
class WaifuTinderWidgetModel
    extends WidgetModel<WaifuTinderScreen, WaifuTinderModel>
    implements IWaifuTinderWidgetModel {
  WaifuTinderWidgetModel(WaifuTinderModel model) : super(model);

  final EntityStateNotifier<List<ImageProvider>> _images =
      EntityStateNotifier.value([]);
  @override
  ListenableState<EntityState<List<ImageProvider<Object>>>> get images =>
      _images;

  final SwipableStackController _stackController = SwipableStackController();
  @override
  SwipableStackController get stackController => _stackController;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    fetchWaifus();
  }

  Future<void> fetchWaifus() async {
    _images.loading();

    await model.fetchWaifus();

    _images.content(model.images.value
        .map((e) => CachedNetworkImageProvider(e.url))
        .toList());
  }

  @override
  void onErrorHandle(Object error) {
    if (error is DioError) {
      // error
    }
  }

  @override
  void onDismiss(int index) {
    print('dismissed $index');
  }

  @override
  void onSave(int index) {
    print('saved $index');
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:waifu/service/context_helper.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';
import 'package:waifu/ui/waifu_list/waifu_list_model.dart';
import 'package:waifu/ui/waifu_list/waifu_list_screen.dart';

class WaifuListWM extends WidgetModel<WaifuListScreen, WaifuListModel>
    implements IWaifuListWM {
  final EntityStateNotifier<WaifuImageList?> _images = EntityStateNotifier();

  final ContextHelper _contextHelper;

  Completer<void>? _refreshCompleter;

  @override
  Completer<void>? get refreshCompleter => _refreshCompleter;

  @override
  ListenableState<EntityState<WaifuImageList?>> get images => _images;

  @override
  WaifuType get type => model.type.value;

  @override
  String get category => model.category.value;

  WaifuListWM(
    WaifuListModel model,
    this._contextHelper,
  ) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _fetchWaifuList();
  }

  @override
  void onChangeCategory(String newCategory) {
    model.onChangeCategory(newCategory);
    _fetchWaifuList();
  }

  @override
  void onChangeType(WaifuType newType) {
    model.onChangeType(newType);
    _fetchWaifuList();
  }

  Future<void> _fetchWaifuList() async {
    try {
      _images.accept(EntityState(data: _images.value?.data, isLoading: true));
      final images = await model.fetchWaifuImages();
      _images.content(images);
    } on DioError catch (e) {
      _images.error(e);
    }
  }

  void refreshList() async {
    if (_refreshCompleter?.isCompleted ?? true) {
      _refreshCompleter = Completer<void>();
    }
    await _fetchWaifuList();
    _refreshCompleter?.complete();
  }
}

abstract class IWaifuListWM extends IWidgetModel {
  ListenableState<EntityState<WaifuImageList?>> get images;
  Completer<void>? get refreshCompleter;

  WaifuType get type;
  String get category;

  void onChangeType(WaifuType type);
  void onChangeCategory(String category);
}

WaifuListWM createWaifuListWM(BuildContext _) => WaifuListWM(
      WaifuListModel(
        WaifuService(),
      ),
      ContextHelper(),
    );

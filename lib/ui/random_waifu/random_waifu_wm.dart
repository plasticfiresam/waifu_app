import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waifu/main.dart';
import 'package:waifu/service/context_helper.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/waifu_service.dart';
import 'random_waifu_model.dart';
import 'random_waifu_screen.dart';

abstract class IRandomWaifuWidgetModel extends IWidgetModel {
  ListenableState<EntityState<WaifuImage>> get image;

  void onRefresh();
  void onCopyLink();
}

RandomWaifuWidgetModel defaultRandomWaifuWidgetModelFactory(
    BuildContext context) {
  return RandomWaifuWidgetModel(
    RandomWaifuModel(
      getIt.get<WaifuService>(),
    ),
    ContextHelper(),
  );
}

class RandomWaifuWidgetModel
    extends WidgetModel<RandomWaifuScreen, RandomWaifuModel>
    implements IRandomWaifuWidgetModel {
  final EntityStateNotifier<WaifuImage> _currentImage =
      EntityStateNotifier<WaifuImage>();

  final ContextHelper _contextHelper;

  RandomWaifuWidgetModel(
    RandomWaifuModel model,
    this._contextHelper,
  ) : super(model);

  @override
  ListenableState<EntityState<WaifuImage>> get image => _currentImage;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _fetchRandowWaifu();
  }

  Future<void> _fetchRandowWaifu() async {
    try {
      _currentImage.loading(_currentImage.value?.data);

      final res = await model.loadRandomWaifu();
      _currentImage.content(res);
    } on DioError catch (e) {
      _currentImage.error(e, _currentImage.value?.data);
    }
  }

  @override
  void onRefresh() {
    _fetchRandowWaifu();
  }

  @override
  Future<void> onCopyLink() async {
    if (image.value != null) {
      Clipboard.setData(ClipboardData(text: image.value!.data!.url)).then(
        (_) => _contextHelper.getScaffoldMessenger(context)
          ..clearSnackBars()
          ..showSnackBar(
            const SnackBar(content: Text('Copied to clipboard')),
          ),
      );
    }
  }
}

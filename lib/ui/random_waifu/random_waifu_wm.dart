import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waifu/main.dart';
import 'package:waifu/service/context_helper.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/waifu_service.dart';
import 'random_waifu_model.dart';
import 'random_waifu_screen.dart';

abstract class IRandomWaifuWidgetModel extends IWidgetModel {
  ValueListenable<ImageProvider?> get image;
  ListenableState<EntityState<ImageProvider>> get imageState;

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
  final EntityStateNotifier<ImageProvider> _currentImage =
      EntityStateNotifier<ImageProvider>();

  final ContextHelper _contextHelper;

  RandomWaifuWidgetModel(
    RandomWaifuModel model,
    this._contextHelper,
  ) : super(model);

  @override
  ValueListenable<ImageProvider?> get image => model.image;

  @override
  ListenableState<EntityState<ImageProvider>> get imageState => _currentImage;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _fetchRandowWaifu();
  }

  Future<void> _fetchRandowWaifu() async {
    _currentImage.loading(_currentImage.value?.data);

    await model.loadRandomWaifu();
    _currentImage.content(image.value!);
  }

  @override
  void onErrorHandle(Object error) {
    if (error is DioError) {
      _currentImage.error(error, _currentImage.value?.data);
    }
  }

  @override
  void onRefresh() {
    _fetchRandowWaifu();
  }

  @override
  Future<void> onCopyLink() async {
    if (image.value != null && image.value is NetworkImage) {
      Clipboard.setData(ClipboardData(text: (image.value as NetworkImage).url))
          .then(
        (_) => _contextHelper.getScaffoldMessenger(context)
          ..clearSnackBars()
          ..showSnackBar(
            const SnackBar(content: Text('Copied to clipboard')),
          ),
      );
    }
  }
}

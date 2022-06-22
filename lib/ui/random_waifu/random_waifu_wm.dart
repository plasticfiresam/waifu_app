import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu/main.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/waifu_service.dart';
import 'random_waifu_model.dart';
import 'random_waifu_widget.dart';

abstract class IRandomWaifuWidgetModel extends IWidgetModel {
  ListenableState<EntityState<WaifuImage>> get image;

  void onRefresh();
}

RandomWaifuWidgetModel defaultRandomWaifuWidgetModelFactory(
    BuildContext context) {
  return RandomWaifuWidgetModel(
    RandomWaifuModel(
      getIt.get<WaifuService>(),
    ),
  );
}

// TODO: cover with documentation
/// Default widget model for RandomWaifuWidget
class RandomWaifuWidgetModel
    extends WidgetModel<RandomWaifuWidget, RandomWaifuModel>
    implements IRandomWaifuWidgetModel {
  final EntityStateNotifier<WaifuImage> _currentImage =
      EntityStateNotifier<WaifuImage>();

  RandomWaifuWidgetModel(RandomWaifuModel model) : super(model);

  @override
  ListenableState<EntityState<WaifuImage>> get image => _currentImage;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _fetchRandowWaifu();
  }

  Future<void> _fetchRandowWaifu() async {
    try {
      _currentImage.loading();

      final res = await model.loadRandomWaifu();
      _currentImage.content(res);
    } on DioError catch (e) {
      _currentImage.error(e);
    }
  }

  @override
  void onRefresh() {
    _fetchRandowWaifu();
  }
}

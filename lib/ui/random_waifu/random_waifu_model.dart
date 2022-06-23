import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';

String _defaultCategory = 'waifu';

/// Default Elementary model for RandomWaifu module
class RandomWaifuModel extends ElementaryModel {
  ValueNotifier<ImageProvider?> image = ValueNotifier(null);
  final WaifuService _waifuService;

  RandomWaifuModel(this._waifuService) : super();

  Future<void> loadRandomWaifu() async {
    try {
      final randomImage = await _waifuService.getRandomWaifuImage(
        WaifuType.sfw,
        _defaultCategory,
      );

      image.value = NetworkImage(randomImage.url);
    } on DioError catch (e) {
      handleError(e);
    }
  }
}

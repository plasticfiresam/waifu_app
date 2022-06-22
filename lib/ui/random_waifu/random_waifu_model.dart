import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';

String _defaultCategory = 'waifu';

/// Default Elementary model for RandomWaifu module
class RandomWaifuModel extends ElementaryModel {
  ValueNotifier<WaifuImage?> image = ValueNotifier(null);
  final WaifuService _waifuService;

  RandomWaifuModel(this._waifuService) : super();

  Future<void> loadRandomWaifu() async {
    try {
      final randomImage = await _waifuService.getRandomWaifuImage(
        WaifuType.sfw,
        _defaultCategory,
      );

      image.value = randomImage;
    } on DioError catch (e) {
      handleError(e);
    }
  }
}

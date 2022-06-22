import 'dart:math';

import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';

String _defaultCategory = 'waifu';

/// Default Elementary model for RandomWaifu module
class RandomWaifuModel extends ElementaryModel {
  final WaifuService _waifuService;

  RandomWaifuModel(this._waifuService) : super();

  Future<WaifuImage> loadRandomWaifu() async {
    try {
      final res = await _waifuService.getRandomWaifuImage(
        WaifuType.sfw,
        _defaultCategory,
      );

      return res;
    } on DioError catch (e) {
      handleError(e);
      rethrow;
    }
  }
}

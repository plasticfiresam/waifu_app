import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';

/// Default Elementary model for WaifuTinder module
class WaifuTinderModel extends ElementaryModel {
  final ValueNotifier<List<WaifuImageJson>> images =
      ValueNotifier<List<WaifuImageJson>>([]);

  final WaifuService _waifuService;

  WaifuTinderModel(this._waifuService);

  fetchWaifus() async {
    try {
      final waifus = await _waifuService.getWaifuImages(WaifuType.sfw, 'waifu');
      images.value = waifus.images.map((e) => WaifuImageJson(e)).toList();
    } on DioError catch (e) {
      handleError(e);
    }
  }
}

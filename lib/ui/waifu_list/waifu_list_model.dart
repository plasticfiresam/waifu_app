import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:waifu/service/constants/waifu_categories.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';

class WaifuListModel extends ElementaryModel {
  final ValueNotifier<List<WaifuImage>> images =
      ValueNotifier<List<WaifuImage>>([]);

  final ValueNotifier<WaifuType> _type =
      ValueNotifier<WaifuType>(WaifuType.sfw);

  final ValueNotifier<String> _category =
      ValueNotifier<String>(waifuCategories[WaifuType.sfw]!.first);

  final WaifuService _waifuService;

  WaifuListModel(this._waifuService);

  void onChangeType(WaifuType type) {
    _type.value = type;

    fetchWaifuImages();
  }

  void onChangeCategory(String category) {
    _category.value = category;

    fetchWaifuImages();
  }

  Future<WaifuImageList> fetchWaifuImages() async {
    try {
      final imageList =
          await _waifuService.getWaifuImages(_type.value, _category.value);

      return imageList;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }
}

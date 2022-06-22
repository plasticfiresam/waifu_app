import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/service/constants/waifu_categories.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';

class WaifuListModel extends ElementaryModel {
  final ValueNotifier<List<WaifuImage>> images =
      ValueNotifier<List<WaifuImage>>([]);

  final ValueNotifier<WaifuType> type = ValueNotifier<WaifuType>(WaifuType.sfw);

  final ValueNotifier<String> category =
      ValueNotifier<String>(waifuCategories[WaifuType.sfw]!.first);

  final WaifuService _waifuService;
  final AppModel _appModel;

  WaifuListModel(this._appModel, this._waifuService);

  void onChangeType(WaifuType newType) {
    type.value = newType;
  }

  void onChangeCategory(String newCategory) {
    category.value = newCategory;
  }

  void selectWaifu(WaifuImage waifu) {
    _appModel.currentImage = waifu;
  }

  Future<WaifuImageList> fetchWaifuImages() async {
    try {
      final imageList =
          await _waifuService.getWaifuImages(type.value, category.value);

      return imageList;
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }
}

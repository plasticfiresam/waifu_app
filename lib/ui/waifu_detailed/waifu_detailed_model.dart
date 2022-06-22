import 'package:elementary/elementary.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/service/model/waifu_image.dart';

class WaifuDetailedModel extends ElementaryModel {
  final AppModel _appModel;
  WaifuImage? get image => _appModel.currentImage;

  WaifuDetailedModel(this._appModel) : super();
}

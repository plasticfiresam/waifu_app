import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/main.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'waifu_detailed_model.dart';
import 'waifu_detailed_screen.dart';

abstract class IWaifuDetailedWidgetModel extends IWidgetModel {
  WaifuImage? get image;
}

WaifuDetailedWidgetModel defaultWaifuDetailedWidgetModelFactory(
    BuildContext context) {
  return WaifuDetailedWidgetModel(
    WaifuDetailedModel(
      getIt.get<AppModel>(),
    ),
  );
}

class WaifuDetailedWidgetModel
    extends WidgetModel<WaifuDetailedScreen, WaifuDetailedModel>
    implements IWaifuDetailedWidgetModel {
  WaifuDetailedWidgetModel(WaifuDetailedModel model) : super(model);

  @override
  WaifuImage? get image => model.image;
}

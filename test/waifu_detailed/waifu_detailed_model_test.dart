import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/ui/waifu_detailed/waifu_detailed_model.dart';

void main() {
  late WaifuDetailedModel model;
  late WaifuDetailedModel modelFilled;
  group('WaifuDetailedModel test', () {
    setUp(() {
      model = WaifuDetailedModel(AppModel());

      modelFilled = WaifuDetailedModel(AppModel()..currentImage = _mockWaifu);
    });

    test('init with nothing selected', () {
      expect(model.image, isNull);
    });

    test('init with selected waifu', () {
      expect(modelFilled.image, isNotNull);
    });
  });
}

const _mockWaifu = AssetImage('assets/images/placeholder.jpeg');

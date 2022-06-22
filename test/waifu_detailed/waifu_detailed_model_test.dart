import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/ui/waifu_detailed/waifu_detailed_model.dart';

void main() {
  late WaifuDetailedModel model;
  late WaifuDetailedModel modelFilled;
  final waifuMock = MockWaifuImage();
  group('WaifuDetailedModel test', () {
    setUp(() {
      model = WaifuDetailedModel(AppModel());

      modelFilled = WaifuDetailedModel(AppModel()..currentImage = waifuMock);
    });

    test('init with nothing selected', () {
      expect(model.image, isNull);
    });

    test('init with selected waifu', () {
      expect(modelFilled.image, isNotNull);
    });
  });
}

class MockWaifuImage extends Mock implements WaifuImage {}

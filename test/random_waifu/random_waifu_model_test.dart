import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';
import 'package:waifu/ui/random_waifu/random_waifu_model.dart';

void main() {
  late RandomWaifuModel model;
  final waifuServiceMock = WaifuServiceMock();
  group('RandomWaifuModel test', () {
    setUp(() {
      model = RandomWaifuModel(waifuServiceMock);
    });

    test('loadRandomWaifu returns image', () async {
      when(() => waifuServiceMock.getRandomWaifuImage(WaifuType.sfw, 'waifu'))
          .thenAnswer((_) => Future.value(_mockResponse));

      await model.loadRandomWaifu();

      expect(model.image.value, _mockWaifu);
    });
  });
}

const _mockResponse = WaifuImageJson('assets/images/placeholder.jpeg');

const _mockWaifu = NetworkImage('assets/images/placeholder.jpeg');

class WaifuServiceMock extends Mock implements WaifuService {}

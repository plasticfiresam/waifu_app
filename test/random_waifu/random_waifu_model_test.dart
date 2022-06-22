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
          .thenAnswer((_) => Future.value(mockImage));

      await model.loadRandomWaifu();

      expect(model.image.value, mockImage);
    });
  });
}

const mockImage = WaifuImage("https://i.waifu.pics/L~qlLcJ.jpg");

class WaifuServiceMock extends Mock implements WaifuService {}

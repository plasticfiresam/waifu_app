import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/waifu_service.dart';
import 'package:waifu/ui/waifu_list/waifu_list_model.dart';

void main() {
  final waifuServiceMock = WaifuServiceMock();

  late WaifuListModel model;

  group('WaifuListModel test', () {
    setUp(() {
      model = WaifuListModel(AppModel(), waifuServiceMock);

      when(() => waifuServiceMock.getWaifuImages(WaifuType.sfw, 'waifu'))
          .thenAnswer((_) => Future.value(_mockWaifusResponse));
    });

    test('init with empty images', () {
      expect(model.images.value.isEmpty, true);
    });

    test('type is changing', () {
      model.onChangeType(WaifuType.nsfw);

      expect(model.type.value, equals(WaifuType.nsfw));
    });

    test('category is changing', () {
      model.onChangeCategory('neko');

      expect(model.category.value, equals('neko'));
    });

    test('fetchWaifuImages mutates values correctly', () async {
      await model.fetchWaifuImages();

      expect(model.images.value.isNotEmpty, true);
    });
  });
}

class WaifuServiceMock extends Mock implements WaifuService {}

const _mockWaifusResponse = WaifuImageList([
  'https://i.waifu.pics/G8JK8lu.png',
  'https://i.waifu.pics/8flhYEv.jpg',
  'https://i.waifu.pics/xUYXg76.png',
  'https://i.waifu.pics/V8hvqfK.jpg',
  'https://i.waifu.pics/U3IZOf3.jpg'
]);

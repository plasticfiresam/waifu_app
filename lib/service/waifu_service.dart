import 'package:dio/dio.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/service/rest_client/waifu_client.dart';

const baseUrl = 'https://api.waifu.pics';

class WaifuService {
  final WaifuClient _client = WaifuClient(Dio(), baseUrl: baseUrl);

  Future<WaifuImageList> getWaifuImages(
    WaifuType type,
    String category,
  ) async {
    return await _client.getWaifuImages(type: type, category: category);
  }

  Future<WaifuImage> getRandomWaifuImages(
    WaifuType type,
    String category,
  ) async {
    return await _client.getRandomWaifuImage(type: type, category: category);
  }
}

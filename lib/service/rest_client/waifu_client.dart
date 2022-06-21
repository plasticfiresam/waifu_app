import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/service/model/waifu_type.dart';

part 'waifu_client.g.dart';

@RestApi()
abstract class WaifuClient {
  factory WaifuClient(
    Dio dio, {
    String? baseUrl,
  }) = _WaifuClient;

  @GET('/many/{type}/{category}')
  Future<WaifuImageList> getWaifuImages({
    @Path() required WaifuType type,
    @Path() required String category,
  });

  @GET('/{type}/{category}')
  Future<WaifuImage> getRandomWaifuImage({
    @Path() required WaifuType type,
    @Path() required String category,
  });
}

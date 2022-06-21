import 'package:json_annotation/json_annotation.dart';
import 'package:waifu/service/model/waifu_image.dart';

part 'waifu_image_list.g.dart';

@JsonSerializable(createToJson: false)
class WaifuImageList {
  @JsonKey(name: 'images')
  final List<WaifuImage> files;

  const WaifuImageList(this.files);

  factory WaifuImageList.fromJson(Map<String, Object?> json) =>
      _$WaifuImageListFromJson(json);
}

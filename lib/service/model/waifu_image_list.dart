import 'package:json_annotation/json_annotation.dart';

part 'waifu_image_list.g.dart';

@JsonSerializable(createToJson: false)
class WaifuImageList {
  @JsonKey(name: 'files')
  final List<String> images;

  const WaifuImageList(this.images);

  factory WaifuImageList.fromJson(Map<String, Object?> json) =>
      _$WaifuImageListFromJson(json);
}

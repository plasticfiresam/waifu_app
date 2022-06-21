import 'package:json_annotation/json_annotation.dart';

part 'waifu_image.g.dart';

@JsonSerializable(createToJson: false)
class WaifuImage {
  final String url;

  const WaifuImage(this.url);

  factory WaifuImage.fromJson(Map<String, Object?> json) =>
      _$WaifuImageFromJson(json);
}

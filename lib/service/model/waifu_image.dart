import 'package:json_annotation/json_annotation.dart';

part 'waifu_image.g.dart';

@JsonSerializable(createToJson: false)
class WaifuImageJson {
  final String url;

  const WaifuImageJson(this.url);

  factory WaifuImageJson.fromJson(Map<String, Object?> json) =>
      _$WaifuImageFromJson(json);
}

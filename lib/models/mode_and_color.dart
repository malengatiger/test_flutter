import 'package:json_annotation/json_annotation.dart';

part 'mode_and_color.g.dart';

@JsonSerializable()
class ModeAndColor {
   int? colorIndex;
   int? mode;

   ModeAndColor({
    this.colorIndex,
    this.mode,
  });

  factory ModeAndColor.fromJson(Map<String, dynamic> json) =>
      _$ModeAndColorFromJson(json);

  Map<String, dynamic> toJson() => _$ModeAndColorToJson(this);
}

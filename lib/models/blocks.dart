import 'package:json_annotation/json_annotation.dart';

part 'blocks.g.dart';

@JsonSerializable()
class Blocks {
  final int? height;
  final String? hash;
  final int? time;

  const Blocks({
    this.height,
    this.hash,
    this.time,
  });

  factory Blocks.fromJson(Map<String, dynamic> json) =>
      _$BlocksFromJson(json);

  Map<String, dynamic> toJson() => _$BlocksToJson(this);
}

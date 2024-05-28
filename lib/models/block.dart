import 'package:json_annotation/json_annotation.dart';

part 'block.g.dart';

@JsonSerializable()
class Block {
  final int? status;
  final Data? data;

  const Block({
    this.status,
    this.data,
  });

  factory Block.fromJson(Map<String, dynamic> json) =>
      _$BlockFromJson(json);

  Map<String, dynamic> toJson() => _$BlockToJson(this);
}

@JsonSerializable()
class Data {
  final String? hash;
  final int? time;
  @JsonKey(name: 'block_index')
  final int? blockIndex;
  final int? height;
  final List<int>? txIndexes;

  const Data({
    this.hash,
    this.time,
    this.blockIndex,
    this.height,
    this.txIndexes,
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

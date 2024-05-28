import 'package:json_annotation/json_annotation.dart';

part 'latest_block.g.dart';

@JsonSerializable()
class LatestBlock {
  final String? hash;
  final int? time;
  @JsonKey(name: 'block_index')
  final int? blockIndex;
  final int? height;
  final List<int>? txIndexes;

  const LatestBlock({
    this.hash,
    this.time,
    this.blockIndex,
    this.height,
    this.txIndexes,
  });

  factory LatestBlock.fromJson(Map<String, dynamic> json) =>
      _$LatestBlockFromJson(json);

  Map<String, dynamic> toJson() => _$LatestBlockToJson(this);
}

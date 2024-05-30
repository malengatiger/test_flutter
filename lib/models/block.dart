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
  //received_time
  @JsonKey(name: 'received_time')
  final int? receivedTime;
  final int? height, size;
  //main_chain
  @JsonKey(name: 'main_chain')
  final int? mainChain;
  //relayed_by
  @JsonKey(name: 'relayed_by')
  final String? relayedBy;
  //n_tx prev_block
  @JsonKey(name: 'n_tx')
  final int? numberOfTransactions;
  @JsonKey(name: 'prev_block')
  final String? prevBlock;
  final List<int>? txIndexes;


  Data({
      this.hash,
      this.time,
      this.blockIndex,
      this.receivedTime,
      this.height,
      this.size,
      this.mainChain,
      this.relayedBy,
      this.numberOfTransactions,
      this.prevBlock,
      this.txIndexes});

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

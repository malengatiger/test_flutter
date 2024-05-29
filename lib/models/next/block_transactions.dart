import 'package:busha_app/models/next/single_transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'block_transactions.g.dart';

@JsonSerializable()
class BlockTransactions {
  final String? hash;
  final int? ver;
  @JsonKey(name: 'prev_block')
  final String? prevBlock;
  @JsonKey(name: 'mrkl_root')
  final String? mrklRoot;
  final int? time;
  final int? bits;
  final int? nonce;
  @JsonKey(name: 'n_tx')
  final int? nTx;
  final int? size;
  @JsonKey(name: 'block_index')
  final int? blockIndex;
  @JsonKey(name: 'main_chain')
  final bool? mainChain;
  final int? height;
  @JsonKey(name: 'received_time')
  final int? receivedTime;
  @JsonKey(name: 'relayed_by')
  final String? relayedBy;
  final List<SingleTransaction>? tx;

  const BlockTransactions({
    this.hash,
    this.ver,
    this.prevBlock,
    this.mrklRoot,
    this.time,
    this.bits,
    this.nonce,
    this.nTx,
    this.size,
    this.blockIndex,
    this.mainChain,
    this.height,
    this.receivedTime,
    this.relayedBy,
    this.tx,
  });

  factory BlockTransactions.fromJson(Map<String, dynamic> json) =>
      _$BlockTransactionsFromJson(json);

  Map<String, dynamic> toJson() => _$BlockTransactionsToJson(this);
}

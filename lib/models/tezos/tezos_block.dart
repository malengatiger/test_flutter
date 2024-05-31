import 'package:json_annotation/json_annotation.dart';

part 'tezos_block.g.dart';

@JsonSerializable()
class TezosBlock {
  final int? cycle;
  final int? level;
  final String? hash;
  final String? timestamp;
  final int? proto;
  final int? payloadRound;
  final int? blockRound;
  final int? validations;
  final int? deposit;
  final int? rewardLiquid;
  final int? rewardStakedOwn;
  final int? rewardStakedShared;
  final int? bonusLiquid;
  final int? bonusStakedOwn;
  final int? bonusStakedShared;
  final int? fees;
  final bool? nonceRevealed;
  final int? lbToggleEma;
  final int? aiToggleEma;
  final int? reward;
  final int? bonus;
  final int? priority;
  final bool? lbEscapeVote;
  final int? lbEscapeEma;

  const TezosBlock({
    this.cycle,
    this.level,
    this.hash,
    this.timestamp,
    this.proto,
    this.payloadRound,
    this.blockRound,
    this.validations,
    this.deposit,
    this.rewardLiquid,
    this.rewardStakedOwn,
    this.rewardStakedShared,
    this.bonusLiquid,
    this.bonusStakedOwn,
    this.bonusStakedShared,
    this.fees,
    this.nonceRevealed,
    this.lbToggleEma,
    this.aiToggleEma,
    this.reward,
    this.bonus,
    this.priority,
    this.lbEscapeVote,
    this.lbEscapeEma,
  });

  factory TezosBlock.fromJson(Map<String, dynamic> json) =>
      _$TezosBlockFromJson(json);

  Map<String, dynamic> toJson() => _$TezosBlockToJson(this);
}

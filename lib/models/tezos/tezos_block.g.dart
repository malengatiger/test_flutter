// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tezos_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TezosBlock _$TezosBlockFromJson(Map<String, dynamic> json) => TezosBlock(
      cycle: (json['cycle'] as num?)?.toInt(),
      level: (json['level'] as num?)?.toInt(),
      hash: json['hash'] as String?,
      timestamp: json['timestamp'] as String?,
      proto: (json['proto'] as num?)?.toInt(),
      payloadRound: (json['payloadRound'] as num?)?.toInt(),
      blockRound: (json['blockRound'] as num?)?.toInt(),
      validations: (json['validations'] as num?)?.toInt(),
      deposit: (json['deposit'] as num?)?.toInt(),
      rewardLiquid: (json['rewardLiquid'] as num?)?.toInt(),
      rewardStakedOwn: (json['rewardStakedOwn'] as num?)?.toInt(),
      rewardStakedShared: (json['rewardStakedShared'] as num?)?.toInt(),
      bonusLiquid: (json['bonusLiquid'] as num?)?.toInt(),
      bonusStakedOwn: (json['bonusStakedOwn'] as num?)?.toInt(),
      bonusStakedShared: (json['bonusStakedShared'] as num?)?.toInt(),
      fees: (json['fees'] as num?)?.toInt(),
      nonceRevealed: json['nonceRevealed'] as bool?,
      lbToggleEma: (json['lbToggleEma'] as num?)?.toInt(),
      aiToggleEma: (json['aiToggleEma'] as num?)?.toInt(),
      reward: (json['reward'] as num?)?.toInt(),
      bonus: (json['bonus'] as num?)?.toInt(),
      priority: (json['priority'] as num?)?.toInt(),
      lbEscapeVote: json['lbEscapeVote'] as bool?,
      lbEscapeEma: (json['lbEscapeEma'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TezosBlockToJson(TezosBlock instance) =>
    <String, dynamic>{
      'cycle': instance.cycle,
      'level': instance.level,
      'hash': instance.hash,
      'timestamp': instance.timestamp,
      'proto': instance.proto,
      'payloadRound': instance.payloadRound,
      'blockRound': instance.blockRound,
      'validations': instance.validations,
      'deposit': instance.deposit,
      'rewardLiquid': instance.rewardLiquid,
      'rewardStakedOwn': instance.rewardStakedOwn,
      'rewardStakedShared': instance.rewardStakedShared,
      'bonusLiquid': instance.bonusLiquid,
      'bonusStakedOwn': instance.bonusStakedOwn,
      'bonusStakedShared': instance.bonusStakedShared,
      'fees': instance.fees,
      'nonceRevealed': instance.nonceRevealed,
      'lbToggleEma': instance.lbToggleEma,
      'aiToggleEma': instance.aiToggleEma,
      'reward': instance.reward,
      'bonus': instance.bonus,
      'priority': instance.priority,
      'lbEscapeVote': instance.lbEscapeVote,
      'lbEscapeEma': instance.lbEscapeEma,
    };

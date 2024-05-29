// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockTransactions _$BlockTransactionsFromJson(Map<String, dynamic> json) =>
    BlockTransactions(
      hash: json['hash'] as String?,
      ver: (json['ver'] as num?)?.toInt(),
      prevBlock: json['prev_block'] as String?,
      mrklRoot: json['mrkl_root'] as String?,
      time: (json['time'] as num?)?.toInt(),
      bits: (json['bits'] as num?)?.toInt(),
      nonce: (json['nonce'] as num?)?.toInt(),
      nTx: (json['n_tx'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      blockIndex: (json['block_index'] as num?)?.toInt(),
      mainChain: json['main_chain'] as bool?,
      height: (json['height'] as num?)?.toInt(),
      receivedTime: (json['received_time'] as num?)?.toInt(),
      relayedBy: json['relayed_by'] as String?,
      tx: (json['tx'] as List<dynamic>?)
          ?.map((e) => SingleTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlockTransactionsToJson(BlockTransactions instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'ver': instance.ver,
      'prev_block': instance.prevBlock,
      'mrkl_root': instance.mrklRoot,
      'time': instance.time,
      'bits': instance.bits,
      'nonce': instance.nonce,
      'n_tx': instance.nTx,
      'size': instance.size,
      'block_index': instance.blockIndex,
      'main_chain': instance.mainChain,
      'height': instance.height,
      'received_time': instance.receivedTime,
      'relayed_by': instance.relayedBy,
      'tx': instance.tx,
    };

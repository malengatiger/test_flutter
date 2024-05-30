// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
      status: (json['status'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      hash: json['hash'] as String?,
      time: (json['time'] as num?)?.toInt(),
      blockIndex: (json['block_index'] as num?)?.toInt(),
      receivedTime: (json['received_time'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      mainChain: (json['main_chain'] as num?)?.toInt(),
      relayedBy: json['relayed_by'] as String?,
      numberOfTransactions: (json['n_tx'] as num?)?.toInt(),
      prevBlock: json['prev_block'] as String?,
      txIndexes: (json['txIndexes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'hash': instance.hash,
      'time': instance.time,
      'block_index': instance.blockIndex,
      'received_time': instance.receivedTime,
      'height': instance.height,
      'size': instance.size,
      'main_chain': instance.mainChain,
      'relayed_by': instance.relayedBy,
      'n_tx': instance.numberOfTransactions,
      'prev_block': instance.prevBlock,
      'txIndexes': instance.txIndexes,
    };

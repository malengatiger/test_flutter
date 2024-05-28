// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestBlock _$LatestBlockFromJson(Map<String, dynamic> json) => LatestBlock(
      hash: json['hash'] as String?,
      time: (json['time'] as num?)?.toInt(),
      blockIndex: (json['block_index'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      txIndexes: (json['txIndexes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$LatestBlockToJson(LatestBlock instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'time': instance.time,
      'block_index': instance.blockIndex,
      'height': instance.height,
      'txIndexes': instance.txIndexes,
    };

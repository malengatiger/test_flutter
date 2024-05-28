// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blocks _$BlocksFromJson(Map<String, dynamic> json) => Blocks(
      height: (json['height'] as num?)?.toInt(),
      hash: json['hash'] as String?,
      time: (json['time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BlocksToJson(Blocks instance) => <String, dynamic>{
      'height': instance.height,
      'hash': instance.hash,
      'time': instance.time,
    };

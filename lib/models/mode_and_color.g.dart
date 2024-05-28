// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mode_and_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModeAndColor _$ModeAndColorFromJson(Map<String, dynamic> json) => ModeAndColor(
      colorIndex: (json['colorIndex'] as num?)?.toInt(),
      mode: (json['mode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ModeAndColorToJson(ModeAndColor instance) =>
    <String, dynamic>{
      'colorIndex': instance.colorIndex,
      'mode': instance.mode,
    };

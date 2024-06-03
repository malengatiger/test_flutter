// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
      level: (json['level'] as num?)?.toInt(),
      timestamp: json['timestamp'] as String?,
      balance: (json['balance'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BalanceToJson(Balance instance) => <String, dynamic>{
      'level': instance.level,
      'timestamp': instance.timestamp,
      'balance': instance.balance,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountContract _$AccountContractFromJson(Map<String, dynamic> json) =>
    AccountContract(
      kind: json['kind'] as String?,
      alias: json['alias'] as String?,
      address: json['address'] as String?,
      balance: (json['balance'] as num?)?.toInt(),
      creationLevel: (json['creationLevel'] as num?)?.toInt(),
      creationTime: json['creationTime'] as String?,
    );

Map<String, dynamic> _$AccountContractToJson(AccountContract instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'alias': instance.alias,
      'address': instance.address,
      'balance': instance.balance,
      'creationLevel': instance.creationLevel,
      'creationTime': instance.creationTime,
    };

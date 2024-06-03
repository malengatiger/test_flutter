// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountOperation _$AccountOperationFromJson(Map<String, dynamic> json) =>
    AccountOperation(
      type: json['type'] as String?,
      id: (json['id'] as num?)?.toInt(),
      level: (json['level'] as num?)?.toInt(),
      timestamp: json['timestamp'] as String?,
      block: json['block'] as String?,
      hash: json['hash'] as String?,
      counter: (json['counter'] as num?)?.toInt(),
      initiator: json['initiator'] == null
          ? null
          : Initiator.fromJson(json['initiator'] as Map<String, dynamic>),
      sender: json['sender'] == null
          ? null
          : Sender.fromJson(json['sender'] as Map<String, dynamic>),
      senderCodeHash: (json['senderCodeHash'] as num?)?.toInt(),
      nonce: (json['nonce'] as num?)?.toInt(),
      gasLimit: (json['gasLimit'] as num?)?.toInt(),
      gasUsed: (json['gasUsed'] as num?)?.toInt(),
      storageLimit: (json['storageLimit'] as num?)?.toInt(),
      storageUsed: (json['storageUsed'] as num?)?.toInt(),
      bakerFee: (json['bakerFee'] as num?)?.toInt(),
      storageFee: (json['storageFee'] as num?)?.toInt(),
      allocationFee: (json['allocationFee'] as num?)?.toInt(),
      target: json['target'] == null
          ? null
          : Target.fromJson(json['target'] as Map<String, dynamic>),
      amount: (json['amount'] as num?)?.toInt(),
      status: json['status'] as String?,
      hasInternals: json['hasInternals'] as bool?,
    );

Map<String, dynamic> _$AccountOperationToJson(AccountOperation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'level': instance.level,
      'timestamp': instance.timestamp,
      'block': instance.block,
      'hash': instance.hash,
      'counter': instance.counter,
      'initiator': instance.initiator,
      'sender': instance.sender,
      'senderCodeHash': instance.senderCodeHash,
      'nonce': instance.nonce,
      'gasLimit': instance.gasLimit,
      'gasUsed': instance.gasUsed,
      'storageLimit': instance.storageLimit,
      'storageUsed': instance.storageUsed,
      'bakerFee': instance.bakerFee,
      'storageFee': instance.storageFee,
      'allocationFee': instance.allocationFee,
      'target': instance.target,
      'amount': instance.amount,
      'status': instance.status,
      'hasInternals': instance.hasInternals,
    };

Initiator _$InitiatorFromJson(Map<String, dynamic> json) => Initiator(
      address: json['address'] as String?,
    );

Map<String, dynamic> _$InitiatorToJson(Initiator instance) => <String, dynamic>{
      'address': instance.address,
    };

Sender _$SenderFromJson(Map<String, dynamic> json) => Sender(
      alias: json['alias'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$SenderToJson(Sender instance) => <String, dynamic>{
      'alias': instance.alias,
      'address': instance.address,
    };

Target _$TargetFromJson(Map<String, dynamic> json) => Target(
      alias: json['alias'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$TargetToJson(Target instance) => <String, dynamic>{
      'alias': instance.alias,
      'address': instance.address,
    };

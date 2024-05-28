// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      hash: json['hash'] as String?,
      ver: (json['ver'] as num?)?.toInt(),
      vinSz: (json['vin_sz'] as num?)?.toInt(),
      voutSz: (json['vout_sz'] as num?)?.toInt(),
      lockTime: json['lock_time'] as String?,
      size: (json['size'] as num?)?.toInt(),
      relayedBy: json['relayed_by'] as String?,
      blockHeight: (json['block_height'] as num?)?.toInt(),
      txIndex: json['tx_index'] as String?,
      inputs: (json['inputs'] as List<dynamic>?)
          ?.map((e) => Inputs.fromJson(e as Map<String, dynamic>))
          .toList(),
      out: (json['out'] as List<dynamic>?)
          ?.map((e) => Out.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'ver': instance.ver,
      'vin_sz': instance.vinSz,
      'vout_sz': instance.voutSz,
      'lock_time': instance.lockTime,
      'size': instance.size,
      'relayed_by': instance.relayedBy,
      'block_height': instance.blockHeight,
      'tx_index': instance.txIndex,
      'inputs': instance.inputs,
      'out': instance.out,
    };

Inputs _$InputsFromJson(Map<String, dynamic> json) => Inputs(
      prevOut: json['prev_out'] == null
          ? null
          : PrevOut.fromJson(json['prev_out'] as Map<String, dynamic>),
      script: json['script'] as String?,
    );

Map<String, dynamic> _$InputsToJson(Inputs instance) => <String, dynamic>{
      'prev_out': instance.prevOut,
      'script': instance.script,
    };

PrevOut _$PrevOutFromJson(Map<String, dynamic> json) => PrevOut(
      hash: json['hash'] as String?,
      value: json['value'] as String?,
      txIndex: json['tx_index'] as String?,
      n: json['n'] as String?,
    );

Map<String, dynamic> _$PrevOutToJson(PrevOut instance) => <String, dynamic>{
      'hash': instance.hash,
      'value': instance.value,
      'tx_index': instance.txIndex,
      'n': instance.n,
    };

Out _$OutFromJson(Map<String, dynamic> json) => Out(
      value: json['value'] as String?,
      hash: json['hash'] as String?,
      script: json['script'] as String?,
    );

Map<String, dynamic> _$OutToJson(Out instance) => <String, dynamic>{
      'value': instance.value,
      'hash': instance.hash,
      'script': instance.script,
    };

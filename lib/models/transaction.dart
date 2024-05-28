import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final String? hash;
  final int? ver;
  @JsonKey(name: 'vin_sz')
  final int? vinSz;
  @JsonKey(name: 'vout_sz')
  final int? voutSz;
  @JsonKey(name: 'lock_time')
  final String? lockTime;
  final int? size;
  @JsonKey(name: 'relayed_by')
  final String? relayedBy;
  @JsonKey(name: 'block_height')
  final int? blockHeight;
  @JsonKey(name: 'tx_index')
  final String? txIndex;
  final List<Inputs>? inputs;
  final List<Out>? out;

  const Transaction({
    this.hash,
    this.ver,
    this.vinSz,
    this.voutSz,
    this.lockTime,
    this.size,
    this.relayedBy,
    this.blockHeight,
    this.txIndex,
    this.inputs,
    this.out,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable()
class Inputs {
  @JsonKey(name: 'prev_out')
  final PrevOut? prevOut;
  final String? script;

  const Inputs({
    this.prevOut,
    this.script,
  });

  factory Inputs.fromJson(Map<String, dynamic> json) =>
      _$InputsFromJson(json);

  Map<String, dynamic> toJson() => _$InputsToJson(this);
}

@JsonSerializable()
class PrevOut {
  final String? hash;
  final String? value;
  @JsonKey(name: 'tx_index')
  final String? txIndex;
  final String? n;

  const PrevOut({
    this.hash,
    this.value,
    this.txIndex,
    this.n,
  });

  factory PrevOut.fromJson(Map<String, dynamic> json) =>
      _$PrevOutFromJson(json);

  Map<String, dynamic> toJson() => _$PrevOutToJson(this);
}

@JsonSerializable()
class Out {
  final String? value;
  final String? hash;
  final String? script;

  const Out({
    this.value,
    this.hash,
    this.script,
  });

  factory Out.fromJson(Map<String, dynamic> json) =>
      _$OutFromJson(json);

  Map<String, dynamic> toJson() => _$OutToJson(this);
}

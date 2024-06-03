import 'package:json_annotation/json_annotation.dart';

part 'account_operation.g.dart';

@JsonSerializable()
class AccountOperation {
  final String? type;
  final int? id;
  final int? level;
  final String? timestamp;
  final String? block;
  final String? hash;
  final int? counter;
  final Initiator? initiator;
  final Sender? sender;
  final int? senderCodeHash;
  final int? nonce;
  final int? gasLimit;
  final int? gasUsed;
  final int? storageLimit;
  final int? storageUsed;
  final int? bakerFee;
  final int? storageFee;
  final int? allocationFee;
  final Target? target;
  final int? amount;
  final String? status;
  final bool? hasInternals;

  const AccountOperation({
    this.type,
    this.id,
    this.level,
    this.timestamp,
    this.block,
    this.hash,
    this.counter,
    this.initiator,
    this.sender,
    this.senderCodeHash,
    this.nonce,
    this.gasLimit,
    this.gasUsed,
    this.storageLimit,
    this.storageUsed,
    this.bakerFee,
    this.storageFee,
    this.allocationFee,
    this.target,
    this.amount,
    this.status,
    this.hasInternals,
  });

  factory AccountOperation.fromJson(Map<String, dynamic> json) =>
      _$AccountOperationFromJson(json);

  Map<String, dynamic> toJson() => _$AccountOperationToJson(this);
}

@JsonSerializable()
class Initiator {
  final String? address;

  const Initiator({
    this.address,
  });

  factory Initiator.fromJson(Map<String, dynamic> json) =>
      _$InitiatorFromJson(json);

  Map<String, dynamic> toJson() => _$InitiatorToJson(this);
}

@JsonSerializable()
class Sender {
  final String? alias;
  final String? address;

  const Sender({
    this.alias,
    this.address,
  });

  factory Sender.fromJson(Map<String, dynamic> json) =>
      _$SenderFromJson(json);

  Map<String, dynamic> toJson() => _$SenderToJson(this);
}

@JsonSerializable()
class Target {
  final String? alias;
  final String? address;

  const Target({
    this.alias,
    this.address,
  });

  factory Target.fromJson(Map<String, dynamic> json) =>
      _$TargetFromJson(json);

  Map<String, dynamic> toJson() => _$TargetToJson(this);
}

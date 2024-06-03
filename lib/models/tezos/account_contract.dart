import 'package:json_annotation/json_annotation.dart';

part 'account_contract.g.dart';

@JsonSerializable()
class AccountContract {
  final String? kind;
  final String? alias;
  final String? address;
  final int? balance;
  final int? creationLevel;
  final String? creationTime;

  const AccountContract({
    this.kind,
    this.alias,
    this.address,
    this.balance,
    this.creationLevel,
    this.creationTime,
  });

  factory AccountContract.fromJson(Map<String, dynamic> json) =>
      _$AccountContractFromJson(json);

  Map<String, dynamic> toJson() => _$AccountContractToJson(this);
}

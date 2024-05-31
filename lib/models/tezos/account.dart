import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  final int? id;
  final String? type;
  final String? address;
  final String? alias;
  final bool? revealed;
  final int? balance;
  final int? rollupBonds;
  final int? smartRollupBonds;
  final int? stakedBalance;
  final int? stakedPseudotokens;
  final int? unstakedBalance;
  final int? lostBalance;
  final int? counter;
  final int? numContracts;
  final int? rollupsCount;
  final int? smartRollupsCount;
  final int? activeTokensCount;
  final int? tokenBalancesCount;
  final int? tokenTransfersCount;
  final int? activeTicketsCount;
  final int? ticketBalancesCount;
  final int? ticketTransfersCount;
  final int? numActivations;
  final int? numDelegations;
  final int? numOriginations;
  final int? numTransactions;
  final int? numReveals;
  final int? numRegisterConstants;
  final int? numSetDepositsLimits;
  final int? numMigrations;
  final int? txRollupOriginationCount;
  final int? txRollupSubmitBatchCount;
  final int? txRollupCommitCount;
  final int? txRollupReturnBondCount;
  final int? txRollupFinalizeCommitmentCount;
  final int? txRollupRemoveCommitmentCount;
  final int? txRollupRejectionCount;
  final int? txRollupDispatchTicketsCount;
  final int? transferTicketCount;
  final int? increasePaidStorageCount;
  final int? drainDelegateCount;
  final int? smartRollupAddMessagesCount;
  final int? smartRollupCementCount;
  final int? smartRollupExecuteCount;
  final int? smartRollupOriginateCount;
  final int? smartRollupPublishCount;
  final int? smartRollupRecoverBondCount;
  final int? smartRollupRefuteCount;
  final int? refutationGamesCount;
  final int? activeRefutationGamesCount;
  final int? stakingOpsCount;
  final int? firstActivity;
  final String? firstActivityTime;
  final int? lastActivity;
  final String? lastActivityTime;

  const Account({
    this.id,
    this.type,
    this.address,
    this.alias,
    this.revealed,
    this.balance,
    this.rollupBonds,
    this.smartRollupBonds,
    this.stakedBalance,
    this.stakedPseudotokens,
    this.unstakedBalance,
    this.lostBalance,
    this.counter,
    this.numContracts,
    this.rollupsCount,
    this.smartRollupsCount,
    this.activeTokensCount,
    this.tokenBalancesCount,
    this.tokenTransfersCount,
    this.activeTicketsCount,
    this.ticketBalancesCount,
    this.ticketTransfersCount,
    this.numActivations,
    this.numDelegations,
    this.numOriginations,
    this.numTransactions,
    this.numReveals,
    this.numRegisterConstants,
    this.numSetDepositsLimits,
    this.numMigrations,
    this.txRollupOriginationCount,
    this.txRollupSubmitBatchCount,
    this.txRollupCommitCount,
    this.txRollupReturnBondCount,
    this.txRollupFinalizeCommitmentCount,
    this.txRollupRemoveCommitmentCount,
    this.txRollupRejectionCount,
    this.txRollupDispatchTicketsCount,
    this.transferTicketCount,
    this.increasePaidStorageCount,
    this.drainDelegateCount,
    this.smartRollupAddMessagesCount,
    this.smartRollupCementCount,
    this.smartRollupExecuteCount,
    this.smartRollupOriginateCount,
    this.smartRollupPublishCount,
    this.smartRollupRecoverBondCount,
    this.smartRollupRefuteCount,
    this.refutationGamesCount,
    this.activeRefutationGamesCount,
    this.stakingOpsCount,
    this.firstActivity,
    this.firstActivityTime,
    this.lastActivity,
    this.lastActivityTime,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

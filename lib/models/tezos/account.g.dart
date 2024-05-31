// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      address: json['address'] as String?,
      alias: json['alias'] as String?,
      revealed: json['revealed'] as bool?,
      balance: (json['balance'] as num?)?.toInt(),
      rollupBonds: (json['rollupBonds'] as num?)?.toInt(),
      smartRollupBonds: (json['smartRollupBonds'] as num?)?.toInt(),
      stakedBalance: (json['stakedBalance'] as num?)?.toInt(),
      stakedPseudotokens: (json['stakedPseudotokens'] as num?)?.toInt(),
      unstakedBalance: (json['unstakedBalance'] as num?)?.toInt(),
      lostBalance: (json['lostBalance'] as num?)?.toInt(),
      counter: (json['counter'] as num?)?.toInt(),
      numContracts: (json['numContracts'] as num?)?.toInt(),
      rollupsCount: (json['rollupsCount'] as num?)?.toInt(),
      smartRollupsCount: (json['smartRollupsCount'] as num?)?.toInt(),
      activeTokensCount: (json['activeTokensCount'] as num?)?.toInt(),
      tokenBalancesCount: (json['tokenBalancesCount'] as num?)?.toInt(),
      tokenTransfersCount: (json['tokenTransfersCount'] as num?)?.toInt(),
      activeTicketsCount: (json['activeTicketsCount'] as num?)?.toInt(),
      ticketBalancesCount: (json['ticketBalancesCount'] as num?)?.toInt(),
      ticketTransfersCount: (json['ticketTransfersCount'] as num?)?.toInt(),
      numActivations: (json['numActivations'] as num?)?.toInt(),
      numDelegations: (json['numDelegations'] as num?)?.toInt(),
      numOriginations: (json['numOriginations'] as num?)?.toInt(),
      numTransactions: (json['numTransactions'] as num?)?.toInt(),
      numReveals: (json['numReveals'] as num?)?.toInt(),
      numRegisterConstants: (json['numRegisterConstants'] as num?)?.toInt(),
      numSetDepositsLimits: (json['numSetDepositsLimits'] as num?)?.toInt(),
      numMigrations: (json['numMigrations'] as num?)?.toInt(),
      txRollupOriginationCount:
          (json['txRollupOriginationCount'] as num?)?.toInt(),
      txRollupSubmitBatchCount:
          (json['txRollupSubmitBatchCount'] as num?)?.toInt(),
      txRollupCommitCount: (json['txRollupCommitCount'] as num?)?.toInt(),
      txRollupReturnBondCount:
          (json['txRollupReturnBondCount'] as num?)?.toInt(),
      txRollupFinalizeCommitmentCount:
          (json['txRollupFinalizeCommitmentCount'] as num?)?.toInt(),
      txRollupRemoveCommitmentCount:
          (json['txRollupRemoveCommitmentCount'] as num?)?.toInt(),
      txRollupRejectionCount: (json['txRollupRejectionCount'] as num?)?.toInt(),
      txRollupDispatchTicketsCount:
          (json['txRollupDispatchTicketsCount'] as num?)?.toInt(),
      transferTicketCount: (json['transferTicketCount'] as num?)?.toInt(),
      increasePaidStorageCount:
          (json['increasePaidStorageCount'] as num?)?.toInt(),
      drainDelegateCount: (json['drainDelegateCount'] as num?)?.toInt(),
      smartRollupAddMessagesCount:
          (json['smartRollupAddMessagesCount'] as num?)?.toInt(),
      smartRollupCementCount: (json['smartRollupCementCount'] as num?)?.toInt(),
      smartRollupExecuteCount:
          (json['smartRollupExecuteCount'] as num?)?.toInt(),
      smartRollupOriginateCount:
          (json['smartRollupOriginateCount'] as num?)?.toInt(),
      smartRollupPublishCount:
          (json['smartRollupPublishCount'] as num?)?.toInt(),
      smartRollupRecoverBondCount:
          (json['smartRollupRecoverBondCount'] as num?)?.toInt(),
      smartRollupRefuteCount: (json['smartRollupRefuteCount'] as num?)?.toInt(),
      refutationGamesCount: (json['refutationGamesCount'] as num?)?.toInt(),
      activeRefutationGamesCount:
          (json['activeRefutationGamesCount'] as num?)?.toInt(),
      stakingOpsCount: (json['stakingOpsCount'] as num?)?.toInt(),
      firstActivity: (json['firstActivity'] as num?)?.toInt(),
      firstActivityTime: json['firstActivityTime'] as String?,
      lastActivity: (json['lastActivity'] as num?)?.toInt(),
      lastActivityTime: json['lastActivityTime'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'address': instance.address,
      'alias': instance.alias,
      'revealed': instance.revealed,
      'balance': instance.balance,
      'rollupBonds': instance.rollupBonds,
      'smartRollupBonds': instance.smartRollupBonds,
      'stakedBalance': instance.stakedBalance,
      'stakedPseudotokens': instance.stakedPseudotokens,
      'unstakedBalance': instance.unstakedBalance,
      'lostBalance': instance.lostBalance,
      'counter': instance.counter,
      'numContracts': instance.numContracts,
      'rollupsCount': instance.rollupsCount,
      'smartRollupsCount': instance.smartRollupsCount,
      'activeTokensCount': instance.activeTokensCount,
      'tokenBalancesCount': instance.tokenBalancesCount,
      'tokenTransfersCount': instance.tokenTransfersCount,
      'activeTicketsCount': instance.activeTicketsCount,
      'ticketBalancesCount': instance.ticketBalancesCount,
      'ticketTransfersCount': instance.ticketTransfersCount,
      'numActivations': instance.numActivations,
      'numDelegations': instance.numDelegations,
      'numOriginations': instance.numOriginations,
      'numTransactions': instance.numTransactions,
      'numReveals': instance.numReveals,
      'numRegisterConstants': instance.numRegisterConstants,
      'numSetDepositsLimits': instance.numSetDepositsLimits,
      'numMigrations': instance.numMigrations,
      'txRollupOriginationCount': instance.txRollupOriginationCount,
      'txRollupSubmitBatchCount': instance.txRollupSubmitBatchCount,
      'txRollupCommitCount': instance.txRollupCommitCount,
      'txRollupReturnBondCount': instance.txRollupReturnBondCount,
      'txRollupFinalizeCommitmentCount':
          instance.txRollupFinalizeCommitmentCount,
      'txRollupRemoveCommitmentCount': instance.txRollupRemoveCommitmentCount,
      'txRollupRejectionCount': instance.txRollupRejectionCount,
      'txRollupDispatchTicketsCount': instance.txRollupDispatchTicketsCount,
      'transferTicketCount': instance.transferTicketCount,
      'increasePaidStorageCount': instance.increasePaidStorageCount,
      'drainDelegateCount': instance.drainDelegateCount,
      'smartRollupAddMessagesCount': instance.smartRollupAddMessagesCount,
      'smartRollupCementCount': instance.smartRollupCementCount,
      'smartRollupExecuteCount': instance.smartRollupExecuteCount,
      'smartRollupOriginateCount': instance.smartRollupOriginateCount,
      'smartRollupPublishCount': instance.smartRollupPublishCount,
      'smartRollupRecoverBondCount': instance.smartRollupRecoverBondCount,
      'smartRollupRefuteCount': instance.smartRollupRefuteCount,
      'refutationGamesCount': instance.refutationGamesCount,
      'activeRefutationGamesCount': instance.activeRefutationGamesCount,
      'stakingOpsCount': instance.stakingOpsCount,
      'firstActivity': instance.firstActivity,
      'firstActivityTime': instance.firstActivityTime,
      'lastActivity': instance.lastActivity,
      'lastActivityTime': instance.lastActivityTime,
    };

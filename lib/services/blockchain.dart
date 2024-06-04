import 'dart:convert';

import 'package:busha_app/models/block.dart';
import 'package:busha_app/models/tezos/account.dart';
import 'package:busha_app/models/tezos/account_contract.dart';
import 'package:busha_app/models/tezos/account_operation.dart';
import 'package:busha_app/models/tezos/tezos_block.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/util/functions.dart';

import '../models/next/block_transactions.dart';
import '../models/tezos/balance.dart';

// @Welltested()
class BlockchainService {
  static const mm = '🔷 🔷 🔷 BlockchainService';
  final Net net;

  BlockchainService(this.net);

  Future<Block?> getLatestBlock() async {
    pp('$mm ........................ getLatestBlock ...');
    Block? block;
    try {
      var resp = await net.get('blockchain/getLatestBlock');
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        block = Block.fromJson(jsonDecode(resp.body));
        pp('$mm getLatestBlock ...  🍐 \n block time: 🍐 ${block.data!.time}  🍐');
      } else {
        throw Exception('Get latest block failed: ${resp.statusCode}');
      }
    } catch (e, s) {
      pp('getLatestBlock ERROR: $e $s');
      throw Exception('Get latest block failed: $e');
    }
    return block;
  }

  //http://localhost:8080/tezos/getAccounts?balanceParam=10000000&limit=3
  //BlockchainService response: 200 - {"code":400,"errors":{"balance.gt":"Invalid integer value."}}
  Future<List<Account>> getTezosAccounts(
      {required int balanceParam, required int limit}) async {
    List<Account> accounts = [];
    try {
      var s1 = 'tezos/getAccounts?balanceParam=$balanceParam';
      s1 = '$s1&limit=$limit';
      pp('$mm ....... getTezosAccounts: path: $s1');
      var resp = await net.get(s1);
      pp('$mm response, statusCode: ${resp.statusCode} - ${resp.body}');
      if (resp.statusCode == 200) {
        try {
          Map<String, dynamic> json = jsonDecode(resp.body);
          if (json.containsKey('code')) {
            pp('$mm ... error encountered: $json');
            throw Exception(resp.body);
          }
        } catch (e, s) {
          // pp('$e \n$s');
        }
        List mList = jsonDecode(resp.body);
        pp('$mm ... seems OK?: ${mList.length} records found');
        for (var json in mList) {
          var acc = Account.fromJson(json);
          accounts.add(acc);
        }
      }
    } catch (e, s) {
      pp('$e $s');
    }

    return accounts;
  }

  Future<TezosBlock?> getTezosBlock(String timestamp) async {
    TezosBlock? block;
    try {
      var resp = await net.get('tezos/getBlock?timestamp=$timestamp');
      if (resp.statusCode == 200) {
        var mJson = jsonDecode(resp.body);
        block = TezosBlock.fromJson(mJson);
      } else {
        throw Exception(
            'Failed to get Tezos block: Bad status code: ${resp.statusCode}');
      }
    } catch (e, s) {
      pp('$e $s');
      throw Exception('Failed to get Tezos block: $e');
    }

    return block;
  }

  Future<int> getBalance(String address) async {
    int balance = 0;
    try {
      var resp = await net.get('tezos/getBalance?address=$address');
      if (resp.statusCode == 200) {
        balance = int.parse(resp.body);
      } else {
        throw Exception(
            'Failed to getBalance: Bad status code: ${resp.statusCode}');
      }
    } catch (e, s) {
      pp('$e $s');
      throw Exception('Failed to getBalance: $e');
    }

    return balance;
  }

  Future<List<Balance>> getBalanceHistory(String address) async {
    List<Balance> balances = [];
    try {
      var resp = await net.get('tezos/getBalanceHistory?address=$address');
      if (resp.statusCode == 200) {
        List mJson = jsonDecode(resp.body);
        for (var json in mJson) {
          balances.add(Balance.fromJson(json));
        }
      } else {
        throw Exception(
            'Failed to getBalanceHistory: Bad status code: ${resp.statusCode}');
      }
    } catch (e, s) {
      pp('$e $s');
      throw Exception('Failed to getBalanceHistory: $e');
    }

    return balances;
  }

  Future<List<AccountOperation>> getAccountOperations(String address) async {
    List<AccountOperation> balances = [];
    try {
      var resp = await net.get('tezos/getAccountOperations?address=$address');
      if (resp.statusCode == 200) {
        List mJson = jsonDecode(resp.body);
        for (var json in mJson) {
          balances.add(AccountOperation.fromJson(json));
        }
      } else {
        throw Exception(
            'Failed to getAccountOperations: Bad status code: ${resp.statusCode}');
      }
    } catch (e, s) {
      pp('$e $s');
      throw Exception('Failed to getAccountOperations: $e');
    }

    return balances;
  }

  Future<List<AccountContract>> getAccountContracts(String address) async {
    List<AccountContract> balances = [];
    try {
      var resp = await net.get('tezos/getAccountContracts?address=$address');
      if (resp.statusCode == 200) {
        List mJson = jsonDecode(resp.body);
        for (var json in mJson) {
          balances.add(AccountContract.fromJson(json));
        }
      } else {
        throw Exception(
            'Failed to getAccountContracts: Bad status code: ${resp.statusCode}');
      }
    } catch (e, s) {
      pp('$e $s');
      throw Exception('Failed to getAccountContracts: $e');
    }

    return balances;
  }

  Future<BlockTransactions?> getBlockTransactions(String hash) async {
    pp('\n\n$mm ........................ getBlockTransactions, hash: $hash ...');
    BlockTransactions? blockTransactions;
    try {
      var resp = await net.get('blockchain/getBlockTransactions?hash=$hash');
      pp('$mm ... getBlockTransactions response: status: ${resp.statusCode} ');
      // pp('$mm ... getBlockTransactions response: body: ${resp.body}');
      var hJson = jsonDecode(resp.body);
      var xJson = hJson['data'];

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        blockTransactions = BlockTransactions.fromJson(xJson);

        var length = jsonEncode(blockTransactions).length;
        pp('$mm ... getBlockTransactions response'
            '... 🌿🌿🌿 '
            '\n  🌿 hash: ${blockTransactions.hash}  🍐  '
            '\n  🌿 ver: ${blockTransactions.ver}  🍐'
            '\n  🌿 size ${blockTransactions.size}  🍐'
            '\n  🌿 height: ${blockTransactions.height}  🍐'
            '\n  🌿 blockIndex:${blockTransactions.blockIndex}  🍐'
            '\n  🌿🌿🌿🌿🌿🌿🌿🌿🌿🌿🌿🌿🌿🌿🌿');
      } else {
        pp('$mm BAD RESPONSE, 👿 status: ${resp.statusCode} 👿 body: ${resp.body}');
        throw Exception(
            'getBlockTransactions failed: statusCode: ${resp.statusCode}');
      }
    } catch (e, s) {
      pp('$mm getBlockTransactions ERROR: $e - $s');
      throw Exception('getBlockTransactions failed: $e');
    }
    return blockTransactions;
  }
}

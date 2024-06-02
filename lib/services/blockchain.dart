import 'dart:convert';

import 'package:busha_app/models/block.dart';
import 'package:busha_app/models/tezos/account.dart';
import 'package:busha_app/models/tezos/tezos_block.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/util/functions.dart';
import 'package:get_it/get_it.dart';
import 'package:welltested_annotation/welltested_annotation.dart';

import '../models/next/block_transactions.dart';

@Welltested()
class BlockchainService {
  static const mm = '🔷 🔷 🔷 BlockchainService';
  late Net net;

  Future<Block?> getLatestBlock() async {
    pp('$mm ........................ getLatestBlock ...');
    Block? block;
    net = GetIt.instance<Net>();
    try {
      var resp = await net.get('blockchain/getLatestBlock');
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        block = Block.fromJson(jsonDecode(resp.body));
        pp('$mm getLatestBlock ...  🍐 \n block time: 🍐 ${block.data!.time}  🍐');
      }
    } catch (e) {
      pp(e);
      throw Exception('Get latest block failed: $e');
    }
    return block;
  }

  Future<List<Account>> getTezosAccounts() async {
    List<Account> accounts = [];
    net = GetIt.instance<Net>();
    try {
      var resp = await net.get('tezos/getAccounts');
      if (resp.statusCode == 200) {
        List mList = jsonDecode(resp.body);
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
    net = GetIt.instance<Net>();
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

  Future<BlockTransactions?> getBlockTransactions(String hash) async {
    pp('\n\n$mm ........................ getBlockTransactions, hash: $hash ...');
    net = GetIt.instance<Net>();
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

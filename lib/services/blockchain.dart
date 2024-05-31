import 'dart:convert';

import 'package:busha_app/models/block.dart';
import 'package:busha_app/models/tezos/account.dart';
import 'package:busha_app/models/tezos/tezos_block.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/util/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_print_json/pretty_print_json.dart';

import '../models/next/block_transactions.dart';

class BlockchainService {
  static const mm = '🔷 🔷 🔷 BlockchainService';

  Future<Block?> getLatestBlock() async {
    pp('$mm ........................ getLatestBlock ...');
    String mUrl = AuthService.localUrl;
    Block? block;
    if (!kDebugMode) {
      mUrl = AuthService.remoteUrl;
    }
    try {
      var resp = await Net.get('blockchain/getLatestBlock');
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        block = Block.fromJson(jsonDecode(resp.body));
        pp('$mm getLatestBlock ...  🍐 \n block time: 🍐 ${block.data!.time}  🍐');
      }
    } catch (e, s) {
      pp(e);
      throw Exception('Get latest block failed: $e');
    }
    return block;
  }

  Future<List<Account>> getTezosAccounts() async {
    List<Account> accounts = [];

    try {
      var resp = await Net.get('tezos/getAccounts');
      if (resp.statusCode == 200) {
            List mList = jsonDecode(resp.body);
            for (var json in mList) {
              var acc = Account.fromJson(json);
              accounts.add(acc);
            }
          }
    } catch (e,s) {
      pp('$e $s');
    }

    return accounts;
  }
  Future<TezosBlock?> getTezosBlock(String timestamp) async {
     TezosBlock? block;

    try {
      var resp = await Net.get('tezos/getBlock?timestamp=$timestamp');
      if (resp.statusCode == 200) {
        var mJson = jsonDecode(resp.body);
        block = TezosBlock.fromJson(mJson);
      }
    } catch (e,s) {
      pp('$e $s');
      throw Exception('Failed to get Tezos block: $e');
    }

    return block;
  }
  Future<BlockTransactions?> getBlockTransactions(String hash) async {
    pp('\n\n$mm ........................ getBlockTransactions, hash: $hash ...');

    BlockTransactions? blockTransactions;
    try {
      var resp = await Net.get('blockchain/getBlockTransactions?hash=$hash');
      pp('$mm ... getBlockTransactions response: status: ${resp.statusCode} ');
      // pp('$mm ... getBlockTransactions response: body: ${resp.body}');
      var hJson = jsonDecode(resp.body);
      var xJson = hJson['data'];

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        blockTransactions = BlockTransactions.fromJson(xJson);

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
        throw Exception('getBlockTransactions failed: statusCode: ${resp.statusCode}');
      }
    } catch (e, s) {
      pp('$mm getBlockTransactions ERROR: $e - $s');
      throw Exception('getBlockTransactions failed: $e');
    }
    return blockTransactions;
  }

  Future getZetosBlocks() async {}

  Future getZetosAccounts() async {

    var resp = await Net.get('path');
  }
}

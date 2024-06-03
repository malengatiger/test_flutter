import 'dart:convert';
import 'package:busha_app/models/block.dart';
import 'package:busha_app/models/next/block_transactions.dart';
import 'package:busha_app/models/tezos/tezos_block.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/services/net.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'blockchain_test.mocks.dart' as bmc;


// Generate mocks using:
// flutter pub run build_runner build

@GenerateMocks([Net])
void main() {
  late bmc.MockNet mockNet;
  late BlockchainService blockchainService;

  setUp(() {
    mockNet = bmc.MockNet();
    blockchainService = BlockchainService(mockNet);

    final   Block block = Block(status: 200, data: Data());
    when(mockNet.get('blockchain/getLatestBlock'))
        .thenAnswer((_) async =>
        http.Response(jsonEncode(block.toJson()), 200));
  });

  group('BlockchainService', ()
  {
    test('returns Block on success', () async {
      // Mock a successful response
      final   Block block = Block(status: 200, data: Data());
      when(mockNet.get('blockchain/getLatestBlock'))
          .thenAnswer((_) async =>
          http.Response(jsonEncode(block.toJson()), 200));

      // Call the method
      final result = await blockchainService.getLatestBlock();

      // Verify the result
      expect(result, isA<Block>());
      expect(result?.status, block.status);
    });
    test('returns Tezos Block on success', () async {
      // Mock a successful response
      const   TezosBlock block = TezosBlock(hash: '798647');
      const timestamp = '2024-06-01T04:00';

      when(mockNet.get('tezos/getBlock?timestamp=$timestamp'))
          .thenAnswer((_) async =>
          http.Response(jsonEncode(block.toJson()), 200));

      // Call the method
      final result = await blockchainService.getTezosBlock(timestamp);

      // Verify the result
      expect(result, isA<TezosBlock>());
      expect(result?.hash, block.hash);
    });
    test('returns BlockTransactions on success', () async {
      // Mock a successful response
      var hash = '0987Fdgdj';
      BlockTransactions block = BlockTransactions(hash: hash, );
      when(mockNet.get('blockchain/getBlockTransactions?hash=$hash'))
          .thenAnswer((_) async =>
          http.Response(jsonEncode({'data':{'hash': '544646' }}), 200));

      // Call the method
      final result = await blockchainService.getBlockTransactions(hash);

      // Verify the result
      expect(result, isA<BlockTransactions>());
    });

  });
}
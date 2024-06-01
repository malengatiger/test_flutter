import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/models/tezos/tezos_block.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:badges/badges.dart' as bd;
import '../../util/functions.dart';
import '../../util/gaps.dart';
import '../../util/navigation_util.dart';
import '../landing/info_page.dart';
import 'block_detail.dart';

class TezosBlockWidget extends StatefulWidget {
  const TezosBlockWidget({super.key});

  @override
  TezosBlockWidgetState createState() => TezosBlockWidgetState();
}

class TezosBlockWidgetState extends State<TezosBlockWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  BlockchainService blockchainService = GetIt.instance<BlockchainService>();
  TezosBlock? block;
  bool _busy = false;
  static const mm = '🍐🍐🍐🍐TezosBlockWidget 🍐';

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    getHourAgo();
    _getBlock();
  }

  String? timestamp;
  void _getBlock() async {
    setState(() {
      _busy = true;
    });
    pp('$mm ..... getting Tezos Block ... 🍎timestamp: $timestamp');

    try {
      block = await blockchainService.getTezosBlock(timestamp!);
      if (block != null) {
        pp('$mm Tezos Block: '
            '\n😡😡😡😡😡😡😡😡😡😡😡😡😡😡😡'
            '\n😡 hash: ${block!.hash} '
            '\n😡 timestamp: ${block!.timestamp} '
            '\n😡 level: ${block!.level} '
            '\n😡 reward: ${block!.reward} '
            '\n😡 bonus: ${block!.bonus} '
            '\n😡 fees: ${block!.fees}');
      } else {
        pp('$mm Boss, we just got fucked!, block is null');
      }
    } catch (e,s) {
      pp('$e\n$s');
      if (mounted) {
        showErrorDialog(message: 'Error: $e', context: context);
      }
    }
    setState(() {
      _busy = false;
    });
  }

  void getHourAgo() {
    var now = DateTime.now().subtract(const Duration(hours: 1));
    timestamp = '${now.year}-${now.month}-${now.day}T${now.hour}:00';
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  _navigateToLanding() {
    NavigationUtils.navigateToPage(context: context, widget: const InfoPage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tezos Block Details'),
        actions: [
          IconButton(onPressed: (){
            getHourAgo();
            _getBlock();
          }, icon: const Icon(Icons.refresh)),
          GestureDetector(
            onTap: (){
              _navigateToLanding();
            },
            child: const CircleAvatar(
              radius: 18.0,
              backgroundImage: AssetImage('assets/busha_logo.jpeg'),
            ),
          ),
          gapW8,
        ],
      ),
      body:  SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH32,
                block == null? gapH32:Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlockDetail(tezosBlock: block!),
                ),
              ],
            ),
          ),
          _busy? const Positioned(child: Center(
            child: BusyIndicator(
              caption: 'Loading Tezos block',
            ),
          )): gapH8,
        ],
      )),
    );
  }
}

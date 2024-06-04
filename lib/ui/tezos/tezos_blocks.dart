import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/models/tezos/tezos_block.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/ui/tezos/account_home.dart';
import 'package:busha_app/ui/tezos/tezos_accounts.dart';
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../util/functions.dart';
import '../../util/gaps.dart';
import '../../util/navigation_util.dart';
import '../landing/info_page.dart';
import 'block_detail.dart';
import 'package:busha_app/util/functions.dart';

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
        pp('$mm Tezos Block is OK? : '
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
    } catch (e, s) {
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
    var year = now.year;
    var month = now.month;
    var day = now.day;
    var hour = now.hour;
    var min = now.minute;

    timestamp =
        '$year-${month < 10 ? '0${now.month}' : now.month}-${day < 10 ? '0$day' : '$day'}'
        'T${hour < 10 ? '0$hour' : hour}:00';
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
    Color textColor = Colors.black;
    if (isColorDark(Theme.of(context).primaryColor)) {
      textColor = Colors.white;
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getHourAgo();
                _getBlock();
              },
              icon: const Icon(Icons.refresh)),
          GestureDetector(
            onTap: () {
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
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH32,
                Text(
                  'Tezos Block Details',
                  style: myTextStyleLargerPrimaryColor(context),
                ),
                gapH32,
                block == null
                    ? gapH32
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: BlockDetail(tezosBlock: block!),
                      ),
              ],
            ),
          ),
          block == null? gapH16: Positioned(
              left: 16,
              bottom: 24,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Theme.of(context).primaryColor),
                    elevation: const WidgetStatePropertyAll(16.0),
                  ),
                  onPressed: () {
                    NavigationUtils.navigateToPage(
                        context: context, widget: const TezosAccounts());
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 180,
                        child: Text('Tezos Accounts',
                            style: myTextStyle(
                                context, textColor, 20, FontWeight.normal)),
                      )))),
          _busy
              ? const Positioned(
                  child: Center(
                  child: BusyIndicator(
                    caption: 'Loading Tezos block',
                  ),
                ))
              : gapH8,
        ],
      )),
    );
  }
}

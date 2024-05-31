import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/ui/tezos/account_detail.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:badges/badges.dart' as bd;
import '../../models/tezos/account.dart';
import '../../util/functions.dart';

class TezosAccounts extends StatefulWidget {
  const TezosAccounts({super.key});

  @override
  TezosAccountsState createState() => TezosAccountsState();
}

class TezosAccountsState extends State<TezosAccounts>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  BlockchainService blockchainService = GetIt.instance<BlockchainService>();
  List<Account> accounts = [];
  bool _busy = false;
  static const mm = ' 🍐 🍐TezosAccounts 🍐';

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getAccounts();
  }

  void _getAccounts() async {
    setState(() {
      _busy = false;
    });
    accounts = await blockchainService.getTezosAccounts();
    for (var m in accounts) {
      pp('$mm Tezos Account: '
          '\n🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎'
          '\n🍎 address: ${m.address} '
          '\n🍎 balance: ${m.balance} '
          '\n🍎 transactions: ${m.numTransactions} '
          '\n🍎 firstActivityTime: ${m.firstActivityTime} '
          '\n🍎 lastActivityTime: ${m.lastActivityTime}');
    }
    setState(() {
      _busy = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: bd.Badge(
                  position: bd.BadgePosition.topEnd(
                    top: 2, end: 12,
                  ),
                  badgeContent: Text(
                    '${accounts.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (_, index) {
                          var acc = accounts[index];
                          return AccountDetail(account: acc, index: index + 1,);
                        }),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}

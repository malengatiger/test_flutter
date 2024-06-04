import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/ui/tezos/account_detail.dart';
import 'package:busha_app/ui/tezos/account_home.dart';
import 'package:busha_app/ui/tezos/balance_param_dropdown.dart';
import 'package:busha_app/ui/tezos/tezos_blocks.dart';
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:badges/badges.dart' as bd;
import 'package:intl/intl.dart';
import '../../misc/settings.dart';
import '../../models/tezos/account.dart';
import '../../util/functions.dart';
import '../../util/gaps.dart';
import '../../util/navigation_util.dart';
import '../landing/info_page.dart';

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

  int balanceParam = 1000000;
  int limit = 50;

  void _getAccounts() async {
    setState(() {
      _busy = true;
    });
    try {
      accounts = await blockchainService.getTezosAccounts(
          balanceParam: balanceParam, limit: limit);
      pp('$mm _getAccounts: Tezos Accounts: '
          '\n🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎'
          '\n🍎 accounts: ${accounts.length} '
          '\n🍎 ');
    } catch (e, s) {
      pp('$e \n$s');
      if (mounted) {
        showErrorDialog(message: 'E', context: context);
      }
    }
    setState(() {
      _busy = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _navigateToSettings() {
    NavigationUtils.navigateToPage(
        context: context, widget: const SettingsWidget());
  }

  _navigateToLanding() {
    NavigationUtils.navigateToPage(context: context, widget: const InfoPage());
  }

  _navigateToAccountHome(Account account) {
    NavigationUtils.navigateToPage(
        context: context, widget: AccountHome(account: account));
  }

  @override
  Widget build(BuildContext context) {
    var nf = NumberFormat('###,###,###,###');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _navigateToSettings();
              },
              icon: const Icon(Icons.settings)),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                gapH32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tezos Accounts',
                      style: myTextStyleLargerPrimaryColor(context),
                    ),
                    gapW32,
                    bd.Badge(
                      badgeStyle: const bd.BadgeStyle(
                          padding: EdgeInsets.all(12), elevation: 16),
                      badgeContent: Text(
                        '${accounts.length}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                gapH32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    balanceParam == 0
                        ? gapW32
                        : Text(
                            nf.format(balanceParam),
                            style: myTextStyleLarge(context),
                          ),
                    gapW32,
                    BalanceParamDropdown(onChanged: (m) {
                      balanceParam = m;
                      _getAccounts();
                    }),
                    gapW32,
                  ],
                ),
                gapH32,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (_, index) {
                          var acc = accounts[index];
                          return GestureDetector(
                              onTap: () {
                                _navigateToAccountHome(acc);
                              },
                              child: AccountDetail(
                                account: acc,
                                index: index + 1,
                              ));
                        }),
                  ),
                ),
              ],
            ),
          ),
          _busy
              ? const Positioned(
                  child: Center(
                  child: BusyIndicator(
                    caption: 'Loading Tezos Accounts',
                  ),
                ))
              : gapH16,
        ],
      )),
    );
  }
}

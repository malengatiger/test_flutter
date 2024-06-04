import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/models/tezos/account.dart';
import 'package:busha_app/models/tezos/account_operation.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/ui/tezos/account_operations.dart';
import 'package:busha_app/ui/tezos/balance_history.dart';
import 'package:busha_app/ui/tezos/contract_list.dart';
import 'package:busha_app/ui/tezos/tezos_blocks.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../misc/settings.dart';
import '../../models/tezos/account_contract.dart';
import '../../models/tezos/balance.dart';
import '../../util/functions.dart';
import '../../util/navigation_util.dart';
import '../../util/styles.dart';
import '../landing/info_page.dart';

class AccountHome extends StatefulWidget {
  const AccountHome({super.key, required this.account});

  final Account account;

  @override
  AccountHomeState createState() => AccountHomeState();
}

class AccountHomeState extends State<AccountHome>
    with TickerProviderStateMixin {
  static const mm = '🍐🍐🍐AccountHome';
  bool _busy = false;
  late TabController _tabController;
  final BlockchainService _blockchainService =
      GetIt.instance<BlockchainService>();

  List<AccountContract> accountContracts = [];
  List<Balance> balances = [];
  List<AccountOperation> accountOperations = [];

  int balance = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      pp('$mm what are we listening for? 😡 index: ${_tabController.index} 😡previousIndex: ${_tabController.previousIndex}');
    });
    super.initState();
    _getData();
  }

  _getData() async {
    pp('$mm getting lots of data ..........');
    setState(() {
      _busy = true;
    });
    try {
      accountContracts =
          await _blockchainService.getAccountContracts(widget.account.address!);
      accountOperations = await _blockchainService
          .getAccountOperations(widget.account.address!);
      balances =
          await _blockchainService.getBalanceHistory(widget.account.address!);
      balance = await _blockchainService.getBalance(widget.account.address!);

      pp('$mm getting lots of data : 🌍🌍COMPLETED.');
    } catch (e, s) {
      pp('$mm ERROR getting data: $e \n$s');
      if (mounted) {
        showErrorDialog(message: '$e', context: context);
      }
    }
    setState(() {
      _busy = false;
    });
  }
  _navigateToSettings() {
    NavigationUtils.navigateToPage(
        context: context, widget: const SettingsWidget());
  }

  _navigateToLanding() {
    NavigationUtils.navigateToPage(context: context, widget: const InfoPage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Balances'),
            Tab(text: 'Operations'),
            Tab(text: 'Contracts'),

          ],
        ),
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
        child: _busy
            ? const Center(
                child: BusyIndicator(
                  caption: 'Loading data ...',
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    gapH16,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${widget.account.address}', style: myTextStyleTinyGrey(context),),
                    ),
                    Expanded(
                      // Use Expanded to let TabBarView take available space
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          BalanceHistory(balances: balances),
                          AccountOperations(
                              accountOperations: accountOperations),
                          ContractList(accountContracts: accountContracts),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

import 'package:busha_app/misc/settings.dart';
import 'package:busha_app/models/next/block_transactions.dart';
import 'package:busha_app/models/user.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/block.dart';
import '../../util/functions.dart';

class DashWidget extends StatefulWidget {
  const DashWidget({super.key});

  @override
  DashWidgetState createState() => DashWidgetState();
}

class DashWidgetState extends State<DashWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Prefs prefs = GetIt.instance<Prefs>();
  BlockchainService blockchainService = GetIt.instance<BlockchainService>();

  static const mm = ' 🍎  🍎  🍎 Dashboard 🍎';

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getUser();
    _getLatestBlock();
  }

  User? user;
  Block? block;
  bool _busy = false;

  void _getUser() {
    user = prefs.getUser();
    setState(() {});
  }

  void _getLatestBlock() async {
    pp('$mm .......... _getLatestBlock ......');

    setState(() {
      _busy = true;
    });
    try {
      block = await blockchainService.getLatestBlock();
      if (block != null) {
        try {
          pp('$mm latest block returned, will get transactions ..'
              ' 🍎 hash: ${block!.data!.hash} 🍎');
          await _getBlockTransactions();
        } catch (e, s) {
          pp('$e $s');
          if (mounted) {
            showErrorDialog(message: '$e', context: context);
          }
        }
      }
    } catch (e, s) {
      pp('$mm ERROR: $e $s');
      if (mounted) {
        showErrorDialog(message: '$e', context: context);
      }
    }

    setState(() {
      _busy = false;
    });
  }
  BlockTransactions? _blockTransactions;
  Future _getBlockTransactions() async {
    pp('$mm .......... _getBlockTransactions ......');

    setState(() {
      _busy = true;
    });
    try {
      if (block != null) {
        pp('$mm _blockTransactions returned, 🍎 hash: ${block!.data!.hash} 🍎');
        _blockTransactions = await blockchainService.getBlockTransactions(block!.data!.hash!);

      }
    } catch (e, s) {
      pp('$mm ERROR: $e $s');
      if (mounted) {
        showErrorDialog(message: '$e', context: context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busha Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                _navigateToSettings();
              },
              icon: const Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                _getLatestBlock();
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: 480,
              child: Card(
                elevation: 8,
                child: Column(
                  children: [
                    gapH32,
                    Text(
                      user == null ? '' : user!.name!,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      )),
    );
  }
}

import 'dart:convert';

import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/models/block.dart';
import 'package:busha_app/models/next/block_transactions.dart';
import 'package:busha_app/models/next/single_transaction.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../services/blockchain.dart';
import '../../util/functions.dart';
import '../landing/info_page.dart';
import 'package:badges/badges.dart' as bd;

class TransactionList extends StatefulWidget {
  const TransactionList({super.key, this.block});

  final Block? block;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  static const mm = 'TransactionList';
  final BlockchainService blockchainService =
      GetIt.instance<BlockchainService>();
  BlockTransactions? _blockTransactions;
  bool _busy = false;
  Block? block;

  @override
  void initState() {
    super.initState();
    block = widget.block;
    if (block == null) {
      _getLatestBlock();
    } else {
      _getBlockTransactions();
    }
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

  String? responseLength;

  Future _getBlockTransactions() async {
    pp('$mm .......... _getBlockTransactions ......');

    if (block == null) {
      _getLatestBlock();
      return;
    }
    setState(() {
      _busy = true;
    });
    try {
      pp('$mm _blockTransactions returned, 🍎 time: ${block!.data!.time} 🍎');
      _blockTransactions =
          await blockchainService.getBlockTransactions(block!.data!.hash!);
      pp('$mm _blockTransactions returned, 🍎 mainChain: ${_blockTransactions!.mainChain!} 🍎');
      var length = jsonEncode(_blockTransactions).length;
      responseLength = (length / 1024 / 1024).toStringAsFixed(2);
      pp('\n  🌿 Length of response in bytes: $responseLength} MB 🍐');
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

  _navigateToLanding() {
    NavigationUtils.navigateToPage(context: context, widget: const InfoPage());
  }

  @override
  Widget build(BuildContext context) {
    List<SingleTransaction> list = [];
    int total = 0;
    if (_blockTransactions != null && _blockTransactions!.tx != null) {
      for (var m in _blockTransactions!.tx!) {
        m.inputs?.forEach((inp) {
          var pValue = inp.prevOut?.value;
          total += pValue ?? 0;
        });
        var nf = NumberFormat('###,###,###,###');
        var mTotal = nf.format(total);
        list.add(m);
      }
    }
    var nf = NumberFormat('###,###,###,##0');
    DateFormat df = DateFormat('EEEE, yyyy-MM-dd HH:mm');
    var num = nf.format(list.length);

    var mode = MediaQuery.of(context).platformBrightness;
    var date = DateTime.fromMillisecondsSinceEpoch(
        block == null ? 0 : block!.data!.time! * 1000);
    final DateFormat formatter = DateFormat('EEEE, yyyy-MMMM-dd    HH:mm');
    final String formatted = formatter.format(date);
    if (block != null) {
      pp(' ... time: ${block!.data!.time} date: $formatted');
    }
    var height = MediaQuery.of(context).size.height - 100;
    late Color textColor;
    if (isColorDark(Theme.of(context).primaryColor)) {
      textColor = Colors.white;
    } else {
      textColor = Colors.black;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('BTC Transactions'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  responseLength = null;
                });
                _getBlockTransactions();
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
          gapW16,
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Column(
              children: [
                gapH16,
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'Hash',
                        style: myTextStyleTinyGrey(context),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: SizedBox(
                              width: 260,
                              child: Text(
                                '${block?.data!.hash}',
                                style: myTextStyleTiny(context),
                              ))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TransactionTotalWidget(
                      title: 'Total Value',
                      total: nf.format(total),
                      size: 28.0),
                ),
                gapH16,
              ],
            )),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: bd.Badge(
              position: bd.BadgePosition.topEnd(top: 2, end: -12),
              badgeContent: Text(
                nf.format(list.length),
                style: const TextStyle(color: Colors.white),
              ),
              badgeStyle: const bd.BadgeStyle(
                padding: EdgeInsets.all(16),
                badgeColor: Colors.red,
              ),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    var tx = list.elementAt(index);

                    return Card(
                      elevation: 4,
                      child: SizedBox(
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Flexible(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 28, right: 28),
                                  child: Text(
                                    tx.hash!,
                                    style: myTextStyleSmallWithColor(
                                        context, Colors.grey.shade600),
                                  ),
                                ),
                              )),
                              gapH16,
                              Padding(
                                padding: const EdgeInsets.only(left: 36.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatted,
                                      style: mode == Brightness.light
                                          ? myTextStyleSmallBold(
                                              context, Colors.black)
                                          : myTextStyleSmallBold(
                                              context, Colors.grey.shade600),
                                    ),
                                    Text(
                                      '${index + 1}',
                                      style: myTextStyle(
                                          context,
                                          Theme.of(context).primaryColor,
                                          14,
                                          FontWeight.w900),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          responseLength == null
              ? gapW16
              : Positioned(
                  left: 8,
                  bottom: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        responseLength = null;
                      });
                    },
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          height: 52,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Size of Response',
                                    style: myTextStyleSmallBold(
                                        context, textColor),
                                  ),
                                  gapW16,
                                  Text(
                                    '${responseLength!} MB',
                                    style: myTextStyle(context, textColor, 20,
                                        FontWeight.w900),
                                  ),
                                ],
                              ),
                              gapH8,
                              Text(
                                'Tap to remove',
                                style: myTextStyle(context, textColor, 12,
                                    FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
          _busy
              ? const Positioned(
                  child: Center(
                      child: BusyIndicator(
                  caption: 'Loading transactions from the latest block. 🍎'
                      '\n\nThis task has been known to take a couple of minutes sometimes. Hang in there!',
                )))
              : gapH32,
        ],
      )),
    );
  }
}

class TransactionTotalWidget extends StatelessWidget {
  const TransactionTotalWidget(
      {super.key,
      required this.title,
      required this.total,
      required this.size});

  final String title, total;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: myTextStyle(
              context, Theme.of(context).primaryColor, 14, FontWeight.w300),
        ),
        Text(
          total,
          style: myTextStyle(
              context, Theme.of(context).primaryColor, size, FontWeight.w900),
        ),
      ],
    );
  }
}

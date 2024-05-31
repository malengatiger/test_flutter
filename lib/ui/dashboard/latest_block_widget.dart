import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/ui/dashboard/transaction_list.dart';
import 'package:busha_app/ui/dashboard/view_on_blockchain.dart';
import 'package:busha_app/ui/landing/info_page.dart';
import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:busha_app/util/styles.dart';
import 'package:busha_app/util/toasts.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../../models/block.dart';
import '../landing/landing_page.dart';

class LatestBlockWidget extends StatefulWidget {
  const LatestBlockWidget({
    super.key,
  });

  @override
  State<LatestBlockWidget> createState() => _LatestBlockWidgetState();
}

class _LatestBlockWidgetState extends State<LatestBlockWidget> {
  Block? block;
  bool _busy = false;
  BlockchainService blockchainService = GetIt.instance<BlockchainService>();
  static const mm = ' 🍎 🍎 🍎LatestBlockWidget';

  @override
  void initState() {
    super.initState();
    _getLatestBlock();
  }

  _navigateToTransactions() {
    NavigationUtils.navigateToPage(
        context: context,
        widget: TransactionList(
          block: block,
        ));
  }

  _navigateToLanding() {
    NavigationUtils.navigateToPage(context: context, widget: const InfoPage());
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

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('EEEE, yyyy-MMMM-dd HH:mm');
    final DateFormat formatter2 = DateFormat('yyyy-MM-dd HH:mm');
    var width = MediaQuery.of(context).size.width;
    var style = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
    );
    var style2 = TextStyle(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.amber[800]!);

    DateTime? date, rDate;

    if (block != null) {
      if (block!.data!.time != null) {
        date = DateTime.fromMillisecondsSinceEpoch(block!.data!.time! * 1000);
      } else {
        pp(' 😡😡😡 Time is NULL! 😡😡😡');
      }
      if (block!.data!.receivedTime != null) {
        rDate = DateTime.fromMillisecondsSinceEpoch(
            block!.data!.receivedTime! * 1000);
      } else {
        pp(' 😡😡😡 Received Time is NULL! 😡😡😡');
      }
    }

    String formattedTime = 'Not Available';
    if (date != null) {
      formattedTime = formatter.format(date);
    }

    String formattedReceivedTime = 'Not Available';
    if (rDate != null) {
      formattedReceivedTime = formatter2.format(rDate);
    }

    if (block != null) {
      pp(' ... time: ${block!.data!.time} 💜 recTime: ${block!.data!.receivedTime} ==> '
          'Time: $formattedTime 💜 Received Time : $formattedReceivedTime');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest Block'),
        actions: [
          IconButton(
              onPressed: () {
                _getLatestBlock();
              },
              icon: const Icon(Icons.refresh)),
          GestureDetector(
            onTap: () {
              _navigateToLanding();
            },
            child: const CircleAvatar(
              radius: 24.0,
              backgroundImage: AssetImage('assets/busha_logo.jpeg'),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width - 32,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: block == null
                      ? gapH32
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView(
                                children: [
                                  gapH32,
                                  GestureDetector(
                                    onTap: () {
                                      _navigateToTransactions();
                                    },
                                    child: Card(
                                      elevation: 8.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Hash',
                                              style: style,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(block!.data!.hash!),
                                            ),
                                            gapH16,
                                            Text(
                                              'Tap for transactions',
                                              style: myTextStyle(
                                                  context,
                                                  Colors.blue,
                                                  15,
                                                  FontWeight.w500),
                                            ),
                                            gapH16,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  gapH32,
                                  gapH32,
                                  Card(
                                    elevation: 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Time',
                                            style: style,
                                          ),
                                          Text(formattedTime),
                                        ],
                                      ),
                                    ),
                                  ),
                                  gapH16,
                                  Card(
                                    elevation: 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Block Index',
                                            style: style,
                                          ),
                                          Text('${block!.data!.blockIndex!}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  gapH16,
                                  Card(
                                    elevation: 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Height',
                                            style: style,
                                          ),
                                          Text('${block!.data!.height!}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  gapH16,
                                  Card(
                                    elevation: 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Received Time',
                                            style: style,
                                          ),
                                          Text(
                                            formattedReceivedTime,
                                            style: style2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  gapH32,
                                  gapH32,
                                  GestureDetector(
                                      onTap: () {
                                        pp('... newsRefreshListener.setRefresh ... ');
                                        showToast(
                                            message:
                                                'Under Construction, check us out later!',
                                            context: context);
                                      },
                                      child: const ViewOnBlockchain()),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          _busy
              ? const Positioned(
                  child: Center(
                  child: BusyIndicator(
                    caption: 'Loading the latest block ...',
                  ),
                ))
              : gapH32,
        ],
      )),
    );
  }
}

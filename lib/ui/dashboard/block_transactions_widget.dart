import 'package:busha_app/models/next/block_transactions.dart';
import 'package:busha_app/ui/dashboard/view_on_blockchain.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/block.dart';

class BlockTransactionsWidget extends StatelessWidget {
  const BlockTransactionsWidget({super.key, required this.blockTransactions});

  final BlockTransactions blockTransactions;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(blockTransactions.time!);
    final DateFormat formatter = DateFormat('EEEE, yyyy-MMMM-dd HH:mm');
    final String formatted = formatter.format(date);

    var width = MediaQuery.of(context).size.width;
    var style = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
    );
    var style2 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest Block Transactions'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width - 32,
              child: GestureDetector(
                onTap: (){
                  NavigationUtils.navigateToPage(context: context, widget: BlockTransactionsWidget(blockTransactions: blockTransactions));
                },
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      const CircleAvatar(
                      radius: 24.0,
                      backgroundImage: AssetImage('assets/busha_logo.jpeg'),
                
                    ),
                        Expanded(
                          child: ListView(
                            children: [
                              gapH32,
                              Card(
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
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(blockTransactions.hash!),
                                      ),
                                    ],
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
                                      Text(formatted!),
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
                                      Text('${blockTransactions.blockIndex!}'),
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
                                      Text('${blockTransactions.height!}'),
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
                                      Text('${blockTransactions.time!}'),
                                    ],
                                  ),
                                ),
                              ),
                              gapH32,
                              gapH32,
                              const ViewOnBlockchain(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

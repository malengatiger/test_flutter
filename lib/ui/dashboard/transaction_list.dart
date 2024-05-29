import 'package:busha_app/models/next/block_transactions.dart';
import 'package:busha_app/models/next/single_transaction.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as bd;

import '../../util/functions.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.blockTransactions, required this.time});

  final BlockTransactions blockTransactions;
  final int time;

  @override
  Widget build(BuildContext context) {
    List<SingleTransaction> list = [];
    int total = 0;
    for (var m in blockTransactions.tx!) {
      m.inputs?.forEach((inp) {
        var pValue = inp.prevOut?.value;
        total += pValue ?? 0;
      });
      var nf = NumberFormat('###,###,###,###');
      var mTotal = nf.format(total);
      list.add(m);
    }
    var nf = NumberFormat('###,###,###,##0');
    DateFormat df = DateFormat('EEEE, yyyy-MM-dd HH:mm');
    var num = nf.format(list.length);

    var mode = MediaQuery.of(context).platformBrightness;
    var date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    final DateFormat formatter = DateFormat('EEEE, yyyy-MMMM-dd HH:mm');
    final String formatted = formatter.format(date);
    pp(' ... time: $time date: $formatted');

    return Scaffold(
      appBar: AppBar(
        title: const Text('BTC Transactions'),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  gapW32,
                  CircleAvatar(
                    radius: 24.0,
                    backgroundImage: AssetImage('assets/busha_logo.jpeg'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TransactionTotalWidget(
                    title: 'Transaction Total',
                    total: nf.format(total),
                    size: 20.0),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: bd.Badge(
                    badgeContent: Text(
                      num,
                      style: myTextStyle(
                          context,
                          mode == Brightness.dark ? Colors.white : Colors.white,
                          12,
                          FontWeight.w900),
                    ),
                    badgeStyle: const bd.BadgeStyle(
                        padding: EdgeInsets.all(12.0),
                        elevation: 16.0,
                        badgeColor: Colors.pink),
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (_, index) {
                          var tx = list.elementAt(index);

                          return Card(
                            elevation: 4,
                            child: SizedBox(
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Flexible(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(tx.hash!),
                                    )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(formatted, style: mode == Brightness.light?myTextStyleSmallBlackBold(context): myTextStyleSmallBold(context),),
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
                                  ],
                                ),
                              ),
                            ),
                          );
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
              context, Theme.of(context).primaryColor, size, FontWeight.w900),
        ),
        Text(total, style: myTextStyleMediumBold(context),),
      ],
    );
  }
}

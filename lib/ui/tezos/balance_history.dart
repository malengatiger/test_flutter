import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as bd;
import '../../models/tezos/balance.dart';

class BalanceHistory extends StatelessWidget {
  const BalanceHistory({super.key, required this.balances});

  final List<Balance> balances;

  @override
  Widget build(BuildContext context) {
    var nf = NumberFormat('###,###,###,###');
    var df = DateFormat('EEEE, yyyy MMMM dd, HH:mm');

    return SafeArea(
        child: Stack(
      children: [
        Column(
          children: [
            gapH32,
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Text(
                    'Balance History',
                    style: myTextStyleLarge(context),
                  ),
                  gapW32,
                  bd.Badge(
                    badgeContent: Text('${balances.length}', style: const TextStyle(color: Colors.white)),
                    badgeStyle: bd.BadgeStyle(
                      padding: const EdgeInsets.all(12),
                      badgeColor: Colors.blue.shade700,
                    ),
                  ),
                ]),
              ),
            ),
            gapH32,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: balances.length,
                    itemBuilder: (_, index) {
                      var b = balances[index];

                      return Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Balance',
                                    style: myTextStyleTinyGrey(context),
                                  ),
                                  Text(
                                    nf.format(b.balance),
                                    style: myTextStyle(
                                        context,
                                        Theme.of(context).primaryColor,
                                        20,
                                        FontWeight.w900),
                                  ),
                                ],
                              ),
                              gapH16,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Level',
                                    style: myTextStyleTinyGrey(context),
                                  ),
                                  Text('${b.level}'),
                                ],
                              ),
                              gapH8,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Time',
                                    style: myTextStyleTinyGrey(context),
                                  ),
                                  Text(style: myTextStyleTiny(context),
                                    df.format(
                                      DateTime.parse(b.timestamp!),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        )
      ],
    ));
  }
}

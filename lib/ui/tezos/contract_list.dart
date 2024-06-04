import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as bd;

import '../../models/tezos/account_contract.dart';
import '../../util/gaps.dart';
import '../../util/styles.dart';

class ContractList extends StatelessWidget {
  const ContractList({super.key, required this.accountContracts});

  final List<AccountContract> accountContracts;

  @override
  Widget build(BuildContext context) {
    var nf = NumberFormat('###,###,###,###');
    var df = DateFormat('EEEE, yyyy MMMM dd, HH:mm');
    return SafeArea(
        child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Text(
                      'Contracts',
                      style: myTextStyleLarge(context),
                    ),
                    gapW32,
                    bd.Badge(
                      badgeContent: Text('${accountContracts.length}',
                          style: const TextStyle(color: Colors.white)),
                      badgeStyle: bd.BadgeStyle(
                        padding: const EdgeInsets.all(12),
                        badgeColor: Colors.purple.shade700,
                      ),
                    ),
                  ]),
                ),
              ),
              gapH16,
              Expanded(
                child: accountContracts.isEmpty
                    ? Center(
                        child: Text(
                          'No Contracts found',
                          style: myTextStyleLarge(context),
                        ),
                      )
                    : ListView.builder(
                        itemCount: accountContracts.length,
                        itemBuilder: (_, index) {
                          var c = accountContracts[index];

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
                                      c.balance! == 0
                                          ? Text(
                                              '0',
                                              style: myTextStyle(
                                                  context,
                                                  Colors.grey.shade700,
                                                  22,
                                                  FontWeight.w900),
                                            )
                                          : Text(
                                              nf.format(c.balance),
                                              style: myTextStyle(
                                                  context,
                                                  Colors.amber.shade700,
                                                  22,
                                                  FontWeight.w900),
                                            ),
                                    ],
                                  ),
                                  gapH8,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Creation Level',
                                        style: myTextStyleTinyGrey(context),
                                      ),
                                      Text('${c.creationLevel}'),
                                    ],
                                  ),
                                  gapH8,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Creation Time',
                                        style: myTextStyleTinyGrey(context),
                                      ),
                                      Text(
                                        df.format(
                                            DateTime.parse(c.creationTime!)),
                                        style: myTextStyleTiny(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
              ),
            ],
          ),
        )
      ],
    ));
  }
}

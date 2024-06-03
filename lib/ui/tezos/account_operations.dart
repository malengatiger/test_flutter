import 'package:busha_app/models/tezos/account_operation.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as bd;

import '../../util/styles.dart';

class AccountOperations extends StatelessWidget {
  const AccountOperations({super.key, required this.accountOperations});

  final List<AccountOperation> accountOperations;

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
                      'Operations',
                      style: myTextStyleLarge(context),
                    ),
                    gapW32,
                    bd.Badge(
                      badgeContent: Text('${accountOperations.length}',
                        style: const TextStyle(color: Colors.white),),
                      badgeStyle: bd.BadgeStyle(
                        padding: const EdgeInsets.all(12),
                        badgeColor: Colors.teal.shade700,
                      ),
                    ),
                  ]),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: accountOperations.length,
                    itemBuilder: (_, index) {
                      var c = accountOperations[index];
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
                                    'Amount',
                                    style: myTextStyleTinyGrey(context),
                                  ),
                                  Text(
                                    nf.format(c.amount),
                                    style: myTextStyle(
                                        context,
                                        Colors.blue.shade700,
                                        22,
                                        FontWeight.w900),
                                  ),
                                ],
                              ),
                              gapH8,
                              SizedBox(
                                height: 48,
                                child: Column(
                                  children: [
                                    Text(
                                      'Sender',
                                      style: myTextStyleTinyGrey(context),
                                    ),
                                    Text(
                                      c.sender!.address!,
                                      style: myTextStyleTinyGrey(context),
                                    ),
                                  ],
                                ),
                              ),
                              gapH8,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Status',
                                    style: myTextStyleTinyGrey(context),
                                  ),
                                  Text(
                                    c.status!,
                                    style: myTextStyleSmallWithColor(
                                        context, Colors.grey),
                                  ),
                                ],
                              ),
                              gapH16,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Baker Fee',
                                    style: myTextStyleTinyGrey(context),
                                  ),
                                  c.bakerFee! == 0? Text(
                                    '0',style: myTextStyle(
                                      context,
                                      Colors.grey.shade700,
                                      16,
                                      FontWeight.w900),
                                  ): Text(
                                    nf.format(c.bakerFee),
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
                                    'Gas Used',
                                    style: myTextStyleTinyGrey(context),
                                  ),
                                  Text(
                                    nf.format(c.gasUsed),
                                    style: myTextStyle(context, Colors.red, 16,
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
                                    'Allocation Fee',
                                    style: myTextStyleTinyGrey(context),
                                  ),
                                  c.allocationFee! == 0? Text('0', style: myTextStyle(
                                      context,
                                      Colors.grey.shade700,
                                      16,
                                      FontWeight.w900),):Text(nf.format(c.allocationFee), style: myTextStyle(
                                      context,
                                      Colors.green.shade700,
                                      20,
                                      FontWeight.w900),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Timestamp',
                                    style: myTextStyleTinyGrey(context),
                                  ),
                                  Text(
                                    df.format(DateTime.parse(c.timestamp!)),
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

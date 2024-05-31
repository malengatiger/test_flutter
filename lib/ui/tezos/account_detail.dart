import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/tezos/account.dart';

class AccountDetail extends StatelessWidget {
  const AccountDetail({super.key, required this.account, required this.index});
final Account account;
final int index;
  @override
  Widget build(BuildContext context) {
    var tiny =  TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10,
      color: Colors.grey[700]!,
    );
    var blue =  TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.blue[700]!,
    );
    var teal =  TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.teal[700]!,
    );
    var nf = NumberFormat('###,###,###,###');
    var df = DateFormat('EEEE dd MMMM yyyy HH:mm');
    return  Stack(
      children: [
        Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                gapH8,
                Row(
                  children: [
                    Flexible(child: Text('${account.address}')),
                    Text('$index', style: myTextStyleSmallBoldPrimaryColor(context),),
                  ],
                ),
                gapH8,
                Row(
                  children: [
                     SizedBox(width: 72, child: Text('Level', style: tiny),),
                    Text(nf.format(account.balance), style: teal,),
                  ],
                ),
                Row(
                  children: [
                     SizedBox(width: 72, child: Text('Transactions', style: tiny),),
                    Text(nf.format(account.numTransactions), style: blue,),
                  ],
                ),
                Row(
                  children: [
                     SizedBox(width: 72, child: Text('First Activity', style: tiny),),
                    Text(df.format(DateTime.parse(account.firstActivityTime!))),
                  ],
                ),
                Row(
                  children: [
                     SizedBox(width: 72, child: Text('Last Activity', style: tiny),),
                    Text(df.format(DateTime.parse(account.lastActivityTime!))),
                  ],
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}

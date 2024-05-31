import 'package:busha_app/models/tezos/tezos_block.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/styles.dart';
import 'package:busha_app/util/toasts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlockDetail extends StatelessWidget {
  const BlockDetail({super.key, required this.tezosBlock});

  final TezosBlock tezosBlock;

  @override
  Widget build(BuildContext context) {
    var tiny = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: Colors.grey[700]!,
    );
    var blue = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.blue[700]!,
    );
    var teal = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.teal[700]!,
    );
    var red = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.red[700]!,
    );
    var nf = NumberFormat('###,###,###,###');
    var df = DateFormat('EEEE dd MMMM yyyy HH:mm');
    return Stack(
      children: [
        Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH16,
                SizedBox(height: 64,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 48, right: 48),
                            child: Text('${tezosBlock.hash}', style: myTextStyleSmallBold(context),),
                          )),

                    ],
                  ),
                ),
                gapH32, gapH16,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Time', style: tiny),
                    Text(
                      df.format(DateTime.parse(tezosBlock.timestamp!)),
                      style: teal,
                    ),
                  ],
                ),
                gapH32,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Level', style: tiny),
                    Text(
                      '${tezosBlock.level}',
                      style: red,
                    ),
                  ],
                ),
                gapH32,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Reward', style: tiny),
                    Text(
                      nf.format(tezosBlock.reward),
                      style: blue,
                    ),
                  ],
                ),
                gapH32,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bonus', style: tiny),
                    Text(
                      nf.format(tezosBlock.bonus),
                      style: blue,
                    ),
                  ],
                ),
                gapH32,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fees', style: tiny),
                    Text(
                      nf.format(tezosBlock.fees),
                      style: blue,
                    ),
                  ],
                ),
                gapH32,
                gapH32,
                gapH32,
                GestureDetector(
                  onTap: (){
                    showToast(message: 'Not quite there yet! Sorry!', context: context);
                  },
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_download, color: Colors.blue,),
                      gapW16,
                      Text('View on Blockchain Explorer'),
                    ],
                  ),
                ),
                gapH32,

              ],
            ),
          ),
        ),
      ],
    );
  }
}

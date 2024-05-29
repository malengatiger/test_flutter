import 'package:busha_app/ui/dashboard/view_on_blockchain.dart';
import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/block.dart';

class LatestBlockWidget extends StatelessWidget {
  const LatestBlockWidget({super.key, required this.block, required this.onTransactionListRequired});

  final Block block;
  final Function(String) onTransactionListRequired;

  @override
  Widget build(BuildContext context) {
    if (block.data!.time == null) {
      throw Exception('No time, Boss!');
    }
    var date = DateTime.fromMillisecondsSinceEpoch(block.data!.time! * 1000);
    final DateFormat formatter = DateFormat('EEEE, yyyy-MMMM-dd HH:mm');
    final String formatted = formatter.format(date);
    pp(' ... time: ${block.data!.time} date: $formatted');

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
        title: const Text('Latest Block'),
        actions: [
          IconButton(onPressed: (){
            onTransactionListRequired(block.data!.hash!);
          }, icon: const Icon(Icons.refresh)),
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
                  onTransactionListRequired(block.data!.hash!);
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
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(block.data!.hash!),
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
                                      Text(formatted),
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
                                      Text('${block.data!.blockIndex!}'),
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
                                      Text('${block.data!.height!}'),
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
                                      Text('${block.data!.time!}'),
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

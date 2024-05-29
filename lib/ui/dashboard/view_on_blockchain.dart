import 'package:flutter/material.dart';

import '../../util/gaps.dart';

class ViewOnBlockchain extends StatelessWidget {
  const ViewOnBlockchain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.download, color: Colors.blue, size: 36.0,),
        gapW32,
        Text('View on Blockchain Explorer')
      ],
    );
  }
}

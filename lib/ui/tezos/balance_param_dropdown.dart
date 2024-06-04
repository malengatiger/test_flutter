import 'package:flutter/material.dart';

class BalanceParamDropdown extends StatelessWidget {
  const BalanceParamDropdown({super.key, required this.onChanged});

  final Function(int) onChanged;
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> items = [];
    int mil = 10000000;
    items.add( DropdownMenuItem<int>(
        value: mil,
        child: const Text('10 Million')));
    items.add( DropdownMenuItem<int>(
        value: mil * 2,
        child: const Text('20 Million')));
    items.add( DropdownMenuItem<int>(
        value: mil * 3,
        child: const Text('30 Million')));
    items.add( DropdownMenuItem<int>(
        value: mil * 4,
        child: const Text('40 Million')));
    items.add( DropdownMenuItem<int>(
        value: mil * 5,
        child: const Text('50 Million')));
    items.add( DropdownMenuItem<int>(
        value: mil * 10,
        child: const Text('100 Million')));
    return DropdownButton<int>(
        elevation: 8,
        hint: const Text('Balance'),
        items: items, onChanged: (m){
      if (m != null) {
        onChanged(m);
      }
    });
  }
}

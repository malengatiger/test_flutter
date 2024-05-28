
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../util/functions.dart';
import '../../util/gaps.dart';
import '../../util/prefs.dart';

/// Shared Color selector that saves selecyed color in shared prefs
class ColorGallery extends StatefulWidget {
  const ColorGallery(
      {super.key, required this.onColorSelected});

  final Function(int) onColorSelected;
  @override
  ColorGalleryState createState() => ColorGalleryState();
}

class ColorGalleryState extends State<ColorGallery> {
  Color? selectedColor;
  List<Color> colors = [];
  Prefs prefs = GetIt.instance<Prefs>();

  @override
  void initState() {
    super.initState();
    colors = getColors();
    pp('colors available: ${colors.length}');
    _getColorIndex();
  }

  _getColorIndex() {
    colorIndex = prefs.getColorIndex();
    setState(() {
    });
  }
  void _setColorIndex(int index) {
    prefs.saveColorIndex(index);
    setState(() {
      colorIndex = index;
    });
    pp('ColorGallery new colorIndex: $index');
    widget.onColorSelected(index);
  }
  int colorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Select App Colour'),
                  gapW32,
                  Container(height: 16, width: 16, color: selectedColor,),
                ],
              ),
              gapH8,

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: colors.length,
                      itemBuilder: (_, index) {
                        var color = colors.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                              _setColorIndex(index);
                            });
                          },
                          child: Container(
                            color: color,
                            margin: const EdgeInsets.all(8),
                            child: selectedColor == color
                                ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int groupValue = 0;

}


final List<Color> colorList = [
  Colors.red[200]!,
  Colors.green[200]!,
  Colors.blue[200]!,
  Colors.yellow[200]!,
  Colors.pink[200]!,
  Colors.teal[200]!,
  Colors.indigo[200]!,
  Colors.brown[200]!,
  Colors.deepPurple[200]!,
  Colors.amber[200]!,
  Colors.lightGreen[200]!,
  Colors.orange[200]!,
  Colors.cyan[200]!,
  Colors.red[300]!,
  Colors.green[300]!,
  Colors.blue[300]!,
  Colors.yellow[300]!,
  Colors.pink[300]!,
  Colors.teal[300]!,
  Colors.indigo[300]!,
  Colors.brown[300]!,
  Colors.deepPurple[300]!,
  Colors.amber[300]!,
  Colors.lightGreen[300]!,
  Colors.orange[300]!,
  Colors.cyan[300]!,
  Colors.red[400]!,
  Colors.green[400]!,
  Colors.blue[400]!,
  Colors.yellow[400]!,
  Colors.pink[400]!,
  Colors.teal[400]!,
  Colors.indigo[400]!,
  Colors.brown[400]!,
  Colors.deepPurple[400]!,
  Colors.amber[400]!,
  Colors.lightGreen[400]!,
  Colors.orange[400]!,
  Colors.cyan[400]!,
  Colors.grey[600]!,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.pink,
  Colors.teal,
  Colors.indigo,
  Colors.brown,
  Colors.deepPurple,
  Colors.amber,
  Colors.lightGreen,
  Colors.orange,
  Colors.cyan,
  Colors.red[700]!,
  Colors.green[700]!,
  Colors.blue[700]!,
  Colors.yellow[700]!,
  Colors.pink[700]!,
  Colors.teal[700]!,
  Colors.indigo[700]!,
  Colors.brown[700]!,
  Colors.deepPurple[700]!,
  Colors.amber[700]!,
  Colors.lightGreen[700]!,
  Colors.orange[700]!,
  Colors.cyan[700]!,
];

List<Color> getColors() {
  return colorList;
}

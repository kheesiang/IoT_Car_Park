import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../layout_size.dart';

/// This is a Stateful widget used for entrances on the User Interface.
///
/// Created August 2020
/// by Bee Khee Siang
/// Modified October 2020
/// by Aqeel Ahlam Rauf
/// Modified October 2020
/// by Wan Ru Thang

class Entrance extends StatefulWidget {

  /// Text to display on this widget.
  final String entranceName;
  /// Height of this widget.
  final double height;

  /// Constructor.
  Entrance(this.entranceName, this.height);

  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  @override
  Widget build(BuildContext context) {

    // get current screen size
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Container(
      height: LayoutSize.blockSizeVertical * widget.height,
      width: queryData.size.width * 0.30,
      alignment: Alignment(0.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(widget.entranceName, style: TextStyle(fontFamily: 'Lato', color: Colors.white)),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../layout_size.dart';

/// This is a Stateful widget used for displaying the meaning of the icons
/// on the parking slots, for the User Interface.
///
/// Created August 2020
/// by Bee Khee Siang
/// Modified October 2020
/// by Aqeel Ahlam Rauf
/// Modified October 2020
/// by Wan Ru Thang

class Information extends StatefulWidget {

  /// Text to display on this widget.
  final String info;
  /// Part of the filepath to the icon displayed on this widget.
  final String iconPath;

  /// Constructor
  Information(this.info, this.iconPath);

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      height: LayoutSize.blockSizeVertical * 5,
      width: queryData.size.width * 0.18,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: AssetImage('assets/images/' + widget.iconPath + '.png'),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(widget.info,
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: 'Lato')),
          ),
      ),
      )
    );
  }
}

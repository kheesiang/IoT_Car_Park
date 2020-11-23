import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/layout_size.dart';
import 'package:myapp/utils/constants.dart';

/// This is a Stateful widget used for each parking slot on the User Interface.
///
/// Created August 2020
/// by Bee Khee Siang
/// Modified October 2020
/// by Aqeel Ahlam Rauf
/// Modified October 2020
/// by Wan Ru Thang

class ParkingSlot extends StatefulWidget {

  /// Slot number of the parking slot, eg. L1_A1.
  final String slotNumber;
  /// Part of the filepath to the icon displayed on this widget.
  final String iconPath;

  /// Constructor.
  ParkingSlot({
    Key key,
    @required this.slotNumber,
    @required this.iconPath})
      : super(key: key);

  @override
  _ParkingSlotState createState() => _ParkingSlotState();
}

class _ParkingSlotState extends State<ParkingSlot> {

  /// Stores current status of parking slot.
  /// True is occupied, false is available.
  bool currentStatus;

  @override
  void initState() {
    checkStatus(widget.slotNumber);  // check slot status from firebase
    super.initState();
  }

  /// Checks the slot's status from Firebase.
  void checkStatus(String slotNum) {
    // initialises a stream that listens for changes in data from Firebase document
    Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance
        .collection('slots')
        .doc(slotNum)
        .snapshots();
    // update status if there is a change in status in Firebase
    documentStream.listen((snapshot) {
      if (this.mounted) {
        setState(() {
          currentStatus = snapshot.data()['status'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // get current screen size
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    if (currentStatus == false) { // if the parking slot is available
      return GestureDetector( // onclick produces flushbar with details of parking slot
        onTap: () {
          Flushbar(
            title: "Parking Slot: " + widget.slotNumber,
            message: "Status: Available",
            flushbarStyle: FlushbarStyle.FLOATING,
            margin: EdgeInsets.all(8),
            borderRadius: 8,
            icon: Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.blue[300],
            ),
            duration: Duration(seconds: 3),
            leftBarIndicatorColor: Colors.blue[300],
          )
            ..show(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(PADDING2),
          child: Container(
            height: LayoutSize.blockSizeVertical * 12,
            width: queryData.size.width * 0.30,
              decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage('assets/images/noun_Parking_2313077.png'),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(PADDING),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(widget.slotNumber, style: TextStyle(fontFamily: 'Lato')),
                ),
              ),
            )
          ),
        )
      );
    }

    else { // if the parking slot is occupied
      return GestureDetector(
          onTap: () {
            Flushbar(
              title: "Parking Slot: " + widget.slotNumber,
              message: "Status: Occupied",
              flushbarStyle: FlushbarStyle.FLOATING,
              margin: EdgeInsets.all(8),
              borderRadius: 8,
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.blue[300],
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.blue[300],
            )
              ..show(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(PADDING2),
            child: Container(
              height: LayoutSize.blockSizeVertical * 12,
              width: queryData.size.width * 0.30,
              decoration: BoxDecoration(
                color: Colors.red[700],
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: AssetImage('assets/images/' + widget.iconPath + '.png'),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(PADDING),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(widget.slotNumber, style: TextStyle(fontFamily: 'Lato')),
                  ),
                )
            ),
            ),
          )
      );
    }
  }
}
import 'package:flutter/material.dart';
import 'layout_size.dart';
import 'package:flutter/widgets.dart';
import 'utils/constants.dart';
import 'widgets/information.dart';
import 'widgets/entrance.dart';
import 'widgets/parking_slot.dart';
import 'package:firebase_core/firebase_core.dart';


/*
  Main script for web dashboard. Dashboard shows the parking slots available on
  both floors. Green indicates available, and red indicates taken.

  The bottom menu bar allows users to switch between the floors.
  Clicking on a parking slot will indicate the availability of the slot in a
  snackbar. Clicking on an available parking slot will also produce arrow directions
  from the entrance to the parking slot.

  Created August 2020
  by Bee Khee Siang
  Modified October 2020
  by Aqeel Ahlam Rauf
  Modified October 2020
  by Wan Ru Thang
*/

/** GENERAL NOTES:
 * 1. StatelessWidget: The State of the widget CANNOT change over time,
 * once it has been initialized, everything inside it, including the data
 * cannot be changed
 *
 * 2. StatefulWidget: The State of the widget CAN change over time.
 */


/// This is the first line of code that will run as we start the app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/// Root Widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Returns a wrapper widget.
    return MaterialApp(
      title: 'Smart Car Park',
      theme: new ThemeData(scaffoldBackgroundColor: Colors.blueGrey, brightness: Brightness.light),
      /// This is the widget that is running on the home screen.
      home: MyHomePage(title: 'Smart Car Park'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  /// Title of page.
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Current floor.
  int _selectedIndex = 0;

  /// Changes the current floor.
  void _onFloorTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    LayoutSize().init(context);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: const Text('Smart Car Park',
          style: TextStyle(
              fontSize: 35.0
          ),
        ),
      ),

      /// Gets the layout of the correct floor.
      body: new _FloorLayout()._getFloorLayout(_selectedIndex),
      /// Contents of the bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            title: Text('Level 1',
                key: Key('level1'),
                style: TextStyle(color: Colors.white)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            title: Text('Level 2',
                key: Key('level2'),
                style: TextStyle(color: Colors.white)),
          ),
        ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.cyan,
      backgroundColor: Colors.grey[850],
      onTap: _onFloorTapped,
    ),
    );
  }
}


class _FloorLayout {

  /// List containing the different layouts.
  static List<Card> _layoutOptions = <Card>[
    /// PARKING SLOTS FOR LEVEL 1.
    Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.black26,
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: Entrance('↑ To Level 2', 4),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: Entrance('↗ Mall Entrance', 4),
                    ),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(PADDING),
                      child: ParkingSlot(key: Key('L1A1'),
                                slotNumber: 'L1_A1',
                                iconPath: SIDE_A),
                    ),
                     Padding(
                       padding: EdgeInsets.all(PADDING),
                       child: ParkingSlot(key: Key('L1B1'),
                        slotNumber: 'L1_B1',
                        iconPath: SIDE_B),
                     ),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: ParkingSlot(key: Key('L1A2'),
                          slotNumber: 'L1_A2',
                          iconPath: SIDE_A),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: ParkingSlot(key: Key('L1B2'),
                          slotNumber: 'L1_B2',
                          iconPath: SIDE_B),
                    ),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: ParkingSlot(key: Key('L1A3'),
                          slotNumber: 'L1_A3',
                          iconPath: SIDE_A),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: ParkingSlot(key: Key('L1B3'),
                          slotNumber: 'L1_B3',
                          iconPath: SIDE_B),
                    ),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: ParkingSlot(key: Key('L1A4'),
                          slotNumber: 'L1_A4',
                          iconPath: SIDE_A),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: ParkingSlot(key: Key('L1B4'),
                          slotNumber: 'L1_B4',
                          iconPath: SIDE_B),
                    ),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Entrance('↑ Entrance - Exit ↓', 5),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: Information('Occupied', 'car_A'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(PADDING),
                      child: Information('Free', 'noun_Parking_2313077'),
                    ),
                  ],
                )
              ]
          )
        )
    ),

    /// PARKING SLOTS FOR LEVEL 2.
    Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.black26,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: Entrance(' ', 4),
                ),
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: Entrance('↗ Mall Entrance', 4),
                ),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: ParkingSlot(key: Key('L2A1'),
                      slotNumber: 'L2_A1',
                      iconPath: SIDE_A),
                ),
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: Entrance(' ', 12),
                ),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: ParkingSlot(key: Key('L2A2'),
                      slotNumber: 'L2_A2',
                      iconPath: SIDE_A),
                ),
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: Entrance(' ', 12),
                ),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: ParkingSlot(key: Key('L2A3'),
                      slotNumber: 'L2_A3',
                      iconPath: SIDE_A),
                ),
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: Entrance(' ', 12),
                ),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: ParkingSlot(key: Key('L2A4'),
                      slotNumber: 'L2_A4',
                      iconPath: SIDE_A),
                ),
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: Entrance(' ', 12),
                ),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Entrance('↓ To Level 1',5),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: Information('Occupied', 'car_A'),
                ),
                Padding(
                  padding: const EdgeInsets.all(PADDING),
                  child: Information('Free', 'noun_Parking_2313077'),
                ),
              ],
            )
          ]
        )
      )
    ),
  ];

/// Used to return the layout index (CARD index).
/// Each Card holds the slots for one level of parking.
  Card _getFloorLayout(int index) {
    /// Returns the layout (CARD INDEX)
    return _layoutOptions.elementAt(index);
  }
}
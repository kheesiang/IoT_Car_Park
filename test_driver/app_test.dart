import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

/// This file is for integration testing of this entire app.

void main() {
  group('App Performance Test: ', () {
    final levelOne = find.byValueKey('level1');
    final levelTwo = find.byValueKey('level2');
    final slotL1B2 = find.byValueKey('L1B2');
    final slotL2A2 = find.byValueKey('L2A2');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Parking slot registers tap', () async {
      // default floor is level 1
      await driver.waitFor(slotL1B2);
      await driver.tap(slotL1B2);
      print('Tapped slot');
    });

    test('Tapping bottom navigation bar changes floor', () async {
      // tap level 2
      await driver.waitFor(levelTwo);
      await driver.tap(levelTwo);
      print('Tapped level 2');
      // tap slot L2 A2
      await driver.waitFor(slotL2A2);
      await driver.tap(slotL2A2);
      print('Tapped slot L2 A2');
      // tap level 1
      await driver.waitFor(levelOne);
      await driver.tap(levelOne);
      print('Tapped level 1');
      // tap slot L1 B2
      await driver.waitFor(slotL1B2);
      await driver.tap(slotL1B2);
      print('Tapped slot L1 B2');
    });
  });
}
import 'package:flutter_driver/driver_extension.dart';
import 'package:myapp/main.dart' as app;

/// This file is used in app_test.dart for integration testing of this app.

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jobcdp/app/app_config.dart' as config;

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// class MyThemes {
//   static final darkTheme = ThemeData(
//     backgroundColor: config.Colorss().black(1),
//     focusColor: config.Colorss().second(1),
//     hintColor: config.Colorss().main(1),
//     cardColor: config.Colorss().main(1),
//     canvasColor: config.Colorss().main(1),
//     indicatorColor: config.Colorss().second(1),
//     primaryColor: config.Colorss().main(1),
//     colorScheme: ColorScheme.fromSwatch().copyWith(
//       secondary: config.Colorss().second(1),
//       secondaryContainer: config.Colorss().white(1),
//       brightness: Brightness.dark,
//     ),
//   );

//   static final lightTheme = ThemeData(
//     backgroundColor: config.Colorss().white(1),
//     focusColor: config.Colorss().main(1),
//     hintColor: config.Colorss().second(1),
//     cardColor: config.Colorss().second(1),
//     canvasColor: config.Colorss().second(1),
//     indicatorColor: config.Colorss().main(1),
//     primaryColor: config.Colorss().second(1),
//     colorScheme: ColorScheme.fromSwatch().copyWith(
//       secondary: config.Colorss().main(1),
//       secondaryContainer: config.Colorss().black(1),
//       brightness: Brightness.dark,
//     ),
//   );
// }

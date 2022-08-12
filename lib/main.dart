import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobcdp/firebase_options.dart';
import 'package:jobcdp/views/LoginScreen/login.dart';
import 'package:provider/provider.dart';
import 'package:jobcdp/helper/utils/theme_notifer.dart';
import 'package:jobcdp/viewModel/Dashboard/dashboard_viewmodel.dart';
import 'helper/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => DashboardScreenViewModel()),
    ], child: const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CDP360 By SS',
            themeMode: themeProvider.themeMode,
            //theme: MyThemes.lightTheme,
            // darkTheme: MyThemes.darkTheme,
            home: const LoginScreen(),
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      );
}

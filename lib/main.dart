import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keyboard/app/providers/providers_list.dart';
import 'package:keyboard/app/routes/app_pages.dart';
import 'package:keyboard/app/routes/app_routes.dart';
import 'package:keyboard/app/themes/app_theme.dart';
import 'package:keyboard/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  // await Future.delayed(const Duration(milliseconds: 1000));
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  await dotenv.load(fileName: "dotenv");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersList.providers,
      child: MaterialApp(
        theme: kAppTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.SPLASH,
        routes: AppPages.pages,
      ),
    );
  }
}

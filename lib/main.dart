import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  await Future.delayed(const Duration(milliseconds: 1000));
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "dotenv");

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersList.providers,
      child: MaterialApp(
        title: "OTTAA Keyboard",
        theme: kAppTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        routes: AppPages.pages,
      ),
    );
  }
}

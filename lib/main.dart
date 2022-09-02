import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keyboards/app/providers/providers_list.dart';
import 'package:keyboards/app/routes/app_pages.dart';
import 'package:keyboards/app/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  await Future.delayed(const Duration(milliseconds: 1000));
  await dotenv.load(fileName: "dotenv");
  WidgetsFlutterBinding.ensureInitialized();
  kIsWeb
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: dotenv.env['API_KEY'] ?? 'add Proper Values',
            appId: dotenv.env['APP_ID'] ?? 'add Proper Values',
            messagingSenderId:
                dotenv.env['MESSAGING_SENDER_ID'] ?? 'add Proper Values',
            projectId: dotenv.env['PROJECT_ID'] ?? 'add Proper Values',
          ),
        )
      : await Firebase.initializeApp();
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
        debugShowCheckedModeBanner: false,
        initialRoute:AppRoutes.SPLASH,
        routes: AppPages.pages,
      ),
    );
  }
}

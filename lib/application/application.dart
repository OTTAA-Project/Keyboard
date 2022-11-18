import 'package:flutter/material.dart';
import 'package:keyboard/application/routes/app_pages.dart';
import 'package:keyboard/application/routes/app_routes.dart';
import 'package:keyboard/application/themes/app_theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "OTTAA Keyboard",
      theme: kAppTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppPages.pages,
    );
  }
}

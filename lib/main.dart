import 'package:flutter/material.dart';
import 'package:keyboards/app/modules/qwetry_keyboard/qwerty_layout.dart';
import 'package:keyboards/app/providers/qwerty_layout_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QwertyLayoutProvider(),
      lazy: false,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: QwertyLayout(),
      ),
    );
  }
}

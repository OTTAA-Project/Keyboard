import 'package:flutter/material.dart';
import 'package:keyboard/application/providers/providers_list.dart';
import 'package:provider/provider.dart';

class Injector extends StatelessWidget {
  final Widget application;

  const Injector({super.key, required this.application}) : super();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersList.providers,
      child: application,
    );
  }
}

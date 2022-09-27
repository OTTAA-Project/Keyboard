import 'package:flutter/material.dart';
import 'package:keyboard/app/providers/splash_provider.dart';
import 'package:keyboard/app/routes/app_routes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isLogged = await context.read<SplashProvider>().isUserLogIn;
      if (!mounted) return;
      if (!isLogged) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        return;
      }
      Navigator.of(context).pushReplacementNamed(AppRoutes.keyboard);
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ],
    ));
  }
}

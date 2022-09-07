import 'package:flutter/material.dart';
import 'package:keyboard/app/providers/splash_provider.dart';
import 'package:keyboard/app/routes/app_routes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: context.read<SplashProvider>().isUserLogIn,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.hasData && snapshot.data! == true) {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.KEYBOARD);
              });
            }
            if (snapshot.data! == false && snapshot.hasData) {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
              });
              // Navigator.of(context).pushReplacementNamed('/login');
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

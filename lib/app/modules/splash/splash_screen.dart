import 'package:flutter/material.dart';
import 'package:keyboards/app/providers/splash_provider.dart';
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
                Navigator.of(context).pushReplacementNamed('/qwerty_keyboard');
              });
            }
            if (snapshot.data! == false && snapshot.hasData) {
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pushReplacementNamed('/login');
              });
              // Navigator.of(context).pushReplacementNamed('/login');
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.black87,
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
                  color: Colors.black87,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

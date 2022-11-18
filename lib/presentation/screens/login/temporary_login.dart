import 'package:flutter/material.dart';
import 'package:keyboard/application/common/constants.dart';
import 'package:keyboard/application/providers/auth_provider.dart';
import 'package:keyboard/application/routes/app_routes.dart';
import 'package:keyboard/application/themes/app_theme.dart';
import 'package:keyboard/core/models/user_model.dart';
import 'package:keyboard/presentation/common/ui/jumping_dots.dart';
import 'package:provider/provider.dart';

class TemporaryLogin extends StatefulWidget {
  const TemporaryLogin({Key? key}) : super(key: key);

  @override
  State<TemporaryLogin> createState() => _TemporaryLoginState();
}

class _TemporaryLoginState extends State<TemporaryLogin> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isLoading = context.read<AuthProvider>().isLoading;
    return Scaffold(
      body: SizedBox.fromSize(
        size: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ottaa_logo_drawer.png', width: (size.width / 3)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Bienvenido', style: textTheme.titleLarge!.copyWith(color: kPrimaryFont, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Regístrate con tu cuenta de Google para acceder a todas las funciones de la aplicación',
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium!.copyWith(color: kPrimaryFont.withOpacity(.8), fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 80),

                  // GOOGLE BUTTON
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () async {
                            final UserModel? user = await context.read<AuthProvider>().trySignIn();
                            if (mounted && user != null) {
                              Navigator.popAndPushNamed(
                                context,
                                AppRoutes.keyboard,
                              );
                            }
                          },
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: kPrimaryMaterialColor.shade300,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        children: isLoading
                            ? const [
                                Expanded(child: JumpingDotsProgressIndicator()),
                              ]
                            : [
                                Expanded(
                                  child: Image.asset('assets/images/gIcon.png'),
                                ),
                                const SizedBox(width: 20),
                                const Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Acceder con Google',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

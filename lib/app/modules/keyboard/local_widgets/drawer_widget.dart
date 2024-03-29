import 'package:flutter/material.dart';
import 'package:keyboard/app/global_controllers/auth_provider.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:keyboard/app/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:keyboard/app/utils/constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        width: horizontalSize * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(verticalSize * 0.03),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: kColorAppbar,
                    borderRadius: BorderRadius.circular(verticalSize * 0.027),
                  ),
                  height: verticalSize * 0.15,
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/drawer_asset_image.png',
                          height: verticalSize * 0.05,
                        ),
                        Image.asset(
                          'assets/images/ottaa_logo_drawer.png',
                          height: verticalSize * 0.09,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: verticalSize * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTileWidget(
                        icon: context.watch<KeyboardLayoutProvider>().isMuted ? Icons.volume_up : Icons.volume_off,
                        title: context.watch<KeyboardLayoutProvider>().isMuted ? 'Activar sonido' : 'Silenciar',
                        onTap: () async {
                          context.read<KeyboardLayoutProvider>().muteFunction();
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: kPrimaryBG,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTileWidget(
                        icon: Icons.info_outline,
                        title: 'Acerca de',
                        onTap: () {},
                      ),
                      ListTileWidget(
                        icon: Icons.settings,
                        title: 'Ajustes',
                        onTap: () async {
                          Navigator.pushNamed(context, AppRoutes.settings);
                        },
                      ),
                      ListTileWidget(
                        icon: Icons.info_outline,
                        title: 'Tutorial',
                        onTap: () async {},
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: kPrimaryBG,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ListTileWidget(
                      //   icon: Icons.highlight_remove,
                      //   title: 'close_application'.tr,
                      //   onTap: () async {
                      //     exit(0);
                      //   },
                      // ),
                      ListTileWidget(
                        icon: Icons.exit_to_app,
                        title: 'Cerrar sesión',
                        onTap: () async {
                          await context.read<AuthProvider>().logout();
                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height;
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: verticalSize * 0.035,
      ),
      title: Text(
        title,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:keyboards/app/global_controllers/auth_provider.dart';
import 'package:keyboards/app/providers/qwerty_layout_provider.dart';
import 'package:keyboards/app/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:keyboards/app/utils/constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double horizontalSize = MediaQuery.of(context).size.width;
    double verticalSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalSize * 0.02),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: verticalSize * 0.01),
          width: horizontalSize * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(verticalSize * 0.03),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTileWidget(
                          icon: context.watch<QwertyLayoutProvider>().muteOrNot
                              ? Icons.volume_up
                              : Icons.volume_off,
                          title: 'Mute',
                          onTap: () async {
                           context.read<QwertyLayoutProvider>().muteFunction();
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    // thickness: 0.0,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTileWidget(
                          icon: Icons.info_outline,
                          title: 'About Questions',
                          onTap: () {},
                        ),
                        ListTileWidget(
                          icon: Icons.settings,
                          title: 'Settings',
                          onTap: () async {
                            Navigator.pushNamed(context, AppRoutes.SETTINGS);
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
                    color: Colors.grey,
                    // thickness: 0.0,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalSize * 0.01),
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
                          title: 'Sign out',
                          onTap: () async {
                            await context.read<AuthProvider>().logout();
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

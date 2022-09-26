import 'package:flutter/material.dart';
import 'package:keyboard/app/providers/settings_provider.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'local_widgets/build_app_bar.dart';

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SettingsProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('Accesibilidad'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Botones de acción',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Divider(
              height: 10,
              color: Colors.grey[700],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Pequeño",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Mediano",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Grande",
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Slider(
                    value: provider.buttonActionsSize,
                    onChanged: provider.changeCurrentButtonActionsSize,
                    label: provider.buttonActionsSizes[provider.buttonActionsSize],
                    divisions: provider.buttonActionsSizes.length - 1,
                    thumbColor: kOTTAAOrangeNew,
                    activeColor: kOTTAAOrangeNew,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

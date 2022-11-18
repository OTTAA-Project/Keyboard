import 'package:flutter/material.dart';
import 'package:keyboard/application/common/constants.dart';
import 'package:keyboard/application/providers/tts_controller.dart';
import 'package:keyboard/application/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'local_widgets/build_app_bar.dart';

class VoiceAndSubtitlesPage extends StatelessWidget {
  const VoiceAndSubtitlesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('Voces y subtitulos'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Voz',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey[700],
              ),
              const Text(
                'Elige una voz según tu preferencia.',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: context.watch<SettingsProvider>().currentLanguage["name"],
                iconSize: 20,
                elevation: 16,
                underline: Container(),
                onChanged: (newValue) {
                  context.read<SettingsProvider>().changeLanguage(newValue: newValue!);
                },
                items: context.read<TTSController>().enabledTTS.map<DropdownMenuItem<String>>((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const Divider(),
              const Text(
                'Motor de texto a voz',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey[700],
              ),
              SwitchListTile(
                activeColor: kColorAppbar,
                value: context.watch<SettingsProvider>().ttsController.isCustomTTSEnable,
                onChanged: (bool value) {
                  context.read<SettingsProvider>().toggleIsCustomTTSEnable(value);
                },
                title: const Text('TTS personalizado'),
                subtitle: context.watch<SettingsProvider>().ttsController.isCustomTTSEnable ? const Text('ACTIVO') : const Text('APAGADO'),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                title: const Text('Velocidad de lectura'),
                subtitle: Text(context.watch<SettingsProvider>().ttsController.rate.toString()),
                enabled: false,
              ),
              Slider(
                activeColor: context.watch<SettingsProvider>().ttsController.isCustomTTSEnable ? kColorAppbar : Colors.grey,
                inactiveColor: Colors.grey,
                value: context.read<SettingsProvider>().ttsController.rate,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: context.read<SettingsProvider>().ttsController.rate.toString(),
                onChanged: (double value) {
                  if (context.read<SettingsProvider>().ttsController.isCustomTTSEnable) {
                    context.read<SettingsProvider>().setRate(value);
                  }
                },
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                title: const Text('Tono de voz'),
                subtitle: Text(context.read<SettingsProvider>().ttsController.pitch.toString()),
                enabled: false,
              ),
              Slider(
                activeColor: context.watch<SettingsProvider>().ttsController.isCustomTTSEnable ? kColorAppbar : Colors.grey,
                inactiveColor: Colors.grey,
                value: context.read<SettingsProvider>().ttsController.pitch,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: context.read<SettingsProvider>().ttsController.pitch.toString(),
                onChanged: (double value) {
                  if (context.read<SettingsProvider>().ttsController.isCustomTTSEnable) {
                    context.read<SettingsProvider>().setPitch(value);
                  }
                },
              ),
              const Text(
                'Subtitulos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey[700],
              ),
              SwitchListTile(
                activeColor: kColorAppbar,
                title: const Text('Subtitulos Personalizados'),
                subtitle: context.watch<SettingsProvider>().ttsController.isCustomSubtitle ? const Text('ACTIVO') : const Text('APAGADO'),
                onChanged: (bool value) {
                  context.read<SettingsProvider>().toggleIsCustomSubtitle(value);
                },
                value: context.read<SettingsProvider>().ttsController.isCustomSubtitle,
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                title: const Text('Tamaño'),
                subtitle: Text(context.read<SettingsProvider>().ttsController.subtitleSize.toString()),
                enabled: false,
              ),
              Slider(
                activeColor: context.watch<SettingsProvider>().ttsController.isCustomSubtitle ? kColorAppbar : Colors.grey,
                inactiveColor: Colors.grey,
                value: context.read<SettingsProvider>().ttsController.subtitleSize.toDouble(),
                min: 1.0,
                max: 4.0,
                divisions: 3,
                label: context.read<SettingsProvider>().ttsController.subtitleSize.toString(),
                onChanged: (double value) {
                  if (context.read<SettingsProvider>().ttsController.isCustomSubtitle) {
                    context.read<SettingsProvider>().setSubtitleSize(value.toInt());
                  }
                },
              ),
              const Divider(),
              SwitchListTile(
                activeColor: context.watch<SettingsProvider>().ttsController.isCustomSubtitle ? kColorAppbar : Colors.grey,
                title: const Text('Mayusculas'),
                subtitle: const Text('El texto se mostrara en mayusculas'),
                onChanged: (bool value) {
                  if (context.read<SettingsProvider>().ttsController.isCustomSubtitle) {
                    context.read<SettingsProvider>().toggleIsSubtitleUppercase(value);
                  }
                },
                value: context.read<SettingsProvider>().ttsController.isSubtitleUppercase,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

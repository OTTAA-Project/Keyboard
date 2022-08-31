import 'package:flutter/material.dart';
import 'package:keyboards/app/providers/settings_provider.dart';
import 'package:keyboards/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'local_widgets/build_app_bar.dart';

class VoiceAndSubtitlesPage extends StatelessWidget {
  const VoiceAndSubtitlesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Voice and subtitles'),
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
                'VOZ',
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
                value: context.read<SettingsProvider>().ttsController.availableTTS.first,
                iconSize: 20,
                elevation: 16,
                underline: Container(),
                onChanged: (newValue) {
                  //todo: set value
                  context.read<SettingsProvider>().ttsController.languaje = newValue;
                },
                items: context.read<SettingsProvider>().ttsController.availableTTS
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
              const Divider(),
              const Text(
                'TEXT-TO-SPEECH-ENGINE',
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
                value: context.read<SettingsProvider>().ttsController.isCustomTTSEnable,
                onChanged: (bool value) {
                  context.read<SettingsProvider>().toggleIsCustomTTSEnable(value);
                },
                title: const Text('Enable custom TTS'),
                subtitle: context.read<SettingsProvider>().ttsController.isCustomTTSEnable
                    ? const Text('ON')
                    : const Text('OFF'),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                title: const Text('Speech Rate'),
                subtitle: Text(context.read<SettingsProvider>().ttsController.rate.toString()),
                enabled: false,
              ),
              Slider(
                activeColor: context.read<SettingsProvider>().ttsController.isCustomTTSEnable
                    ? kColorAppbar
                    : Colors.grey,
                inactiveColor: Colors.grey,
                value: context.read<SettingsProvider>().ttsController.rate,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: context.read<SettingsProvider>().ttsController.rate.toString(),
                onChanged: (double value) {
                  if (context.read<SettingsProvider>().ttsController.isCustomTTSEnable) context.read<SettingsProvider>().setRate(value);
                },
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                title: const Text('Speech Pitch'),
                subtitle: Text(context.read<SettingsProvider>().ttsController.pitch.toString()),
                enabled: false,
              ),
              Slider(
                activeColor: context.read<SettingsProvider>().ttsController.isCustomTTSEnable
                    ? kColorAppbar
                    : Colors.grey,
                inactiveColor: Colors.grey,
                value: context.read<SettingsProvider>().ttsController.pitch,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: context.read<SettingsProvider>().ttsController.pitch.toString(),
                onChanged: (double value) {
                  if (context.read<SettingsProvider>().ttsController.isCustomTTSEnable) context.read<SettingsProvider>().setPitch(value);
                },
              ),
              const Text(
                'SUBTITLE',
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
                title: const Text('Customized subtitle'),
                subtitle: context.read<SettingsProvider>().ttsController.isCustomSubtitle
                    ? const Text('ON')
                    : const Text('OFF'),
                onChanged: (bool value) {
                  context.read<SettingsProvider>().toggleIsCustomSubtitle(value);
                },
                value: context.read<SettingsProvider>().ttsController.isCustomSubtitle,
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                title: const Text('Size'),
                subtitle: Text(context.read<SettingsProvider>().ttsController.subtitleSize.toString()),
                enabled: false,
              ),
              Slider(
                activeColor: context.read<SettingsProvider>().ttsController.isCustomSubtitle
                    ? kColorAppbar
                    : Colors.grey,
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
                activeColor: context.read<SettingsProvider>().ttsController.isCustomSubtitle
                    ? kColorAppbar
                    : Colors.grey,
                title: const Text('Uppercase'),
                subtitle: const Text('It allows uppercase subtitles.'),
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

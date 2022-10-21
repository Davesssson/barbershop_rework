import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/theme_controller.dart';

class profileScreen extends ConsumerWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);

    return  Scaffold(
      body:
      authControllerState==null
      ?SettingsList(
        sections: [
            SettingsSection(
                tiles: [
                  SettingsTile(
                    title:Text("asd"),
                    enabled: true,
                  ),
                  SettingsTile.switchTile(
                      initialValue: ref.read(ThemeModeFilterProvider.notifier).state==ThemeModeFilter.dark,
                      onToggle: (toggled){
                        print("heloka");
                        ref.read(ThemeModeFilterProvider.notifier).state==ThemeModeFilter.dark ? ref.read(ThemeModeFilterProvider.notifier).state=ThemeModeFilter.light : ref.read(ThemeModeFilterProvider.notifier).state=ThemeModeFilter.dark;
                      },
                      title: Text("Dark mode")
                  ),
                  SettingsTile(
                    title:Text("Sign out"),
                    enabled: true,
                    onPressed: (context){
                      ref.read(authControllerProvider.notifier).signOut();
                      Navigator.of(context).pop();
                    },
                  ),
                ]
            )

        ],
      )
      :Container(
        color: Colors.green,
        child: Text("Heloka, be kéne jelentkezni, nem gondolod?"),
      ),
    );
  }
}


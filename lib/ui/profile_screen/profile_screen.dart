import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/profile_screen/profile_own_bookings.dart';
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
      authControllerState!=null
      ?Container(
        child: SingleChildScrollView(
          child: Column(
            children:[
              Container(
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width*0.1,
                        backgroundColor: Colors.green,
                      ),
                      (authControllerState.displayName == null || authControllerState.isAnonymous)
                          ? Text("vagy anonim vagyok vagy nincsen display namem")
                          : Text(authControllerState.displayName!)
                    ],
                  ),
                ),
              ),
              SettingsList(
                shrinkWrap: true,
                darkTheme: SettingsThemeData(
                  settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
                  settingsTileTextColor: Theme.of(context).cardColor,
                  titleTextColor: Colors.white,
                  tileDescriptionTextColor: Colors.white,
                  trailingTextColor: Colors.white,
                  tileHighlightColor:Colors.white,
                ),
                sections: [
                    SettingsSection(
                        title: Text("beállítások"),
                        tiles: [
                          SettingsTile(
                            title:Text("asd",style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!),),
                            enabled: true,
                          ),
                          SettingsTile.switchTile(
                              initialValue: ref.read(ThemeModeFilterProvider.notifier).state==ThemeModeFilter.dark,
                              onToggle: (toggled){
                                print("heloka");
                                ref.read(ThemeModeFilterProvider.notifier).state==ThemeModeFilter.dark ? ref.read(ThemeModeFilterProvider.notifier).state=ThemeModeFilter.light : ref.read(ThemeModeFilterProvider.notifier).state=ThemeModeFilter.dark;
                              },
                              title: Text("Dark mode",style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!),)
                          ),
                          SettingsTile.navigation(
                              title: Text("Foglalásaim",style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!),),
                              onPressed: (context) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ownBookings()),
                                );
                              },
                          ),
                          SettingsTile(
                            title:Text("Sign out",style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!),),
                            enabled: true,
                            onPressed: (context){
                              ref.read(authControllerProvider.notifier).signOut();
                              Navigator.of(context).pop();
                            },
                          ),
                        ]
                    )

                ],
              ),
          ]
          ),
        ),
      )
      :Container(
        color: Colors.green,
        child: Text("Heloka, be kéne jelentkezni, nem gondolod?"),
      ),
    );
  }
}


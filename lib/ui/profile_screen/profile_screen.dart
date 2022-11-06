import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../controllers/auth_controller.dart';
import 'widgets/profile_header.dart';
import 'widgets/settingsList.dart';

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
              profileHeader(),
              settingsList(),
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

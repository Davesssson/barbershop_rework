import 'package:flutter/material.dart';

import 'package:flutter_shopping_list/ui/login_screen/variants/login_screen_mobile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

//class LoginScreen extends HookConsumerWidget{
class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout(
      mobile: LoginScreen_mobile(),
      desktop: Container(color: Colors.blue),
    );
  }
}

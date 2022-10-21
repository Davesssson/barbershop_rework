import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/theme_controller.dart';

class serviceScreen extends ConsumerWidget {
  const serviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
      body:Container(color:Colors.red)
    );
  }
}


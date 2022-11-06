

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controllers/auth_controller.dart';

class profileHeader extends ConsumerWidget {
  const profileHeader({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    return Container(
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width*0.1,
              backgroundColor: Colors.green,
            ),
            (authControllerState?.displayName == null || authControllerState!.isAnonymous)
                ? Text("vagy anonim vagyok vagy nincsen display namem")
                : Text(authControllerState.displayName!)
          ],
        ),
      ),
    );
  }
}
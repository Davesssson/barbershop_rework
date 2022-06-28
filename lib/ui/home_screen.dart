import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/widgets/bottom_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
    );
  }
}








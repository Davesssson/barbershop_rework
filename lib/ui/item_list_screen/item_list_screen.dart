import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/item_list_screen/variants/item_list_screen_mobile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';


class ItemListScreen extends ConsumerWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout(
      mobile: ItemListScreen_mobile(),
      desktop: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: Container(color: Colors.pink)),
    );
  }
}

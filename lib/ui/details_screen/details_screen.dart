import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/details_screen_mobile.dart';
import 'package:flutter_shopping_list/ui/item_list_screen/variants/item_list_screen_mobile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';


class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout(
      mobile: DetailsScreen_mobile(),
      desktop: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
          ),
          body: Container(
            color: Colors.pink,
            child: Text("Details Screen Desktop"),

          )
      ),
    );
  }
}

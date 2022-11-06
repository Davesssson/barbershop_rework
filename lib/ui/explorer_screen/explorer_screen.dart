import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/explorer_screen/variants/explorer_screen_mobile.dart';
import 'package:flutter_shopping_list/ui/explorer_screen/variants/explorer_screen_web.dart';
import 'package:flutter_shopping_list/ui/explorer_screen/variants/explorer_screen_web_2.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
class ExplorerScreen extends ConsumerWidget {
  const ExplorerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout(
      //mobile: ListScreen_mobile_pagination_mine(),
      mobile: ExplorerScreen_mobile(),
      //mobile: ListScreen_mobile_final_proto(),
      desktop: ExplorerScreen_web2(),
    );
  }
}
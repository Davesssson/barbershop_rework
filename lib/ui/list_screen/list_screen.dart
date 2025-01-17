import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/mobile/list_screen_mobile_final.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/list_screen_mobile_pagination_mine.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/list_screen_mobile_services.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/web/list_screen_web.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout(
      //mobile: ListScreen_mobile_pagination_mine(),
      mobile: ListScreen_mobile_final(),
      //mobile: ListScreen_mobile_final_proto(),
      desktop: ListScreen_web(),
    );
  }
}

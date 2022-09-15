import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/list_screen_mobile_5.dart';
import 'package:flutter_shopping_list/ui/list_screen/variants/list_screen_mobile_pagination.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenTypeLayout(
      mobile: PaginatedListView(),
      desktop: Container(color: Colors.blue),
    );
  }
}

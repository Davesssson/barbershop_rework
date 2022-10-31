
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/models/barbershop/barbershop_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/barbershop_controller/barbershop_providers.dart';

class adminShopSettingsScreen extends HookConsumerWidget {
  final String shopId;
  const adminShopSettingsScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentShop = ref.watch(shopProvider(shopId));
    final cityTextfieldController = useTextEditingController();
    return Scaffold(
        body: Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8),
            color: Colors.grey,
            child: currentShop.when(
                data: (data) {
                  return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("city"),
                            trailing: SizedBox(
                              width: MediaQuery.of(context).size.width/10,
                              child: TextFormField(
                                initialValue: data.city,
                                controller: cityTextfieldController,
                              ),
                            ),
                          ),
                          ListTile(),
                          ListTile(),
                        ],
                      ),
                );},
                error: (e, _) => Text(e.toString()),
                loading: () => CircularProgressIndicator())
        )
    );
  }
}

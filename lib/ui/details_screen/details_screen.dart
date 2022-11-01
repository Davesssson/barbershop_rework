import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/mobile/details_screen_mobile.dart';
import 'package:flutter_shopping_list/ui/details_screen/variants/web/details_screen_web.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../controllers/barbershop_controller/barbershop_providers.dart';


class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({Key? key,required this.barbershopId}) : super(key: key);
  final String barbershopId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(shopProvider(barbershopId));
    return barbershop.when(
        data: (data){
          return       ScreenTypeLayout(
            mobile: DetailsScreen_mobile(barbershop: data,),
            desktop: DetailsScreen_web(barbershop:data)
          );
        },
        error: (e,_){return Text("faszom");},
        loading: (){return CircularProgressIndicator();}
    ) ;

  }
}

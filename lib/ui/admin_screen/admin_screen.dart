import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/repositories/barbershops_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../controllers/barbershop_controller/barbershop_providers.dart';
import 'admin_barbers_screen/admin_barber_view.dart';
import 'admin_dashboard.dart';
import 'admin_resource_view.dart';
import 'admin_services_view.dart';
import 'admin_shop_settings.dart';

final pageProvider = StateProvider<int>((_) => 4);
final visibleProvider = StateProvider<bool>((_) => false);

class adminScreen extends ConsumerWidget {
  final String shopId;
  adminScreen({Key? key, required this.shopId}) : super(key: key);

  List<Widget> _buildScreens(){
    return [
      admin_barbers(shopId:shopId),
      calendarView(shopId: shopId),
      adminServiceView(shopId: shopId,),
      adminShopSettingsScreen(shopId:shopId),
      adminDashboardScreen(),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final currentShop = ref.watch(shopProvider(shopId));
    final page = ref.watch(pageProvider);
    final visible = ref.watch(visibleProvider);
    final int _selectedDestination = ref.watch(pageProvider);

    return currentShop.when(
        data: (data){
          Future.delayed(Duration.zero,(){ // ez nagyon fontos!!!!!
            ref.read(visibleProvider.notifier).state=data.isVisible!;
          });
          return Row(
            children: [
              Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Header',
                        style: textTheme.headline6,
                      ),
                    ),
                    Divider(height: 1, thickness: 1,),
                    ListTile(
                        leading: Icon(Icons.event_available),
                        title: Text('Üzlet látható'),
                        trailing:Switch(
                          value: visible,
                          activeColor: Colors.blueAccent,
                          onChanged: (value)async{
                            await ref.read(barbershopRepositoryProvider).changeShopVisibility(shopId,value);
                            ref.read(visibleProvider.notifier).state=value;

                          },
                        )
                    ),
                    Divider(height: 1, thickness: 1,),
                    ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text('Munkatársak'),
                      selected: _selectedDestination == 0,
                      onTap: () {ref.read(pageProvider.notifier).state=0;},
                    ),
                    ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Beosztás'),
                      selected: _selectedDestination == 1,
                      onTap: () {ref.read(pageProvider.notifier).state=1;},
                    ),
                    ListTile(
                      leading: Icon(Icons.label),
                      title: Text('Üzlet szolgáltatások'),
                      selected: _selectedDestination == 2,
                      onTap: () {ref.read(pageProvider.notifier).state=2;},
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Label',
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Üzlet beállítások'),
                      selected: _selectedDestination == 3,
                      onTap: () {ref.read(pageProvider.notifier).state=3;},
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Dashboard'),
                      selected: _selectedDestination == 4,
                      onTap: () {ref.read(pageProvider.notifier).state=4;},
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
              ),
              Expanded(
                child: Scaffold(
                    appBar: AppBar(
                      title: Text("widget.titl"),
                    ),
                    body: _buildScreens()[page]
                ),
              ),
            ],
          );
        },
        error: (e,_){return Text("anyád");},
        loading: (){return CircularProgressIndicator();}
    );

  }
}


/*
class adminScreen extends StatefulWidget {
  final String shopId ;
  adminScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  _adminScreenState createState() => _adminScreenState();
}

class _adminScreenState extends State<adminScreen> {
  int _selectedDestination = 0;
  List<Widget> _buildScreens(){
    return [
      admin_barbers(),
      calendarView(),
      adminServiceView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Header',
                  style: textTheme.headline6,
                ),
              ),
              Divider(height: 1, thickness: 1,),
              ListTile(
                leading: Icon(Icons.event_available),
                title: Text('Üzlet látható'),
                trailing:Switch(
                  value: true,
                  activeColor: Colors.blueAccent,
                  onChanged: (value){

                  },
                )
              ),
              Divider(height: 1, thickness: 1,),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Munkatársak'),
                selected: _selectedDestination == 0,
                onTap: () => selectDestination(0),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Beosztás'),
                selected: _selectedDestination == 1,
                onTap: () => selectDestination(1),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Üzlet szolgáltatások'),
                selected: _selectedDestination == 2,
                onTap: () => selectDestination(2),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Label',
                ),
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Item A'),
                selected: _selectedDestination == 3,
                onTap: () => selectDestination(3),
              ),
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: Text("widget.titl"),
            ),
            body: _buildScreens()[_selectedDestination]
          ),
        ),
      ],
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
*/




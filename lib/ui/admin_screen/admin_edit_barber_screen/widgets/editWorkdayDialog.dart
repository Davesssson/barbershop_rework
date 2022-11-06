import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../controllers/work_day_availability_controller/work_day_availability_providers.dart';

class editWorkDayDialog extends HookConsumerWidget {
  static void show(BuildContext context, CalendarTapDetails details, String barberId) {
    showDialog(
      context: context,
      builder: (context) => editWorkDayDialog(details: details,barberUnderEdit: barberId,),
    );
  }
  final String barberUnderEdit;
  final CalendarTapDetails details;

  const editWorkDayDialog({Key? key, required this.details, required this.barberUnderEdit}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startController = useTextEditingController(text:details.date!.hour.toString());
    final endController = useTextEditingController(text:(details.date!..add(Duration(hours: 8))).hour.toString());
    return Dialog(
      child: Container(
        width:MediaQuery.of(context).size.width*3/4,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("start"),
            TextField(
              controller: startController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            Text("end"),
            TextField(
              controller: endController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Item name'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*3/4,
              child: ElevatedButton(
                onPressed: () {
                  print(barberUnderEdit);
                  print(details.date.toString().split(" ")[0]);
                  print(startController.text.trim());
                  print(endController.text.trim());
                  ref.read(WorkDayAvailabilityListStateProvider(barberUnderEdit).notifier)
                      .modifyWorkDayAvailability(
                      barberUnderEdit,
                      details.date.toString().split(" ")[0],
                      int.parse(startController.text.trim()),
                      int.parse(endController.text.trim())
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
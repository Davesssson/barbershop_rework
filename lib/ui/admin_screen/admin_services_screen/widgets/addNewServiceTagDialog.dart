
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shopping_list/controllers/serviceTags_controller/serviceTags_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../controllers/serviceTags_controller/serviceTags_controller.dart';
import '../../../../controllers/service_controller/service_providers.dart';
import '../../../../models/service/service_model.dart';


class addNewServiceTagDialog extends HookConsumerWidget {
  static void show(BuildContext context, Service service) {
    showDialog(
      context: context,
      builder: (context) => addNewServiceTagDialog(service: service),
    );
  }

  final Service service;

  const addNewServiceTagDialog({Key? key, required this.service}) : super(key: key);

  bool get isUpdating => service.id != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagController = useTextEditingController(text: service.serviceTitle);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tagController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Tag name'),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: isUpdating
                      ? Colors.orange
                      : Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  ref.read(ServiceTagsListStateControllerProvider.notifier).addServiceTag(newTag: tagController.text.trim());

                },
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

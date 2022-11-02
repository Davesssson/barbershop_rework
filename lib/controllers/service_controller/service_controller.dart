import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as developer;
import '../../models/service/service_model.dart';
import '../../repositories/custom_exception.dart';
import '../../repositories/service_repository.dart';

class ServiceListStateController extends StateNotifier<AsyncValue<List<Service>>>{
  final Reader _read;
  ServiceListStateController(this._read):super(AsyncValue.loading()){
    retrieveServiceTags();
  }
  ServiceListStateController.forShop(this._read):super(AsyncValue.loading()){
    retrieveServicesFromShop("7HTJ8DF8hFwUnrL566Wc");
  }
  ServiceListStateController.forAdmin(this._read,String shopId):super(AsyncValue.loading()){
    retrieveServicesFromShop(shopId);
  }

  Future<void> retrieveServiceTags({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServiceTags] - retrieveServiceTags ");
      final items = await _read(serviceRepositoryProvider).retrieveServices();
      if (mounted) {
        state = AsyncValue.data(items);
        print("services state now = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServiceTags] - retrieveServiceTags Exception");
      state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveServicesFromShop(String shopId,{bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServicesFromShop] - retrieveServicesFromShop ");
      final items = await _read(serviceRepositoryProvider).retrieveServicesFromShop(shopId);
      if (mounted) {
        state = AsyncValue.data(items);
        print("services state now = " + state.toString());
      }
    } on CustomException catch (e) {
      developer.log("[service_controller.dart][ServiceListStateController][retrieveServicesFromShop] - retrieveServiceTags Exception");
      state = AsyncValue.error(e);
    }
  }

  Future<void> updateService({required String serviceId, required Service updatedService}) async {
    try {
      developer.log("[service_controller.dart][ServiceListStateController][updateService] - updateService ");
      await _read(serviceRepositoryProvider)
          .updateService(serviceId:serviceId, service:updatedService);
      state.whenData((services) {
        state = AsyncValue.data([
          for (final service in services)
            if (service.id == updatedService.id) updatedService else service
        ]);
      });
    } on CustomException catch (e) {
      developer.log("[service_controller.dart][ServiceListStateController][updateService] - updateService Exception ");

      // _read(itemListExceptionProvider).state = e;
    }
  }

  Future<void> addService({required String shopId,required String title, required String description, required int price}) async {
    try {
      developer.log("[service_controller.dart][ServiceListStateController][addService] - addService ");
      final service = Service(barbershop_id:shopId, serviceTitle: title,serviceDescription: description, servicePrice: price);
      final serviceId = await _read(serviceRepositoryProvider).createItem(
        shopId:shopId,
        service: service,
      );
      state.whenData((items) =>
      state = AsyncValue.data(items..add(service.copyWith(id: serviceId))));
    } on CustomException catch (e) {
      developer.log("[service_controller.dart][ServiceListStateController][addService] - addService Exception");
      //_read(itemListExceptionProvider).state = e;
    }
  }

  Future<void> deleteItem({required String serviceId}) async {
    try {
      developer.log("[service_controller.dart][ServiceListStateController][addService] - addService ");
      await _read(serviceRepositoryProvider).deleteService(
        serviceId: serviceId,
      );
      state.whenData((services) => state =
          AsyncValue.data(services..removeWhere((service) => service.id == serviceId)));
    } on CustomException catch (e) {
      developer.log("[service_controller.dart][ServiceListStateController][addService] - addService Exception ");

      // _read(itemListExceptionProvider).state = e;
    }
  }
  Future<void> updateTags({required Service service,required List<String> tags}) async {
    try {
      developer.log("[service_controller.dart][ServiceListStateController][addService] - addService ");
      Map<String,bool> newTags ={};

      tags.forEach((element) {
        newTags.addAll({element:true});
      });
      Service newService = service.copyWith(tags: newTags);

      await _read(serviceRepositoryProvider)
          .updateService(serviceId:newService.id!, service:newService);

      state.whenData((services) {
        state = AsyncValue.data([
          for (final service in services)
            if (service.id == newService.id)newService else service
        ]);
      });

    } on CustomException catch (e) {
      developer.log("[service_controller.dart][ServiceListStateController][addService] - addService Exception ");

      // _read(itemListExceptionProvider).state = e;
    }
  }

}
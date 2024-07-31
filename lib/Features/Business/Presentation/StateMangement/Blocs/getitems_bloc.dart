import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemsEntites/item_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/cart_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/SavedItems/saveitem_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/getitems_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetitemsBloc extends Cubit<BlocStates> {
  final GetitemsUsecase getItemsUseCase;

  List<ItemEntity> itemList = [];

  GetitemsBloc({required this.getItemsUseCase}) : super(Initial());

  Future<void> getItems(int count) async {
    emit(Loading());

    final result = await getItemsUseCase.call(count);

    result.fold(
      (failure) {
        emit(Failure());
      },
      (items) {
        itemList = items;

        emit(Sucessfull());
      },
    );
  }

  List<ItemEntity> getLocalList() {
    return itemList;
  }

  List<ItemEntity> getnameFiltered(String itemTitle) {
    return itemList
        .where((item) =>
            item.itemTitle!.toLowerCase().contains(itemTitle.toLowerCase()))
        .toList();
  }

  List<ItemEntity> getsubCatFiltered(String subCategoryId) {
    return itemList
        .where((item) => item.subCategoryId!
            .toLowerCase()
            .contains(subCategoryId.toLowerCase()))
        .toList();
  }

  List<ItemEntity> getLocalListFreeShipping() {
    return itemList.where((item) => item.shippingPrice == 0.0).toList();
  }

  List<ItemEntity> getLocalListRecentlyVied(
      List<SavedItemEntity> savedItemList) {
    // Get IDs of saved items
    // Assuming itemList is already defined in your class
    // Filter the itemList based on matching IDs from the savedItemList
    return itemList.where((item) {
      return savedItemList.any((savedItem) => savedItem.itemId == item.id);
    }).toList();
  }

  List<ItemEntity> getCartList(List<CartEntity> savedItemList) {
    // Get IDs of saved items
    // Assuming itemList is already defined in your class
    // Filter the itemList based on matching IDs from the savedItemList
    return itemList.where((item) {
      return savedItemList.any((savedItem) => savedItem.itemId == item.id);
    }).toList();
  }
}

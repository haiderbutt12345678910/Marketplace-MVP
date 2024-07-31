import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/cart_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCartBloc extends Cubit<BlocStates> {
  final GetCartUseCase getCartUseCase;
  String addedState = "S";
  List<CartEntity> cartList = [];

  GetCartBloc({required this.getCartUseCase}) : super(Initial());

  Future<void> getCat() async {
    emit(Loading());

    final result = await getCartUseCase.call();

    result.fold(
      (failure) {
        emit(Failure());
      },
      (items) {
        cartList = items;
        emit(Sucessfull());
      },
    );
  }

  List<CartEntity> getLocalList() {
    return cartList;
  }

  Future<void> addToCart(String id) async {
    emit(Loading());

    final result = await getCartUseCase.addToCart(id);

    result.fold(
      (failure) {
        emit(Failure());
        addedState = "F";
      },
      (_) {
        emit(Sucessfull());
        addedState = "S";
        getCat();
      },
    );
  }

  Future<void> removeCart(String id) async {
    emit(Loading());

    final result = await getCartUseCase.removeCart(id);

    result.fold(
      (failure) {
        emit(Failure());
      },
      (_) {
        emit(Sucessfull());
        getCat();
      },
    );
  }
}

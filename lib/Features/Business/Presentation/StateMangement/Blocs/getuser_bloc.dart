import 'package:flutter_application_ebay_ecom/AppCores/BlocStates/blocstates.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/user_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/UseCases/getuser_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserBloc extends Cubit<BlocStates> {
  final GetUserUsecase getUserUsecase;

  UserEntity userEntity = UserEntity(
      id: "",
      name: "",
      email: "",
      mobileNo: "",
      profileImage: "",
      cityName: "",
      shippingAddress: "",
      personalAddress: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());

  GetUserBloc({required this.getUserUsecase}) : super(Initial());

  Future<void> getUser() async {
    emit(Loading());

    final result = await getUserUsecase.call();

    result.fold(
      (failure) {
        emit(Failure());
      },
      (user) {
        userEntity = user;
        emit(Sucessfull());
      },
    );
  }

  UserEntity getUserLocal() {
    return userEntity;
  }
}

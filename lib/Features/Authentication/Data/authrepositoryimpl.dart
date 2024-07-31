import 'package:dartz/dartz.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Errors/exceptions.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Data/DataSources/remotedatasource.dart';
import 'package:flutter_application_ebay_ecom/Features/Authentication/Domain/repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, void>> logIn(String email, String password) async {
    try {
      return Right(await authDataSource.logIn(email, password));
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }
}

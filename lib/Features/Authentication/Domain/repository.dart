import 'package:dartz/dartz.dart';

import '../../../AppCores/Errors/exceptions.dart';

abstract class AuthRepository {
  const AuthRepository();
  Future<Either<Failure, void>> logIn(String email, String password);
}

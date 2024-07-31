import 'package:dartz/dartz.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Errors/exceptions.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/RemoteDataSource/apidatasource.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemDetailsEntity/itemdetail_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemsEntites/item_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/SavedItems/saveitem_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/cart_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/category_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/citites_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/membership_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/subcategory_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/user_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/repository.dart';

class RepositoryImpl extends Repository {
  final Apidatasource apidatasource;
  RepositoryImpl({required this.apidatasource});
  @override
  Future<Either<Failure, List<ItemEntity>>> getItems(int count) async {
    try {
      return Right(await apidatasource.getItems(count));
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      return Right(await apidatasource.getCategories());
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, List<SubCategoryEntity>>> getSubCategories() async {
    try {
      return Right(await apidatasource.getSubCategories());
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      return Right(await apidatasource.getUser());
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity userEntity) async {
    try {
      return Right(await apidatasource.updateUser(userEntity));
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, List<CitiesEntity>>> getCitites() async {
    try {
      return Right(await apidatasource.getCitites());
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, List<SavedItemEntity>>> getSavedItems() async {
    try {
      return Right(await apidatasource.getSavedItems());
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, List<SavedItemEntity>>> getrecentItems() async {
    try {
      return Right(await apidatasource.getSavedItems());
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCartItems() async {
    try {
      return Right(await apidatasource.getCartItems());
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, List<MembershipEntity>>> getAllMemberships() async {
    try {
      return Right(await apidatasource.getAllMemberShips());
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, MembershipEntity>> getSingleMembership(
      String id) async {
    try {
      return Right(await apidatasource.getSingleMemberShips(id));
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, ItemDetailEntity>> getSingleItem(String id) async {
    try {
      return Right(await apidatasource.getSingleItem(id));
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, void>> addCartItem(String id) async {
    try {
      return Right(await apidatasource.addCartItem(id));
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }

  @override
  Future<Either<Failure, void>> removeCartItem(String id) async {
    try {
      return Right(await apidatasource.removeCartItem(id));
    } catch (e) {
      return const Left(ApiFailure(error: "Error", statusCode: "404"));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_application_ebay_ecom/AppCores/Errors/exceptions.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemDetailsEntity/itemdetail_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/ItemsEntites/item_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/category_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/citites_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/membership_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/SavedItems/saveitem_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/subcategory_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/user_entity.dart';

import 'Entities/cart_entity.dart';

abstract class Repository {
  const Repository();

  Future<Either<Failure, List<ItemEntity>>> getItems(int count);
  Future<Either<Failure, ItemDetailEntity>> getSingleItem(String id);

  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<SubCategoryEntity>>> getSubCategories();

  //User

  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, void>> updateUser(UserEntity userEntity);

  Future<Either<Failure, List<CitiesEntity>>> getCitites();

  Future<Either<Failure, List<SavedItemEntity>>> getSavedItems();
  Future<Either<Failure, List<SavedItemEntity>>> getrecentItems();

  Future<Either<Failure, List<CartEntity>>> getCartItems();
  Future<Either<Failure, void>> removeCartItem(String id);
  Future<Either<Failure, void>> addCartItem(String id);

  Future<Either<Failure, List<MembershipEntity>>> getAllMemberships();
  Future<Either<Failure, MembershipEntity>> getSingleMembership(String id);
}

import 'dart:convert';

import 'package:flutter_application_ebay_ecom/Features/Business/Data/Models/ItemDetailsModel/itemdetail_model.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/Models/ItemModels/item_model.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/Models/SavedItemsModel/saveditem_model.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/Models/cart_model.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/Models/category_model.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/Models/citites_model.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/Models/membership_model.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/Models/subcategory_model.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Data/Models/SavedItemsModel/user_model.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/SavedItems/saveitem_entity.dart';
import 'package:flutter_application_ebay_ecom/Features/Business/Domain/Entities/user_entity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class Apidatasource {
  Future<List<ItemModel>> getItems(int count);
  Future<ItemDetailModel> getSingleItem(String id);
  Future<List<CategoryModel>> getCategories();
  Future<List<SubCategoryModel>> getSubCategories();
  Future<UserModel> getUser();
  Future<void> updateUser(UserEntity userEntity);
  Future<List<SavedItemEntity>> getSavedItems();
  Future<List<SavedItemEntity>> getRecentItems();

  Future<List<CitiesModel>> getCitites();
  Future<List<CartModel>> getCartItems();
  Future<void> removeCartItem(String id);
  Future<void> addCartItem(String id);

  Future<List<MembershipModel>> getAllMemberShips();
  Future<MembershipModel> getSingleMemberShips(String id);
}

class ApiDataSourceImpl extends Apidatasource {
  final SharedPreferences prefs;
  final http.Client httpClient;
  ApiDataSourceImpl({required this.httpClient, required this.prefs});

  @override
  Future<List<ItemModel>> getItems(int count) async {
    String itemsUrl = 'https://emarket.deliverers.uk/api/items';

    try {
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> itemsData = responseData['items']['data'];
        try {
          List<ItemModel> items =
              itemsData.map((item) => ItemModel.fromJson(item)).toList();

          return items;
        } catch (e) {
          throw Exception(e.toString());
        }
      } else {
        throw Exception("Error Occured");
      }
    } catch (e) {
      throw Exception("Error Occured");
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    String itemsUrl = 'https://emarket.deliverers.uk/api/categories';

    try {
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> itemsData = responseData['data'];
        List<CategoryModel> items =
            itemsData.map((item) => CategoryModel.fromJson(item)).toList();
        return items;
      } else {
        throw Exception("Error Occured");
      }
    } catch (e) {
      throw Exception("Error Occured");
    }
  }

  @override
  Future<List<SubCategoryModel>> getSubCategories() async {
    String itemsUrl = 'https://emarket.deliverers.uk/api/sub-categories';

    try {
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> itemsData = responseData['data'];
        List<SubCategoryModel> items =
            itemsData.map((item) => SubCategoryModel.fromJson(item)).toList();
        return items;
      } else {
        throw Exception("Error Occured");
      }
    } catch (e) {
      throw Exception("Error Occured");
    }
  }

  @override
  Future<UserModel> getUser() async {
    const String itemsUrl = 'https://emarket.deliverers.uk/api/profile';

    try {
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> userData = responseData;
        UserModel user = UserModel.fromJson(userData);
        return user;
      } else {
        throw Exception("Error Occurred");
      }
    } catch (e) {
      throw Exception("Error Occurred");
    }
  }

  @override
  Future<void> updateUser(UserEntity userEntity) async {
    const String updateUrl =
        'https://emarket.deliverers.uk/api/update-profile/{id}';

    try {
      final String? token = prefs.getString('token');

      final response = await http.put(
        Uri.parse(updateUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode((userEntity as UserModel).toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception("Error Occurred");
      }
    } catch (e) {
      throw Exception("Error Occurred");
    }
  }

  @override
  Future<List<CitiesModel>> getCitites() async {
    const String itemsUrl = 'https://emarket.deliverers.uk/api/cities';

    try {
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> itemsData = responseData['data'];
        List<CitiesModel> items =
            itemsData.map((item) => CitiesModel.fromJson(item)).toList();
        return items;
      } else {
        throw Exception("Error Occurred");
      }
    } catch (e) {
      throw Exception("Error Occurred");
    }
  }

  @override
  Future<List<SavedItemEntity>> getSavedItems() async {
    const String itemsUrl = 'https://emarket.deliverers.uk/api/my-saved-items';

    try {
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> itemsData = responseData['data'];
        List<SavedItemModel> items =
            itemsData.map((item) => SavedItemModel.fromJson(item)).toList();

        return items;
      } else {
        throw Exception("Error Occurred");
      }
    } catch (e) {
      throw Exception("Error Occurred");
    }
  }

  @override
  Future<List<SavedItemEntity>> getRecentItems() async {
    const String itemsUrl =
        'https://emarket.deliverers.uk/api/my-recently-viewed-items';

    try {
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> itemsData = responseData['data'];
        List<SavedItemModel> items =
            itemsData.map((item) => SavedItemModel.fromJson(item)).toList();

        return items;
      } else {
        throw Exception("Error Occurred");
      }
    } catch (e) {
      throw Exception("Error Occurred");
    }
  }

  @override
  Future<List<CartModel>> getCartItems() async {
    const String itemsUrl = 'https://emarket.deliverers.uk/api/carts';

    try {
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> itemsData = responseData['data'];
        List<CartModel> items =
            itemsData.map((item) => CartModel.fromJson(item)).toList();

        return items;
      } else {
        throw Exception("Error Occurred");
      }
    } catch (e) {
      throw Exception("Error Occurred");
    }
  }

  @override
  Future<List<MembershipModel>> getAllMemberShips() async {
    const String itemsUrl = 'https://emarket.deliverers.uk/api/memberships';

    try {
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> itemsData = responseData['data'];
        List<MembershipModel> items =
            itemsData.map((item) => MembershipModel.fromJson(item)).toList();

        return items;
      } else {
        throw Exception("Error Occurred");
      }
    } catch (e) {
      throw Exception("Error Occurred");
    }
  }

  @override
  Future<MembershipModel> getSingleMemberShips(String id) async {
    String itemsUrl = 'https://emarket.deliverers.uk/api/membership/$id';

    try {
      final String? token =
          prefs.getString('token'); // Ensure prefs is initialized

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> itemData = responseData['data'];
        MembershipModel item = MembershipModel.fromJson(itemData);

        return item;
      } else {
        throw Exception("Error Occurred: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error Occurred: $e");
    }
  }

  @override
  Future<ItemDetailModel> getSingleItem(String id) async {
    String itemsUrl = 'https://emarket.deliverers.uk/api/item/$id';

    try {
      final String? token =
          prefs.getString('token'); // Ensure prefs is initialized

      final response = await http.get(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> itemData = responseData['itemDetail'];

        // Assuming you have a method to parse the itemData into ItemDetailModel
        final itemDetailModel = ItemDetailModel.fromJson(itemData);

        // Return as a single-item list
        return itemDetailModel;
      } else {
        throw Exception("Error Occurred: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error Occurred: $e");
    }
  }

  @override
  Future<void> addCartItem(String id) async {
    String itemsUrl = 'https://emarket.deliverers.uk/api/add-to-cart/$id';

    try {
      final String? token =
          prefs.getString('token'); // Ensure prefs is initialized

      final response = await http.post(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception("Error Occurred: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error Occurred: $e");
    }
  }

  @override
  Future<void> removeCartItem(String id) async {
    String itemsUrl =
        'https://emarket.deliverers.uk/api/remove-item-from-cart/$id';

    try {
      final String? token = prefs.getString('token');

      final response = await http.post(
        Uri.parse(itemsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception("Error Occurred: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error Occurred: $e");
    }
  }
}

import 'package:burger_builder/models/dummy_data.dart';
import 'package:burger_builder/models/user_order_model.dart';
import 'package:flutter/foundation.dart';

class UserOrderProvider extends ChangeNotifier {
  UserOrderModel _myuserOrderModel = UserOrderModel(
      customer: "Final Day 30 days of flutter Sumith",
      userIngredients: [],
      totalPrice: 10);

  UserOrderModel get userOrderModel {
    return _myuserOrderModel;
  }

  bool get isEmptyIngredients {
    return _myuserOrderModel.userIngredients == null ||
        _myuserOrderModel.userIngredients.length == 0;
  }

  addIngredientHandler(String name) {
    var ingredient = dummyData.singleWhere((ing) => ing.name == name);

    final foundIngredient = _myuserOrderModel.userIngredients.singleWhere(
      (element) => element.ingredient.name == name,
      orElse: () => null,
    );
    if (foundIngredient == null) {
      _myuserOrderModel.userIngredients.add(
        UserSelectedIngredientModel(ingredient: ingredient, count: 1),
      );
    } else {
      foundIngredient.count++;
    }
    _myuserOrderModel.totalPrice =
        _myuserOrderModel.totalPrice + ingredient.price;
    notifyListeners();
  }

  removeIngredientHandler(String name) {
    final ingredient = dummyData.singleWhere((ing) => ing.name == name);

    final foundIngredient = _myuserOrderModel.userIngredients.singleWhere(
      (element) => element.ingredient.name == name,
      orElse: () => null,
    );
    if (foundIngredient != null) {
      foundIngredient.count--;
    }
    _myuserOrderModel.totalPrice =
        _myuserOrderModel.totalPrice - ingredient.price;
    _myuserOrderModel.userIngredients
        .removeWhere((element) => element.count == 0);
    notifyListeners();
  }

  void setDummyData() {
    _myuserOrderModel =
        UserOrderModel(customer: "sumith", userIngredients: [], totalPrice: 10);
  }
}

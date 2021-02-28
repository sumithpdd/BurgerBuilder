import 'package:burger_builder/models/ingredients_model.dart';

class UserOrderModel {
  final String customer;
  final List<UserSelectedIngredientModel> userIngredients;
  double totalPrice;
  UserOrderModel({this.customer, this.userIngredients, this.totalPrice});
}

class UserSelectedIngredientModel {
  IngredientsModel ingredient;
  int count;
  UserSelectedIngredientModel({this.ingredient, this.count});
}

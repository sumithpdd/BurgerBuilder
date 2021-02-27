import 'package:burger_builder/models/dummy_data.dart';
import 'package:burger_builder/models/user_order_model.dart';
import 'package:burger_builder/screens/burger.dart';
import 'package:burger_builder/widgets/app_drawer.dart';
import 'package:burger_builder/widgets/build_controls.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  UserOrderModel userOrderModel = UserOrderModel(
    customer: "sumith",
    userIngredients: List<UserSelectedIngredientModel>(),
    totalPrice: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/burger-logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text("Burger Builder"))
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () => _drawerKey.currentState.openDrawer(),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        Burger(
          userOrderModel: userOrderModel,
        ),
        BuildControls(
            userOrderModel: userOrderModel,
            addHandler: _addIngredientHandler,
            removeHandler: _removeIngredientHandler,
            ingredients: dummyData),
      ]),
    );
  }

  _addIngredientHandler(String name) {
    var ingredient = dummyData.singleWhere((ing) => ing.name == name);

    final foundIngredient = userOrderModel.userIngredients.singleWhere(
      (element) => element.ingredient.name == name,
      orElse: () => null,
    );
    if (foundIngredient == null) {
      setState(() {
        userOrderModel.userIngredients.add(
          UserSelectedIngredientModel(ingredient: ingredient, count: 1),
        );
      });
    } else {
      setState(() {
        foundIngredient.count++;
      });
    }
    setState(() {
      userOrderModel.totalPrice = userOrderModel.totalPrice + ingredient.price;
    });
  }

  _removeIngredientHandler(name) {
    final ingredient = dummyData.singleWhere((ing) => ing.name == name);

    final foundIngredient = userOrderModel.userIngredients.singleWhere(
      (element) => element.ingredient.name == name,
      orElse: () => null,
    );
    if (foundIngredient != null) {
      setState(() {
        foundIngredient.count--;
      });
    }
    setState(() {
      userOrderModel.totalPrice = userOrderModel.totalPrice - ingredient.price;
      userOrderModel.userIngredients
          .removeWhere((element) => element.count == 0);
    });
  }
}

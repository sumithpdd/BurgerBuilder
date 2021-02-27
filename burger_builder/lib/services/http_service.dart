import 'dart:convert';

import 'package:burger_builder/models/dummy_data.dart';
import 'package:burger_builder/models/ingredients_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static const Url = 'https://todo-flutter-8a80f.firebaseio.com';
  Future<List<IngredientsModel>> sendData() async {
    var body =
        json.encode(List<dynamic>.from(dummyData.map((x) => x.toJson())));

    final response = await http.put("$Url/burgeringredients.json", body: body);
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

    return new List<IngredientsModel>();
  }

  Future<List<IngredientsModel>> fetchTheIngredients() async {
    final response = await http.get("$Url/burgeringredients.json");

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

    return parsed
        .map<IngredientsModel>((json) => IngredientsModel.fromJson(json))
        .toList();
  }
}

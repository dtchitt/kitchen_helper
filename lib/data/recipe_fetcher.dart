import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kitchen_helper/models/recipe.dart';

Future<Recipe> getRandomRecipe() async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

  final json = jsonDecode(response.body);

  print('fetched image: $json');

  return Recipe(
    json['meals'][0]['strMeal'],
    json['meals'][0]['strInstructions'],
    json['meals'][0]['strMealThumb'],
  );
}

Future<List<Recipe>> getRandomRecipes(int count) async {
  return Future.wait(List.generate(count, (_) => getRandomRecipe()));
}

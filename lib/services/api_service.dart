import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../models/food_model.dart';
import '../models/recipe_model.dart';

class ApiService {
  Future<List<Category>> loadCategoryList() async {
    List<Category> categoryList = [];

    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['categories'];

      for (var i = 0; i < data.length; i++) {
        categoryList.add(Category.fromJson(data[i]));
      }
    }

    return categoryList;
  }

  Future<List<Food>> loadFoodList(String category) async {
    List<Food> foodList = [];

    final response = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category',
      ),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['meals'];

      for (var i = 0; i < data.length; i++) {
        foodList.add(Food.fromJson(data[i]));
      }
    }

    return foodList;
  }

  Future<List<Food>?> searchFood(String category, String query) async {
    List<Food> filteredFoodList = [];
    try {
      final response = await http.get(
        Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/search.php?s=$query',
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['meals'];

        for (var i = 0; i < data.length; i++) {
          if (data[i]['strCategory'] == category) {
            filteredFoodList.add(Food.fromJson(data[i]));
          }
        }

        return filteredFoodList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Recipe>> getRecipeById(String id) async {
    List<Recipe> recipe = [];
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['meals'][0];
      recipe.add(Recipe.fromJson(data));
      List<String> temp = [];
      for (var i = 1; i < 21; i++) {
        temp.add(data['strIngredient$i']);
      }
      recipe[0].instructions = temp.toString();
    }
    return recipe;
  }

  Future<Recipe?> getRecipeById2(String id) async {
    try{
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['meals'][0];
        return Recipe.fromJson(data);
      }
      return null;
    }
    catch (e){
      return null;
    }
  }

  Future<Recipe?> getRandomRecipe() async {
    try{
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['meals'][0];
        return Recipe.fromJson(data);
      }
      return null;
    }
    catch (e){
      return null;
    }
  }

}

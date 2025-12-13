import 'package:recipes_app/globals.dart';

import '../models/food_model.dart';

class FavoritesService {
  final List<Food> _favoriteFood = favoriteFood;

  List<Food> getFavoritesList(){
    return _favoriteFood;
  }

  void addById(Food food){
    if (!_favoriteFood.any((f) => f.id == food.id)){
      _favoriteFood.add(food);
    }
  }

  void deleteById(String id){
    Food delete = _favoriteFood.where((food) => food.id == id).toList()[0];
    _favoriteFood.remove(delete);
  }

}
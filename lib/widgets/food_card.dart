import 'package:flutter/material.dart';
import 'package:recipes_app/models/food_model.dart';
import 'package:recipes_app/screens/recipe.dart';
import 'package:recipes_app/services/favorites_service.dart';


class FoodCard extends StatefulWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  final FavoritesService _favoritesService = FavoritesService();
  late bool _isFavorite;
  late List<Food> favoriteFood = _favoritesService.getFavoritesList();

  @override
  void initState() {
    super.initState();
    favoriteFood.any((food) => food.id == widget.food.id) ? _isFavorite = true : _isFavorite = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipePage(widget.food.id),
                  ),
                );
              },
              child: Image.network(widget.food.image, fit: BoxFit.contain),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipePage(widget.food.id),
                  ),
                );
              },
              child: Text(
                widget.food.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.black54,
                ),
                onPressed: _toggleFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _isFavorite ? _favoritesService.addById(widget.food) : _favoritesService.deleteById(widget.food.id);

    });
  }
}

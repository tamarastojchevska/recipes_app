import 'package:flutter/material.dart';
import 'package:recipes_app/services/favorites_service.dart';
import 'package:recipes_app/widgets/food_grid_view.dart';
import '../models/food_model.dart';

class FavoritePage extends StatefulWidget {

  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoritesService _favoritesService = FavoritesService();
  late final List<Food> _food;
  List<Food> _filteredFood = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _food = _favoritesService.getFavoritesList();
    _filteredFood = _favoritesService.getFavoritesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.black45,
        foregroundColor: Colors.white,
        title: Text(
          "Favorites",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              cursorColor: Colors.black,
              controller: _searchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Search Favorites...',
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _filteredFood = _food;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                _searchFavorites(value);
              },
            ),
          ),
          Expanded(child: FoodGridView(food: _filteredFood)),
        ],
      ),
      backgroundColor: Colors.grey,
    );
  }


void _searchFavorites(String query) {
  setState(() {
    if (query.isEmpty) {
      _filteredFood = _food;
    } else {
      _filteredFood = _food
          .where(
            (food) => food.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  });
}
}

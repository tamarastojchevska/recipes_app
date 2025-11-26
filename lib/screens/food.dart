import 'package:flutter/material.dart';
import 'package:recipes_app/screens/recipe.dart';
import 'package:recipes_app/services/api_service.dart';
import 'package:recipes_app/widgets/food_grid_view.dart';
import '../models/food_model.dart';

class FoodPage extends StatefulWidget {
  final String category;

  const FoodPage({super.key, required this.category});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late final List<Food> _food;
  List<Food> _filteredFood = [];
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFoodList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.black45,
        foregroundColor: Colors.white,
        title: Text(
          widget.category,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.fastfood_outlined, color: Colors.white),
            tooltip: 'Random Recipe!',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipePage("")),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : //FoodGridView(food: _filteredFood),
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
                      hintText: 'Search Food...',
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
                      _searchFood(value);
                    },
                  ),
                ),
                Expanded(child: FoodGridView(food: _filteredFood)),
              ],
            ),
      backgroundColor: Colors.grey,
    );
  }

  void _loadFoodList() async {
    List<Food> foodList = await _apiService.loadFoodList(widget.category);

    setState(() {
      _food = foodList;
      _filteredFood = foodList;
      _isLoading = false;
    });
  }

  void _searchFood(String query) async {
    List<Food>? filteredFoodList = await _apiService.searchFood(
      widget.category,
      query,
    );

    setState(() {
      if (filteredFoodList != null) {
        _filteredFood = filteredFoodList;
        _isLoading = false;
      }
    });
  }
}

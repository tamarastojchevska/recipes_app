import 'package:flutter/material.dart';
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
        title: Text(
          widget.category,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : //FoodGridView(food: _filteredFood),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Food...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _filteredFood = _food;
                          });
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      _isLoading = true;
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

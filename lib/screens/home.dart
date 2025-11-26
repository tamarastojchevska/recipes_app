import 'package:flutter/material.dart';
import 'package:recipes_app/screens/recipe.dart';
import 'package:recipes_app/services/api_service.dart';
import 'package:recipes_app/widgets/category_list_view.dart';
import '../models/category_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final List<Category> _categories;
  List<Category> _filteredCategories = [];
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.black45,
        foregroundColor: Colors.white,
        title: Text(
          widget.title,
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
          : Column(
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
                      hintText: 'Search Category...',
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
                            _filteredCategories = _categories;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      _searchCategoryByName(value);
                    },
                  ),
                ),
                Expanded(
                  child: CategoriesListView(categories: _filteredCategories),
                ),
              ],
            ),
      backgroundColor: Colors.grey,
    );
  }

  void _loadCategoryList() async {
    List<Category> categoryList = await _apiService.loadCategoryList();

    setState(() {
      _categories = categoryList;
      _filteredCategories = categoryList;
      _isLoading = false;
    });
  }

  void _searchCategoryByName(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where(
              (category) =>
                  category.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }
}

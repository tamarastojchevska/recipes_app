import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/recipe_model.dart';
import '../services/api_service.dart';

import 'package:url_launcher/url_launcher.dart';

class RecipePage extends StatefulWidget {
  final String recipeId;

  const RecipePage(this.recipeId, {super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late final Recipe _recipe;
  late final List<String> _ingredients;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadRecipeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.black45,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Image.network(_recipe.image, fit: BoxFit.contain),
                        SizedBox(height: 16),
                        Text(
                          _recipe.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Watch the recipe on YouTube ',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(Uri.parse(_recipe.youtube));
                                  },
                              ),
                            ),
                            Icon(
                              Icons.open_in_new,
                              color: Colors.blue,
                              size: 14,
                            ),
                          ],
                        ),
                        Divider(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ingredients:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _ingredients.length,
                            itemBuilder: (context, index) {
                              return Expanded(
                                child: Text('\u2022 ${_ingredients[index]}'),
                              );
                            },
                          ),
                        ),
                        Divider(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Instructions:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(_recipe.instructions),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _loadRecipeDetails() async {
    final Recipe? recipe;
    if (widget.recipeId.isEmpty) {
      recipe = await _apiService.getRandomRecipe();
    } else {
      recipe = await _apiService.getRecipeById(widget.recipeId);
    }
    List<String> ingredients = [];
    if (recipe != null) {
      ingredients = recipe.ingredients
          .split(',')
          .where((item) => item.trim().isNotEmpty)
          .toList();
    }

    setState(() {
      if (recipe != null) {
        _recipe = recipe;
        _isLoading = false;
        _ingredients = ingredients;
      }
    });
  }
}

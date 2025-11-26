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
      ),
      backgroundColor: Colors.grey,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Image.network(_recipe.image, fit: BoxFit.contain),
                        SizedBox(height: 20),
                        Text(
                          _recipe.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            text: 'Watch the recipe on Youtube!',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(_recipe.youtube));
                              },
                          ),
                        ),
                        Divider(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ingredients:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _ingredients.length,
                          itemBuilder: (context, index) {
                            return Text(_ingredients[index]);
                          },
                        ),
                        Divider(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Instructions:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(_recipe.instructions),
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
      recipe = await _apiService.getRecipeById2(widget.recipeId);
    }
    List<String> ingredients = [];
    if (recipe != null) {
      ingredients = recipe.ingredients
          .split(',')
          .where((item) => item.isNotEmpty)
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

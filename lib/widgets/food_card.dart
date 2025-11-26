import 'package:flutter/material.dart';
import 'package:recipes_app/models/food_model.dart';
import 'package:recipes_app/screens/recipe.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipePage(food.id),
            ),
        );
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Image.network(food.image, fit: BoxFit.contain),
              SizedBox(height: 20),
              Text(
                food.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

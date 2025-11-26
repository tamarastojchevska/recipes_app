import 'package:flutter/material.dart';
import 'package:recipes_app/models/category_model.dart';
import 'package:recipes_app/screens/food.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodPage(category: category.name),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Image.network(category.image, fit: BoxFit.contain),
              SizedBox(height: 20),
              Text(
                category.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(category.description),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipes_app/models/food_model.dart';
import 'package:dynamic_height_list_view/dynamic_height_view.dart';
import 'package:recipes_app/widgets/food_card.dart';

class FoodGridView extends StatefulWidget {
  final List<Food> food;

  const FoodGridView({super.key, required this.food});

  @override
  State<StatefulWidget> createState() => _FoodGridViewState();
}

class _FoodGridViewState extends State<FoodGridView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: DynamicHeightGridView(
        itemCount: widget.food.length,
        builder: (context, index) {
          return FoodCard(food: widget.food[index]);
        },
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
    );
  }
}

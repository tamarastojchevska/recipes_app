import 'package:flutter/material.dart';
import 'package:recipes_app/models/category_model.dart';
import 'package:recipes_app/widgets/category_card.dart';

class CategoriesListView extends StatefulWidget {
  final List<Category> categories;

  const CategoriesListView({super.key, required this.categories});

  @override
  State<StatefulWidget> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemCount: widget.categories.length,
      separatorBuilder: (BuildContext context, int index) {
      return SizedBox(height: 24);
    },
      itemBuilder: (context, index) {
        return CategoryCard(category: widget.categories[index]);
      },
    );

  }
}

import 'package:demo_project_mohit/project_five/screens/meals_screen.dart';
import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../model/categories.dart';
import '../model/meal.dart';
import '../widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function(Meal meal) onToggleFavorite;
  const CategoriesScreen({super.key,required this.onToggleFavorite});

  void _selectCategory(BuildContext context,Categories category){
    final filteredMeals = dummyMeals.where((meal){
      return meal.categories.contains(category.id);
    }).toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealsScreen(
             title: category.title,
             meals: filteredMeals,
             onToggleFavorite: onToggleFavorite,
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:  2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: availableCategories.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryGridItem(
            category: availableCategories[index], onSelectCategory: (){
            _selectCategory(context,availableCategories[index]);
          },
          );
        },
    );
  }
}

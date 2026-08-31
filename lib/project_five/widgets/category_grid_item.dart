import 'package:demo_project_mohit/custom_widget/custom_gradient.dart';
import 'package:demo_project_mohit/project_five/model/categories.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  final void Function() onSelectCategory;
  final Categories category;
  const CategoryGridItem({super.key,required this.category,required this.onSelectCategory});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      // splashColor: Theme.of(context).hoverColor,
      // splashColor: category.color.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration:  BoxDecoration(
           borderRadius: BorderRadius.circular(16),
           gradient: CustomGradient(
             colors: [
             category.color.withOpacity(0.55),
             category.color.withOpacity(0.9),
           ],
           begin: Alignment.topLeft,
           end: Alignment.bottomRight
           ).gradient,
        ),
        child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        ),
      ),
    );
  }
}

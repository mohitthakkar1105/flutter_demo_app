import 'package:demo_project_mohit/project_five/model/meal.dart';
import 'package:demo_project_mohit/project_five/screens/meal_details.dart';
import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;
  const MealsScreen({super.key,this.title,required this.meals,required this.onToggleFavorite});

  void selectMeal(BuildContext context,Meal meal){
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MealDetails(meal: meal, onToggleFavorite: onToggleFavorite!,)));
  }
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (BuildContext context, int index) {
        return MealItem(meal: meals[index],onSelect: selectMeal,);
      },
    );
    if(meals.isEmpty){
      content =  Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text('uh oh ... nothing here! ',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
            ),),
            const SizedBox(height: 16,),
             Text(
              'try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              ),
            ),
          ],
        ),
      );
    }

    if(title == null){
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}

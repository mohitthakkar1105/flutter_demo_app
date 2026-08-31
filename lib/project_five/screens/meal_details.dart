import 'package:flutter/material.dart';

import '../model/meal.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;
  const MealDetails({
    super.key,required this.meal,
    required this.onToggleFavorite
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: (){
                onToggleFavorite(meal);
              },
              icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14,),
            Text(
              'Ingredient',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 14,),
            for(final ingrident in meal.ingredients)
              Text(
               ingrident,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
            const SizedBox(height: 14,),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 14,),
            for(final step in meal.steps)
              Text(
                step,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
          ],
        ),
      ),
    );
  }
}

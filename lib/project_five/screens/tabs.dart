import 'package:flutter/material.dart';

import '../../custom_widget/custom_snackbar.dart';
import '../../custom_widget/main_drawer.dart';
import '../model/meal.dart';
import 'categories_screen.dart';
import 'meals_screen.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedPageIndex = 0;
  late Widget activePage = CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus,);
  String activePageTitle = 'Categories';
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message){
    AppSnackBar.show(
        context,
        content: Text(message),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal){
    final isExisting = _favoriteMeals.contains(meal);
    if(isExisting){
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage("meal is no longer a favorite");
    }else{
      setState(() {
        print("state chaneg hau");
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("meal is now a favorite");
    }
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier){
    if(identifier=="Meals"){
      Navigator.pop(context);
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    if(_selectedPageIndex==1){
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    }else{
      activePage = CategoriesScreen(
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Categories';
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories'
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favorites'
            ),
          ]
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget{
  const CategoriesScreen ({required this.availableMeals,super.key});
  final List<Meal> availableMeals;
  @override
  State<CategoriesScreen> createState() {
   return _CategoriesScreenState();
  }}
  class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
   late AnimationController _animationController;
  @override
  void initState() {
   super.initState();
   _animationController=AnimationController(
       vsync: this,
   duration: const Duration(milliseconds: 300),
   lowerBound: 0,
   upperBound: 1);
   _animationController.forward();
  }
  @override
  void dispose() {
   _animationController.dispose();
    super.dispose();
  }
  void _selectCategory(BuildContext context, Category category){
  final filteredList =widget.availableMeals.where((meal)=> meal.categories.contains(category.id)).toList();
  Navigator.push(context, MaterialPageRoute(builder: (ctx)=> MealsScreen(title:category.title,meals: filteredList)));

  }


  @override
  Widget build(BuildContext context) {
  return AnimatedBuilder(animation: _animationController,
    child: GridView(
      padding: EdgeInsets.all(20)
      ,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
    ) ,
      children: [
        for(final category in availableCategories )
          CategoryGridItem(category,(){
            _selectCategory(context,category);
          })
      ],

    ),
    builder:(context,child) => SlideTransition(position:
    Tween(
      begin:const Offset(0,0.3) ,
    end:const Offset(0,0)
  ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut))
     ,child: child));
  }

  }


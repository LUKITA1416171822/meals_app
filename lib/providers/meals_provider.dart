import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dummy_data.dart';
final mealsProvider=Provider(
    (ref){
      return dummyMeals;
    }
    );
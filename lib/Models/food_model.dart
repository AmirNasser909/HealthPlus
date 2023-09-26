import 'package:flutter/material.dart';

class FoodItem {
  final int foodItemId;
  final String foodItemTitle;
  final String foodItemCaloreis;

  FoodItem(
      {@required this.foodItemId,
      @required this.foodItemTitle,
      @required this.foodItemCaloreis});
}

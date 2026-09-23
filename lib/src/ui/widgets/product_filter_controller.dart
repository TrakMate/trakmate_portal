import 'package:flutter/foundation.dart';

class ProductFilterController {
  static final ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(
    null,
  );

  static void select(String category) {
    selectedCategory.value = category;
  }

  static void clear() {
    selectedCategory.value = null;
  }
}

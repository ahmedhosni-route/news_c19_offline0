import 'package:flutter/material.dart';

import '../../../../core/category/app_category.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/category_widget.dart';

class HomeScreen extends StatelessWidget {
  Function(AppCategory category) onTap;
   HomeScreen({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "Good Morning\nHere is Some News For You",
            style: TextStyle(fontSize: 24, color: AppColors.white),
          ),

          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onTap(AppCategory.categories[index]);
                  },
                  child: CategoryWidget(
                    category: AppCategory.categories[index],
                    isLeft: index % 2 == 0,
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: AppCategory.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}

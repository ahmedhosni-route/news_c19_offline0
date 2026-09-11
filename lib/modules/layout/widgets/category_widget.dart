import 'package:flutter/material.dart';
import 'package:news_c19_offline/core/category/app_category.dart';

import '../../../core/theme/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  AppCategory category;
  bool isLeft;
  CategoryWidget({super.key, required this.category, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        textDirection: isLeft ? TextDirection.ltr : TextDirection.rtl,
        children: [
          Image.asset(category.image,fit: BoxFit.cover,width: 180,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(category.title, style: TextStyle(fontSize: 24)),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(360),
                  ),
                  child: Row(
                    textDirection: isLeft
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.black,
                        foregroundColor: AppColors.white,
                        child: Icon(
                          isLeft
                              ? Icons.arrow_forward_ios_outlined
                              : Icons.arrow_back_ios_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_c19_offline/modules/layout/api_manager/models/news_response.dart';

import '../../../core/theme/app_colors.dart';

class NewsWidget extends StatelessWidget {
  Articles article;
   NewsWidget({super.key, required this. article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.white)
      ),
      child: Column(
        children: [
          Image.network(article.urlToImage??""),
          SizedBox(height: 8,),

          Text(article.title??"",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.white
          ),),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("By :${article.author??""}",style: TextStyle(color: Colors.grey),),
              Text(DateTime.parse(article.publishedAt??"").timeAgo(),style: TextStyle(color: Colors.grey),)
            ],
          )
        ],
      ),
    );
  }
}




extension DateTimeExtension on DateTime {


  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }


}

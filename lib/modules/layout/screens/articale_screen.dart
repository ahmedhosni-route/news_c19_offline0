import 'package:flutter/material.dart';
import 'package:news_c19_offline/core/category/app_category.dart';
import 'package:news_c19_offline/modules/layout/api_manager/api_manager.dart';
import 'package:news_c19_offline/modules/layout/api_manager/models/news_response.dart';
import 'package:news_c19_offline/modules/layout/widgets/news_widget.dart';

import '../../../core/theme/app_colors.dart';
import '../api_manager/models/source_response.dart';

class ArticleScreen extends StatefulWidget {
  AppCategory category;
  ArticleScreen({super.key, required this.category});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  Sources? source;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: ApiManager.getSources(widget.category.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var sources = snapshot.data;
              source ??= sources?.first;
              return Expanded(
                child: Column(
                  children: [
                    DefaultTabController(
                      length: sources?.length ?? 0,
                      child: TabBar(
                        onTap: (value) {
                          source = sources![value];
                          setState(() {});
                        },
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        labelColor: AppColors.white,
                        dividerColor: Colors.transparent,
                        unselectedLabelColor: AppColors.white,
                        indicatorColor: AppColors.white,
                        labelStyle: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        unselectedLabelStyle: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                        tabs: (sources ?? []).map((e) {
                          return Tab(text: e.name ?? "");
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: ApiManager.getNews(source!.id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else {
                            List<Articles> articles = snapshot.data ?? [];
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                return NewsWidget(article: articles[index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 8);
                              },
                              itemCount: articles.length,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: AppColors.white),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}

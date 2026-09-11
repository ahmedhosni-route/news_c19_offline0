import 'package:flutter/material.dart';
import 'package:news_c19_offline/core/category/app_category.dart';
import 'package:news_c19_offline/modules/layout/viewmodel/layout_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/news_widget.dart';

class ArticleScreen extends StatefulWidget {
  AppCategory category;
  ArticleScreen({super.key, required this.category});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LayoutProvider>(context, listen: false).getSources();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  switch (provider.sourceState) {
                    // TODO: Handle this case.
                    ProviderState.loading => Center(
                      child: CircularProgressIndicator(),
                    ),
                    // TODO: Handle this case.
                    ProviderState.success => DefaultTabController(
                      length: provider.sources.length ?? 0,
                      child: TabBar(
                        onTap: provider.selectSource,
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
                        tabs: (provider.sources).map((e) {
                          return Tab(text: e.name ?? "");
                        }).toList(),
                      ),
                    ),

                    // TODO: Handle this case.
                    ProviderState.error => Text(
                      "error",
                      style: TextStyle(color: Colors.white),
                    ),
                  },

                  switch (provider.newsState) {
                    ProviderState.loading => Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    ProviderState.success => Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return NewsWidget(article: provider.articles[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8);
                        },
                        itemCount: provider.articles.length,
                      ),
                    ),
                    ProviderState.error => Text(
                      "error",
                      style: TextStyle(color: Colors.white),
                    ),
                  },
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

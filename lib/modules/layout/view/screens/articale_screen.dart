import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c19_offline/core/category/app_category.dart';
import 'package:news_c19_offline/modules/layout/cubit/layout_cubit.dart';
import 'package:news_c19_offline/modules/layout/cubit/layout_state.dart';

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
      BlocProvider.of<LayoutCubit>(context, listen: false).getSources();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              BlocConsumer<LayoutCubit, LayoutState>(
                listener: (context, state) {
                  if (state is GetSourcesSuccessState) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container();
                      },
                    );
                  }
                },

                builder: (context, state) {
                  var cubit = BlocProvider.of<LayoutCubit>(context);
                  return state is GetSourcesLoadingState
                      ? Center(child: CircularProgressIndicator())
                      : state is GetSourcesSuccessState
                      ? DefaultTabController(
                          length: cubit.sources.length ?? 0,
                          child: TabBar(
                            onTap: cubit.selectSource,
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
                            tabs: (cubit.sources).map((e) {
                              return Tab(text: e.name ?? "");
                            }).toList(),
                          ),
                        )
                      : Center(
                          child: Text(
                            state is GetSourcesErrorState ? state.error : "",
                          ),
                        );
                },

                buildWhen: (previous, current) {
                  return current is GetSourcesErrorState ||
                      current is GetSourcesSuccessState ||
                      current is GetSourcesLoadingState;
                },
              ),
              Expanded(
                child: BlocBuilder<LayoutCubit, LayoutState>(
                  builder: (context, state) {
                    var cubit = BlocProvider.of<LayoutCubit>(context);
                    return Column(
                      children: [
                        if (state is GetNewsLoadingState)
                          Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        if (state is GetNewsSuccessState)
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return NewsWidget(
                                  article: state.articles[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 8);
                              },
                              itemCount: state.articles.length,
                            ),
                          ),
                        if (state is GetNewsErrorState)
                          Text(
                            state.error,
                            style: TextStyle(color: Colors.white),
                          ),
                      ],
                    );
                  },
                  buildWhen: (previous, current) {
                    return current is GetNewsErrorState ||
                        current is GetNewsSuccessState ||
                        current is GetSourcesLoadingState;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c19_offline/core/theme/app_colors.dart';
import 'package:news_c19_offline/modules/layout/cubit/layout_cubit.dart';
import 'package:news_c19_offline/modules/layout/cubit/layout_state.dart';

import 'articale_screen.dart';
import 'home_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LayoutCubit>(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<LayoutCubit>(context);
          return Scaffold(
            backgroundColor: AppColors.black,
            appBar: AppBar(
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.black,
              centerTitle: true,
              actions: [Icon(Icons.search)],
              title: Text(cubit.selectedCategory?.title ?? "Home"),
            ),
            drawer: Drawer(
              backgroundColor: AppColors.black,
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: AppColors.white),
                    child: Center(
                      child: Text(
                        "News App",
                        style: TextStyle(fontSize: 30, color: AppColors.black),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.backToHome();
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.home, size: 40, color: AppColors.white),
                        Text(
                          "Back To home",
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: cubit.selectedCategory == null
                ? HomeScreen(
              onTap: cubit.selectCategory,
            )
                : ArticleScreen(
              category: cubit.selectedCategory!,
            ),
          );
        },
      ),
    );
  }
}

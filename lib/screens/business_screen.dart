import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';

import '../layout/news_app/cubit/news_app_cubit.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAppCubit, NewsAppState>(
      builder: (context, state) {
        var list =NewsAppCubit.get(context).business;

        return articleBuilder(list,context);
      },
    );
  }
}
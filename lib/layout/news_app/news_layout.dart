import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/app_cubit.dart';

import 'cubit/news_app_cubit.dart';
import 'package:news_app/screens/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsAppCubit, NewsAppState>(
        builder: (context, state) {
          var cubit= NewsAppCubit.get(context);
  
          return Scaffold(
            appBar: AppBar(
              title: const Text('News App'),
              actions: [
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> SearchScreen()));
                  }, 
                  icon: const Icon(Icons.search)
                  ),
                IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
                  }, 
                  icon: const Icon(Icons.brightness_4_outlined)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
      
    );
  }
}

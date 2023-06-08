import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/network/dio_helper.dart';

import '../../../screens/business_screen.dart';
import '../../../screens/science_screen.dart';
import '../../../screens/sports_screen.dart';

part 'news_app_state.dart';

class NewsAppCubit extends Cubit<NewsAppState> {
  NewsAppCubit() : super(NewsAppInitialState());

  static NewsAppCubit get(context)=> BlocProvider.of(context);

  int currentIndex =0;

  List<BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'Business'
      ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball_rounded),
      label: 'Sports'
      ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science'
      ),
  ];

  List<Widget> screens=[
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  void changeBottomNavBar(int index){
    currentIndex=index;
    if(index==1){
      getSportsData();
    }
    if(index==2){
      getScienceData();
    }
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business=[];

  void getBusinessData(){
    emit(NewsBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }
    ).then((value) {
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessfulState());
    }).catchError((error){
      print(error.toString());
      emit(NewsBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports=[];
  void getSportsData(){
    emit(NewsSportsLoadingState());

    if(sports.length==0){
      DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }
    ).then((value) {
      sports=value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessfulState());
    }).catchError((error){
      print(error.toString());
      emit(NewsSortsErrorState(error.toString()));
    });
  }else{
    emit(NewsGetSportsSuccessfulState());
  }
    
  }

  List<dynamic> science=[];

  void getScienceData(){
    emit(NewsScienceLoadingState());

    if(science.length==0){
      DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }
    ).then((value) {
      science=value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessfulState());
    }).catchError((error){
      print(error.toString());
      emit(NewsScienceErrorState(error.toString()));
    });
    }
    else{
      emit(NewsGetScienceSuccessfulState());
    }
    
  }
  List<dynamic> search=[];

  void getSearch(String value){
    emit(NewsSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything', 
      query: {
        'q': value,
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      }
      ).then((value) {
        search=value.data['articles'];
        print(search[0]['title']);
        emit(NewsGetSearchSuccessfulState());
      }).catchError((error){
        print(error.toString());
        emit(NewsSearchErrorState(error.toString()));
      });
  }
  
}

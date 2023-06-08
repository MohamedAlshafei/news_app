part of 'news_app_cubit.dart';

@immutable
abstract class NewsAppState {}

class NewsAppInitialState extends NewsAppState {}

class NewsBottomNavBarState extends NewsAppState{}
class NewsBusinessLoadingState extends NewsAppState{}
class NewsGetBusinessSuccessfulState extends NewsAppState{}
class NewsBusinessErrorState extends NewsAppState{
  final String error;
  NewsBusinessErrorState(this.error);
}

class NewsSportsLoadingState extends NewsAppState{}
class NewsGetSportsSuccessfulState extends NewsAppState{}
class NewsSortsErrorState extends NewsAppState{
  final String error;
  NewsSortsErrorState(this.error);
}

class NewsScienceLoadingState extends NewsAppState{}
class NewsGetScienceSuccessfulState extends NewsAppState{}
class NewsScienceErrorState extends NewsAppState{
  final String error;
  NewsScienceErrorState(this.error);
}


class NewsSearchLoadingState extends NewsAppState{}
class NewsGetSearchSuccessfulState extends NewsAppState{}
class NewsSearchErrorState extends NewsAppState{
  final String error;
  NewsSearchErrorState(this.error);
}
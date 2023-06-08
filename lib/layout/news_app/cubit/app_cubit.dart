import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/local/cache_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool isDark=false;
  void changeAppMode({bool? fromShared}){
    
    if(fromShared != null){
      isDark=fromShared;
      emit(NewsAppChangeModeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.putData(
      key: 'isDark',
      value: isDark,
    ).then((value) {
      emit(NewsAppChangeModeState());
    });

    }
    
    
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/news_app/cubit/app_cubit.dart';
import 'layout/news_app/cubit/bloc_observer.dart';
import 'layout/news_app/cubit/news_app_cubit.dart';
import 'layout/news_app/news_layout.dart';
import 'local/cache_helper.dart';
import 'network/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark=CacheHelper.getData(key: 'isDark');

  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
  MyApp(this.isDark);
  final bool? isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsAppCubit()..getBusinessData() ),
        BlocProvider(create: (context) => AppCubit()..changeAppMode(fromShared: isDark))
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {

          var cubit = AppCubit.get(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.black, size: 30),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey),
              // is not restarted.
              primarySwatch: Colors.deepOrange,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                backgroundColor: HexColor('333739'),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light),
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                iconTheme: const IconThemeData(color: Colors.white, size: 30),
                elevation: 0.0,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey),
              // is not restarted.
              primarySwatch: Colors.deepOrange,
            ),
            themeMode: AppCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
            // themeMode: ThemeMode.light,
            
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}

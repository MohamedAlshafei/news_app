
// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article,context){

  return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                onError: (exception, stackTrace){
                  print('onError');
                  print('Exception: $exception');
                  print('Stack Trace:\n$stackTrace');
                } ,
                image: const NetworkImage('https://g.foolcdn.com/editorial/images/723061/2022-rivian-r1t-16.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                      color: Colors.grey,
                      
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
}

Widget articleBuilder(list, context,{isSearch=false}){
  return ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: (context)=> ListView.separated(
            physics:const BouncingScrollPhysics(),
            itemBuilder: (context,index)=> buildArticleItem(list[index],context),
            separatorBuilder: (context,index){
              return Container(
                width: double.infinity,
                height: 1,
                margin:const EdgeInsets.all(20.0),
                color: const Color.fromARGB(255, 220, 216, 216),
              );
            },
            itemCount: list.length,
          ),
          fallback: (context) => isSearch? Container() : const Center(child: CircularProgressIndicator()),
        );
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/model/SearchModel.dart';
import 'package:shop_app/shared/cubit/search%20cubit/search_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../network/remote/endpoint.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? model;
  void search(String text ,String token){
    emit(SearchLoadingState());
    try{
      DioHelper.post_data(url: SEARCH, data: {"text":text}).then((value){
        model = SearchModel.fromJson(value.data);
        emit(SearchSuccessState(model!));
      }).catchError((onError){
        emit(SearchErrorState());
      });
    }on Exception catch(e){
      emit(SearchErrorState());
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
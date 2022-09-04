import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/model/LoginResponse.dart';
import 'package:shop_app/shared/cubit/login%20cubit/login_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/endpoint.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  bool isObscured = false;
  void obscurePassword(){
    isObscured = !isObscured;
    emit(LoginObscuredState());
  }
  void loginUser(String email , String password){
    emit(LoginLoadingState());
    try{
      print("try");
      DioHelper.post_data(url: LOGIN, data: {
        "email":email,
        "password":password
      }).then((value){
        LoginResponse data = LoginResponse.fromJson(value.data);
        emit(LoginSuccessState(data));
      }).catchError((onError){
        print(onError);
        emit(LoginErrorState(onError.toString()));
      });
    }on DioError catch(e){
      print(e);
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(LoginErrorState(onError.toString()));
    }
  }
}
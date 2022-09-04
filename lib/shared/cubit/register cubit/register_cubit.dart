import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/model/LoginResponse.dart';
import 'package:shop_app/shared/cubit/register%20cubit/register_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/endpoint.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool isPasswordObscured = false;
  bool isConfirmPasswordObscured = false;

  void ObscurePassword(){
    isPasswordObscured = !isPasswordObscured;
    emit(RegisterObscuredPasswordState());
  }
  void ObscureConfirmPassword(){
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    emit(RegisterObscuredConfirmPasswordState());
  }
  LoginResponse? registerResponse;
  void Register(String email , String password , String name , String phone){
    emit(RegisterLoadingState());
    try{
      DioHelper.post_data(url: REGISTER, data: {
        "name":name,
        "email":email,
        "password":password,
        "phone":phone
      }).then((value){
        registerResponse = LoginResponse.fromJson(value.data);
        emit(RegisterSuccessState(registerData: registerResponse!));
      }).catchError((onError){
        emit(RegisterErrorState(onError));
      });
    }on Exception catch(e){
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/model/LoginResponse.dart';
import 'package:shop_app/shared/cubit/profile%20cubit/profile_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/endpoint.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit():super(ProfileInitialState());
  static ProfileCubit get(context)=>BlocProvider.of(context);
  LoginResponse? profileResponse = null;
  void getProfile(String token){
    emit(ProfileLoadingState());
    try{
      DioHelper.getData(url: PROFILE,token: token).then((value){
        profileResponse = LoginResponse.fromJson(value.data);
        print(profileResponse!.data!.phone);
        emit(ProfileSuccessState(profile: profileResponse!));
      }).catchError((onError){
        emit(ProfileErrorState());
      });
    }on Exception catch(e){
      emit(ProfileErrorState());
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
          timeInSecForIosWeb: 5
      );
    }
  }
  bool isPhoneVerified = true;
  void changePhoneVerification(){
    isPhoneVerified = !isPhoneVerified;
    emit(ProfileVerifyPhone());
  }
  void updateProfile(String token , String email , String name , String phone){
    emit(ProfileLoadingState());
    try{
      DioHelper.put_data(url: PROFILE,token: token, data: {
        "name":name,
        "email":email,
        "phone":phone
      }).then((value){
        profileResponse = LoginResponse.fromJson(value.data);
        print(profileResponse!.data!.phone);
        emit(ProfileSuccessState(profile: profileResponse!));
      }).catchError((onError){
        emit(ProfileErrorState());
      });
    }on Exception catch(e){
      emit(ProfileErrorState());
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
          timeInSecForIosWeb: 5
      );
    }
  }
}
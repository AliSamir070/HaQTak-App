import 'package:shop_app/module/login/login_screen.dart';

import '../../../model/Data.dart';
import '../../../model/LoginResponse.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginResponse loginData;
  LoginSuccessState(this.loginData);
}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error){
    print("Error: $error");
  }
}
class LoginObscuredState extends LoginStates{}
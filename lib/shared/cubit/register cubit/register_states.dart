import '../../../model/LoginResponse.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final LoginResponse registerData;
  RegisterSuccessState({required this.registerData});
}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);
}
class RegisterObscuredPasswordState extends RegisterStates{}
class RegisterObscuredConfirmPasswordState extends RegisterStates{}
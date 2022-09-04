import '../../../model/LoginResponse.dart';

abstract class ProfileStates{}
class ProfileInitialState extends ProfileStates{}
class ProfileSuccessState extends ProfileStates{
  final LoginResponse profile;
  ProfileSuccessState({required this.profile});
}
class ProfileLoadingState extends ProfileStates{}
class ProfileErrorState extends ProfileStates{}
class ProfileVerifyPhone extends ProfileStates{}
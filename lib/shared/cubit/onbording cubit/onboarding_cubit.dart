import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/onbording%20cubit/states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates>{
  OnBoardingCubit():super(OnBoardingInitialState());
  static OnBoardingCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  void changePageIndex(int newIndex){
    currentIndex = newIndex;
    emit(OnBoardingChangePageState());
  }
}
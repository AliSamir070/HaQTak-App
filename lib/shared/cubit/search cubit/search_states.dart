import 'package:shop_app/model/SearchModel.dart';

abstract class SearchStates{}
class SearchInitialState extends SearchStates{}
class SearchLoadingState extends SearchStates{}
class SearchSuccessState extends SearchStates{
  final SearchModel model;
  SearchSuccessState(this.model);
}
class SearchErrorState extends SearchStates{}
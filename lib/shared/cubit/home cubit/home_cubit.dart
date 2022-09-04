import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/model/AddFavoriteModel.dart';
import 'package:shop_app/model/FavoritesModel.dart';
import 'package:shop_app/model/GetCategoryResponse.dart';
import 'package:shop_app/model/HomeResponse.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/endpoint.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitialState());
  static HomeCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;

  void setBottomNavitem(int index){
    currentIndex = index;
    emit(HomeBottomNavState());
  }
  HomeResponse? homeResponse = null;
  Map<int,bool> favorites = {};
  void addProductToFavorite(String token , int productId){
    favorites[productId] = !favorites[productId]!;
    emit(HomeAddFavoritesSuccessState());
    try{
      DioHelper.post_data(url: FAVORITES, data: {"product_id":productId},token: token).then((value){
        AddFavoriteModel response = AddFavoriteModel.fromJson(value.data);
        if(!response.status!){
          favorites[productId] = !favorites[productId]!;
        }else{
          getFavorites(token);
        }
        Fluttertoast.showToast(
            msg: response.message??"",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
        emit(HomeAddFavoritesSuccessState());
      }).catchError((onError){
        favorites[productId] = !favorites[productId]!;
        emit(HomeAddFavoritesErrorState());
      });
    }on Exception catch(e){
      emit(HomeAddFavoritesErrorState());
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
  void getProducts(String token){
    emit(HomeProductsLoadingState());
    print(token);
    try{
      DioHelper.getData(url: HOME,token: token).then((value){
        homeResponse = HomeResponse.fromJson(value.data);
        print(homeResponse?.homedata?.products?[0].name);
        homeResponse!.homedata!.products!.forEach((element) {
          favorites.addAll(
            {
              element.id!:element.inFavorites!
            }
          );
        });
        print(favorites);
        emit(HomeProductsSuccessState());
      }).catchError((onError){
        print("Error: ${onError}");
        emit(HomeProductsErrorState());
      });

    }on DioError catch (e){
      emit(HomeProductsErrorState());
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
          timeInSecForIosWeb: 5,
      );
    }
  }
  GetCategoryResponse? categoryResponse = null;
  FavoritesModel? favoritesResponse = null;
  void getFavorites(String token){
    emit(HomeFavoritesLoadingState());
    try{
      DioHelper.getData(url: FAVORITES,token: token).then((value){
        favoritesResponse = FavoritesModel.fromJson(value.data);
        emit(HomeFavoritesSuccessState());
      }).catchError((onError){
        emit(HomeFavoritesErrorState());
      });
    }on Exception catch(e){
      emit(HomeFavoritesErrorState());
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

  void getCategories(){
    try{
      DioHelper.getCategories(url: GET_CATEGORY).then((value){
        categoryResponse = GetCategoryResponse.fromJson(value.data);
        print(categoryResponse!.data2!.categoryData![0].name);
        emit(HomeCategoriesSuccessState());
      }).catchError((e){
        emit(HomeCategoriesErrorState());
      });
    }on Exception catch(e){
      emit(HomeCategoriesErrorState());
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
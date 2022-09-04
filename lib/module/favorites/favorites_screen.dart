import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_cubit.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_states.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        builder: (context , state){
          HomeCubit temp = HomeCubit.get(context);
          return state is HomeFavoritesLoadingState?Center(child: CircularProgressIndicator(color: Theme.of(context).canvasColor,),)
              :Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                itemBuilder: (context,index)=>FavoriteItem(product: temp.favoritesResponse!.favouritesData!.data3![index].favouritesProduct!),
                separatorBuilder: (context,index)=>Container(
                  color: Colors.grey[300],
                  height: 2,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                ),
                itemCount:  temp.favoritesResponse!.favouritesData!.data3!.length
          ),
              );
        },
        listener: (context , state){

        }
    );
  }
}

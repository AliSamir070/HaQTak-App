import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_cubit.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_states.dart';

import '../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      builder: (context,state){
        HomeCubit temp = HomeCubit.get(context);
        return temp.categoryResponse!=null?Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.separated(
              itemBuilder: (context,index)=>CategoryBigItem(category: temp.categoryResponse!.data2!.categoryData![index],),
              separatorBuilder: (context,index)=>SizedBox(height: 20,),
              itemCount: temp.categoryResponse!.data2!.categoryData!.length
          ),
        ):Center(child: CircularProgressIndicator(color: Theme.of(context).canvasColor,),);
      },
      listener: (context,state){

      },
    );
  }
}

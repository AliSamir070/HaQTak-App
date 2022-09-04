import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/search%20cubit/search_cubit.dart';
import 'package:shop_app/shared/cubit/search%20cubit/search_states.dart';
import 'package:shop_app/shared/network/local/prefs_cache_helper.dart';

import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  static String route = "SearchScreen";
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
        create: (_)=>SearchCubit()..search("", PrefsCacheHelper.getToken(key: "token")),
        child: BlocConsumer<SearchCubit , SearchStates>(
          builder: (context , state){
            SearchCubit temp = SearchCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                toolbarHeight: height*0.15,
                title: TextFormField(
                  controller: search,
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.name,

                  decoration: InputDecoration(
                    prefixIcon: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 25,
                    )),
                    contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                    hintText: "Search",
                    fillColor: Theme.of(context).primaryColor,
                    filled: true,

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            width: 0,
                            color: Theme.of(context).primaryColor
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 0,
                            color: Theme.of(context).primaryColor
                        )
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 0,
                            color: Theme.of(context).primaryColor
                        )
                    ),
                  ),
                  onChanged: (value){
                    temp.search(value, PrefsCacheHelper.getToken(key: "token"));
                  },
                ),
              ),
              body: state is SearchLoadingState?Center(child: CircularProgressIndicator(color: Theme.of(context).canvasColor,),)
                    :ListView.separated(
                  itemBuilder: (context,index)=>SearchItem(product: temp.model!.searchData!.data3![index]),
                  separatorBuilder: (context,index)=>Container(
                    color: Colors.grey[300],
                    height: 2,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  itemCount:  temp.model!.searchData!.data3!.length
              ),
            );
          },
          listener: (context,state){

          },
        ),
    );
  }
}

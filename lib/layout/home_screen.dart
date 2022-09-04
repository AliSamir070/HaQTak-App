import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/module/categories/categories_screen.dart';
import 'package:shop_app/module/favorites/favorites_screen.dart';
import 'package:shop_app/module/login/login_screen.dart';
import 'package:shop_app/module/products/products_screen.dart';
import 'package:shop_app/module/profile/profile_screen.dart';
import 'package:shop_app/module/search/search_screen.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_cubit.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_states.dart';
import 'package:shop_app/shared/network/local/prefs_cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/endpoint.dart';

class HomeScreen extends StatelessWidget {
  static String route = "HomeScreen";
  List<Widget> screens = [
    ProductsScreen(),
    FavoritesScreen(),
    CategoriesScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>HomeCubit()..getProducts(PrefsCacheHelper.getToken(key: "token"))..getCategories()..getFavorites(PrefsCacheHelper.getToken(key: "token")),
        child: BlocConsumer<HomeCubit,HomeStates>(
          builder: (context,state){
            HomeCubit temp = HomeCubit.get(context);
            return  Scaffold(
              appBar: AppBar(
                title: Text(
                    'HaQTaK Shop'
                ),
                actions: [
                  IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, ProfileScreen.route);
                        /*String token = PrefsCacheHelper.getToken(key: "token");
                        PrefsCacheHelper.clearToken().then((value){
                          if(value){
                            DioHelper.signout(url: LOGOUT, token: token);
                            Navigator.pushReplacementNamed(context, LoginScreen.route);
                          }
                        });*/
                      },
                      icon: Icon(
                          Icons.person
                      )
                  ),
                  IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, SearchScreen.route);
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      )
                  )
                ],
              ),
              bottomNavigationBar: BottomNavyBar(
                  animationDuration: Duration(milliseconds: 700),
                  backgroundColor: Theme.of(context).canvasColor,
                  items: [
                    BottomNavyBarItem(
                        icon: Icon(Icons.home),
                        title: Text("Home" , style: Theme.of(context).textTheme.bodyLarge,),
                        activeColor: Colors.white,
                        inactiveColor: Colors.black,
                        textAlign: TextAlign.center
                    ),
                    BottomNavyBarItem(
                        icon: Icon(Icons.favorite),
                        title: Text("Favorites" , style: Theme.of(context).textTheme.bodyLarge,),
                        activeColor: Colors.white,
                        inactiveColor: Colors.black,
                        textAlign: TextAlign.center
                    ),
                    BottomNavyBarItem(
                        icon: Icon(Icons.list_alt_outlined),
                        title: Text("Categories" , style: Theme.of(context).textTheme.bodyLarge,),
                        activeColor: Colors.white,
                        inactiveColor: Colors.black,
                        textAlign: TextAlign.center
                    )
                  ],
                  onItemSelected: (index){
                    temp.setBottomNavitem(index);
                  },
                  iconSize: 30,
                  curve: Curves.bounceOut,
                  itemCornerRadius: 15,
                  showElevation: true,
                  selectedIndex: temp.currentIndex,
                  containerHeight: 70,
              ),
              body: screens[temp.currentIndex],
            );
          },
          listener: (context,state){

          },
        ),
    );
  }
}

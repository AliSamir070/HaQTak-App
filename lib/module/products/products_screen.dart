import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_cubit.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_states.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit,HomeStates>
      (
        builder: (context , state){
          HomeCubit temp = HomeCubit.get(context);
          if(temp.homeResponse!=null && temp.categoryResponse!=null){
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CarouselSlider(
                        items: temp.homeResponse?.homedata?.banners?.map((e){
                          return Container(
                            child: Image(
                              image: NetworkImage(e.image!),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                            autoPlay: true,
                            height: height*0.2,
                            autoPlayAnimationDuration: Duration(seconds: 1),
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayCurve: Curves.bounceOut,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                            reverse: false,
                            clipBehavior: Clip.antiAliasWithSaveLayer
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 200,
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index)=>CategoryItem(category: temp.categoryResponse!.data2!.categoryData![index]),
                              separatorBuilder: (context,index)=>SizedBox(width: 10,),
                              itemCount: temp.categoryResponse!.data2!.categoryData!.length
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'New Products',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: temp.homeResponse!.homedata!.products!.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3/5.9,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context,index){
                          return ProductView(product: temp.homeResponse!.homedata!.products![index]);
                        }
                    ),
                  ),

                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(color: Theme.of(context).canvasColor,),);
          }

        },
        listener: (context , state){
          if(state is HomeAddFavoritesSuccessState){
            print("Success");
          }
        }
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/model/FavouritesProduct.dart';
import 'package:shop_app/model/Products.dart';
import 'package:shop_app/shared/cubit/home%20cubit/home_cubit.dart';
import 'package:shop_app/shared/network/local/prefs_cache_helper.dart';
import '../../model/CategoryData.dart';
import '../../model/slider_model.dart';


class BuildDot extends StatelessWidget {
  bool isSelected;
  BuildDot({required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      margin: EdgeInsetsDirectional.only(end: 20),
      decoration: BoxDecoration(
        color: isSelected?Theme.of(context).primaryColor:Colors.grey,
        shape: BoxShape.circle
      ),
    );
  }
}
class SliderPages extends StatelessWidget {
  SliderModel sliderModel;
  SliderPages({required this.sliderModel});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(child: Lottie.asset(sliderModel.animationUrl,width: width*0.3,height: height*0.4)),
        SizedBox(height: 10,),
        Expanded(
          child: Text(
            sliderModel.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        )
      ],
    );
  }
}
class ProductView extends StatelessWidget {
  Products product;
  ProductView({required this.product});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    NumberFormat currencyFormat = NumberFormat.currency(locale: "en",symbol: "EGP");
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:[
              CachedNetworkImage(
                imageUrl: product.image!,
                imageBuilder: (context,provider){
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: provider,
                        )
                    ),
                  );
                },
                height: height*0.3,
                placeholder: (context,url){
                  return Center(child: CircularProgressIndicator(),);
                },
                errorWidget: (context , url,error)=>Center(child: Icon(Icons.broken_image),),
              ),
              if(product.discount!>0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsetsDirectional.all(5),
                  child: Text(
                    'DISCOUNT ${product.discount}%',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.white
                    ),
                  ),
                ),
            ] ,
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Text(
                      product.name??"",
                      style: Theme.of(context).textTheme.displayMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        currencyFormat.format(product.price),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(width: 10,),
                      if(product.discount!>0)
                        Text(
                          product.oldPrice.toString(),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: (){
                            HomeCubit.get(context).addProductToFavorite(PrefsCacheHelper.getToken(key: "token"), product.id!);
                          },
                          icon: Icon(
                            Icons.favorite_rounded,
                            size: 18,
                            color: HomeCubit.get(context).favorites[product.id]!?Theme.of(context).canvasColor:Colors.grey,
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
class FavoriteItem extends StatelessWidget {
  FavouritesProduct product;
  FavoriteItem({required this.product});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    NumberFormat currencyFormat = NumberFormat.currency(locale: "en",symbol: "EGP");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height*0.15,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children:[
                CachedNetworkImage(
                  imageUrl: product.image!,
                  imageBuilder: (context,provider){
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: provider,
                          )
                      ),
                    );
                  },
                  height: height*0.2,
                  width: width*0.3,
                  placeholder: (context,url){
                    return Center(child: CircularProgressIndicator(),);
                  },
                  errorWidget: (context , url,error)=>Center(child: Icon(Icons.broken_image),),
                ),
                if(product.discount!>0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsetsDirectional.all(5),
                    child: Text(
                      'DISCOUNT ${product.discount}%',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white
                      ),
                    ),
                  ),
              ] ,
            ),
            SizedBox(width: 10,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name??"",
                        style: Theme.of(context).textTheme.displayMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          currencyFormat.format(product.price),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(width: 10,),
                        if(product.discount!>0 )
                          Text(
                            product.oldPrice.toString(),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: (){
                              HomeCubit.get(context).addProductToFavorite(PrefsCacheHelper.getToken(key: "token"), product.id!);
                            },
                            icon: Icon(
                              Icons.favorite_rounded,
                              size: 18,
                              color: HomeCubit.get(context).favorites[product.id]!?Theme.of(context).canvasColor:Colors.grey,
                            )
                        )
                      ],
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
class SearchItem extends StatelessWidget {
  Products product;
  SearchItem({required this.product});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    NumberFormat currencyFormat = NumberFormat.currency(locale: "en",symbol: "EGP");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height*0.15,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children:[
                CachedNetworkImage(
                  imageUrl: product.image!,
                  imageBuilder: (context,provider){
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: provider,
                          )
                      ),
                    );
                  },
                  height: height*0.2,
                  width: width*0.3,
                  placeholder: (context,url){
                    return Center(child: CircularProgressIndicator(),);
                  },
                  errorWidget: (context , url,error)=>Center(child: Icon(Icons.broken_image),),
                ),
              ] ,
            ),
            SizedBox(width: 10,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name??"",
                        style: Theme.of(context).textTheme.displayMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          currencyFormat.format(product.price),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),

                        Spacer(),
                        IconButton(
                            onPressed: (){
                            },
                            icon: Icon(
                              Icons.favorite_rounded,
                              size: 18,
                              color: product.inFavorites!?Theme.of(context).canvasColor:Colors.grey,
                            )
                        )
                      ],
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
class CategoryItem extends StatelessWidget {
  CategoryData category;
  CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          color: Theme.of(context).canvasColor
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: category.image!,
            width: 150,
            height: 150,
            placeholder: (context,url)=>Center(child: CircularProgressIndicator(color: Colors.white,),),
            errorWidget: (context,url,error)=>Center(child: Icon(Icons.broken_image),),
            imageBuilder: (context,provider)=>Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: provider,fit: BoxFit.cover)
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text(
            category.name??"",
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
class CategoryBigItem extends StatelessWidget {
  CategoryData category;
  CategoryBigItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        clipBehavior: Clip.antiAlias,
        children: [
          CachedNetworkImage(
            imageUrl: category.image!,
            width: double.infinity,
            height: 150,
            placeholder: (context,url)=>Center(child: CircularProgressIndicator(color: Colors.white,),),
            errorWidget: (context,url,error)=>Center(child: Icon(Icons.broken_image),),
            imageBuilder: (context,provider)=>Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: provider,fit: BoxFit.cover),
                  borderRadius: BorderRadiusDirectional.circular(20)
              ),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.all(10),
            margin: EdgeInsetsDirectional.all(10),
            color: Theme.of(context).canvasColor.withOpacity(0.5),
            child: Text(
              category.name??"",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800
              ),
            ),
          )
        ],
      ),
    );
  }
}





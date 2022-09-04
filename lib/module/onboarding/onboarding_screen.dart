import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/onbording%20cubit/onboarding_cubit.dart';
import 'package:shop_app/shared/cubit/onbording%20cubit/states.dart';
import 'package:shop_app/shared/network/local/prefs_cache_helper.dart';

import '../../layout/home_screen.dart';
import '../../model/slider_model.dart';
import '../../shared/components/style.dart';
import '../login/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  static String route  = "OnBoardingScreen";
  int currentIndex = 0;
  List<SliderModel> pages = [
    SliderModel(animationUrl: "assets/lottie/shopping.json", description: "First Screen is choosing products from different companies and shops like you are in market and add it to cart"),
    SliderModel(animationUrl: "assets/lottie/checkout.json", description: "Second screen is checking out what you want in your cart and buy it and choose the payment type "),
    SliderModel(animationUrl: "assets/lottie/delivery.json", description: "Then wait until the your products come home with the delivery man safely")
  ];
  var pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context)=>OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit,OnBoardingStates>(
        builder: (context,state){
          OnBoardingCubit temp = OnBoardingCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(onPressed: (){
                    submit(context);
                  }, child: Text("Skip",style: Theme.of(context).textTheme.titleMedium,))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: pages.length,
                        onPageChanged: (index){
                          temp.changePageIndex(index);
                        },
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          return SliderPages(sliderModel: pages[index]);
                        }
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => BuildDot(isSelected: temp.currentIndex==index,)),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: (){
                          if(temp.currentIndex==pages.length-1){
                            submit(context);
                          }else{
                            pageController.nextPage(duration: Duration(milliseconds: 900), curve: Curves.linearToEaseOut);
                          }
                        },
                        child: Text(
                          temp.currentIndex==pages.length-1?"Finish":"Next",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  )
                ],
              ),
            ),
          );

        },
        listener: (context , state){

        },
      ),
    );
  }
  void submit(BuildContext context){
    PrefsCacheHelper.saveData(key: "onboarding", value: true).then((value){
      Navigator.pushReplacementNamed(context, LoginScreen.route);
    });
  }
}

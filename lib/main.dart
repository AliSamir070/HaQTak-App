import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/module/login/login_screen.dart';
import 'package:shop_app/module/onboarding/onboarding_screen.dart';
import 'package:shop_app/module/profile/phone_verification.dart';
import 'package:shop_app/module/profile/profile_screen.dart';
import 'package:shop_app/module/register/register_screen.dart';
import 'package:shop_app/module/search/search_screen.dart';
import 'package:shop_app/shared/components/style.dart';
import 'package:shop_app/shared/network/local/prefs_cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PrefsCacheHelper.init();
  DioHelper.init();
  bool isOnboard = PrefsCacheHelper.getOnboarding(key: "onboarding");
  String token = PrefsCacheHelper.getToken(key: "token");
  runApp(MyApp(isOnboard,token));
}

class MyApp extends StatelessWidget {
  final bool isBoarding;
  final String token;
  MyApp(this.isBoarding , this.token);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppStyle.lightTheme,
      routes: {
        HomeScreen.route:(_)=>HomeScreen(),
        OnBoardingScreen.route:(_)=>OnBoardingScreen(),
        LoginScreen.route:(_)=>LoginScreen(),
        RegisterScreen.route:(_)=>RegisterScreen(),
        SearchScreen.route:(_)=>SearchScreen(),
        ProfileScreen.route:(_)=>ProfileScreen(),
        PhoneVerififcationScreen.route:(_)=>PhoneVerififcationScreen()
      },
      initialRoute: isBoarding?(token.isEmpty?LoginScreen.route:HomeScreen.route):OnBoardingScreen.route,
    );
  }
}




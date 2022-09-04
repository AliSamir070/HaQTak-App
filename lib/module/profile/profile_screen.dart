import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shop_app/module/profile/phone_verification.dart';
import 'package:shop_app/shared/cubit/profile%20cubit/profile_cubit.dart';
import 'package:shop_app/shared/cubit/profile%20cubit/profile_states.dart';
import 'package:shop_app/shared/network/local/prefs_cache_helper.dart';

import '../../shared/network/remote/dio_helper.dart';
import '../../shared/network/remote/endpoint.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  static String route = "ProfileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();

  int countryMax = 10;
  var formKey = GlobalKey<FormState>();

 String phoneNumberTemp = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context)=>ProfileCubit()..getProfile(PrefsCacheHelper.getToken(key: "token")),
      child: BlocConsumer<ProfileCubit,ProfileStates>(
          builder: (context,state){
            ProfileCubit temp = ProfileCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: Text(
                    'HaQTaK Shop'
                ),
              ),
              body: state is ProfileLoadingState?Center(child: CircularProgressIndicator(color: Theme.of(context).canvasColor,),)
                  :SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                children: [
                    TextFormField(
                        controller: name,
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.name,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Name shouldn't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 25,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                          hintText: "Name",
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
                    ),
                    SizedBox(
                        height: height*0.05,
                    ),
                    TextFormField(
                        controller: email,
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Email shouldn't be empty";
                          }else if(EmailValidator.validate(value) == false){
                            return "Enter valid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                          hintText: "Email",
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
                    ),
                    SizedBox(
                        height: height*0.05,
                    ),
                    IntlPhoneField(
                        invalidNumberMessage: "Enter valid number",
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 25,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                          hintText: "Phone",
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
                        controller: phone,
                        initialCountryCode: "EG",
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onCountryChanged: (country){
                          countryMax = country.maxLength;
                        },
                        validator: (PhoneNumber){
                          if(PhoneNumber!.number.length<countryMax){
                            return "Enter valid number";
                          }
                          return null;
                        },

                    ),
                    SizedBox(
                    height: height*0.05,
                ),
                    ElevatedButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            String token = PrefsCacheHelper.getToken(key: "token");
                            temp.updateProfile(token, email.text, name.text, phone.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          padding: EdgeInsetsDirectional.all(10),
                          primary: Theme.of(context).canvasColor,
                          shadowColor: Theme.of(context).primaryColor,
                          minimumSize: Size(double.infinity, 60)
                        ),
                        child: Text(
                          "Update",
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                ),
                    SizedBox(
                      height: height*0.05,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          String token = PrefsCacheHelper.getToken(key: "token");
                          PrefsCacheHelper.clearToken().then((value){
                            if(value){
                              DioHelper.signout(url: LOGOUT, token: token);
                              Navigator.pushReplacementNamed(context, LoginScreen.route);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            padding: EdgeInsetsDirectional.all(10),
                            primary: Theme.of(context).canvasColor,
                            shadowColor: Theme.of(context).primaryColor,
                            minimumSize: Size(double.infinity, 60)
                        ),
                        child: Text(
                          "Log out",
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                    ),
                ],
              ),
                      ),
                    ),
                  ),
            );
          },
          listener: (context,state){
            if(state is ProfileSuccessState){
              if(state.profile.status!){
                name.text = state.profile.data!.name!;
                email.text = state.profile.data!.email!;
                phone.text = state.profile.data!.phone!;
                phoneNumberTemp = state.profile.data!.phone!;
              }else{
                Fluttertoast.showToast(
                    msg: state.profile.message!,
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0,
                    timeInSecForIosWeb: 5
                );
              }
            }
          }
      ),
    );
  }
}

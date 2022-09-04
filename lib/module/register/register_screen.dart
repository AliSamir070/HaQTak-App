import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shop_app/model/LoginResponse.dart';
import 'package:shop_app/shared/cubit/register%20cubit/register_cubit.dart';

import '../../layout/home_screen.dart';
import '../../shared/cubit/register cubit/register_states.dart';
import '../../shared/network/local/prefs_cache_helper.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static String route = "RegisterScreen";
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  int countryMax = 10;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        builder: (context,state){
          RegisterCubit temp = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Signup",
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height*0.1,
                      ),
                      TextFormField(
                        controller: nameController,
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
                        controller: emailController,
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
                      TextFormField(
                        controller: passwordController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: temp.isPasswordObscured,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Password shouldn't be empty";
                          }else if(value.length>6){
                            return "Password shouldn't be less than 6";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.white,
                            size: 25,
                          ),
                          suffixIcon: IconButton(
                              onPressed: (){
                                temp.ObscurePassword();
                              },
                              icon: Icon(
                                temp.isPasswordObscured?Icons.visibility_off:Icons.visibility,
                                color: Colors.white,
                                size: 25,
                              )
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                          hintText: "Password",
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
                        controller: confirmPasswordController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: temp.isConfirmPasswordObscured,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Confirm Password shouldn't be empty";
                          }else if(value!=confirmPasswordController.text){
                            return "Should be same as password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.white,
                            size: 25,
                          ),
                          suffixIcon: IconButton(
                              onPressed: (){
                                temp.ObscureConfirmPassword();
                              },
                              icon: Icon(
                                temp.isConfirmPasswordObscured?Icons.visibility_off:Icons.visibility,
                                color: Colors.white,
                                size: 25,
                              )
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                          hintText: "Confirm Password",
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
                        controller: phoneController,
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
                      state is RegisterLoadingState?Center(child: CircularProgressIndicator(color: Theme.of(context).canvasColor,),)
                          :ElevatedButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              temp.Register(emailController.text, passwordController.text, nameController.text, phoneController.text);
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
                          ),
                          child: Text(
                            "Signup",
                            style: Theme.of(context).textTheme.headlineMedium,
                          )
                      ),
                      SizedBox(
                        height: height*0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(width: 10,),
                          TextButton(
                            onPressed: (){
                              Navigator.pushReplacementNamed(context, LoginScreen.route);
                            },
                            child: Text(
                              "Login",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is RegisterSuccessState){
            LoginResponse response = state.registerData;
            if(response.status!){
              PrefsCacheHelper.saveData(key: "token", value: response.data!.token).then((value){
                Navigator.pushReplacementNamed(context, HomeScreen.route);
              });
            }else{
              Fluttertoast.showToast(
                  msg: response.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
        },
      ),
    );
  }
}

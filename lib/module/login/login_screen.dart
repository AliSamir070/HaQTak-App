import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/model/LoginResponse.dart';
import 'package:shop_app/module/register/register_screen.dart';
import 'package:shop_app/shared/cubit/login%20cubit/login_cubit.dart';
import 'package:shop_app/shared/cubit/login%20cubit/login_states.dart';
import 'package:shop_app/shared/network/local/prefs_cache_helper.dart';

class LoginScreen extends StatelessWidget {
  static String route = "LoginScreen";
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        builder: (context,state){
          LoginCubit temp = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: height*0.1,
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
                          obscureText: temp.isObscured,
                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()){
                              temp.loginUser(emailController.text, passwordController.text);
                            }
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Password shouldn't be empty";
                            }else if(value.length<6){
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
                                  temp.obscurePassword();
                                },
                                icon: Icon(
                                  temp.isObscured?Icons.visibility_off:Icons.visibility,
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
                          height: 5,
                        ),
                        InkWell(
                          onTap: (){},
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: height*0.05,
                        ),
                        state is LoginLoadingState?Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).canvasColor,
                          ),
                        ):ElevatedButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                temp.loginUser(emailController.text, passwordController.text);
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
                              "Login",
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
                              "Don't have an account?",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(width: 10,),
                            TextButton(
                              onPressed: (){
                                Navigator.pushReplacementNamed(context, RegisterScreen.route);
                              },
                              child: Text(
                                "Register",
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
            ),
          );
        },
        listener: (context,state){
          if(state is LoginSuccessState){
            LoginResponse response = state.loginData;
            if(response.status!){
              print(response.message);
              print(response.data!.name);
              PrefsCacheHelper.saveData(key: "token", value: response.data!.token).then((value){
                Navigator.pushReplacementNamed(context, HomeScreen.route);
              });
            }else{
              print(response.message);
            }
          }
        },
      ),
    );
  }

}





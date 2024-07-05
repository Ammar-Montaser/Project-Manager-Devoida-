import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:project_manager/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:project_manager/features/auth/presentation/views/login.dart';
import 'package:project_manager/features/auth/presentation/widgets/authField.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  static route() => MaterialPageRoute(builder: (context) => SignUp());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -70,
            top: -20,
            child: Image(
              width: 300,
              image: AssetImage("assets/images/blob.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: size.height * 0.2,
                          child: OverflowBox(
                            minHeight: size.height * 0.2,
                            maxHeight: size.height * 0.3,
                            child: LottieBuilder.asset(
                              "assets/images/signUpAnimation.json",
                              repeat: true,
                            ),
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.headlineLarge!,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please sign up to continue...",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          authField(
                            hintText: "Enter your name",
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person),
                            controller: nameController,
                            isObscureText: false,
                            isPassword: false,
                          ),
                          authField(
                            hintText: "Enter your email",
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            controller: emailController,
                            isObscureText: false,
                            isPassword: false,
                          ),
                          authField(
                            hintText: "Enter your password",
                            labelText: "Password",
                            prefixIcon: Icon(Icons.password),
                            controller: passwordController,
                            isObscureText: true,
                            isPassword: true,
                          ),
                          authField(
                            hintText: "Confirm your password",
                            labelText: "Confirm Password",
                            prefixIcon: Icon(Icons.password),
                            controller: confirmPasswordController,
                            isObscureText: true,
                            isPassword: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              return TextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context)
                                        .register(
                                      emailController.text,
                                      passwordController.text,
                                      nameController.text,
                                    );
                                  }
                                },
                                child: Text("Sign Up"),
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                        minimumSize: MaterialStatePropertyAll(
                                            Size(size.width, 50))),
                              );
                            },
                          ),
                          Row(
                            children: [
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, loginScreen.route());
                                  },
                                  child: Text("Already have an account?")),
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

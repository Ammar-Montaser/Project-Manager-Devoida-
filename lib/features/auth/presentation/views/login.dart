import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:project_manager/features/auth/presentation/widgets/authField.dart';

class loginScreen extends StatelessWidget {
  loginScreen({super.key});
  static route() => MaterialPageRoute(builder: (context) => loginScreen());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: SizedBox(
                            height: size.height * 0.3,
                            child: OverflowBox(
                              minHeight: size.height * 0.3,
                              maxHeight: size.height * 0.4,
                              child: LottieBuilder.asset(
                                "assets/images/loginAnimation.json",
                                repeat: false,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headlineLarge!,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please sign in to continue...",
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
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Login"),
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                    minimumSize: MaterialStatePropertyAll(
                                        Size(size.width, 50))),
                          )
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

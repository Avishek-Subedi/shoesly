import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shoesly/app_setup/controller/base_state.dart';
import 'package:shoesly/config/route/paths.dart';
import 'package:shoesly/core/constants/enums.dart';
import 'package:shoesly/features/auth/controllers/auth_controller.dart' as auth;
import 'package:shoesly/features/auth/presentation/login/login_screen.dart';
import 'package:shoesly/features/auth/presentation/widgets/login_header.dart';
import 'package:shoesly/features/auth/presentation/widgets/social_container.dart';
import 'package:shoesly_components/shoesly_componenets.dart';
import 'package:shoesly_resources/shoesly_resources.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _fullNameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _SignupScreenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    // ref.listen(auth.loginControllerProvider, (prev, next) {
    //   if (next is BaseError) {
    //     context.showSnackBar(message: next.failure.reason);
    //   }
    //   if (next is BaseSuccess) {
    //     context.go(Paths.welcomeScreenRoute.path);
    //     context.showSnackBar(message: "successfully logged in", isError: false);
    //   }
    // });

    ref.listen(
      auth.signUpControllerProvider,
      (prev, next) {
        if (next is BaseError) {
          context.showSnackBar(message: next.failure.reason);
        }
        if (next is BaseSuccess) {
          context.go(Paths.loginScreenRoute.path);
          context.showSnackBar(
              message: "account created successfully", isError: false);
        }
      },
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorScheme(context).primary,
        body: SizedBox(
          height: screenHeight(context),
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomClipPathDown(),
                child: Container(
                  height: screenHeight(context) / 1.35,
                  color: colorScheme(context).surface,
                  padding: EdgeInsets.symmetric(
                      horizontal: 18, vertical: screenHeight(context) / 18),
                  width: screenWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 35),
                      const Align(
                        alignment: Alignment.center,
                        child: LoginHeader(),
                      ),
                      const SizedBox(height: 35),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: textTheme(context).bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context).secondary),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              "Full Name",
                              style: textTheme(context).bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12,
                                  color: colorScheme(context).secondary),
                            ),
                            shoeslyTextField(
                              controller: _fullNameController,
                              onPressed: () {},
                            ),
                            Text(
                              "Email",
                              style: textTheme(context).bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12,
                                  color: colorScheme(context).secondary),
                            ),
                            shoeslyTextField(
                              controller: _emailController,
                              validator: (value) =>
                                  FormValidator.emailValidator(value!),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Password",
                              style: textTheme(context).bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12,
                                  color: colorScheme(context).secondary),
                            ),
                            shoeslyTextField(
                              controller: _passwordController,
                              isPassword: true,
                              onPressed: () {},

                              // validator: (value) =>
                              //     FormValidator.passwordValidator(value!),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenHeight(context) / 1.70,
                child: Column(
                  children: [
                    SizedBox(
                      width: screenWidth(context) / 2,
                      child: SizedBox(
                        height: screenHeight(context) / 18.8,
                        width: screenWidth(context) / 3,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final authState0 =
                                ref.watch(auth.loginControllerProvider);
                            return shoeslyButton.tonal(
                              label: "Register",
                              showProgress:
                                  authState0 is BaseLoading ? true : false,
                              ontap: _signUp,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.04,
                    ),
                    Text(
                      'or',
                      style: textTheme(context).bodySmall?.copyWith(
                          color: colorScheme(context).surface, fontSize: 12),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: screenWidth(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final socialAuthState =
                                  ref.watch(auth.socialLoginIn);
                              return InkWell(
                                onTap: () {
                                  ref
                                      .read(auth.socialLoginIn.notifier)
                                      .loginWithSocialAuth(
                                          socialAuthType:
                                              SocialAuthType.google);
                                },
                                child: SocialContainer(
                                  source: Asset.icons.google,
                                  social: 'Google',
                                  isLoading: socialAuthState is BaseLoading
                                      ? true
                                      : false,
                                ),
                              );
                            },
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     context.showSnackBar(
                          //         message:
                          //             "Facebook login is not implemented yet.");
                          //   },
                          //   child: SocialContainer(
                          //     source: Asset.icons.fb,
                          //   ),
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     context.showSnackBar(
                          //         message: "X login is not implemented yet.");
                          //   },
                          //   child: SocialContainer(
                          //     source: Asset.icons.x,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.09,
                    ),
                    Row(
                      children: [
                        Text(
                          "Already have an account ?",
                          style: textTheme(context).bodySmall!.copyWith(
                                color: colorScheme(context).surface,
                                fontSize: 13,
                              ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(upAnimation(const LoginScreen()));
                          },
                          child: Text(
                            "Login",
                            style: textTheme(context).bodyMedium?.copyWith(
                                fontSize: 13,
                                color: colorScheme(context).surface),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _signUp() {
    if (_formKey.currentState!.validate()) {
      ref.read(auth.signUpControllerProvider.notifier).signupWithCreds(
          email: _emailController.text, password: _passwordController.text);
      // ref.read(auth)
    }
  }

  // _logIn() {
  //   if (_formKey.currentState!.validate()) {
  //     ref.read(auth.loginControllerProvider.notifier).loginWithCreds(
  //         email: _emailController.text, password: _passwordController.text);
  //     // context.push(Paths.welcomeScreenRoute.path);
  //     // context.showSnackBar(message: "successfully logged in", isError: false);
  //     // ref.read(auth)
  //   }
  // }
}

////
///
///


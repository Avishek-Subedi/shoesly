import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shoesly/app_setup/controller/base_state.dart';
import 'package:shoesly/config/route/paths.dart';
import 'package:shoesly/core/constants/enums.dart';
import 'package:shoesly/features/auth/controllers/auth_controller.dart' as auth;
import 'package:shoesly/features/auth/presentation/signup/signup_screen.dart';
import 'package:shoesly/features/auth/presentation/widgets/login_header.dart';
import 'package:shoesly/features/auth/presentation/widgets/skip_button.dart';
import 'package:shoesly/features/auth/presentation/widgets/social_container.dart';
import 'package:shoesly_components/shoesly_componenets.dart';
import 'package:shoesly_resources/shoesly_resources.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(auth.loginControllerProvider, (prev, next) {
      if (next is BaseError) {
        context.showSnackBar(message: next.failure.reason.toString());
      }
      if (next is BaseSuccess) {
        context.go(Paths.homeScreenRoute.path);
        context.showSnackBar(message: "successfully logged in", isError: false);
      }
    });
    ref.listen(auth.socialLoginIn, (prev, next) {
      if (next is BaseError) {
        context.showSnackBar(message: next.failure.reason.toString());
      }
      if (next is BaseSuccess) {
        context.go(Paths.homeScreenRoute.path);
        context.showSnackBar(message: "successfully logged in", isError: false);
      }
    });

    // final socialState = ref
    //     .read(auth.loginControllerProvider.notifier)
    //     .loginWithSocialAuth(socialAuthType: SocialAuthType.google);

    // ref
    //                                   .read(auth.socialLoginIn.notifier)
    //                                   .loginWithSocialAuth(
    //                                       socialAuthType:
    //                                           SocialAuthType.google);

    ref.listen(
      auth.signUpControllerProvider,
      (prev, next) {
        if (next is BaseError) {
          context.showSnackBar(message: next.failure.reason);
        }
        if (next is BaseSuccess) {
          context.go(Paths.welcomeScreenRoute.path);
          context.showSnackBar(
              message: "account created successfully", isError: false);
        }
      },
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SizedBox(
          height: screenHeight(context),
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomClipPathDown(),
                child: Container(
                  height: screenHeight(context) / 1.3,
                  color: colorScheme(context).primary,
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
                        child: LoginHeader(isLoginScreen: true),
                      ),
                      const SizedBox(height: 35),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: textTheme(context).bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context).surface),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              "Email",
                              style: textTheme(context).bodyMedium!.copyWith(
                                    color: colorScheme(context).surface,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12,
                                  ),
                            ),
                            shoeslyTextField(
                              controller: _emailController,
                              validator: (value) =>
                                  FormValidator.emailValidator(value!),
                              isLoginScreen: true,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Password",
                              style: textTheme(context).bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12,
                                    color: colorScheme(context).surface,
                                  ),
                            ),
                            shoeslyTextField(
                              controller: _passwordController,
                              isPassword: true,
                              isLoginScreen: true,
                              onPressed: () {},
                              validator: (value) =>
                                  FormValidator.passwordValidator(value!),
                            ),
                            // TextFormField(
                            //   style: const TextStyle(
                            //     fontSize: 11,
                            //     fontWeight: FontWeight.w100,
                            //   ),
                            //   validator: (value) =>
                            //       FormValidator.passwordValidator(value!),
                            //   decoration: const InputDecoration(
                            //     isDense: true,
                            //     focusedBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(
                            //         style: BorderStyle.solid,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            //   cursorColor: Colors.white,
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenHeight(context) / 1.62,
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
                            return shoeslyButton(
                              label: "Login",
                              showProgress:
                                  authState0 is BaseLoading ? true : false,
                              ontap: _logIn,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.02,
                    ),
                    Text(
                      'or',
                      style: textTheme(context).bodySmall?.copyWith(
                          color: colorScheme(context).secondary, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
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
                      height: screenHeight(context) * 0.08,
                    ),
                    Row(
                      children: [
                        Text(
                          "Don't have an account yet?",
                          style: textTheme(context)
                              .bodyMedium!
                              .copyWith(color: Colors.black, fontSize: 13),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(downAnimation(const SignupScreen()));
                          },
                          child: Text(
                            "Signup",
                            style: textTheme(context).bodyMedium?.copyWith(
                                fontSize: 13,
                                color: colorScheme(context).primary),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SkipButton()
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

  _logIn() {
    if (_formKey.currentState!.validate()) {
      ref.read(auth.loginControllerProvider.notifier).loginWithCreds(
          email: _emailController.text, password: _passwordController.text);
      // context.push(Paths.welcomeScreenRoute.path);
      // context.showSnackBar(message: "successfully logged in", isError: false);
      // ref.read(auth)
    }
  }
}



////
///
///

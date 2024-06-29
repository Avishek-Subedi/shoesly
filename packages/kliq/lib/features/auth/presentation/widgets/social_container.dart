import 'package:flutter/material.dart';
import 'package:shoesly_components/shoesly_componenets.dart';

class SocialContainer extends StatelessWidget {
  final String source;
  final double? height;
  final bool isLoading;
  final String social;
  const SocialContainer({
    super.key,
    required this.source,
    this.height = 52,
    this.isLoading = false,
    required this.social,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: screenWidth(context) / 1.5,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.55))
            ]),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme(context).primary),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Picture(
                      source: source,
                      height: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Sign in with $social",
                    style: textTheme(context).labelLarge!.copyWith(
                        color: colorScheme(context).secondary,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ));
  }
}

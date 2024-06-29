import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/core/providers/locale_provider.dart';
import 'package:shoesly_components/shoesly_componenets.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        // color: Colors.green,
      ),
      child: Consumer(builder: (context, ref, child) {
        final languageValue = ref.watch(languageProvider);
        final supportedLocales = ref.watch(supportedLocalesProvider);

        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: languageValue, // Set initial value to current language
            items: supportedLocales
                .map((locale) => DropdownMenuItem(
                      value: locale.languageCode,
                      child: Center(
                          child: Text(
                        locale.languageCode.toUpperCase(),
                        style: textTheme(context).bodySmall!.copyWith(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )),
                    ))
                .toList(),
            onChanged: (value) {
              ref.read(languageProvider.notifier).state =
                  value ?? supportedLocales.first.languageCode;
            },
          ),
        );
      }),
    );
  }
}

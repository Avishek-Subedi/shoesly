import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/app_setup/controller/theme_notifier.dart';
import 'package:shoesly/config/route/router.dart';
import 'package:shoesly/core/providers/locale_provider.dart';
import 'package:shoesly_resources/shoesly_resources.dart';

class ShoeslyApp extends ConsumerWidget {
  const ShoeslyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedString = ref.watch(languageProvider);

    final isDarkTheme = ref.watch(themeProvider).isDark;

    const localization = shoeslyLocalization();

    return shoeslyTheme(
        themeMode:
            ref.watch(themeProvider).isDark ? ThemeMode.dark : ThemeMode.light,
        builder: (config) {
          return MaterialApp.router(
            localizationsDelegates: localization.delegates,
            supportedLocales: localization.supportedLocales,
            locale: Locale(selectedString),
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: isDarkTheme ? config.dark : config.light,
            darkTheme: isDarkTheme ? config.dark : config.light,
          );
        });
  }
}

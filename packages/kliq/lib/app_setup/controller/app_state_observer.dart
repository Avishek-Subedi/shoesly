import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shoesly/app_setup/controller/app_controller.dart';
import 'package:shoesly/features/news/presentation/home_screen.dart';

class AppStateObserver extends ConsumerWidget {
  const AppStateObserver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We can implement dynamic routing as per the app state
    final appState = ref.watch(appController);
    log(appState.toString());
    return appState.map(
      started: (state) => const HomeScreen(
        user: null,
      ),
      showOnBoarding: (data) => const HomeScreen(
        user: null,
      ),
      authenticated: (authenticated) => HomeScreen(
        user: authenticated.data,
      ),
      unAuthenticated: (state) => const HomeScreen(user: null),
    );
  }
}

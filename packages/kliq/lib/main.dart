import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/app/shoesly_app.dart';
import 'package:shoesly/app_setup/app_init/app_init.dart';

void main() async {
  initializeApp();
}

Future initializeApp() async {
  runZonedGuarded(() async {
    await AppInit.initialize();

    runApp(const ProviderScope(child: ShoeslyApp()));
  }, (error, stack) {});
}

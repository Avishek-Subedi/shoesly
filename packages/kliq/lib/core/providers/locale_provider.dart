import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly_resources/shoesly_resources.dart';

final languageProvider = StateProvider<String>(
    (ref) => const shoeslyLocalization().supportedLocales.first.languageCode);

final supportedLocalesProvider =
    Provider<List<Locale>>((_) => const shoeslyLocalization().supportedLocales);

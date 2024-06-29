import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shoesly/app_setup/controller/theme_notifier.dart';
import 'package:shoesly_components/shoesly_componenets.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterSwitch(
      height: 32,
      width: screenWidth(context) / 7,
      value: ref.watch(themeProvider).isDark,
      onToggle: (value) async {
        ref.read(themeProvider.notifier).toggle();
      },
      activeColor: Colors.orange,
      inactiveColor: Colors.black,
      inactiveIcon: const Icon(
        size: 24,
        Icons.nightlight_rounded,
      ),
      activeIcon: const Icon(
        size: 24,
        Icons.sunny,
        color: Colors.amber,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shoesly/app_setup/language_selector.dart';
// import 'package:shoesly_components/shoesly_componenets.dart';
// import 'package:shoesly_resources/shoesly_resources.dart';

// class WelcomeScreen extends ConsumerWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: colorScheme(context).surface,
//       appBar: AppBar(
//         title: const Text('App initialization'),
//       ),
//       body: Column(
//         children: [
//           const LanguageSelector(),
//           Text(context.loc.description,
//               style: const TextStyle(color: Colors.black)),
//           Container(
//             width: 200,
//             height: 200,
//             color: colorScheme(context).secondary,
//             child: Picture(source: Asset.nav.home),
//           ),
//           shoeslyButton.tonal(
//             label: 'label',
            
//           ),
//           shoeslyButton(label: 'label', onTap: () {})
//         ],
//       ),
//     );
//   }
// }

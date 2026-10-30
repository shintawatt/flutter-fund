import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/product_page.dart';

// ProviderScope: wadah global semua provider Riverpod.
void main() => runApp(const ProviderScope(child: MasterPlanApp()));

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Praktikum 5 - AsyncValue',
        theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
        home: const ProductPage(),
      );
}
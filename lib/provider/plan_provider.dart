import 'package:flutter/material.dart';
import '../models/data_layer.dart';

/// InheritedNotifier yang kini menyimpan DAFTAR Plan (List<Plan>),
/// sehingga bisa dipakai bersama oleh banyak screen.
class PlanProvider extends InheritedNotifier<ValueNotifier<List<Plan>>> {
  const PlanProvider({
    super.key,
    required Widget child,
    required ValueNotifier<List<Plan>> notifier,
  }) : super(child: child, notifier: notifier);

  static ValueNotifier<List<Plan>> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlanProvider>()!
        .notifier!;
  }
}
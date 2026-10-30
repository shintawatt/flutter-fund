import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tugas 2: ubah menjadi true untuk mensimulasikan error server,
/// jalankan ulang, lalu kembalikan ke false (Tugas 3).
const bool kSimulateError = false;

class ProductsNotifier extends AsyncNotifier<List<String>> {
  /// Dipanggil pertama kali provider dibaca (dan setiap invalidate).
  @override
  Future<List<String>> build() async {
    await Future.delayed(const Duration(seconds: 2)); // simulasi network
    if (kSimulateError) {
      throw Exception('Gagal terhubung ke server');
    }
    return ['Keyboard', 'Mouse', 'Monitor'];
  }

  /// Refresh yang mempertahankan data lama (stale data) selama loading.
  Future<void> refresh() async {
    state = const AsyncLoading<List<String>>().copyWithPrevious(state);
    // guard: exception otomatis menjadi AsyncError, tanpa try/catch manual.
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<List<String>> _fetch() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['Keyboard', 'Mouse', 'Monitor', 'Headset'];
  }
}

final productsProvider =
    AsyncNotifierProvider<ProductsNotifier, List<String>>(
        ProductsNotifier.new);
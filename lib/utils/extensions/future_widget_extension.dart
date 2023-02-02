import 'package:flutter/material.dart';

typedef BuildFunction<T> = Widget Function(T data);

/// convert `Future` types to Widgets
///
/// for `flutter_rust_bridge` results
extension FutureToWidget<T> on Future<T> {
  Widget toWidget(BuildFunction<T> builder, {Widget? loadingWidget}) {
    return FutureBuilder<List<T>>(
        future: Future.wait([this]),
        builder: (ctx, s) {
          if (s.data == null) {
            return loadingWidget ?? const Text("loading");
          }
          final data = s.data as List;
          return builder(data[0]);
        });
  }
}

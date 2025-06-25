import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_ddd_template/common/words/words.dart';

part 'network_info.g.dart';

@riverpod
class NetworkInfo extends _$NetworkInfo {
  @override
  Future<bool> build() async {
    final connectivity = Connectivity();
    final result = await connectivity.checkConnectivity();

    _listenToConnectivityChanges();

    return _isConnected(result);
  }

  void _listenToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final isConnected = _isConnected(results);
      final oldState = state.valueOrNull ?? false;

      if (oldState != isConnected) {
        _showMessage(isConnected);
        state = AsyncData(isConnected);
      }
    });
  }

  bool _isConnected(List<ConnectivityResult> results) {
    return results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet,
    );
  }

  void _showMessage(bool isConnected) {
    Fluttertoast.showToast(
      msg: isConnected ? Words.hasInternet.str : Words.noInternet.str,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black45,
      textColor: isConnected ? Colors.greenAccent : Colors.redAccent,
      fontSize: 16.0,
    );
  }
}

@riverpod
Future<bool> isInternetConnected(Ref ref) async {
  final result = await Connectivity().checkConnectivity();

  return result.any(
    (r) =>
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet,
  );
}

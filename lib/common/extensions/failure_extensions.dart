import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_ddd_template/common/constants/app_env.dart';
import 'package:riverpod_ddd_template/common/localization/localization.dart';

import 'show_snackbar.dart';

String getError(dynamic e) {
  printErrorInfo(e);
  if (e is DioException) {
    if (e.response != null) {
      if (e.response!.data is Map && e.response!.data['message'] != null) {
        return e.response!.data['message'];
      }
      return "${e.response!.statusCode}: ${e.response!.statusMessage}\n${e.response!.data}";
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return Words.noInternet.str;

      default:
        return '$e';
    }
  }
  return '$e';
}

void showError(BuildContext context, dynamic e) {
  showSnackBar(context, message: getError(e), type: SnackBarType.error);
}

void printErrorInfo(dynamic e) {
  if (kDebugMode) {
    final info = _functionInfo();
    final tree = "${StackTrace.current}"
        .split('\n')
        .where((e) => e.contains(info.$1) && !e.contains(info.$2));
    if (tree.isNotEmpty) {
      var path = tree.first;
      path = path.substring(path.indexOf(AppEnv.packageName), path.length - 1);
      print('==> Failure File Path: $path');
    }
    print('==> Failure Text: $e');
  }
}

(String, String, String) _functionInfo() {
  StackTrace v = StackTrace.current;
  var path = "$v".split('\n')[0].split(' ').last;
  path = path.substring(1, path.length - 1);

  return (
    path.substring(0, path.indexOf("/") + 1),
    path.substring(0, path.indexOf(".dart:") + 5),
    path,
  );
}

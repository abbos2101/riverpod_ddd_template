import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:safe_device/safe_device.dart';

part 'device_info.g.dart';

@riverpod
Future<bool> isJailBroken(Ref ref) => SafeDevice.isJailBroken;

@riverpod
Future<bool> isRealDevice(Ref ref) => SafeDevice.isRealDevice;

@riverpod
Future<bool> isMockLocation(Ref ref) => SafeDevice.isMockLocation;

@riverpod
Future<PackageInfo> packageInfo(Ref ref) => PackageInfo.fromPlatform();

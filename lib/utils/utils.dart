import 'dart:io';
import 'package:flutter/foundation.dart';
export './smart_dialog_utils.dart';
export './local_storage.dart';
export './screen_fit_utils.dart';

part './platform_utils.dart';

class DevUtils {
  DevUtils._();

  static bool get isWeb => _PlatformUtils._isWeb();
  static bool get isAndroid => _PlatformUtils._isAndroid();
  static bool get isIOS => _PlatformUtils._isIOS();
  static bool get isMacOS => _PlatformUtils._isMacOS();
  static bool get isWindows => _PlatformUtils._isWindows();
  static bool get isFuchsia => _PlatformUtils._isFuchsia();
  static bool get isLinux => _PlatformUtils._isLinux();
  static bool get isMobile =>
      _PlatformUtils._isAndroid() || _PlatformUtils._isIOS();

  static Directory get executableDir =>
      File(Platform.resolvedExecutable).parent;
}

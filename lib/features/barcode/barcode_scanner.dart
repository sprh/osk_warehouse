import 'dart:io';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/navigation/manager/account_scope_navigation_manager.dart';

class BarcodeScanner {
  final AccountScopeNavigationManager _navigationManager;

  const BarcodeScanner(this._navigationManager);

  Future<String?> scanBarcode() async {
    const permission = Permission.camera;
    if (Platform.isAndroid && !await permission.isGranted) {
      await permission.request();
      if (!await permission.isGranted) {
        await _navigationManager.showSomethingWentWrontDialog(
          'Чтобы отсканировать штрихкод, дайте доступ к камере в настройках',
        );
        return null;
      }
    }

    final result = await FlutterBarcodeScanner.scanBarcode(
      '#000000',
      'Отмена',
      true,
      ScanMode.BARCODE,
    );

    if (result == '-1') {
      return null;
    }

    return result;
  }
}

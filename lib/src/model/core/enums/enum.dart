import 'package:flutter/foundation.dart';

enum IdProof { aadhaar, voterID, drivinglicense, passport }

enum MenuType { transaction, resources, reports, catering }

extension MenuTypeString on MenuType {
  String get name {
    switch (this) {
      case MenuType.transaction:
        return 'Transactions';
      case MenuType.resources:
        return 'Resources';
      case MenuType.reports:
        return 'Reports';
      case MenuType.catering:
        return 'Caterings';
      default:
        return '';
    }
  }

  void talk() {
    if (kDebugMode) {
      print('meow');
    }
  }
}

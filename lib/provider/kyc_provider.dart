// provider/kyc_provider.dart
import 'package:flutter/material.dart';

import '../models/kyc_model.dart';

class KycProvider with ChangeNotifier {
  KycDetails? _details;

  KycDetails? get details => _details;

  void setKycDetails(KycDetails details) {
    _details = details;
    notifyListeners();
  }
}
